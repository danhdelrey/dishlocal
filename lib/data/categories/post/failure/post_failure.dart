import 'package:dishlocal/data/error/repository_failure.dart';

sealed class PostFailure extends RepositoryFailure {
  const PostFailure(super.message);
}

/// Lỗi chung, không xác định.
class UnknownFailure extends PostFailure {
  const UnknownFailure() : super('Đã xảy ra lỗi không mong muốn, vui lòng thử lại.');
}

/// Lỗi liên quan đến quyền truy cập (RLS).
class PermissionFailure extends PostFailure {
  const PermissionFailure() : super('Bạn không có quyền thực hiện hành động này.');
}

/// Lỗi khi không tìm thấy một bài viết cụ thể.
class PostNotFoundFailure extends PostFailure {
  const PostNotFoundFailure() : super('Không tìm thấy bài viết này.');
}

/// Lỗi khi upload ảnh lên storage.
class ImageUploadFailure extends PostFailure {
  const ImageUploadFailure() : super('Không thể tải ảnh lên, vui lòng thử lại.');
}

/// Lỗi khi tạo hoặc cập nhật bài viết (ví dụ: vi phạm ràng buộc).
class PostOperationFailure extends PostFailure {
  const PostOperationFailure(super.message);
}

/// Lỗi kết nối mạng.
class ConnectionFailure extends PostFailure {
  const ConnectionFailure() : super('Lỗi kết nối mạng, vui lòng kiểm tra lại.');
}
