// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dishlocal/core/json_converter/food_category_converter.dart';
import 'package:dishlocal/data/categories/post/model/filter_sort_model/filter_sort_params.dart';
import 'package:dishlocal/data/categories/post/model/filter_sort_model/sort_option.dart';
import 'package:dishlocal/data/services/database_service/entity/post_entity.dart';
import 'package:dishlocal/data/services/database_service/entity/post_review_entity.dart';
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
import 'package:uuid/uuid.dart';

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
  Future<Either<PostFailure, Post>> createPost({required Post post, required File imageFile}) async {
    return _handleErrors(() async {
      _log.info('👉 Bắt đầu tạo bài viết mới...');

      // --- BƯỚC 1: TẢI ẢNH LÊN STORAGE ---
      _log.fine('🔄 Đang tải ảnh lên Storage...');
      final imageUrl = await _storageService.uploadFile(
        folder: 'posts',
        file: imageFile,
        publicId: post.postId,
      );
      _log.fine('✅ Tải ảnh thành công. URL: $imageUrl');

      // --- BƯỚC 2: TẠO BẢN GHI CHÍNH TRONG BẢNG "posts" ---
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
        fromJson: PostEntity.fromJson,
      );
      _log.fine('✅ Lưu bài viết vào bảng "posts" thành công.');

      // --- BƯỚC 3 (TỐI ƯU): TẠO TẤT CẢ REVIEW BẰNG MỘT LỆNH GỌI RPC ---
      // Lọc ra các review có rating > 0 để chèn vào DB.
      final List<Map<String, dynamic>> reviewsToInsert = post.reviews.where((item) => item.rating > 0).map((item) {
        // Chuyển ReviewItem (UI model) thành JSON.
        final json = item.toJson();
        // QUAN TRỌNG: Thêm 'post_id' vào mỗi review để liên kết chúng.
        json['post_id'] = post.postId;
        return json;
      }).toList();

      // Chỉ gọi RPC nếu có review để chèn.
      if (reviewsToInsert.isNotEmpty) {
        _log.fine('📤 Đang lưu ${reviewsToInsert.length} đánh giá vào bảng "post_reviews" qua RPC...');
        await _supabase.rpc(
          'upsert_post_reviews',
          params: {'reviews_data': reviewsToInsert},
        );
        _log.fine('✅ Lưu các review thành công.');
      }

      _log.info('🎉 Tạo bài viết thành công!');
      return post.copyWith(imageUrl: imageUrl);
    });
  }

  // Phương thức chung để gọi RPC và xử lý kết quả
  // Future<List<Post>> _fetchPostsViaRpc({
  //   required String rpcName,
  //   required Map<String, dynamic> params,
  // }) async {
  //   _log.info('📡 Gọi RPC "$rpcName" với params: $params');
  //   final data = await _supabase.rpc(rpcName, params: params);

  //   if (data is! List) {
  //     _log.warning('⚠️ RPC "$rpcName" không trả về một List. Kết quả: $data');
  //     return [];
  //   }

  //   final posts = data.map((json) => Post.fromJson(json as Map<String, dynamic>)).toList();
  //   _log.info('✅ RPC "$rpcName" thành công, nhận được ${posts.length} bài viết.');
  //   _log.info(posts.map(
  //     (post) {
  //       _log.info('${post.toString()} \n\n');
  //     },
  //   ));

  //   return await _enrichPostsWithDistance(posts);
  // }

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
    try {
      final userPosition = await _locationService.getCurrentPosition();
      rpcParams['p_user_lat'] = userPosition.latitude;
      rpcParams['p_user_lng'] = userPosition.longitude;
    } catch (e) {
      _log.warning('⚠️ Không thể lấy vị trí người dùng để tính khoảng cách.', e);
      // Bỏ qua, không gửi p_user_lat và p_user_lng
    }

    if (params.distance != null) {
      rpcParams['p_max_distance_meters'] = params.distance!.maxDistance == double.infinity ? null : params.distance!.maxDistance;
      rpcParams['p_min_distance_meters'] = params.distance!.minDistance;
    }

    if (params.lastCursor is DateTime) {
      rpcParams['p_last_cursor_date'] = (params.lastCursor as DateTime).toUtc().toIso8601String();
    } else if (params.lastCursor is int) {
      rpcParams['p_last_cursor_numeric'] = params.lastCursor;
      // Đồng thời, gửi đi con trỏ phụ để phá vỡ thế hòa
      if (params.lastDateCursorForTieBreak != null) {
        rpcParams['p_last_cursor_date'] = params.lastDateCursorForTieBreak!.toUtc().toIso8601String();
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
      _log.fine('📥 Nhận được dữ liệu raw: ${data.toString()}');

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
      _log.info('🔄 Bắt đầu cập nhật bài viết và các review liên quan cho ID: ${post.postId}');

      // --- BƯỚC 1: CẬP NHẬT THÔNG TIN CHÍNH CỦA BÀI POST ---
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

      // Không cần remove null vì `update` của Supabase sẽ bỏ qua chúng.
      _log.fine('📝 Dữ liệu cập nhật cho bảng "posts": $dataToUpdate');
      await _dbService.update(
        tableName: 'posts',
        id: post.postId,
        data: dataToUpdate,
        fromJson: (json) => {}, // Không cần kết quả trả về
      );
      _log.fine('✅ Cập nhật bảng "posts" thành công.');

      // --- BƯỚC 2: UPSERT CÁC REVIEW ---
      _log.fine('🔄 Chuẩn bị dữ liệu để upsert các review qua RPC...');

      final List<Map<String, dynamic>> reviewsToUpsert = post.reviews.where((item) => item.rating > 0).map((item) {
        final json = item.toJson();
        json['post_id'] = post.postId;
        return json;
      }).toList();

      if (reviewsToUpsert.isNotEmpty) {
        _log.fine('📤 Đang gọi RPC "upsert_post_reviews" với ${reviewsToUpsert.length} review...');
        // Thay thế _dbService.upsert bằng một lệnh gọi RPC trực tiếp
        await _supabase.rpc(
          'upsert_post_reviews',
          params: {
            'reviews_data': reviewsToUpsert // Truyền toàn bộ danh sách vào tham số của hàm
          },
        );
        _log.fine('✅ Gọi RPC "upsert_post_reviews" thành công.');
      } else {
        _log.info('ℹ️ Không có review nào hợp lệ để upsert.');
      }

      // --- BƯỚC 3 (TÙY CHỌN): XÓA CÁC REVIEW KHÔNG CÒN HỢP LỆ ---
      // Nếu người dùng chỉnh sửa một review từ 4 sao về 0 sao, bước 2 sẽ không
      // upsert nó. Dòng đó vẫn còn trong DB. Chúng ta cần xóa nó đi.

      // Lấy danh sách các category mà người dùng đã đặt lại về 0.
      final categoriesToReset = post.reviews.where((item) => item.rating == 0).map((item) => item.category.name).toList();

      if (categoriesToReset.isNotEmpty) {
        _log.fine('🗑️ Đang xóa các review đã bị đặt lại về 0 sao cho các category: $categoriesToReset');

        // Bắt đầu xây dựng một bộ lọc 'OR'
        final orFilter = categoriesToReset
            .map((categoryName) => 'category.eq.$categoryName') // Tạo các cặp 'cột.toán_tử.giá_trị'
            .join(','); // Nối chúng bằng dấu phẩy

        await _supabase
            .from('post_reviews')
            .delete()
            .eq('post_id', post.postId) // Điều kiện VÀ: post_id phải khớp
            .or(orFilter); // Điều kiện HOẶC: category là một trong các giá trị trong danh sách

        _log.fine('✅ Xóa các review không hợp lệ thành công.');
      }

      _log.info('🎉 Hoàn thành cập nhật bài viết và các review cho ID: ${post.postId}');
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

  Future<String?> _getLatLngForGeoSearch() async {
    // Logic lấy vị trí hiện tại của người dùng từ LocationService
    // và trả về chuỗi "lat,lng", ví dụ: "21.028511,105.804817"
    // Trả về null nếu không lấy được vị trí.
    try {
      final position = await _locationService.getCurrentPosition();
      return '${position.latitude},${position.longitude}';
    } catch (e) {
      return null;
    }
  }

  @override
  Future<Either<PostFailure, List<Post>>> searchPosts({
    required String query,
    int page = 0,
    int hitsPerPage = 20,
    FilterSortParams? filterParams,
  }) async {
    _log.info('🔍 Bắt đầu tìm kiếm bài viết với query: "$query"');
    try {
      // =======================================================================
      // === THAY ĐỔI QUAN TRỌNG Ở ĐÂY ==========================================
      // =======================================================================

      // 1. Khai báo latLngForGeoSearch là null ban đầu
      String? latLngForGeoSearch;

      // 2. Chỉ lấy vị trí và gán giá trị cho latLngForGeoSearch
      //    NẾU người dùng đã chọn một bộ lọc khoảng cách.
      if (filterParams?.distance != null) {
        _log.info('🚶 Người dùng đã lọc theo khoảng cách, đang lấy vị trí...');
        latLngForGeoSearch = await _getLatLngForGeoSearch();
      }

      // 3. Truyền các giá trị đã được xử lý xuống SearchService
      final searchResult = await _searchService.search(
        query: query,
        searchType: SearchableItem.posts,
        page: page,
        hitsPerPage: hitsPerPage,
        filterParams: filterParams,
        latLongForGeoSearch: latLngForGeoSearch, // Có thể là null hoặc một chuỗi
      );
      _log.info('✅ Tìm kiếm thành công, nhận được ${searchResult.objectIds.length} ID bài viết.');

      if (searchResult.objectIds.isEmpty) {
        return const Right([]); // Trả về danh sách rỗng nếu không có kết quả
      }

      // 2. Lấy chi tiết của TẤT CẢ bài viết trong MỘT lần gọi RPC
      _log.info('📥 Bắt đầu lấy chi tiết cho ${searchResult.objectIds.length} bài viết trong một lần gọi...');
      final currentUserId = _authenticationService.getCurrentUserId();

      final List<dynamic> postsData = await _supabase.rpc('get_post_details_by_ids', params: {
        'p_post_ids': searchResult.objectIds, // <<< Truyền vào toàn bộ mảng ID
        'p_user_id': currentUserId,
      });

      // Chuyển đổi kết quả JSON thành danh sách các đối tượng Post
      final List<Post> unsortedPosts = postsData.map((json) => Post.fromJson(json as Map<String, dynamic>)).toList();

      // 3. SẮP XẾP LẠI KẾT QUẢ THEO THỨ TỰ TỪ DỊCH VỤ TÌM KIẾM
      // Database không đảm bảo thứ tự trả về, nhưng Algolia đã sắp xếp theo mức độ liên quan.
      // Chúng ta cần sắp xếp lại danh sách `unsortedPosts` để khớp với thứ tự của `searchResult.objectIds`.
      final postsById = {for (var post in unsortedPosts) post.postId: post};
      final List<Post> sortedPosts = searchResult.objectIds
          .map((id) => postsById[id])
          .whereType<Post>() // Lọc ra các post không tìm thấy (nếu có)
          .toList();

      _log.info('✅ Lấy và sắp xếp chi tiết bài viết thành công.');

      // 4. Làm giàu dữ liệu với khoảng cách (enrichment)
      // Bước này vẫn cần thiết vì hàm RPC tìm kiếm không tính khoảng cách để tối ưu.
      final enrichedPosts = await _enrichPostsWithDistance(sortedPosts);

      // 5. Trả về kết quả thành công
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

  @override
  Future<Either<PostFailure, List<Post>>> getRecommendedPosts({
    required int page,
    required int pageSize,
  }) {
    return _handleErrors(() async {
      _log.info('📥 Bắt đầu lấy trang $page các bài viết được gợi ý (kích thước trang: $pageSize)...');

      // =======================================================================
      // === BƯỚC 1: GỌI RPC VÀ LOG DỮ LIỆU THÔ (RAW DATA) ======================
      // =======================================================================
      final List<dynamic> data = await _supabase.rpc(
        'get_recommended_posts_paginated',
        params: {
          'p_page_number': page,
          'p_page_size': pageSize,
        },
      );

      // In ra dữ liệu thô để kiểm tra thứ tự từ server
      _log.info('🗄️ DỮ LIỆU THÔ TỪ SUPABASE RPC:');
      for (var i = 0; i < data.length; i++) {
        final item = data[i] as Map<String, dynamic>;
        // In ra tên món ăn và điểm số để dễ so sánh
        _log.info('  [${i + 1}] ${item['dishName']} - score: ${item['score']}');
      }

      // =======================================================================
      // === BƯỚC 2: CHUYỂN ĐỔI VÀ LOG DANH SÁCH POST ==========================
      // =======================================================================
      final posts = data.map((json) => Post.fromJson(json as Map<String, dynamic>)).toList();
      _log.info('✅ Chuyển đổi thành công ${posts.length} bài viết gợi ý.');

      // In ra danh sách Post sau khi chuyển đổi
      _log.info('📜 DANH SÁCH POST SAU KHI CHUYỂN ĐỔI (TRƯỚC KHI LÀM GIÀU):');
      for (var i = 0; i < posts.length; i++) {
        _log.info('  [${i + 1}] ${posts[i].dishName} - score: ${posts[i].score} (lấy từ Post object)');
      }

      // =======================================================================
      // === BƯỚC 3: LÀM GIÀU DỮ LIỆU VÀ LOG KẾT QUẢ CUỐI CÙNG =================
      // =======================================================================
      if (posts.isNotEmpty) {
        final enrichedPosts = await _enrichPostsWithDistance(posts);

        // In ra danh sách Post sau khi đã được làm giàu
        _log.info('✨ DANH SÁCH POST SAU KHI LÀM GIÀU (TRƯỚC KHI TRẢ VỀ):');
        for (var i = 0; i < enrichedPosts.length; i++) {
          _log.info('  [${i + 1}] ${enrichedPosts[i].dishName} - distance: ${enrichedPosts[i].distance}');
        }

        return enrichedPosts;
      }

      return posts;
    });
  }

  @override
  Future<Either<PostFailure, void>> recordPostView({
    required String postId,
    int? durationInMs,
  }) {
    // Sử dụng helper `_handleErrors` để tự động bắt lỗi và chuyển đổi sang PostFailure
    return _handleErrors(() async {
      _log.info('📝 Ghi nhận lượt xem cho bài viết ID: $postId...');

      // 1. Chuẩn bị các tham số cho lệnh gọi RPC
      final params = <String, dynamic>{
        'p_post_id': postId,
      };

      // 2. Chỉ thêm tham số thời gian xem nếu nó hợp lệ
      if (durationInMs != null && durationInMs > 0) {
        params['p_view_duration_ms'] = durationInMs;
        _log.fine('... với thời gian xem: ${durationInMs}ms');
      }

      // 3. Gọi hàm RPC trên Supabase
      // Hàm này không trả về dữ liệu (void), nên chúng ta chỉ cần `await` nó
      // để đảm bảo nó hoàn thành hoặc ném ra lỗi.
      await _supabase.rpc(
        'record_post_view',
        params: params,
      );

      _log.fine('✅ Ghi nhận lượt xem thành công.');
    });
  }

  @override
  Future<Either<PostFailure, List<Post>>> getTrendingPosts({
    required int page,
    required int pageSize,
  }) {
    // Tận dụng lại cơ chế xử lý lỗi hiện có
    return _handleErrors(() async {
      _log.info('📥 Bắt đầu lấy trang $page các bài viết thịnh hành (fallback)...');

      final List<dynamic> data = await _supabase.rpc(
        'get_trending_posts_paginated',
        params: {
          'p_page_number': page,
          'p_page_size': pageSize,
        },
      );

      final posts = data.map((json) => Post.fromJson(json as Map<String, dynamic>)).toList();
      _log.info('✅ Lấy thành công ${posts.length} bài viết thịnh hành.');

      // Vẫn làm giàu dữ liệu để đảm bảo tính nhất quán
      if (posts.isNotEmpty) {
        return _enrichPostsWithDistance(posts);
      }

      return posts;
    });
  }
}
