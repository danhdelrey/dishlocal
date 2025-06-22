// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dishlocal/data/services/database_service/entity/post_entity.dart';
import 'package:dishlocal/data/services/database_service/exception/sql_database_service_exception.dart';
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
  final _supabase = Supabase.instance.client; // Dùng cho các thao tác phức tạp (RPC, match)
  final StorageService _storageService;
  final SqlDatabaseService _dbService;
  final DistanceService _distanceService;
  final LocationService _locationService;
  final AuthenticationService _authenticationService;

  RemotePostRepositorySqlImpl(
    this._storageService,
    this._dbService,
    this._distanceService,
    this._locationService,
    this._authenticationService,
  );

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

  @override
  Future<Either<PostFailure, void>> createPost({required Post post, required File imageFile}) async {
    return _handleErrors(() async {
      _log.info('👉 Bắt đầu tạo bài viết mới...');

      _log.fine('🔄 Đang tải ảnh lên Storage...');
      final imageUrl = await _storageService.uploadFile(
        path: 'posts', 
        file: imageFile,
        publicId: post.postId,
      );
      _log.fine('✅ Tải ảnh thành công. URL: $imageUrl');

      // Chuyển đổi từ UI Model 'Post' sang 'PostEntity' để lưu vào DB
      final postEntity = PostEntity(
        id: post.postId,
        authorId: post.authorUserId,
        imageUrl: imageUrl,
        dishName: post.dishName,
        locationName: post.diningLocationName,
        locationAddress: post.address?.exactAddress,
        latitude: post.address?.latitude,
        longitude: post.address?.longitude,
        price: post.price,
        insight: post.insight,
        createdAt: post.createdAt,
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

    // Chỉ còn làm giàu khoảng cách, các thông tin khác đã có từ RPC
    return await _enrichPostsWithDistance(posts);
  }

  @override
  Future<Either<PostFailure, List<Post>>> getPosts({int limit = 10, DateTime? startAfter}) {
    return _handleErrors(() async {
      final currentUserId = _authenticationService.getCurrentUserId();
      return _fetchPostsViaRpc(
        rpcName: 'get_posts_with_details',
        params: {
          'p_user_id': currentUserId,
          'p_limit': limit,
          'p_start_after': startAfter?.toIso8601String() ?? '9999-12-31',
        },
      );
    });
  }

  @override
  Future<Either<PostFailure, List<Post>>> getFollowingPosts({int limit = 10, DateTime? startAfter}) {
    return _handleErrors(() async {
      final currentUserId = _authenticationService.getCurrentUserId();
      if (currentUserId == null) return []; // Người dùng chưa đăng nhập
      return _fetchPostsViaRpc(
        rpcName: 'get_posts_with_details',
        params: {
          'p_user_id': currentUserId,
          'p_is_following_feed': true,
          'p_limit': limit,
          'p_start_after': startAfter?.toIso8601String() ?? '9999-12-31',
        },
      );
    });
  }

  @override
  Future<Either<PostFailure, List<Post>>> getPostsByUserId({required String? userId, int limit = 10, DateTime? startAfter}) {
    return _handleErrors(() async {
      final targetUserId = userId ?? _authenticationService.getCurrentUserId();
      if (targetUserId == null) return [];

      return _fetchPostsViaRpc(
        rpcName: 'get_posts_with_details',
        params: {
          'p_user_id': _authenticationService.getCurrentUserId(), // User đang xem
          'p_author_id': targetUserId, // Lọc theo tác giả này
          'p_limit': limit,
          'p_start_after': startAfter?.toIso8601String() ?? '9999-12-31',
        },
      );
    });
  }

  @override
  Future<Either<PostFailure, List<Post>>> getSavedPosts({String? userId, int limit = 10, DateTime? startAfter}) {
    return _handleErrors(() async {
      final targetUserId = userId ?? _authenticationService.getCurrentUserId();
      if (targetUserId == null) return [];

      return _fetchPostsViaRpc(
        rpcName: 'get_posts_with_details',
        params: {
          'p_user_id': targetUserId, // User đang xem chính là người có bài viết đã lưu
          'p_is_saved_feed': true,
          'p_limit': limit,
          'p_start_after': startAfter?.toIso8601String() ?? '9999-12-31',
        },
      );
    });
  }

  @override
  Future<Either<PostFailure, Post>> getPostWithId(String postId) {
    return _handleErrors(() async {
      _log.info('📥 Bắt đầu lấy chi tiết bài viết ID: $postId');
      final currentUserId = _authenticationService.getCurrentUserId();

      final data = await _supabase
          .rpc('get_posts_with_details', params: {
            'p_user_id': currentUserId,
          })
          .eq('postId', postId)
          .single();

      final post = Post.fromJson(data);
      _log.info('✅ Lấy chi tiết bài viết thành công.');

      final enrichedList = await _enrichPostsWithDistance([post]);
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
      };

      // Loại bỏ các giá trị null để không ghi đè dữ liệu hiện có bằng null
      dataToUpdate.removeWhere((key, value) => value == null);

      await _dbService.update(
        tableName: 'posts',
        id: post.postId,
        data: dataToUpdate,
        fromJson: (json) => {},
      );
      _log.info('✅ Cập nhật bài viết ${post.postId} thành công.');
    });
  }
}
