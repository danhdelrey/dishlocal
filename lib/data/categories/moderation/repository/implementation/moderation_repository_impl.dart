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
  Future<Either<ModerationFailure, void>> moderateImage(File imageFile) async {
    _log.info('🛡️ Bắt đầu luồng kiểm duyệt hình ảnh trong Repository...');
    try {
      // Gọi service. Nếu thành công, nó sẽ không trả về gì.
      await _moderationService.checkImage(imageFile);

      _log.info('✅ Hình ảnh đã qua kiểm duyệt thành công ở tầng Service.');
      return const Right(null);
    } on ModerationServiceException catch (e) {
      _log.warning('⚠️ Dịch ModerationServiceException thành ModerationFailure. Lỗi: ${e.message}');

      // Dịch từ Exception sang Failure
      if (e is ImageUnsafeException) {
        return Left(ImageUnsafeFailure(e.message));
      }
      return Left(ModerationRequestFailure(e.message));
    } catch (e, st) {
      _log.severe('❌ Lỗi không xác định trong Repository, không phải ModerationServiceException.', e, st);
      return const Left(ModerationRequestFailure('Lỗi không xác định'));
    }
  }

  @override
  Future<Either<ModerationFailure, void>> moderateText(String text) async {
    _log.info('🛡️ Bắt đầu luồng kiểm duyệt văn bản trong Repository...');
    try {
      await _moderationService.checkText(text);

      _log.info('✅ Văn bản đã qua kiểm duyệt thành công ở tầng Service.');
      return const Right(null);
    } on ModerationServiceException catch (e) {
      _log.warning('⚠️ Dịch ModerationServiceException thành ModerationFailure. Lỗi: ${e.message}');

      // Dịch từ Exception sang Failure
      if (e is TextUnsafeException) {
        // Trả về lý do cụ thể cho UI
        return Left(TextUnsafeFailure(e.message));
      }
      return Left(ModerationRequestFailure(e.message));
    } catch (e, st) {
      _log.severe('❌ Lỗi không xác định trong Repository, không phải ModerationServiceException.', e, st);
      return const Left(ModerationRequestFailure('Lỗi không xác định'));
    }
  }
}
