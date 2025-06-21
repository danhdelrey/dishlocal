import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dishlocal/data/categories/post/failure/post_failure.dart';
import 'package:dishlocal/data/categories/post/model/post.dart';

abstract class PostRepository {
  Future<Either<PostFailure, void>> createPost({required Post post, required File imageFile});
  Future<Either<PostFailure, List<Post>>> getPosts({
    int limit = 10,
    DateTime? startAfter,
  });
  Future<Either<PostFailure, Post>> getPostWithId(String postId);
  Future<Either<PostFailure, void>> likePost({
    required String postId,
    required String userId,
    required bool isLiked, // true: like, false: unlike
  });

  Future<Either<PostFailure, void>> savePost({
    required String postId,
    required String userId,
    required bool isSaved, // true: save, false: unsave
  });

  /// Lấy danh sách các bài viết mà người dùng đã lưu.
  ///
  /// Hỗ trợ phân trang bằng [limit] và [startAfter].
  /// [startAfter] là giá trị `savedAt` của bài viết cuối cùng trong trang trước đó.
  Future<Either<PostFailure, List<Post>>> getSavedPosts({
    String? userId,
    int limit = 10,
    DateTime? startAfter,
  });

  /// THÊM MỚI: Lấy bài viết từ những người dùng đang theo dõi
  Future<Either<PostFailure, List<Post>>> getFollowingPosts({
    int limit = 10,
    DateTime? startAfter,
  });

  /// THÊM MỚI: Lấy bài viết của một user cụ thể (dùng cho trang cá nhân)
  Future<Either<PostFailure, List<Post>>> getPostsByUserId({
    required String? userId,
    int limit = 10,
    DateTime? startAfter,
  });

  Future<Either<PostFailure, void>> updatePost(Post post);
}
