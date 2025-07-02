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

  /// Lấy bài viết từ những người dùng đang theo dõi
  Future<Either<PostFailure, List<Post>>> getFollowingPosts({
    int limit = 10,
    DateTime? startAfter,
  });

  /// Lấy bài viết của một user cụ thể (dùng cho trang cá nhân)
  Future<Either<PostFailure, List<Post>>> getPostsByUserId({
    required String? userId,
    int limit = 10,
    DateTime? startAfter,
  });

  Future<Either<PostFailure, void>> updatePost(Post post);
  Future<Either<PostFailure, void>> deletePost({required String postId});

  /// Tìm kiếm các bài viết dựa trên một truy vấn văn bản.
  ///
  /// Phương thức này sử dụng một dịch vụ tìm kiếm bên ngoài (ví dụ: Algolia)
  /// để thực hiện tìm kiếm toàn văn bản hiệu quả.
  ///
  /// [query]: Chuỗi văn bản để tìm kiếm.
  /// [page]: Số trang kết quả, bắt đầu từ 0.
  /// [hitsPerPage]: Số lượng kết quả trên mỗi trang.
  ///
  /// Trả về một `Right` chứa danh sách các `Post` nếu thành công,
  /// hoặc một `Left` chứa `PostFailure` nếu thất bại.
  Future<Either<PostFailure, List<Post>>> searchPosts({
    required String query,
    int page = 0,
    int hitsPerPage = 20,
  });
}
