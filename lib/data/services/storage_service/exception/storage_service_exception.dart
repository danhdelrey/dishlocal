import 'package:dishlocal/data/error/service_exception.dart';

/// Lớp cơ sở cho các lỗi liên quan đến dịch vụ lưu trữ (Storage).
sealed class StorageServiceException extends ServiceException {
  StorageServiceException(super.message);
}

/// Bị throw khi có lỗi trong quá trình tải tệp lên Cloudinary.
/// Nguyên nhân có thể là do lỗi mạng, tệp không hợp lệ, hoặc lỗi từ phía server Cloudinary.
class FileUploadException extends StorageServiceException {
  FileUploadException(String message) : super('Lỗi khi tải tệp lên: $message');
}

/// Bị throw khi có lỗi trong quá trình xóa tệp khỏi Cloudinary.
/// Nguyên nhân có thể là do tệp không tồn tại, không có quyền xóa, hoặc lỗi server.
class FileDeleteException extends StorageServiceException {
  FileDeleteException(String message) : super('Lỗi khi xóa tệp: $message');
}

/// Bị throw khi không thể kết nối đến dịch vụ Cloudinary.
/// Thường là do lỗi mạng hoặc cấu hình sai.
class StorageConnectionException extends StorageServiceException {
  StorageConnectionException() : super('Không thể kết nối đến dịch vụ lưu trữ. Vui lòng kiểm tra kết nối mạng.');
}

/// Bị throw khi có một lỗi không xác định xảy ra từ phía dịch vụ lưu trữ.
class UnknownStorageException extends StorageServiceException {
  UnknownStorageException(String message) : super('Lỗi lưu trữ không xác định: $message');
}
