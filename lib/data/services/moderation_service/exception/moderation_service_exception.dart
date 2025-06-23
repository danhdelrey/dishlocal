import 'package:dishlocal/data/error/service_exception.dart';

sealed class ModerationServiceException extends ServiceException {
  ModerationServiceException(super.message);
}
class ImageUnsafeException extends ModerationServiceException {
  ImageUnsafeException(String reason) : super('Hình ảnh không hợp lệ: $reason');
}

class ModerationRequestException extends ModerationServiceException {
  ModerationRequestException(String error) : super('Lỗi khi kiểm duyệt ảnh: $error');
}
