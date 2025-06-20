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

  @override
  Future<List<Map<String, dynamic>>> getDocuments({
    required String collection,
    String? orderBy,
    bool descending = false,
    int limit = 10,
    dynamic startAfter,
  }) async {
    final path = collection;
    _log.info("Bắt đầu truy vấn danh sách tài liệu từ collection: '$path'");
    _log.fine("Tham số truy vấn: orderBy='$orderBy', descending=$descending, limit=$limit, startAfter=$startAfter");

    try {
      Query query = _firestore.collection(collection);

      if (orderBy != null) {
        query = query.orderBy(orderBy, descending: descending);
        if (startAfter != null) {
          query = query.startAfter([startAfter]);
        }
      }

      query = query.limit(limit);

      final snapshot = await query.get();

      _log.info("Lấy được ${snapshot.docs.length} tài liệu từ collection: '$path'");

      return snapshot.docs.map<Map<String, dynamic>>((doc) {
        final data = doc.data() as Map<String, dynamic>; // Ép kiểu rõ ràng
        data['id'] = doc.id; // Tuỳ chọn thêm id
        return data;
      }).toList();
    } on FirebaseException catch (e) {
      throw _handleFirestoreException(e, path, "truy vấn danh sách");
    } catch (e, stackTrace) {
      _log.severe("Đã xảy ra lỗi không xác định khi truy vấn danh sách tài liệu từ '$path'.", e, stackTrace);
      throw DatabaseServiceUnknownException("Lỗi không xác định khi truy vấn danh sách: ${e.toString()}");
    }
  }
  
  @override
  Future<String> addDocument({required String collection, required Map<String, dynamic> data}) async {
    final path = collection;
    _log.info("Bắt đầu thêm (add) tài liệu mới vào collection: '$path'.");
    _log.fine("Dữ liệu thêm mới có ${data.keys.length} trường.");
    try {
      final docRef = await _firestore.collection(collection).add(data);
      _log.info("Thêm tài liệu mới thành công vào collection '$path' với ID: '${docRef.id}'.");
      return docRef.id;
    } on FirebaseException catch (e) {
      throw _handleFirestoreException(e, path, "thêm");
    } catch (e, stackTrace) {
      _log.severe("Đã xảy ra lỗi không xác định khi thêm tài liệu vào '$path'.", e, stackTrace);
      throw DatabaseServiceUnknownException("Lỗi không xác định khi thêm tài liệu: ${e.toString()}");
    }
  }
  
  @override
  Future<void> deleteDocument({required String collection, required String docId}) async {
    final path = '$collection/$docId';
    _log.info("Bắt đầu xóa tài liệu tại đường dẫn: '$path'.");
    try {
      await _firestore.collection(collection).doc(docId).delete();
      _log.info("Xóa tài liệu thành công tại đường dẫn: '$path'.");
    } on FirebaseException catch (e) {
      throw _handleFirestoreException(e, path, "xóa");
    } catch (e, stackTrace) {
      _log.severe("Đã xảy ra lỗi không xác định khi xóa tài liệu tại '$path'.", e, stackTrace);
      throw DatabaseServiceUnknownException("Lỗi không xác định khi xóa tài liệu: ${e.toString()}");
    }
  }
  
  @override
  Future<Map<String, dynamic>?> getSubDocument({required String parentCollection, required String parentDocId, required String subCollection, required String subDocId}) async {
    final path = '$parentCollection/$parentDocId/$subCollection/$subDocId';
    _log.info("Bắt đầu lấy tài liệu con từ đường dẫn: '$path'");

    try {
      final docSnapshot = await _firestore
          .collection(parentCollection)
          .doc(parentDocId)
          .collection(subCollection)
          .doc(subDocId)
          .get();
      
      final data = docSnapshot.data();

      if (data != null) {
        _log.info("Lấy tài liệu con thành công từ đường dẫn: '$path'.");
      } else {
        _log.warning("Không tìm thấy tài liệu con tại đường dẫn: '$path'.");
      }
      return data;
    } on FirebaseException catch (e) {
      throw _handleFirestoreException(e, path, "lấy");
    } catch (e, stackTrace) {
      _log.severe("Đã xảy ra lỗi không xác định khi lấy tài liệu con từ '$path'.", e, stackTrace);
      throw DatabaseServiceUnknownException("Lỗi không xác định khi lấy tài liệu con: ${e.toString()}");
    }
  }

  @override
  Future<String> addSubDocument({required String parentCollection, required String parentDocId, required String subCollection, required Map<String, dynamic> data}) async {
    final path = '$parentCollection/$parentDocId/$subCollection';
    _log.info("Bắt đầu thêm (add) tài liệu con mới vào collection: '$path'.");
    _log.fine("Dữ liệu thêm mới có ${data.keys.length} trường.");

    try {
      final docRef = await _firestore
          .collection(parentCollection)
          .doc(parentDocId)
          .collection(subCollection)
          .add(data);
      _log.info("Thêm tài liệu con mới thành công vào collection '$path' với ID: '${docRef.id}'.");
      return docRef.id;
    } on FirebaseException catch (e) {
      throw _handleFirestoreException(e, path, "thêm");
    } catch (e, stackTrace) {
      _log.severe("Đã xảy ra lỗi không xác định khi thêm tài liệu con vào '$path'.", e, stackTrace);
      throw DatabaseServiceUnknownException("Lỗi không xác định khi thêm tài liệu con: ${e.toString()}");
    }
  }

  @override
  Future<void> setSubDocument({required String parentCollection, required String parentDocId, required String subCollection, required String subDocId, required Map<String, dynamic> data}) async {
    final path = '$parentCollection/$parentDocId/$subCollection/$subDocId';
    _log.info("Bắt đầu ghi (set) dữ liệu cho tài liệu con tại đường dẫn: '$path'.");
    _log.fine("Dữ liệu sẽ được ghi có ${data.keys.length} trường.");

    try {
      await _firestore
          .collection(parentCollection)
          .doc(parentDocId)
          .collection(subCollection)
          .doc(subDocId)
          .set(data);
      _log.info("Ghi dữ liệu thành công cho tài liệu con: '$path'.");
    } on FirebaseException catch (e) {
      throw _handleFirestoreException(e, path, "ghi (set)");
    } catch (e, stackTrace) {
      _log.severe("Đã xảy ra lỗi khi ghi (set) dữ liệu cho tài liệu con '$path'.", e, stackTrace);
      throw DatabaseServiceUnknownException("Lỗi không xác định khi ghi dữ liệu: ${e.toString()}");
    }
  }
  
  @override
  Future<void> updateSubDocument({required String parentCollection, required String parentDocId, required String subCollection, required String subDocId, required Map<String, dynamic> data}) async {
    final path = '$parentCollection/$parentDocId/$subCollection/$subDocId';
    _log.info("Bắt đầu cập nhật (update) dữ liệu cho tài liệu con tại đường dẫn: '$path'.");
    _log.fine("Dữ liệu cập nhật có ${data.keys.length} trường: ${data.keys.join(', ')}");

    try {
      await _firestore
          .collection(parentCollection)
          .doc(parentDocId)
          .collection(subCollection)
          .doc(subDocId)
          .update(data);
      _log.info("Cập nhật dữ liệu thành công cho tài liệu con: '$path'.");
    } on FirebaseException catch (e) {
      throw _handleFirestoreException(e, path, "cập nhật");
    } catch (e, stackTrace) {
      _log.severe("Đã xảy ra lỗi khi cập nhật (update) dữ liệu cho tài liệu con '$path'.", e, stackTrace);
      throw DatabaseServiceUnknownException("Lỗi không xác định khi cập nhật dữ liệu: ${e.toString()}");
    }
  }

  @override
  Future<void> deleteSubDocument({required String parentCollection, required String parentDocId, required String subCollection, required String subDocId}) async {
    final path = '$parentCollection/$parentDocId/$subCollection/$subDocId';
    _log.info("Bắt đầu xóa tài liệu con tại đường dẫn: '$path'.");
    try {
      await _firestore
          .collection(parentCollection)
          .doc(parentDocId)
          .collection(subCollection)
          .doc(subDocId)
          .delete();
      _log.info("Xóa tài liệu con thành công tại đường dẫn: '$path'.");
    } on FirebaseException catch (e) {
      throw _handleFirestoreException(e, path, "xóa");
    } catch (e, stackTrace) {
      _log.severe("Đã xảy ra lỗi không xác định khi xóa tài liệu con tại '$path'.", e, stackTrace);
      throw DatabaseServiceUnknownException("Lỗi không xác định khi xóa tài liệu con: ${e.toString()}");
    }
  }
  
  @override
  Future<List<Map<String, dynamic>>> getSubDocuments({required String parentCollection, required String parentDocId, required String subCollection, String? orderBy, bool descending = false, int limit = 10, startAfter}) async {
    final path = '$parentCollection/$parentDocId/$subCollection';
    _log.info("Bắt đầu truy vấn danh sách tài liệu con từ collection: '$path'");
    _log.fine("Tham số truy vấn: orderBy='$orderBy', descending=$descending, limit=$limit, startAfter=$startAfter");
    
    try {
      Query query = _firestore
          .collection(parentCollection)
          .doc(parentDocId)
          .collection(subCollection);
      
      if (orderBy != null) {
        query = query.orderBy(orderBy, descending: descending);
        if (startAfter != null) {
          query = query.startAfter([startAfter]);
        }
      }

      query = query.limit(limit);

      final snapshot = await query.get();

      _log.info("Lấy được ${snapshot.docs.length} tài liệu con từ collection: '$path'");

      return snapshot.docs.map<Map<String, dynamic>>((doc) {
        final data = doc.data() as Map<String, dynamic>; 
        data['id'] = doc.id; 
        return data;
      }).toList();
    } on FirebaseException catch (e) {
      throw _handleFirestoreException(e, path, "truy vấn danh sách");
    } catch (e, stackTrace) {
      _log.severe("Đã xảy ra lỗi không xác định khi truy vấn danh sách tài liệu con từ '$path'.", e, stackTrace);
      throw DatabaseServiceUnknownException("Lỗi không xác định khi truy vấn danh sách: ${e.toString()}");
    }
  }

}
