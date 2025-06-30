import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dishlocal/data/categories/moderation/repository/failure/moderation_failure.dart';
import 'package:dishlocal/data/categories/moderation/repository/interface/moderation_repository.dart';
import 'package:dishlocal/data/services/moderation_service/exception/moderation_service_exception.dart';
import 'package:dishlocal/data/services/moderation_service/implementation/hive_ai_moderation_service_impl.dart';
import 'package:dishlocal/data/services/moderation_service/interface/moderation_service.dart';
import 'package:injectable/injectable.dart';
import 'package:logging/logging.dart';

@LazySingleton(as: ModerationRepository)
class ModerationRepositoryImpl implements ModerationRepository {
  final _log = Logger('ModerationRepositoryImpl');
  final ModerationService _hiveAiModerationService;
  final ModerationService _sightengineModerationService;

  ModerationRepositoryImpl(@Named('hive.ai') this._hiveAiModerationService, @Named('sightengine') this._sightengineModerationService);

  @override
  Future<Either<ModerationFailure, void>> moderate({String? text, File? imageFile}) async {
    try {
      _log.info('Bắt đầu quy trình kiểm duyệt nội dung...');

      // Gọi service. Nếu thành công, service sẽ không ném ra exception.
      await _sightengineModerationService.moderate(text: text, imageFile: imageFile);
      await _hiveAiModerationService.moderate(text: text, imageFile: imageFile);

      _log.info('✅ Kiểm duyệt thành công. Nội dung hợp lệ.');
      // Nếu không có lỗi, trả về Right(void). `null` đại diện cho `void`.
      return const Right(null);
    } on ImageUnsafeException catch (e) {
      _log.warning('☢️ Nội dung hình ảnh không an toàn.', e);
      // Dịch ImageUnsafeException sang ImageUnsafeFailure
      return Left(ImageUnsafeFailure(e.message));
    } on TextUnsafeException catch (e) {
      final userFriendlyMessage = ModerationViolationTranslator.translate(e.violations);
      _log.warning('☢️ Nội dung văn bản không an toàn.', e);
      return Left(TextUnsafeFailure(userFriendlyMessage));
    } on ModerationRequestException catch (e) {
      _log.severe('❌ Lỗi yêu cầu kiểm duyệt (API/Server).', e);
      // Dịch ModerationRequestException sang ModerationRequestFailure
      return Left(ModerationRequestFailure(e.message));
    } on ArgumentError catch (e) {
      _log.severe('❌ Lỗi đầu vào không hợp lệ.', e);
      // Lỗi này xảy ra khi cả text và imageFile đều null.
      // Đây cũng là một lỗi về yêu cầu.
      return Left(ModerationRequestFailure(e.message));
    } catch (e, st) {
      _log.severe('❌ Lỗi không xác định trong quá trình kiểm duyệt.', e, st);
      // Bắt tất cả các lỗi khác (ví dụ: lỗi mạng không lường trước,...)
      // và dịch sang một failure chung.
      return Left(ModerationRequestFailure('Đã xảy ra lỗi không mong muốn: ${e.toString()}'));
    }
  }
}
