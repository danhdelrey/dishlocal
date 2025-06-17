import 'package:cloud_firestore/cloud_firestore.dart';
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
    } catch (e, stackTrace) {
      _log.severe("Đã xảy ra lỗi khi lấy tài liệu từ '$path'.", e, stackTrace);
      rethrow;
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
    // Lưu ý: Không log toàn bộ 'data' để tránh rò rỉ thông tin nhạy cảm và làm đầy log.
    _log.fine("Dữ liệu sẽ được ghi có ${data.keys.length} trường.");

    try {
      await _firestore.collection(collection).doc(docId).set(data);
      _log.info("Ghi dữ liệu thành công cho tài liệu: '$path'.");
    } catch (e, stackTrace) {
      _log.severe("Đã xảy ra lỗi khi ghi (set) dữ liệu cho tài liệu '$path'.", e, stackTrace);
      rethrow;
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
    } catch (e, stackTrace) {
      _log.severe("Đã xảy ra lỗi khi cập nhật (update) dữ liệu cho tài liệu '$path'.", e, stackTrace);
      rethrow;
    }
  }
}
