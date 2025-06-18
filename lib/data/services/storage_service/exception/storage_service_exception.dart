import 'package:dishlocal/data/error/service_exception.dart';

/// Lớp cơ sở cho các lỗi liên quan đến dịch vụ lưu trữ (Storage).
sealed class StorageServiceException extends ServiceException {
  StorageServiceException(super.message);
}

/// Bị throw khi người dùng không có quyền thực hiện thao tác (đọc/ghi/xóa)
/// dựa trên các quy tắc bảo mật (Security Rules) của Firebase Storage.
/// Tương ứng với mã lỗi 'unauthorized' hoặc 'unauthenticated'.
class UnauthorizedException extends StorageServiceException {
  UnauthorizedException(super.message);
}

/// Bị throw khi cố gắng thực hiện thao tác trên một đối tượng không tồn tại.
/// Tương ứng với mã lỗi 'object-not-found'.
class ObjectNotFoundException extends StorageServiceException {
  ObjectNotFoundException(super.message);
}

/// Bị throw khi người dùng chủ động hủy một thao tác đang diễn ra (ví dụ: hủy tải lên).
/// Tương ứng với mã lỗi 'canceled'.
class OperationCancelledException extends StorageServiceException {
  OperationCancelledException() : super('Thao tác đã bị người dùng hủy.');
}

/// Bị throw khi việc tải lên thất bại do các nguyên nhân khác (lỗi mạng, hết thời gian chờ...).
/// Tương ứng với các mã lỗi không xác định trong quá trình tải lên.
class UploadFailedException extends StorageServiceException {
  UploadFailedException(super.message);
}

/// Bị throw khi có một lỗi không xác định xảy ra trong dịch vụ lưu trữ.
class UnknownStorageException extends StorageServiceException {
  UnknownStorageException(super.message);
}
