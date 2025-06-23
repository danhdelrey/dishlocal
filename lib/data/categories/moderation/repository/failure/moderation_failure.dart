import 'package:dishlocal/data/error/repository_failure.dart';

sealed class ModerationFailure extends RepositoryFailure {
  const ModerationFailure(super.message);
}

class ImageUnsafeFailure extends ModerationFailure {
  const ImageUnsafeFailure(String reason) : super('Hình ảnh không hợp lệ: $reason');
}

class ModerationRequestFailure extends ModerationFailure {
  const ModerationRequestFailure(String error) : super('Lỗi khi kiểm duyệt ảnh: $error');
}

/// Failure khi nội dung văn bản không được chấp nhận.
class TextUnsafeFailure extends ModerationFailure {
  const TextUnsafeFailure(super.reason); // Trả về lý do trực tiếp
}
