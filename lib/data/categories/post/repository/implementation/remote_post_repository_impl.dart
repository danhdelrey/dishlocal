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
    _log.info('📥 Lấy danh sách post (limit: $limit, startAfter: $startAfter)');
    // hỏi hàng loạt (batch query)
    // Lần 1: "Firebase ơi, cho tôi danh sách 10 bài viết mới nhất."
    // Firebase trả về 10 bài viết.
    // Bạn lấy ra ID của cả 10 bài viết đó (giống như viết tên sách ra giấy).
    // Lần 2: "Firebase ơi, trong danh sách 10 ID bài viết này, người dùng của tôi đã thích những bài nào? Cho tôi kết quả."
    // Firebase chỉ cần tìm 1 lần và trả về, ví dụ: "Người dùng đã thích bài A, D, F".
    // Lần 3: "Firebase ơi, cũng trong danh sách 10 ID đó, người dùng của tôi đã lưu những bài nào?"
    // Firebase lại tìm 1 lần và trả về, ví dụ: "Người dùng đã lưu bài B, D, H".
    //=> Tổng cộng, bạn chỉ phải hỏi Firebase 3 lần (1 lần lấy bài viết, 1 lần lấy danh sách thích, 1 lần lấy danh sách lưu).

    try {
      // BƯỚC 1 & 2: Lấy UserID và danh sách bài viết
      final currentUserId = _authenticationService.getCurrentUserId();
      _log.fine('🆔 User ID hiện tại: $currentUserId');

      final rawPosts = await _databaseService.getDocuments(
        collection: 'posts',
        orderBy: 'createdAt',
        descending: true,
        limit: limit,
        startAfter: startAfter,
      );

      if (rawPosts.isEmpty) {
        _log.info('✅ Không có bài viết nào được tìm thấy. Trả về danh sách trống.');
        return right([]);
      }

      final posts = rawPosts.map((json) => Post.fromJson(json)).toList();
      _log.info('✅ Lấy được ${posts.length} bài viết.');

      // BƯỚC 3: Trích xuất danh sách Post ID
      final postIds = posts.map((p) => p.postId).toList();

      // BƯỚC 4: Lấy trạng thái Like và Save hàng loạt (chỉ khi user đã đăng nhập)
      Set<String> likedPostIds = {};
      Set<String> savedPostIds = {};

      if (currentUserId != null && currentUserId.isNotEmpty) {
        _log.info('🚀 Bắt đầu lấy trạng thái like/save cho ${postIds.length} bài viết.');

        // Chạy song song 2 truy vấn để tăng tốc độ
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

        // Dùng Set để tra cứu O(1)
        likedPostIds = results[0].map((doc) => doc['id'] as String).toSet();
        savedPostIds = results[1].map((doc) => doc['id'] as String).toSet();
        _log.fine('👍 Đã thích ${likedPostIds.length} bài viết. 📌 Đã lưu ${savedPostIds.length} bài viết.');
      } else {
        _log.info('👤 Người dùng chưa đăng nhập, bỏ qua việc kiểm tra trạng thái like/save.');
      }

      // 🔍 Lấy tọa độ người dùng hiện tại
      final userPosition = await _locationService.getCurrentPosition();

      // BƯỚC 5: Tổng hợp tất cả dữ liệu
      _log.info('🔄 Bắt đầu tổng hợp dữ liệu (khoảng cách, like, save) cho các bài viết.');
      final postsWithFullData = await Future.wait(posts.map((post) async {
        // Tính khoảng cách
        final distance = (post.address?.latitude != null && post.address?.longitude != null)
            ? await _distanceService.calculateDistance(
                fromLat: userPosition.latitude,
                fromLong: userPosition.longitude,
                toLat: post.address!.latitude,
                toLong: post.address!.longitude,
              )
            : null;

        // Kiểm tra trạng thái like/save
        final isLiked = likedPostIds.contains(post.postId);
        final isSaved = savedPostIds.contains(post.postId);

        return post.copyWith(
          distance: distance,
          isLiked: isLiked,
          isSaved: isSaved,
        );
      }));

      _log.info('🎉 Hoàn thành lấy và tổng hợp dữ liệu cho ${postsWithFullData.length} bài viết.');
      return right(postsWithFullData);
    } catch (e, stackTrace) {
      _log.severe('❌ Lỗi khi lấy danh sách bài viết', e, stackTrace);
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
}
