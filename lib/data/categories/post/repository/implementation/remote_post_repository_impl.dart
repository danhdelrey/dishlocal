// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dishlocal/data/categories/app_user/repository/interface/app_user_repository.dart';
import 'package:dishlocal/data/services/authentication_service/interface/authentication_service.dart';
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

  RemotePostRepositoryImpl(
    this._storageService,
    this._databaseService,
    this._distanceService,
    this._locationService,
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

    try {
      final rawPosts = await _databaseService.getDocuments(
        collection: 'posts',
        orderBy: 'createdAt',
        descending: true,
        limit: limit,
        startAfter: startAfter,
      );

      final posts = rawPosts.map((json) => Post.fromJson(json)).toList();
      _log.info('✅ Lấy được ${posts.length} bài viết.');

      // 🔍 Lấy tọa độ người dùng hiện tại
      final userPosition = await _locationService.getCurrentPosition();
      final userLat = userPosition.latitude;
      final userLong = userPosition.longitude;

      // 🔁 Tính khoảng cách cho từng bài viết
      final postsWithDistance = await Future.wait(posts.map((post) async {
        final postLat = post.address?.latitude;
        final postLong = post.address?.longitude;

        if (postLat == null || postLong == null) {
          _log.warning('⚠️ Post ${post.postId} không có tọa độ');
          return post;
        }

        final distance = await _distanceService.calculateDistance(
          fromLat: userLat,
          fromLong: userLong,
          toLat: postLat,
          toLong: postLong,
        );

        return post.copyWith(distance: distance);
      }));

      return right(postsWithDistance);
    } catch (e, stackTrace) {
      _log.severe('❌ Lỗi khi lấy post', e, stackTrace);
      return const Left(UnknownFailure());
    }
  }
}
