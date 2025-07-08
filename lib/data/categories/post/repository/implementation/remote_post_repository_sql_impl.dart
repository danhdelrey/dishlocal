// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dishlocal/core/json_converter/food_category_converter.dart';
import 'package:dishlocal/data/categories/post/model/filter_sort_model/filter_sort_params.dart';
import 'package:dishlocal/data/categories/post/model/filter_sort_model/sort_option.dart';
import 'package:dishlocal/data/services/database_service/entity/post_entity.dart';
import 'package:dishlocal/data/services/database_service/exception/sql_database_service_exception.dart';
import 'package:dishlocal/data/services/geocoding_service/interface/geocoding_service.dart';
import 'package:dishlocal/data/services/search_service/exception/search_service_exception.dart';
import 'package:dishlocal/data/services/search_service/interface/search_service.dart';
import 'package:dishlocal/data/services/storage_service/exception/storage_service_exception.dart';
import 'package:injectable/injectable.dart';
import 'package:logging/logging.dart';

import 'package:dishlocal/data/categories/post/failure/post_failure.dart';
import 'package:dishlocal/data/categories/post/model/post.dart';
import 'package:dishlocal/data/categories/post/repository/interface/post_repository.dart';
import 'package:dishlocal/data/services/authentication_service/interface/authentication_service.dart';
import 'package:dishlocal/data/services/database_service/interface/sql_database_service.dart';
import 'package:dishlocal/data/services/distance_service/interface/distance_service.dart';
import 'package:dishlocal/data/services/location_service/interface/location_service.dart';
import 'package:dishlocal/data/services/storage_service/interface/storage_service.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

@LazySingleton(as: PostRepository)
class RemotePostRepositorySqlImpl implements PostRepository {
  final _log = Logger('RemotePostRepositorySqlImpl');
  final _supabase = Supabase.instance.client;
  final StorageService _storageService;
  final SqlDatabaseService _dbService;
  final DistanceService _distanceService;
  final LocationService _locationService;
  final GeocodingService _geocodingService;
  final AuthenticationService _authenticationService;
  final SearchService _searchService;

  RemotePostRepositorySqlImpl(
    this._storageService,
    this._dbService,
    this._distanceService,
    this._locationService,
    this._authenticationService,
    this._geocodingService,
    this._searchService,
  );

  // --- Bảng ánh xạ từ SortField sang tên cột trong DB ---
  // Rất quan trọng để giữ logic này ở một nơi.
  static const Map<SortField, String> _sortFieldToColumn = {
    SortField.datePosted: 'created_at',
    SortField.likes: 'like_count',
    SortField.comments: 'comment_count',
    SortField.saves: 'save_count',
  };

  // Helper để bắt và dịch lỗi
  Future<Either<PostFailure, T>> _handleErrors<T>(Future<T> Function() future) async {
    try {
      return Right(await future());
    } on SqlDatabaseServiceException catch (e) {
      _log.severe('❌ Lỗi từ SqlDatabaseService', e);
      return Left(switch (e) {
        PermissionDeniedException() => const PermissionFailure(),
        RecordNotFoundException() => const PostNotFoundFailure(),
        UniqueConstraintViolationException() => const PostOperationFailure('Dữ liệu này đã tồn tại.'),
        CheckConstraintViolationException() => const PostOperationFailure('Dữ liệu không hợp lệ.'),
        DatabaseConnectionException() => const ConnectionFailure(),
        _ => const UnknownFailure(),
      });
    } on StorageException catch (e) {
      _log.severe('❌ Lỗi từ StorageService', e);
      return const Left(ImageUploadFailure());
    } catch (e, st) {
      _log.severe('❌ Lỗi không xác định trong Repository', e, st);
      return const Left(UnknownFailure());
    }
  }

  // Helper để làm giàu dữ liệu (chỉ tính khoảng cách)
  Future<List<Post>> _enrichPostsWithDistance(List<Post> posts) async {
    if (posts.isEmpty) return [];
    _log.fine('📏 Bắt đầu tính khoảng cách cho ${posts.length} bài viết...');
    final userPosition = await _locationService.getCurrentPosition();
    final enriched = await Future.wait(posts.map((post) async {
      if (post.address?.latitude != null && post.address?.longitude != null) {
        final distance = await _distanceService.calculateDistance(
          fromLat: userPosition.latitude,
          fromLong: userPosition.longitude,
          toLat: post.address!.latitude,
          toLong: post.address!.longitude,
        );
        return post.copyWith(distance: distance);
      }
      return post;
    }));
    _log.fine('✅ Hoàn thành tính khoảng cách.');
    return enriched;
  }

  Future<List<Post>> _enrichPostsWithLocationDisplayName(List<Post> posts) async {
    if (posts.isEmpty) return [];
    _log.fine('📏 Bắt đầu lấy tên địa điểm cho ${posts.length} bài viết...');
    final enriched = await Future.wait(posts.map((post) async {
      if (post.address?.latitude != null && post.address?.longitude != null) {
        final name = await _geocodingService.getAddressFromPosition(post.address!.latitude, post.address!.longitude);
        final address = post.address!.copyWith(
          displayName: name,
        );
        return post.copyWith(address: address);
      }
      return post;
    }));
    _log.fine('✅ Hoàn thành tính khoảng cách.');
    return enriched;
  }

  @override
  Future<Either<PostFailure, void>> createPost({required Post post, required File imageFile}) async {
    return _handleErrors(() async {
      _log.info('👉 Bắt đầu tạo bài viết mới...');

      _log.fine('🔄 Đang tải ảnh lên Storage...');
      final imageUrl = await _storageService.uploadFile(
        folder: 'posts',
        file: imageFile,
        publicId: post.postId,
      );
      _log.fine('✅ Tải ảnh thành công. URL: $imageUrl');

      // Chuyển đổi từ UI Model 'Post' sang 'PostEntity' để lưu vào DB
      final postEntity = PostEntity(
        id: post.postId,
        authorId: post.authorUserId,
        imageUrl: imageUrl,
        blurHash: post.blurHash,
        dishName: post.dishName,
        locationName: post.diningLocationName,
        locationAddress: post.address?.exactAddress,
        latitude: post.address?.latitude,
        longitude: post.address?.longitude,
        price: post.price,
        insight: post.insight,
        createdAt: post.createdAt,
        foodCategory: post.foodCategory,
      );

      _log.fine('📤 Đang lưu bài viết vào bảng "posts"...');
      await _dbService.create(
        tableName: 'posts',
        data: postEntity.toJson(),
        fromJson: PostEntity.fromJson, // Dù không dùng kết quả, vẫn cần cung cấp
      );
      _log.info('🎉 Tạo bài viết thành công!');
    });
  }

  // Phương thức chung để gọi RPC và xử lý kết quả
  Future<List<Post>> _fetchPostsViaRpc({
    required String rpcName,
    required Map<String, dynamic> params,
  }) async {
    _log.info('📡 Gọi RPC "$rpcName" với params: $params');
    final data = await _supabase.rpc(rpcName, params: params);

    if (data is! List) {
      _log.warning('⚠️ RPC "$rpcName" không trả về một List. Kết quả: $data');
      return [];
    }

    final posts = data.map((json) => Post.fromJson(json as Map<String, dynamic>)).toList();
    _log.info('✅ RPC "$rpcName" thành công, nhận được ${posts.length} bài viết.');
    _log.info(posts.map(
      (post) {
        _log.info('${post.toString()} \n\n');
      },
    ));

    return await _enrichPostsWithDistance(posts);
  }

  Future<List<Post>> _getFilteredAndSortedPosts({
    required FilterSortParams params,
    // Các tham số tùy chọn để xác định loại feed
    bool isFollowingFeed = false,
    bool isSavedFeed = false,
    String? authorId,
  }) async {
    _log.info('📡 Bắt đầu xây dựng lệnh gọi RPC với bộ lọc: ${params.toVietnameseString}');

    const rpcName = 'get_posts_filtered'; // Tên hàm RPC mới/được cập nhật của bạn
    final currentUserId = _authenticationService.getCurrentUserId();


   // 2. Chuẩn bị các tham số cho RPC
    final rpcParams = <String, dynamic>{
      'p_user_id': currentUserId,
      'p_limit': params.limit,
      'p_sort_by': _sortFieldToColumn[params.sortOption.field] ?? 'created_at',
      'p_sort_direction': params.sortOption.direction == SortDirection.desc ? 'DESC' : 'ASC',

      // === THAY ĐỔI QUAN TRỌNG: GỬI ĐÚNG CON TRỎ ===
      'p_last_cursor_date': params.sortOption.field == SortField.datePosted ? (params.lastCursor as DateTime?)?.toUtc().toIso8601String() : null,
      'p_last_cursor_numeric': params.sortOption.field != SortField.datePosted ? params.lastCursor as int? : null,

      'p_categories': params.categories.isNotEmpty ? params.categories.map((c) => c.name).toList() : null,
      'p_min_price': params.range?.minPrice.toInt(),
      'p_max_price': params.range?.maxPrice == double.infinity ? null : params.range?.maxPrice.toInt(),

      // --- Các cờ cho loại feed ---
      'p_is_following_feed': isFollowingFeed,
      'p_is_saved_feed': isSavedFeed,
      'p_author_id': authorId,
    };

    // 3. Xử lý lọc khoảng cách (cần vị trí người dùng)
    if (params.distance != null) {
      _log.fine('🏃 Lọc theo khoảng cách, đang lấy vị trí người dùng...');
      try {
        final userPosition = await _locationService.getCurrentPosition();
        rpcParams['p_user_lat'] = userPosition.latitude;
        rpcParams['p_user_lng'] = userPosition.longitude;
        // Gửi đi khoảng cách tối đa, DB sẽ xử lý `> min` và `<= max`
        rpcParams['p_max_distance_meters'] = params.distance!.maxDistance == double.infinity ? null : params.distance!.maxDistance;
        rpcParams['p_min_distance_meters'] = params.distance!.minDistance;
      } catch (e) {
        _log.warning('⚠️ Không thể lấy vị trí người dùng để lọc khoảng cách.', e);
        // Có thể quyết định trả về danh sách rỗng hoặc bỏ qua bộ lọc khoảng cách
      }
    }

    // Loại bỏ các khóa có giá trị null để không gửi đi các tham số không cần thiết
    rpcParams.removeWhere((key, value) => value == null);

    _log.info('📡 Gọi RPC "$rpcName" với params: $rpcParams');
    final data = await _supabase.rpc(rpcName, params: rpcParams);

    if (data is! List) {
      _log.warning('⚠️ RPC "$rpcName" không trả về một List. Kết quả: $data');
      return [];
    }

    final posts = data.map((json) => Post.fromJson(json as Map<String, dynamic>)).toList();
    _log.info('✅ RPC "$rpcName" thành công, nhận được ${posts.length} bài viết.');

    // Làm giàu dữ liệu không cần thiết nữa nếu RPC đã tính toán khoảng cách.
    // Nếu RPC chỉ lọc, bạn vẫn cần bước làm giàu này để hiển thị.
    // Giả sử RPC đã trả về trường `distance`.
    return posts;
  }

  @override
  Future<Either<PostFailure, List<Post>>> getPosts({required FilterSortParams params}) {
    return _handleErrors(() => _getFilteredAndSortedPosts(params: params));
  }

  @override
  Future<Either<PostFailure, List<Post>>> getFollowingPosts({required FilterSortParams params}) {
    return _handleErrors(() => _getFilteredAndSortedPosts(params: params, isFollowingFeed: true));
  }

  @override
  Future<Either<PostFailure, List<Post>>> getPostsByUserId({required String? userId, required FilterSortParams params}) {
    return _handleErrors(() {
      final targetUserId = userId ?? _authenticationService.getCurrentUserId();
      if (targetUserId == null) return Future.value([]);
      return _getFilteredAndSortedPosts(params: params, authorId: targetUserId);
    });
  }

  @override
  Future<Either<PostFailure, List<Post>>> getSavedPosts({String? userId, required FilterSortParams params}) {
    return _handleErrors(() {
      final targetUserId = userId ?? _authenticationService.getCurrentUserId();
      if (targetUserId == null) return Future.value([]);
      // Đối với bài đã lưu, authorId là của chính người dùng đó
      return _getFilteredAndSortedPosts(params: params, isSavedFeed: true, authorId: targetUserId);
    });
  }

  @override
  Future<Either<PostFailure, Post>> getPostWithId(String postId) {
    // _handleErrors là một wrapper tuyệt vời để xử lý lỗi một cách tập trung.
    return _handleErrors(() async {
      _log.info('📥 Bắt đầu lấy chi tiết bài viết ID: $postId');
      final currentUserId = _authenticationService.getCurrentUserId();

      // SỬA ĐỔI:
      // 1. Gọi hàm mới: 'get_post_details_by_id'
      // 2. Truyền postId và userId VÀO BÊN TRONG params, nơi chúng thực sự thuộc về.
      final data = await _supabase.rpc('get_post_details_by_id', params: {
        'p_post_id': postId,
        'p_user_id': currentUserId,
      }).single(); // Giờ đây .single() sẽ hoạt động chính xác vì hàm RPC
      // được thiết kế để trả về đúng một dòng.

      final post = Post.fromJson(data);
      _log.info('✅ Lấy chi tiết bài viết thành công.: ${post.toString()}');

      // Các logic enrich (làm giàu dữ liệu) của bạn vẫn được giữ nguyên và hoạt động tốt.
      final enrichedList = await _enrichPostsWithLocationDisplayName(await _enrichPostsWithDistance([post]));

      return enrichedList.first;
    });
  }

  @override
  Future<Either<PostFailure, void>> likePost({required String postId, required String userId, required bool isLiked}) {
    return _handleErrors(() async {
      final action = isLiked ? "thích" : "bỏ thích";
      _log.info('🔄 Bắt đầu $action bài viết $postId cho người dùng $userId.');

      if (isLiked) {
        // Chèn vào bảng post_likes. Trigger sẽ tự tăng like_count.
        await _dbService.create(
          tableName: 'post_likes',
          data: {'post_id': postId, 'user_id': userId},
          fromJson: (json) => {}, // Dummy fromJson
        );
      } else {
        // Xóa khỏi bảng post_likes. Trigger sẽ tự giảm like_count.
        // Dùng raw client vì _dbService.delete chỉ hoạt động với 1 PK.
        await _supabase.from('post_likes').delete().match({'post_id': postId, 'user_id': userId});
      }
      _log.info('✅ Hoàn thành $action bài viết $postId thành công.');
    });
  }

  @override
  Future<Either<PostFailure, void>> savePost({required String postId, required String userId, required bool isSaved}) {
    return _handleErrors(() async {
      final action = isSaved ? "lưu" : "bỏ lưu";
      _log.info('🔄 Bắt đầu $action bài viết $postId cho người dùng $userId.');

      if (isSaved) {
        await _dbService.create(
          tableName: 'post_saves',
          data: {'post_id': postId, 'user_id': userId},
          fromJson: (json) => {},
        );
      } else {
        await _supabase.from('post_saves').delete().match({'post_id': postId, 'user_id': userId});
      }
      _log.info('✅ Hoàn thành $action bài viết $postId thành công.');
    });
  }

  @override
  Future<Either<PostFailure, void>> updatePost(Post post) {
    return _handleErrors(() async {
      _log.info('🔄 Bắt đầu cập nhật bài viết ID: ${post.postId}');
      final dataToUpdate = {
        'dish_name': post.dishName,
        'location_name': post.diningLocationName,
        'location_address': post.address?.exactAddress,
        'latitude': post.address?.latitude,
        'longitude': post.address?.longitude,
        'price': post.price,
        'insight': post.insight,
        'food_category': const FoodCategoryConverter().toJson(post.foodCategory),
      };

      // Loại bỏ các giá trị null để không ghi đè dữ liệu hiện có bằng null
      //dataToUpdate.removeWhere((key, value) => value == null);

      await _dbService.update(
        tableName: 'posts',
        id: post.postId,
        data: dataToUpdate,
        fromJson: (json) => {},
      );
      _log.info('✅ Cập nhật bài viết ${post.postId} thành công.');
      _log.info('Data to update: $dataToUpdate');
    });
  }

  @override
  Future<Either<PostFailure, void>> deletePost({required String postId}) {
    // 1. Sử dụng helper _handleErrors để bọc toàn bộ logic.
    // Nó sẽ bắt các lỗi nghiêm trọng từ _dbService (như PermissionDenied)
    // và dịch chúng sang Failure tương ứng.
    return _handleErrors(() async {
      _log.info('🗑️ Bắt đầu quá trình xóa bài viết ID: $postId');

      // BƯỚC QUAN TRỌNG: Xóa bản ghi trong cơ sở dữ liệu trước tiên.
      // Nếu bước này thất bại (ví dụ: không có quyền xóa), _handleErrors sẽ bắt
      // và ném ra Failure, kết thúc quá trình ngay lập tức.
      _log.fine('🗃️ Đang xóa bản ghi trong bảng "posts"...');
      await _dbService.delete(
        tableName: 'posts',
        id: postId,
      );
      _log.fine('✅ Xóa bản ghi trong database thành công. Các likes/saves liên quan đã được tự động xóa (ON DELETE CASCADE).');

      // BƯỚC DỌN DẸP: Xóa ảnh tương ứng khỏi Cloudinary.
      // Chúng ta bọc thao tác này trong một khối try-catch riêng để nó không
      // làm hỏng toàn bộ quá trình nếu có lỗi không nghiêm trọng.
      try {
        _log.fine('🖼️ Đang xóa ảnh từ Cloudinary...');
        await _storageService.deleteFile(
          folder: 'posts', // Thư mục chứa ảnh bài viết trên Cloudinary
          publicId: postId,
        );
        // Log thành công sẽ được ghi bởi chính StorageService.
      } on StorageServiceException catch (e, st) {
        // 2. Ghi nhận lỗi nhưng không ném lại.
        // Quá trình xóa post vẫn được coi là thành công đối với người dùng
        // vì bản ghi DB đã biến mất. Lỗi này dành cho đội ngũ phát triển để theo dõi.
        _log.warning(
          '⚠️ Lỗi không nghiêm trọng khi xóa ảnh cho postId: $postId. '
          'Bản ghi DB đã được xóa thành công. Lỗi Storage: ${e.message}',
          e,
          st,
        );
      }

      _log.info('🎉 Hoàn thành xóa bài viết ID: $postId.');
    });
  }

  @override
  Future<Either<PostFailure, List<Post>>> searchPosts({
    required String query,
    int page = 0,
    int hitsPerPage = 20,
  }) async {
    _log.info('🔍 Bắt đầu tìm kiếm bài viết với query: "$query"');
    try {
      // 1. Ủy quyền công việc tìm kiếm cho SearchService
      final searchResult = await _searchService.search(
        query: query,
        searchType: SearchableItem.posts,
        page: page,
        hitsPerPage: hitsPerPage,
      );
      _log.info('✅ Tìm kiếm thành công, nhận được ${searchResult.objectIds.length} bài viết.');
      if (searchResult.objectIds.isEmpty) {
        _log.info('🔍 Không tìm thấy bài viết nào với query: "$query"');
        return const Right([]); // Trả về danh sách rỗng nếu không có kết quả
      }
      _log.info('📥 Bắt đầu lấy chi tiết cho ${searchResult.objectIds.length} bài viết...');
      // 2. Lấy chi tiết bài viết từ Supabase bằng RPC;

      final currentUserId = _authenticationService.getCurrentUserId();
      final List<Post> posts = [];

      for (var postId in searchResult.objectIds) {
        _log.info('📥 Bắt đầu lấy chi tiết bài viết ID: $postId');
        final data = await _supabase.rpc('get_post_details_by_id', params: {
          'p_post_id': postId,
          'p_user_id': currentUserId,
        }).single();

        final post = Post.fromJson(data);
        posts.add(post);
        _log.info('✅ Lấy chi tiết bài viết thành công.: ${post.toString()}');
      }

      // 2. Làm giàu dữ liệu với khoảng cách
      final enrichedPosts = await _enrichPostsWithDistance(posts);

      // 3. Trả về kết quả thành công
      return Right(enrichedPosts);
    } on SearchServiceException catch (e, st) {
      // 4. Bắt các lỗi đã được định nghĩa từ SearchService và ánh xạ chúng sang PostFailure
      _log.severe('❌ Lỗi từ SearchService: ${e.runtimeType}', e, st);

      // Sử dụng switch expression để ánh xạ một cách gọn gàng và an toàn
      final failure = switch (e) {
        // Lỗi kết nối hoặc timeout từ Algolia -> ConnectionFailure
        SearchConnectionException() => const ConnectionFailure(),

        // Lỗi truy vấn không hợp lệ -> PostOperationFailure
        InvalidSearchQueryException() => PostOperationFailure(e.message),

        // Lỗi xác thực, không tìm thấy index, lỗi server Algolia -> gom vào một lỗi hoạt động chung
        // vì từ góc độ người dùng, đây là lỗi hệ thống.
        SearchApiException() => const PostOperationFailure('Dịch vụ tìm kiếm đang gặp sự cố. Vui lòng thử lại sau.'),

        // Lỗi phân tích dữ liệu -> Lỗi hệ thống/Dữ liệu không nhất quán
        SearchDataParsingException() => const PostOperationFailure('Không thể đọc dữ liệu tìm kiếm.'),
      };
      return Left(failure);
    } on Exception catch (e, st) {
      // 5. Bắt tất cả các lỗi không mong muốn khác
      _log.severe('❌ Lỗi không xác định trong quá trình tìm kiếm', e, st);
      return const Left(UnknownFailure());
    }
  }
}
