// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:dishlocal/data/categories/app_user/repository/interface/app_user_repository.dart';
import 'package:dishlocal/data/services/authentication_service/interface/authentication_service.dart';
import 'package:dishlocal/data/services/database_service/model/batch_operation.dart';
import 'package:dishlocal/data/services/database_service/model/server_timestamp.dart';
import 'package:dishlocal/data/services/distance_service/interface/distance_service.dart';
import 'package:dishlocal/data/services/location_service/interface/location_service.dart';
import 'package:dishlocal/data/services/storage_service/interface/storage_service.dart';
import 'package:injectable/injectable.dart';
import 'package:logging/logging.dart';

import 'package:dishlocal/data/categories/post/failure/post_failure.dart';
import 'package:dishlocal/data/categories/post/model/post.dart';
import 'package:dishlocal/data/categories/post/repository/interface/post_repository.dart';
import 'package:dishlocal/data/services/database_service/interface/no_sql_database_service.dart';
import 'package:dishlocal/ui/features/post/view/small_post.dart';

@LazySingleton(as: PostRepository)
class RemotePostRepositoryImpl implements PostRepository {
  final _log = Logger('RemotePostRepositoryImpl');
  final StorageService _storageService;
  final NoSqlDatabaseService _databaseService;
  final DistanceService _distanceService;
  final LocationService _locationService;
  final AuthenticationService _authenticationService;

  RemotePostRepositoryImpl(
    this._storageService,
    this._databaseService,
    this._distanceService,
    this._locationService,
    this._authenticationService,
  );

  Future<List<Post>> _enrichPostsWithUserData(List<Post> posts) async {
    if (posts.isEmpty) return [];

    // Lấy ID người dùng hiện tại
    final currentUserId = _authenticationService.getCurrentUserId();

    // Trích xuất danh sách Post ID
    final postIds = posts.map((p) => p.postId).toList();

    // Lấy trạng thái Like và Save hàng loạt (chỉ khi user đã đăng nhập)
    Set<String> likedPostIds = {};
    Set<String> savedPostIds = {};

    if (currentUserId != null && currentUserId.isNotEmpty) {
      final results = await Future.wait([
        _databaseService.getDocumentsWhereIdIn(
          collection: 'users/$currentUserId/likes',
          ids: postIds,
        ),
        _databaseService.getDocumentsWhereIdIn(
          collection: 'users/$currentUserId/savedPosts',
          ids: postIds,
        ),
      ]);
      likedPostIds = results[0].map((doc) => doc['id'] as String).toSet();
      savedPostIds = results[1].map((doc) => doc['id'] as String).toSet();
    }

    // Lấy tọa độ người dùng hiện tại
    final userPosition = await _locationService.getCurrentPosition();

    // Tổng hợp tất cả dữ liệu
    final postsWithFullData = await Future.wait(posts.map((post) async {
      final distance = (post.address?.latitude != null && post.address?.longitude != null)
          ? await _distanceService.calculateDistance(
              fromLat: userPosition.latitude,
              fromLong: userPosition.longitude,
              toLat: post.address!.latitude,
              toLong: post.address!.longitude,
            )
          : null;

      final isLiked = likedPostIds.contains(post.postId);
      final isSaved = savedPostIds.contains(post.postId);

      return post.copyWith(
        distance: distance,
        isLiked: isLiked,
        isSaved: isSaved,
      );
    }));

    return postsWithFullData;
  }

  @override
  Future<Either<PostFailure, void>> createPost({
    required Post post,
    required File imageFile,
  }) async {
    _log.info('👉 Bắt đầu tạo bài viết với postId: ${post.postId}');

    try {
      _log.fine('🔄 Đang tải ảnh lên Storage với postId: ${post.postId}...');
      final url = await _storageService.uploadFile(
        path: 'path',
        file: imageFile,
        publicId: post.postId,
      );
      _log.fine('✅ Tải ảnh thành công. URL: $url');

      final postWithImage = post.copyWith(imageUrl: url);
      _log.fine('📤 Đang lưu bài viết vào Firestore với dữ liệu: ${postWithImage.toJson()}');

      await _databaseService.setDocument(
        collection: 'posts',
        docId: post.postId,
        data: postWithImage.toJson(),
      );

      _log.info('🎉 Tạo bài viết thành công: ${post.postId}');
      return const Right(null);
    } catch (e, stackTrace) {
      _log.severe('❌ Lỗi khi tạo bài viết: ${post.postId}', e, stackTrace);
      return const Left(UnknownFailure());
    }
  }

  @override
  Future<Either<PostFailure, List<Post>>> getPosts({
    int limit = 10,
    DateTime? startAfter,
  }) async {
    _log.info('📥 Lấy danh sách post MỚI NHẤT...');
    try {
      final rawPostsData = await _databaseService.getDocuments(
        collection: 'posts',
        orderBy: 'createdAt',
        descending: true,
        limit: limit,
        startAfter: startAfter,
      );

      if (rawPostsData.isEmpty) {
        return right([]);
      }

      final posts = rawPostsData.map((json) => Post.fromJson(json)).toList();

      // Gọi hàm helper để làm giàu dữ liệu
      final enrichedPosts = await _enrichPostsWithUserData(posts);

      _log.info('🎉 Hoàn thành lấy và tổng hợp dữ liệu cho ${enrichedPosts.length} bài viết mới nhất.');
      return right(enrichedPosts);
    } catch (e, stackTrace) {
      _log.severe('❌ Lỗi khi lấy danh sách bài viết mới nhất', e, stackTrace);
      return const Left(UnknownFailure());
    }
  }

  @override
  Future<Either<PostFailure, void>> likePost({
    required String postId,
    required String userId,
    required bool isLiked,
  }) async {
    final action = isLiked ? "thích" : "bỏ thích";
    _log.info('🔄 Bắt đầu $action bài viết $postId cho người dùng $userId.');

    try {
      // 1. Định nghĩa các đường dẫn cần thao tác
      final postPath = 'posts/$postId';
      final userLikePath = 'users/$userId/likes/$postId';
      // (Optional) Đường dẫn để tra cứu ngược, nếu bạn cần
      // final postLikePath = 'likes/$postId/users/$userId';

      // 2. Chuẩn bị danh sách các thao tác
      final List<BatchOperation> operations = [];
      final incrementValue = isLiked ? 1 : -1;

      // Thao tác 1: Cập nhật `likeCount` trên tài liệu `post`
      operations.add(BatchOperation.update(
        path: postPath,
        data: {'likeCount': FieldIncrement(incrementValue)},
      ));

      if (isLiked) {
        // Thao tác 2 (khi thích): Ghi lại rằng user này đã thích bài viết
        operations.add(BatchOperation.set(
          path: userLikePath,
          data: {'likedAt': const ServerTimestamp()},
        ));
      } else {
        // Thao tác 2 (khi bỏ thích): Xóa bản ghi user đã thích bài viết
        operations.add(BatchOperation.delete(path: userLikePath));
      }

      // 3. Gửi toàn bộ các thao tác đến service để thực thi nguyên tử
      await _databaseService.executeBatch(operations);

      _log.info('✅ Hoàn thành $action bài viết $postId thành công.');
      return right(null);
    } catch (e, stackTrace) {
      _log.severe(
        '❌ Lỗi khi $action bài viết $postId cho người dùng $userId.',
        e,
        stackTrace,
      );
      // Bạn có thể tạo một lớp Failure cụ thể hơn nếu cần
      return left(const UnknownFailure());
    }
  }

  @override
  Future<Either<PostFailure, void>> savePost({
    required String postId,
    required String userId,
    required bool isSaved,
  }) async {
    final action = isSaved ? "lưu" : "bỏ lưu";
    _log.info('🔄 Bắt đầu $action bài viết $postId cho người dùng $userId.');

    try {
      // 1. Định nghĩa các đường dẫn cần thao tác
      final postPath = 'posts/$postId';
      final userSavedPostPath = 'users/$userId/savedPosts/$postId';
      // (Optional) Đường dẫn để tra cứu ngược, nếu bạn cần
      // final postSavedByPath = 'posts/$postId/savedBy/$userId';

      // 2. Chuẩn bị danh sách các thao tác
      final List<BatchOperation> operations = [];
      final incrementValue = isSaved ? 1 : -1;

      // Thao tác 1: Cập nhật `saveCount` trên tài liệu `post`
      operations.add(BatchOperation.update(
        path: postPath,
        data: {'saveCount': FieldIncrement(incrementValue)},
      ));

      if (isSaved) {
        // Thao tác 2 (khi lưu): Ghi lại rằng user này đã lưu bài viết
        operations.add(BatchOperation.set(
          path: userSavedPostPath,
          data: {'savedAt': const ServerTimestamp()},
        ));
      } else {
        // Thao tác 2 (khi bỏ lưu): Xóa bản ghi user đã lưu bài viết
        operations.add(BatchOperation.delete(path: userSavedPostPath));
      }

      // 3. Gửi toàn bộ các thao tác đến service để thực thi nguyên tử
      await _databaseService.executeBatch(operations);

      _log.info('✅ Hoàn thành $action bài viết $postId thành công.');
      return right(null);
    } catch (e, stackTrace) {
      _log.severe(
        '❌ Lỗi khi $action bài viết $postId cho người dùng $userId.',
        e,
        stackTrace,
      );
      return left(const UnknownFailure());
    }
  }

  @override
  Future<Either<PostFailure, Post>> getPostWithId(String postId) async {
    _log.info('📥 Bắt đầu lấy post với postId: $postId');

    try {
      // Bước 1: Lấy thông tin người dùng hiện tại
      final currentUserId = _authenticationService.getCurrentUserId();
      _log.fine('🆔 User ID hiện tại: $currentUserId');

      // Bước 2: Lấy dữ liệu bài viết từ Firestore
      final json = await _databaseService.getDocument(
        collection: 'posts',
        docId: postId,
      );

      if (json == null) {
        _log.warning('⚠️ Không tìm thấy post với postId: $postId');
        return left(const UnknownFailure()); // Bạn có thể định nghĩa PostNotFound() nếu chưa có
      }

      final post = Post.fromJson(json);

      // Bước 3: Trạng thái liked/saved
      bool isLiked = false;
      bool isSaved = false;

      if (currentUserId != null && currentUserId.isNotEmpty) {
        final results = await Future.wait([
          _databaseService.getDocument(
            collection: 'users/$currentUserId/likes',
            docId: postId,
          ),
          _databaseService.getDocument(
            collection: 'users/$currentUserId/savedPosts',
            docId: postId,
          ),
        ]);

        isLiked = results[0] != null;
        isSaved = results[1] != null;
      }

      // Bước 4: Tính khoảng cách nếu có địa chỉ
      double? distance;
      if (post.address?.latitude != null && post.address?.longitude != null) {
        final userPosition = await _locationService.getCurrentPosition();
        distance = await _distanceService.calculateDistance(
          fromLat: userPosition.latitude,
          fromLong: userPosition.longitude,
          toLat: post.address!.latitude,
          toLong: post.address!.longitude,
        );
      }

      final enrichedPost = post.copyWith(
        isLiked: isLiked,
        isSaved: isSaved,
        distance: distance,
      );

      _log.info('✅ Lấy bài viết thành công: $postId');
      return right(enrichedPost);
    } catch (e, stackTrace) {
      _log.severe('❌ Lỗi khi lấy bài viết với postId: $postId', e, stackTrace);
      return const Left(UnknownFailure());
    }
  }

  @override
  Future<Either<PostFailure, List<Post>>> getSavedPosts({
    String? userId, // <-- Thêm vào đây
    int limit = 10,
    DateTime? startAfter,
  }) async {
    _log.info('📥 Bắt đầu lấy danh sách bài viết đã lưu...');
    try {
      // --- BẮT ĐẦU SỬA ĐỔI ---

      // Bước 1: Xác định ID mục tiêu (giống hệt cách làm với getPostsByUserId)
      final String? targetUserId = userId ?? _authenticationService.getCurrentUserId();

      // Bước 2: Kiểm tra ID mục tiêu
      if (targetUserId == null || targetUserId.isEmpty) {
        _log.warning('⚠️ UserID mục tiêu rỗng. Không thể lấy bài viết đã lưu.');
        return right([]);
      }
      _log.fine('🆔 Lấy bài viết đã lưu cho người dùng: $targetUserId');

      // Bước 3: Lấy danh sách tham chiếu bài viết đã lưu từ người dùng mục tiêu
      final savedPostRefs = await _databaseService.getDocuments(
        collection: 'users/$targetUserId/savedPosts', // <-- SỬ DỤNG targetUserId
        orderBy: 'savedAt',
        descending: true,
        limit: limit,
        startAfter: startAfter,
      );

      // --- KẾT THÚC SỬA ĐỔI --- (Phần còn lại giữ nguyên logic)

      if (savedPostRefs.isEmpty) {
        _log.info('✅ Không còn bài viết nào đã lưu để hiển thị.');
        return right([]);
      }

      final postIds = savedPostRefs.map((ref) => ref['id'] as String).toList();
      _log.fine('🔍 Tìm thấy ${postIds.length} ID bài viết đã lưu: $postIds');

      final rawPostsData = await _databaseService.getDocumentsWhereIdIn(
        collection: 'posts',
        ids: postIds,
      );

      final posts = rawPostsData.map((json) => Post.fromJson(json)).toList();
      final enrichedPosts = await _enrichPostsWithUserData(posts);

      final postIdToPostMap = {for (var post in enrichedPosts) post.postId: post};
      final sortedEnrichedPosts = postIds.map((id) => postIdToPostMap[id]).where((post) => post != null).cast<Post>().toList();

      _log.info('🎉 Lấy thành công ${sortedEnrichedPosts.length} bài viết đã lưu.');
      return right(sortedEnrichedPosts);
    } catch (e, stackTrace) {
      _log.severe('❌ Lỗi khi lấy danh sách bài viết đã lưu', e, stackTrace);
      return const Left(UnknownFailure());
    }
  }

  @override
  Future<Either<PostFailure, List<Post>>> getFollowingPosts({
    int limit = 10,
    DateTime? startAfter,
  }) async {
    _log.info('📥 Bắt đầu lấy danh sách bài viết từ những người đang theo dõi...');
    try {
      // Bước 1: Lấy ID người dùng hiện tại
      final currentUserId = _authenticationService.getCurrentUserId();
      if (currentUserId == null || currentUserId.isEmpty) {
        _log.warning('⚠️ Người dùng chưa đăng nhập. Không thể lấy bài viết đang theo dõi.');
        return right([]);
      }

      // Bước 2: Lấy danh sách ID của những người mà user này đang theo dõi
      final followingDocs = await _databaseService.getDocuments(
        collection: 'users/$currentUserId/following',
        limit: 1000, // Lấy tối đa 1000 người đang theo dõi
      );
      final followingUserIds = followingDocs.map((doc) => doc['id'] as String).toList();

      if (followingUserIds.isEmpty) {
        _log.info('✅ Người dùng chưa theo dõi ai. Trả về danh sách trống.');
        return right([]);
      }
      _log.fine('🔍 Người dùng đang theo dõi ${followingUserIds.length} người.');

      // Bước 3: Sử dụng hàm mới getDocumentsWhere để lấy bài viết có authorId nằm trong danh sách
      final rawPostsData = await _databaseService.getDocumentsWhere(
        collection: 'posts',
        field: 'authorUserId', // Tên trường chứa ID của người đăng bài
        values: followingUserIds,
        orderBy: 'createdAt',
        descending: true,
        limit: limit,
        startAfter: startAfter,
      );

      final posts = rawPostsData.map((json) => Post.fromJson(json)).toList();

      // Bước 4: Làm giàu dữ liệu (tính khoảng cách, trạng thái like/save)
      final enrichedPosts = await _enrichPostsWithUserData(posts);

      _log.info('🎉 Lấy thành công ${enrichedPosts.length} bài viết từ những người đang theo dõi.');
      return right(enrichedPosts);
    } catch (e, stackTrace) {
      _log.severe('❌ Lỗi khi lấy danh sách bài viết đang theo dõi', e, stackTrace);
      return const Left(UnknownFailure());
    }
  }

  /// IMPLEMENT TÍNH NĂNG MỚI: LẤY BÀI VIẾT CỦA MỘT USER
  @override
  Future<Either<PostFailure, List<Post>>> getPostsByUserId({
    required String? userId,
    int limit = 10,
    DateTime? startAfter,
  }) async {
    // --- BẮT ĐẦU SỬA ĐỔI ---

    // Bước 1: Xác định ID mục tiêu
    // Nếu userId được cung cấp, dùng nó. Nếu không, lấy ID của người dùng đang đăng nhập.
    final String? targetUserId = userId ?? _authenticationService.getCurrentUserId();

    _log.info('📥 Bắt đầu lấy bài viết của người dùng: $targetUserId');

    // Bước 2: Kiểm tra lại ID mục tiêu. Nếu vẫn rỗng (VD: chưa đăng nhập và cũng không có userId) thì dừng lại.
    if (targetUserId == null || targetUserId.isEmpty) {
      _log.warning('⚠️ UserID mục tiêu rỗng. Không thể lấy bài viết.');
      return right([]);
    }

    try {
      // Sử dụng `targetUserId` đã được xác định cho truy vấn
      final rawPostsData = await _databaseService.getDocumentsWhere(
        collection: 'posts',
        field: 'authorUserId',
        values: [targetUserId], // Sử dụng targetUserId ở đây
        orderBy: 'createdAt',
        descending: true,
        limit: limit,
        startAfter: startAfter,
      );

      // --- KẾT THÚC SỬA ĐỔI --- (Phần còn lại giữ nguyên)

      final posts = rawPostsData.map((json) => Post.fromJson(json)).toList();

      // Làm giàu dữ liệu
      final enrichedPosts = await _enrichPostsWithUserData(posts);

      _log.info('🎉 Lấy thành công ${enrichedPosts.length} bài viết của người dùng $targetUserId.');
      return right(enrichedPosts);
    } catch (e, stackTrace) {
      _log.severe('❌ Lỗi khi lấy bài viết của người dùng $targetUserId', e, stackTrace);
      return const Left(UnknownFailure());
    }
  }

  @override
  Future<Either<PostFailure, void>> updatePost(Post post) async {
    _log.info('🔄 Bắt đầu cập nhật bài viết với postId: ${post.postId}');
    try {
      // Chúng ta chỉ cập nhật các trường có thể thay đổi,
      // không ghi đè toàn bộ document để tránh xóa nhầm các trường
      // được quản lý bởi server như likeCount, saveCount.
      final Map<String, dynamic> dataToUpdate = {
        'address': post.address?.toJson(),
        'diningLocationName': post.diningLocationName,
        'dishName': post.dishName,
        'insight': post.insight,
        'price': post.price,
      };

      // Nếu người dùng có thể thay đổi cả ảnh, logic sẽ phức tạp hơn một chút
      // (xóa ảnh cũ, upload ảnh mới, lấy url mới rồi cập nhật vào dataToUpdate)
      // Nhưng ở đây ta giả định chỉ cập nhật dữ liệu text.

      await _databaseService.updateDocument(
        collection: 'posts',
        docId: post.postId,
        data: dataToUpdate,
      );

      _log.info('✅ Cập nhật bài viết ${post.postId} thành công.');
      return right(null);
    } catch (e, stackTrace) {
      _log.severe('❌ Lỗi khi cập nhật bài viết ${post.postId}', e, stackTrace);
      return left(const UnknownFailure());
    }
  }
}
