import 'package:dartz/dartz.dart';
import 'package:dishlocal/data/categories/app_user/model/app_user.dart';
import 'package:dishlocal/data/categories/comment/model/comment.dart';
import 'package:dishlocal/data/categories/comment/model/comment_reply.dart';
import 'package:dishlocal/data/categories/comment/repository/failure/comment_failure.dart';

/// Interface định nghĩa các phương thức để tương tác với dữ liệu
/// bình luận và trả lời bình luận trong ứng dụng.
abstract class CommentRepository {
  /// Lấy danh sách các bình luận gốc của một bài viết.
  ///
  /// Hỗ trợ phân trang bằng [limit] và [startAfter].
  /// [startAfter] là giá trị `createdAt` của bình luận cuối cùng trong trang trước đó.
  Future<Either<CommentFailure, List<Comment>>> getCommentsForPost({
    required String postId,
    int limit = 20,
    DateTime? startAfter,
  });

  /// Lấy danh sách các trả lời của một bình luận gốc.
  ///
  /// Hỗ trợ phân trang bằng [limit] và [startAfter].
  /// [startAfter] là giá trị `createdAt` của trả lời cuối cùng trong trang trước đó.
  Future<Either<CommentFailure, List<CommentReply>>> getRepliesForComment({
    required String parentCommentId,
    int limit = 10,
    DateTime? startAfter,
  });

  /// Tạo một bình luận gốc mới cho một bài viết.
  Future<Either<CommentFailure, Comment>> createComment({
    required String postId,
    required String content,
    required AppUser currentUser,
  });

  /// Tạo một trả lời mới cho một bình luận gốc.
  ///
  /// [replyToUserId] là ID của người dùng mà trả lời này đang nhắm tới.
  /// Đó có thể là tác giả của bình luận gốc, hoặc tác giả của một trả lời khác.
  Future<Either<CommentFailure, CommentReply>> createReply({
    required String parentCommentId,
    required String content,
    required AppUser currentUser,
    required AppUser replyToUser,
  });

  /// Thích hoặc bỏ thích một bình luận gốc.
  Future<Either<CommentFailure, void>> likeComment({
    required String commentId,
    required bool isLiked, // true: like, false: unlike
  });

  /// Thích hoặc bỏ thích một trả lời.
  Future<Either<CommentFailure, void>> likeReply({
    required String replyId,
    required bool isLiked, // true: like, false: unlike
  });

  /// Xóa một bình luận gốc.
  ///
  /// Việc kiểm tra quyền (chủ bình luận hoặc chủ bài viết) được thực hiện ở tầng DB (RLS).
  Future<Either<CommentFailure, void>> deleteComment({
    required String commentId,
  });

  /// Xóa một trả lời.
  ///
  /// Việc kiểm tra quyền (chủ trả lời hoặc chủ bài viết) được thực hiện ở tầng DB (RLS).
  Future<Either<CommentFailure, void>> deleteReply({
    required String replyId,
  });
}
