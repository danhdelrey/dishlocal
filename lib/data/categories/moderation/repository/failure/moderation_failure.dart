import 'package:dishlocal/data/error/repository_failure.dart';

sealed class ModerationFailure extends RepositoryFailure {
  const ModerationFailure(super.message);
}

class ImageUnsafeFailure extends ModerationFailure {
  const ImageUnsafeFailure(super.reason);
}

class ModerationRequestFailure extends ModerationFailure {
  const ModerationRequestFailure(super.error);
}

/// Failure khi nội dung văn bản không được chấp nhận.
class TextUnsafeFailure extends ModerationFailure {
  const TextUnsafeFailure(super.reason); // Trả về lý do trực tiếp
}
