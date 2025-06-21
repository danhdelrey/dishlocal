import 'package:dishlocal/data/error/service_exception.dart';

/// Exception cơ sở cho các lỗi liên quan đến dịch vụ cơ sở dữ liệu.
sealed class DatabaseServiceException extends ServiceException {
  DatabaseServiceException(super.message);
}

/// Bị throw khi không có quyền thực hiện một thao tác (đọc/ghi) trên Firestore.
/// Tương ứng với mã lỗi 'permission-denied' của Firestore.
class PermissionDeniedException extends DatabaseServiceException {
  PermissionDeniedException(super.message);
}

/// Bị throw khi cố gắng cập nhật một tài liệu không tồn tại.
/// Tương ứng với mã lỗi 'not-found' của Firestore trong một số thao tác.
class DocumentNotFoundException extends DatabaseServiceException {
  DocumentNotFoundException(super.message);
}

/// Bị throw khi dịch vụ Firestore không khả dụng, thường do lỗi mạng hoặc sự cố từ phía Google.
/// Tương ứng với mã lỗi 'unavailable' của Firestore.
class DatabaseServiceUnavailableException extends DatabaseServiceException {
  DatabaseServiceUnavailableException(super.message);
}

/// Bị throw khi có một lỗi không xác định xảy ra trong dịch vụ cơ sở dữ liệu.
class DatabaseServiceUnknownException extends DatabaseServiceException {
  DatabaseServiceUnknownException(super.message);
}
