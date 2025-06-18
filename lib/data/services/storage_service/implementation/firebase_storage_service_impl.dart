// file: lib/data/services/storage_service/implementation/firebase_storage_service_impl.dart

import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:injectable/injectable.dart';
import 'package:logging/logging.dart';

import 'package:dishlocal/data/services/storage_service/exception/storage_service_exception.dart';
import 'package:dishlocal/data/services/storage_service/interface/storage_service.dart';

@LazySingleton(as: StorageService)
class FirebaseStorageServiceImpl implements StorageService {
  final _log = Logger('FirebaseStorageServiceImpl');
  final FirebaseStorage _firebaseStorage;

  // Nhận dependency qua constructor
  FirebaseStorageServiceImpl(this._firebaseStorage) {
    _log.info('Khởi tạo FirebaseStorageServiceImpl.');
  }

  @override
  Future<String> uploadFile({required String path, required File file}) async {
    _log.info("Bắt đầu tải tệp lên đường dẫn: '$path'");
    try {
      final ref = _firebaseStorage.ref().child(path);

      _log.fine("Đang thực hiện putFile cho đường dẫn '$path'.");
      final uploadTask = ref.putFile(file);
      final snapshot = await uploadTask.whenComplete(() => null);

      final downloadUrl = await snapshot.ref.getDownloadURL();
      _log.info("Tải tệp lên thành công. URL: $downloadUrl");
      return downloadUrl;
    } on FirebaseException catch (e, stackTrace) {
      _log.severe("Lỗi FirebaseException khi tải tệp lên '$path'. Code: ${e.code}", e, stackTrace);
      // Dịch FirebaseException sang StorageServiceException tùy chỉnh
      switch (e.code) {
        case 'unauthorized':
        case 'unauthenticated':
          throw UnauthorizedException("Không có quyền tải tệp lên đường dẫn '$path'.");
        case 'canceled':
          throw OperationCancelledException();
        default:
          throw UploadFailedException("Tải tệp lên thất bại: ${e.message ?? e.code}");
      }
    } catch (e, stackTrace) {
      _log.severe("Lỗi không xác định khi tải tệp lên '$path'.", e, stackTrace);
      throw UnknownStorageException("Lỗi không xác định: ${e.toString()}");
    }
  }

  @override
  Future<void> deleteFile({required String path}) async {
    _log.info("Bắt đầu xóa tệp tại đường dẫn: '$path'");
    try {
      await _firebaseStorage.ref(path).delete();
      _log.info("Xóa tệp tại đường dẫn '$path' thành công.");
    } on FirebaseException catch (e, stackTrace) {
      _log.severe("Lỗi FirebaseException khi xóa tệp '$path'. Code: ${e.code}", e, stackTrace);
      // Dịch FirebaseException sang StorageServiceException tùy chỉnh
      switch (e.code) {
        case 'object-not-found':
          throw ObjectNotFoundException("Không tìm thấy tệp để xóa tại '$path'.");
        case 'unauthorized':
        case 'unauthenticated':
          throw UnauthorizedException("Không có quyền xóa tệp tại '$path'.");
        default:
          throw UnknownStorageException("Lỗi khi xóa tệp: ${e.message ?? e.code}");
      }
    } catch (e, stackTrace) {
      _log.severe("Lỗi không xác định khi xóa tệp '$path'.", e, stackTrace);
      throw UnknownStorageException("Lỗi không xác định: ${e.toString()}");
    }
  }
}
