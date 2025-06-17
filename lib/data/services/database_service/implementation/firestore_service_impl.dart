// file: lib/data/services/database_service/implementation/firestore_service_impl.dart

import 'package:cloud_firestore/cloud_firestore.dart';
// THÊM IMPORT MỚI
import 'package:dishlocal/data/services/database_service/exception/database_service_exception.dart';
import 'package:dishlocal/data/services/database_service/interface/database_service.dart';
import 'package:injectable/injectable.dart';
import 'package:logging/logging.dart';

@LazySingleton(as: DatabaseService)
class FirestoreServiceImpl implements DatabaseService {
  final _log = Logger('FirestoreServiceImpl');
  final FirebaseFirestore _firestore;

  FirestoreServiceImpl(this._firestore) {
    _log.info('Khởi tạo FirestoreServiceImpl.');
  }

  /// PHƯƠNG THỨC HELPER ĐỂ XỬ LÝ LỖI MỘT CÁCH NHẤT QUÁN
  /// Giúp tránh lặp lại code trong các khối catch.
  DatabaseServiceException _handleFirestoreException(FirebaseException e, String path, String operation) {
    _log.severe("Đã xảy ra lỗi FirebaseException khi $operation tài liệu '$path'.", e, e.stackTrace);
    switch (e.code) {
      case 'permission-denied':
        return PermissionDeniedException("Không có quyền $operation tài liệu tại '$path'.");
      case 'not-found':
        return DocumentNotFoundException("Không tìm thấy tài liệu để $operation tại '$path'.");
      case 'unavailable':
        return DatabaseServiceUnavailableException("Dịch vụ không khả dụng khi $operation tài liệu tại '$path'.");
      default:
        return DatabaseServiceUnknownException("Lỗi Firestore không xác định khi $operation: ${e.message ?? e.code}");
    }
  }

  @override
  Future<Map<String, dynamic>?> getDocument({
    required String collection,
    required String docId,
  }) async {
    final path = '$collection/$docId';
    _log.info("Bắt đầu lấy tài liệu từ đường dẫn: '$path'");

    try {
      final docSnapshot = await _firestore.collection(collection).doc(docId).get();
      final data = docSnapshot.data();

      if (data != null) {
        _log.info("Lấy tài liệu thành công từ đường dẫn: '$path'.");
      } else {
        _log.warning("Không tìm thấy tài liệu tại đường dẫn: '$path'.");
      }
      return data;
    }
    // THAY ĐỔI: Bắt lỗi cụ thể và throw exception tùy chỉnh
    on FirebaseException catch (e) {
      // Sử dụng helper để xử lý và throw exception tương ứng
      throw _handleFirestoreException(e, path, "lấy");
    } catch (e, stackTrace) {
      // Bắt các lỗi không phải của Firebase
      _log.severe("Đã xảy ra lỗi không xác định khi lấy tài liệu từ '$path'.", e, stackTrace);
      throw DatabaseServiceUnknownException("Lỗi không xác định khi lấy tài liệu: ${e.toString()}");
    }
  }

  @override
  Future<void> setDocument({
    required String collection,
    required String docId,
    required Map<String, dynamic> data,
  }) async {
    final path = '$collection/$docId';
    _log.info("Bắt đầu ghi (set) dữ liệu cho tài liệu tại đường dẫn: '$path'.");
    _log.fine("Dữ liệu sẽ được ghi có ${data.keys.length} trường.");

    try {
      await _firestore.collection(collection).doc(docId).set(data);
      _log.info("Ghi dữ liệu thành công cho tài liệu: '$path'.");
    }
    // THAY ĐỔI: Bắt lỗi cụ thể và throw exception tùy chỉnh
    on FirebaseException catch (e) {
      throw _handleFirestoreException(e, path, "ghi (set)");
    } catch (e, stackTrace) {
      _log.severe("Đã xảy ra lỗi khi ghi (set) dữ liệu cho tài liệu '$path'.", e, stackTrace);
      throw DatabaseServiceUnknownException("Lỗi không xác định khi ghi dữ liệu: ${e.toString()}");
    }
  }

  @override
  Future<void> updateDocument({
    required String collection,
    required String docId,
    required Map<String, dynamic> data,
  }) async {
    final path = '$collection/$docId';
    _log.info("Bắt đầu cập nhật (update) dữ liệu cho tài liệu tại đường dẫn: '$path'.");
    _log.fine("Dữ liệu cập nhật có ${data.keys.length} trường: ${data.keys.join(', ')}");

    try {
      await _firestore.collection(collection).doc(docId).update(data);
      _log.info("Cập nhật dữ liệu thành công cho tài liệu: '$path'.");
    }
    // THAY ĐỔI: Bắt lỗi cụ thể và throw exception tùy chỉnh
    on FirebaseException catch (e) {
      throw _handleFirestoreException(e, path, "cập nhật");
    } catch (e, stackTrace) {
      _log.severe("Đã xảy ra lỗi khi cập nhật (update) dữ liệu cho tài liệu '$path'.", e, stackTrace);
      throw DatabaseServiceUnknownException("Lỗi không xác định khi cập nhật dữ liệu: ${e.toString()}");
    }
  }
}
