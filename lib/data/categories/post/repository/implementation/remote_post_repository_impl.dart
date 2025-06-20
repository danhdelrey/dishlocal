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
import 'package:dishlocal/data/services/database_service/interface/database_service.dart';
import 'package:dishlocal/ui/features/post/view/small_post.dart';

@LazySingleton(as: PostRepository)
class RemotePostRepositoryImpl implements PostRepository {
  final _log = Logger('RemotePostRepositoryImpl');
  final StorageService _storageService;
  final DatabaseService _databaseService;
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


}
