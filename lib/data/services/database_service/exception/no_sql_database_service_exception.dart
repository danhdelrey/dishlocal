import 'package:dishlocal/data/error/service_exception.dart';

/// Exception cơ sở cho các lỗi liên quan đến dịch vụ cơ sở dữ liệu.
sealed class NoSqlDatabaseServiceException extends ServiceException {
  NoSqlDatabaseServiceException(super.message);
}

/// Bị throw khi không có quyền thực hiện một thao tác (đọc/ghi) trên Firestore.
/// Tương ứng với mã lỗi 'permission-denied' của Firestore.
class PermissionDeniedException extends NoSqlDatabaseServiceException {
  PermissionDeniedException(super.message);
}

/// Bị throw khi cố gắng cập nhật một tài liệu không tồn tại.
/// Tương ứng với mã lỗi 'not-found' của Firestore trong một số thao tác.
class DocumentNotFoundException extends NoSqlDatabaseServiceException {
  DocumentNotFoundException(super.message);
}

/// Bị throw khi dịch vụ Firestore không khả dụng, thường do lỗi mạng hoặc sự cố từ phía Google.
/// Tương ứng với mã lỗi 'unavailable' của Firestore.
class DatabaseServiceUnavailableException extends NoSqlDatabaseServiceException {
  DatabaseServiceUnavailableException(super.message);
}

/// Bị throw khi có một lỗi không xác định xảy ra trong dịch vụ cơ sở dữ liệu.
class DatabaseServiceUnknownException extends NoSqlDatabaseServiceException {
  DatabaseServiceUnknownException(super.message);
}
