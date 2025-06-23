import 'dart:io';
import 'package:dishlocal/data/services/moderation_service/exception/moderation_service_exception.dart';

/// Interface cho dịch vụ kiểm duyệt hình ảnh.
abstract class ModerationService {
  /// Kiểm tra một tệp hình ảnh.
  ///
  /// - Hoàn thành bình thường nếu ảnh an toàn.
  /// - Ném ra [ImageUnsafeException] nếu ảnh vi phạm chính sách.
  /// - Ném ra [ModerationRequestException] nếu có lỗi khi gọi API.
  Future<void> checkImage(File imageFile);
}
