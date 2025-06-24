import 'dart:io';

import 'package:cloudinary_api/uploader/cloudinary_uploader.dart';
import 'package:cloudinary_url_gen/cloudinary.dart';
import 'package:dishlocal/core/app_environment/app_environment.dart';
import 'package:dishlocal/data/services/storage_service/exception/storage_service_exception.dart';
import 'package:dishlocal/data/services/storage_service/interface/storage_service.dart';
import 'package:cloudinary_api/src/request/model/uploader_params.dart';
import 'package:injectable/injectable.dart';
import 'package:logging/logging.dart';

@LazySingleton(as: StorageService)
class CloudinaryStorageServiceImpl implements StorageService {
  final _log = Logger('CloudinaryStorageServiceImpl');

  late final Cloudinary _cloudinary;
  final String rootFolder = AppEnvironment.isInDevelopment ? 'development' : 'production';

  CloudinaryStorageServiceImpl() {
    _cloudinary = Cloudinary.fromStringUrl(AppEnvironment.cloudinaryUrl);
    _cloudinary.config.urlConfig.secure = true;
    _log.info('✅ Cloudinary Service đã được khởi tạo thành công.');
  }

  /// Bọc một thao tác lưu trữ để xử lý và chuyển đổi lỗi một cách nhất quán.
  Future<T> _wrapStorageOperation<T>(String operationName, Future<T> Function() operation) async {
    try {
      return await operation();
    } on SocketException catch (e, st) {
      _log.severe('🕸️ Lỗi mạng (SocketException) trong [$operationName]', e, st);
      throw StorageConnectionException();
    } catch (e, st) {
      _log.severe('❓ Lỗi không xác định trong [$operationName]', e, st);
      // Dựa vào loại lỗi, chúng ta có thể ném ra exception cụ thể hơn
      if (operationName.contains('Upload')) {
        throw FileUploadException(e.toString());
      }
      if (operationName.contains('Delete')) {
        throw FileDeleteException(e.toString());
      }
      throw UnknownStorageException(e.toString());
    }
  }

  @override
  Future<String> uploadFile({
    required String folder,
    required File file,
    required String publicId,
  }) {
    final operationName = 'Upload to "$rootFolder/$folder"';
    return _wrapStorageOperation(operationName, () async {
      final fullPublicId = '$rootFolder/$folder/$publicId';
      _log.info('➡️ $operationName: Bắt đầu tải tệp lên với publicId: $fullPublicId');

      final response = await _cloudinary.uploader().upload(
            file,
            params: UploadParams(
              folder: '$rootFolder/$folder',
              publicId: publicId,
              uniqueFilename: false, // Để không tự động thêm chuỗi ngẫu nhiên vào tên file
              overwrite: true, // Ghi đè nếu file đã tồn tại
            ),
          );

      if (response?.responseCode != null && response!.responseCode >= 200 && response.responseCode < 300 && response.data?.secureUrl != null) {
        final url = response.data!.secureUrl!;
        _log.info('✅ $operationName: Tải tệp thành công! URL: $url');
        return url;
      } else {
        // Lấy thông báo lỗi một cách an toàn
        final errorMessage = response?.error?.message ?? 'Không nhận được phản hồi lỗi từ Cloudinary.';
        _log.severe('❌ $operationName: Tải tệp thất bại. Status code: ${response?.responseCode}, Lỗi: $errorMessage');
        throw FileUploadException(errorMessage);
      }
    });
  }

  @override
  Future<void> deleteFile({required String folder, required String publicId}) {
    final operationName = 'Delete from "$folder"';
    return _wrapStorageOperation(operationName, () async {
      final fullPublicId = '$rootFolder/$folder/$publicId';
      _log.info('🗑️ $operationName: Bắt đầu xóa tệp với publicId: $fullPublicId');

      final response = await _cloudinary.uploader().destroy(
            DestroyParams(
              publicId: fullPublicId,
              invalidate: true, // Xóa cache trên CDN
            ),
          );

      _log.info('Response code: ${response.responseCode}');
      _log.info('secureUrl: ${response.data?.secureUrl}');

      if (response.responseCode >= 200 && response.responseCode < 300) {
        return;
      }

      // Nếu không rơi vào các trường hợp thành công ở trên, coi như thất bại.
      final errorMessage = response.error?.message ?? 'Không nhận được phản hồi lỗi từ Cloudinary.';
      _log.severe('❌ $operationName: Xóa tệp thất bại. Status code: ${response.responseCode}, Lỗi: $errorMessage');
      throw FileDeleteException(errorMessage);
    });
  }
}
