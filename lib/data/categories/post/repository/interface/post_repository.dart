import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dishlocal/data/categories/post/failure/post_failure.dart';
import 'package:dishlocal/data/categories/post/model/filter_sort_model/filter_sort_params.dart';
import 'package:dishlocal/data/categories/post/model/post.dart';

abstract class PostRepository {
  Future<Either<PostFailure, Post>> createPost({required Post post, required File imageFile});

  /// Lấy danh sách bài viết dựa trên các tiêu chí lọc và sắp xếp.
  ///
  /// Phương thức này là trung tâm cho việc khám phá bài viết.
  /// - [params]: Một đối tượng chứa tất cả các tùy chọn lọc, sắp xếp, và phân trang.
  Future<Either<PostFailure, List<Post>>> getPosts({
    required FilterSortParams params,
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
  /// Hỗ trợ lọc, sắp xếp và phân trang thông qua [params].
  Future<Either<PostFailure, List<Post>>> getSavedPosts({
    String? userId,
    required FilterSortParams params,
  });

  /// Lấy bài viết từ những người dùng đang theo dõi
  Future<Either<PostFailure, List<Post>>> getFollowingPosts({
    required FilterSortParams params,
  });

  /// Lấy bài viết của một user cụ thể (dùng cho trang cá nhân)
  Future<Either<PostFailure, List<Post>>> getPostsByUserId({
    required String? userId,
    required FilterSortParams params,
  });

  Future<Either<PostFailure, void>> updatePost(Post post);
  Future<Either<PostFailure, void>> deletePost({required String postId});

  /// Tìm kiếm các bài viết dựa trên một truy vấn văn bản.
  /// (Giữ nguyên vì logic tìm kiếm khác với logic lọc/sắp xếp)
  Future<Either<PostFailure, List<Post>>> searchPosts({
    required String query,
    int page = 0,
    int hitsPerPage = 20,
  });

  Future<Either<PostFailure, List<Post>>> getRecommendedPosts({
    required int page,
    required int pageSize,
  });

  Future<Either<PostFailure, void>> recordPostView({
    required String postId,
    int? durationInMs,
  });
}
