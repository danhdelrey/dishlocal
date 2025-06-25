import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dishlocal/data/categories/moderation/repository/failure/moderation_failure.dart';
import 'package:dishlocal/data/categories/moderation/repository/interface/moderation_repository.dart';
import 'package:dishlocal/data/services/moderation_service/exception/moderation_service_exception.dart';
import 'package:dishlocal/data/services/moderation_service/interface/moderation_service.dart';
import 'package:injectable/injectable.dart';
import 'package:logging/logging.dart';

@LazySingleton(as: ModerationRepository)
class ModerationRepositoryImpl implements ModerationRepository {
  final _log = Logger('ModerationRepositoryImpl');
  final ModerationService _moderationService;

  ModerationRepositoryImpl(this._moderationService);

  @override
  Future<Either<ModerationFailure, void>> moderate({String? text, File? imageFile}) async {
    _log.info('Bắt đầu quy trình kiểm duyệt tại Repository...');
    _log.fine('Dữ liệu đầu vào: text is ${text != null ? "present" : "absent"}, image is ${imageFile != null ? "present" : "absent"}');

    try {
      // Gọi phương thức của service. Nếu nó không ném ra exception,
      // có nghĩa là nội dung đã được kiểm duyệt và an toàn.
      await _moderationService.moderate(text: text, imageFile: imageFile);

      // Nếu không có lỗi, trả về Right với giá trị void (đại diện bằng null trong fpdart).
      // Điều này báo hiệu sự thành công cho tầng trên.
      _log.info('Kiểm duyệt thành công, không có nội dung vi phạm.');
      return right(null);
    } on TextUnsafeException catch (e) {
      // Bắt exception cụ thể khi văn bản không an toàn.
      _log.warning('Văn bản bị gắn cờ không an toàn. Lý do: ${e.message}. Ánh xạ sang TextUnsafeFailure.', e);
      // Dịch nó thành TextUnsafeFailure.
      return left(TextUnsafeFailure(e.message));
    } on ImageUnsafeException catch (e) {
      // Bắt exception cụ thể khi ảnh không an toàn.
      _log.warning('Ảnh bị gắn cờ không an toàn. Lý do: ${e.message}. Ánh xạ sang ImageUnsafeFailure.', e);
      // Dịch nó thành ImageUnsafeFailure.
      return left(ImageUnsafeFailure(e.message));
    } on ModerationRequestException catch (e) {
      // Bắt các lỗi liên quan đến request (lỗi mạng, API key sai, v.v.).
      _log.severe('Lỗi yêu cầu kiểm duyệt. Ánh xạ sang ModerationRequestFailure.', e);
      // Dịch nó thành ModerationRequestFailure chung.
      return left(ModerationRequestFailure(e.message));
    } catch (e, stackTrace) {
      // Bắt tất cả các lỗi không mong muốn khác.
      // Đây là một "lưới an toàn" quan trọng.
      _log.severe('Lỗi không xác định xảy ra trong quá trình kiểm duyệt.', e, stackTrace);
      // Dịch nó thành một Failure chung để tầng trên có thể xử lý.
      return left(ModerationRequestFailure('Đã xảy ra lỗi không mong muốn: ${e.toString()}'));
    }
  }
}
