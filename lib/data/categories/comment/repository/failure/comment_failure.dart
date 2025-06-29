import 'package:dishlocal/data/error/repository_failure.dart';

/// Lớp cơ sở cho tất cả các lỗi liên quan đến kho lưu trữ bình luận (CommentRepository).
sealed class CommentFailure extends RepositoryFailure {
  const CommentFailure(super.message);
}

/// Lỗi chung, không xác định khi thao tác với bình luận.
class UnknownCommentFailure extends CommentFailure {
  const UnknownCommentFailure() : super('Đã xảy ra lỗi không mong muốn, vui lòng thử lại.');
}

/// Lỗi liên quan đến quyền truy cập (RLS) khi thao tác với bình luận.
class PermissionCommentFailure extends CommentFailure {
  const PermissionCommentFailure() : super('Bạn không có quyền thực hiện hành động này.');
}

/// Lỗi khi không tìm thấy bình luận hoặc trả lời cụ thể.
class CommentNotFoundFailure extends CommentFailure {
  const CommentNotFoundFailure() : super('Không tìm thấy bình luận này.');
}

/// Lỗi khi bài viết mà người dùng đang cố gắng bình luận không tồn tại.
class PostNotFoundForCommentFailure extends CommentFailure {
  const PostNotFoundForCommentFailure() : super('Không thể bình luận vì bài viết không tồn tại.');
}

/// Lỗi khi tạo, cập nhật hoặc xóa bình luận (ví dụ: vi phạm ràng buộc dữ liệu).
class CommentOperationFailure extends CommentFailure {
  const CommentOperationFailure(super.message);
}

/// Lỗi kết nối mạng khi thực hiện các thao tác với bình luận.
class ConnectionCommentFailure extends CommentFailure {
  const ConnectionCommentFailure() : super('Lỗi kết nối mạng, vui lòng kiểm tra lại.');
}
