import 'dart:io';

/// Dịch vụ kiểm duyệt nội dung, bao gồm văn bản và/hoặc hình ảnh.
abstract class ModerationService {
  /// Kiểm duyệt nội dung được cung cấp.
  ///
  /// Có thể kiểm duyệt chỉ văn bản, chỉ ảnh, hoặc cả hai.
  /// Ném ra một [ModerationRequestException] nếu cả `text` và `imageFile` đều là null.
  /// Ném ra các Exception cụ thể như [TextUnsafeException], [ImageUnsafeException],
  /// hoặc [ModerationRequestException] nếu nội dung vi phạm hoặc có lỗi xảy ra.
  Future<void> moderate({String? text, File? imageFile});
}
