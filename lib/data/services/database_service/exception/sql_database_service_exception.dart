
import 'package:dishlocal/data/error/service_exception.dart';

/// Exception cơ sở cho các lỗi liên quan đến dịch vụ cơ sở dữ liệu.
/// Việc có một lớp cơ sở giúp bắt lỗi dễ dàng hơn ở các tầng trên.
sealed class SqlDatabaseServiceException extends ServiceException {
  SqlDatabaseServiceException(super.message);
}

/// ===================================================================
/// Lỗi liên quan đến kết nối và hệ thống
/// ===================================================================

/// Bị throw khi không thể kết nối đến máy chủ cơ sở dữ liệu.
/// Nguyên nhân thường là do mất kết nối internet hoặc máy chủ Supabase tạm thời không khả dụng.
class DatabaseConnectionException extends SqlDatabaseServiceException {
  DatabaseConnectionException() : super('Không thể kết nối đến máy chủ. Vui lòng kiểm tra kết nối mạng của bạn.');
}

/// Bị throw khi có một lỗi không xác định từ phía server PostgreSQL.
/// Đây là lỗi chung cho các vấn đề phía máy chủ không thuộc các loại cụ thể khác.
class UnknownDatabaseException extends SqlDatabaseServiceException {
  UnknownDatabaseException(String message) : super('Đã xảy ra lỗi không mong muốn từ cơ sở dữ liệu: $message');
}

/// ===================================================================
/// Lỗi liên quan đến quyền truy cập (Row Level Security)
/// ===================================================================

/// Bị throw khi người dùng cố gắng thực hiện một hành động (đọc, ghi, xóa)
/// mà không được cho phép bởi chính sách RLS (Row Level Security).
/// Ví dụ: Cố gắng xóa bài viết của người khác.
class PermissionDeniedException extends SqlDatabaseServiceException {
  PermissionDeniedException() : super('Bạn không có quyền thực hiện hành động này.');
}

/// ===================================================================
/// Lỗi liên quan đến dữ liệu và ràng buộc (Constraints)
/// ===================================================================

/// Bị throw khi truy vấn một bản ghi cụ thể nhưng không tìm thấy.
/// Ví dụ: Tìm một bài post với ID không tồn tại.
class RecordNotFoundException extends SqlDatabaseServiceException {
  final String recordType;
  final dynamic recordId;

  RecordNotFoundException({
    required this.recordType,
    required this.recordId,
  }) : super('$recordType với ID "$recordId" không được tìm thấy.');
}

/// Exception cơ sở cho các lỗi vi phạm ràng buộc dữ liệu trong SQL.
sealed class ConstraintViolationException extends SqlDatabaseServiceException {
  final String fieldName;
  ConstraintViolationException(super.message, {required this.fieldName});
}

/// Bị throw khi cố gắng chèn hoặc cập nhật một giá trị đã tồn tại vào một cột
/// có ràng buộc UNIQUE.
/// Ví dụ: Đăng ký một username đã có người sử dụng.
class UniqueConstraintViolationException extends ConstraintViolationException {
  final dynamic value;

  UniqueConstraintViolationException({
    required String fieldName,
    required this.value,
  }) : super('Giá trị "$value" đã tồn tại cho trường "$fieldName".', fieldName: fieldName);
}

/// Bị throw khi cố gắng chèn hoặc cập nhật một giá trị không hợp lệ
/// vi phạm ràng buộc CHECK.
/// Ví dụ: Username chứa ký tự đặc biệt, vi phạm `CHECK (username ~ '^[a-z0-9_]+$')`.
class CheckConstraintViolationException extends ConstraintViolationException {
  CheckConstraintViolationException({
    required String fieldName,
    required String constraintName,
  }) : super('Giá trị cho trường "$fieldName" không hợp lệ (vi phạm ràng buộc $constraintName).', fieldName: fieldName);
}

/// Bị throw khi cố gắng chèn một bản ghi có khóa ngoại trỏ đến một bản ghi không tồn tại.
/// Đây thường là lỗi logic phía client và ít khi xảy ra với người dùng cuối.
/// Ví dụ: Tạo bài post với `author_id` không tồn tại trong bảng `profiles`.
class ForeignKeyConstraintViolationException extends ConstraintViolationException {
  ForeignKeyConstraintViolationException({
    required String fieldName,
    required String referenceTable,
  }) : super('Không tìm thấy bản ghi liên quan trong bảng "$referenceTable" cho trường "$fieldName".', fieldName: fieldName);
}

/// ===================================================================
/// Lỗi liên quan đến phía Client
/// ===================================================================

/// Bị throw khi dữ liệu trả về từ server không thể được phân tích (parse)
/// thành đối tượng Entity tương ứng của Dart.
/// Thường là dấu hiệu của sự không khớp giữa model Dart và schema của DB.
class DataParsingException extends SqlDatabaseServiceException {
  DataParsingException(String message) : super('Lỗi phân tích dữ liệu: $message');
}
