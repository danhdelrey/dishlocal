import 'package:dishlocal/data/error/service_exception.dart';


/// Lớp sealed cho các lỗi cụ thể của ModerationService.
sealed class ModerationServiceException extends ServiceException {
  ModerationServiceException(super.message);
}

/// Bị throw khi hình ảnh vi phạm chính sách kiểm duyệt.
class ImageUnsafeException extends ModerationServiceException {
  ImageUnsafeException(String reason) : super('Hình ảnh không hợp lệ: $reason');
}

/// Bị throw khi có lỗi trong quá trình gọi API (mạng, server...).
class ModerationRequestException extends ModerationServiceException {
  ModerationRequestException(String error) : super('Lỗi khi kiểm duyệt: $error');
}

/// Bị throw khi nội dung văn bản vi phạm chính sách kiểm duyệt.
class TextUnsafeException extends ModerationServiceException {
  TextUnsafeException(String reason) : super('Nội dung không hợp lệ: $reason');
}
