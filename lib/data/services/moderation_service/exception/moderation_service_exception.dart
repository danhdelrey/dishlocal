import 'package:dishlocal/data/error/service_exception.dart';

/// Lớp sealed cho các lỗi cụ thể của ModerationService.
sealed class ModerationServiceException extends ServiceException {
  ModerationServiceException(super.message);
}

/// Bị throw khi hình ảnh vi phạm chính sách kiểm duyệt.
class ImageUnsafeException extends ModerationServiceException {
  ImageUnsafeException(super.reason);
}

/// Bị throw khi có lỗi trong quá trình gọi API (mạng, server...).
class ModerationRequestException extends ModerationServiceException {
  ModerationRequestException(super.error);
}

/// Bị throw khi nội dung văn bản vi phạm chính sách kiểm duyệt.
class TextUnsafeException extends ModerationServiceException {
  /// Danh sách các mã vi phạm bằng tiếng Anh (ví dụ: 'sexual', 'bullying').
  final List<String> violations;

  TextUnsafeException(this.violations) : super('Content violates policies: ${violations.join(', ')}');
}
