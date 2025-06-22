// file: lib/data/services/database_service/implementation/firestore_service_impl.dart

import 'package:cloud_firestore/cloud_firestore.dart';
// THÊM IMPORT MỚI
import 'package:dishlocal/data/services/database_service/exception/no_sql_database_service_exception.dart';
import 'package:dishlocal/data/services/database_service/interface/no_sql_database_service.dart';
import 'package:dishlocal/data/services/database_service/model/batch_operation.dart';
import 'package:dishlocal/data/services/database_service/model/server_timestamp.dart';
import 'package:injectable/injectable.dart';
import 'package:logging/logging.dart';

@LazySingleton(as: NoSqlDatabaseService)
class NoSqlFirestoreServiceImpl implements NoSqlDatabaseService {
  final _log = Logger('FirestoreServiceImpl');
  final FirebaseFirestore _firestore;

  NoSqlFirestoreServiceImpl(this._firestore) {
    _log.info('Khởi tạo FirestoreServiceImpl.');
  }

  /// PHƯƠNG THỨC HELPER ĐỂ XỬ LÝ LỖI MỘT CÁCH NHẤT QUÁN
  /// Giúp tránh lặp lại code trong các khối catch.
  NoSqlDatabaseServiceException _handleFirestoreException(FirebaseException e, String path, String operation) {
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
      final docSnapshot = await _firestore.collection(parentCollection).doc(parentDocId).collection(subCollection).doc(subDocId).get();

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
      final docRef = await _firestore.collection(parentCollection).doc(parentDocId).collection(subCollection).add(data);
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
      await _firestore.collection(parentCollection).doc(parentDocId).collection(subCollection).doc(subDocId).set(data);
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
      await _firestore.collection(parentCollection).doc(parentDocId).collection(subCollection).doc(subDocId).update(data);
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
      await _firestore.collection(parentCollection).doc(parentDocId).collection(subCollection).doc(subDocId).delete();
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
      Query query = _firestore.collection(parentCollection).doc(parentDocId).collection(subCollection);

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

  @override
  Future<void> executeBatch(List<BatchOperation> operations) async {
    if (operations.isEmpty) {
      _log.warning("Thực thi batch nhưng danh sách thao tác rỗng. Bỏ qua.");
      return;
    }

    _log.info("Bắt đầu thực thi batch write với ${operations.length} thao tác.");
    final batch = _firestore.batch();

    try {
      for (final op in operations) {
        final docRef = _firestore.doc(op.path);

        // Hàm helper để dịch các giá trị placeholder thành FieldValue của Firestore
        Map<String, dynamic> translateData(Map<String, dynamic> originalData) {
          final translatedData = <String, dynamic>{};
          for (final entry in originalData.entries) {
            final value = entry.value;
            if (value is FieldIncrement) {
              // Dịch FieldIncrement thành FieldValue.increment
              translatedData[entry.key] = FieldValue.increment(value.value);
            } else if (value is ServerTimestamp) {
              // Dịch ServerTimestamp thành FieldValue.serverTimestamp
              translatedData[entry.key] = FieldValue.serverTimestamp();
            } else {
              // Giữ nguyên các giá trị khác
              translatedData[entry.key] = value;
            }
          }
          return translatedData;
        }

        // Switch case bây giờ hoàn toàn chính xác
        switch (op.type) {
          case BatchOperationType.set:
            _log.fine("Batch: Thêm thao tác SET cho đường dẫn '${op.path}'.");
            // Dịch dữ liệu trước khi set
            batch.set(docRef, translateData(op.data!));
            break;
          case BatchOperationType.update:
            _log.fine("Batch: Thêm thao tác UPDATE cho đường dẫn '${op.path}'.");
            // Dịch dữ liệu trước khi update
            batch.update(docRef, translateData(op.data!));
            break;
          case BatchOperationType.delete:
            _log.fine("Batch: Thêm thao tác DELETE cho đường dẫn '${op.path}'.");
            batch.delete(docRef);
            break;
        }
      }

      await batch.commit();
      _log.info("Thực thi batch write thành công.");
    } on FirebaseException catch (e) {
      _log.severe("Lỗi FirebaseException trong quá trình batch write.", e, e.stackTrace);
      throw DatabaseServiceUnknownException("Lỗi Firestore trong batch write: ${e.message ?? e.code}");
    } catch (e, stackTrace) {
      _log.severe("Lỗi không xác định trong quá trình batch write.", e, stackTrace);
      throw DatabaseServiceUnknownException("Lỗi không xác định trong batch write: ${e.toString()}");
    }
  }

  @override
  Future<List<Map<String, dynamic>>> getDocumentsWhereIdIn({
    required String collection,
    required List<String> ids,
  }) async {
    // Firestore không cho phép truy vấn 'whereIn' với danh sách rỗng.
    if (ids.isEmpty) {
      _log.info("Danh sách ID rỗng cho truy vấn 'whereIn' trên collection '$collection', trả về danh sách trống.");
      return [];
    }

    _log.info("Bắt đầu truy vấn 'whereIn' trên ${ids.length} ID trong collection '$collection'.");
    try {
      // Chia nhỏ danh sách ID nếu nó quá lớn, vì Firestore giới hạn 10 phần tử cho `whereIn`.
      // (Lưu ý: Giới hạn này đã được nâng lên 30 cho `in`, `not-in`, `array-contains-any` kể từ tháng 11/2022)
      // Chúng ta sẽ giả sử giới hạn là 30.
      List<Map<String, dynamic>> results = [];
      for (var i = 0; i < ids.length; i += 30) {
        final sublist = ids.sublist(i, i + 30 > ids.length ? ids.length : i + 30);
        final snapshot = await _firestore.collection(collection).where(FieldPath.documentId, whereIn: sublist).get();

        results.addAll(snapshot.docs.map((doc) {
          final data = doc.data();
          data['id'] = doc.id;
          return data;
        }));
      }

      _log.info("Truy vấn 'whereIn' thành công, lấy được ${results.length} tài liệu từ '$collection'.");
      return results;
    } on FirebaseException catch (e) {
      throw _handleFirestoreException(e, collection, "truy vấn 'whereIn'");
    } catch (e, stackTrace) {
      _log.severe("Lỗi không xác định khi truy vấn 'whereIn' trên collection '$collection'.", e, stackTrace);
      throw DatabaseServiceUnknownException("Lỗi không xác định khi truy vấn 'whereIn': ${e.toString()}");
    }
  }

  @override
  Future<List<Map<String, dynamic>>> getDocumentsWhere({
    required String collection,
    required String field,
    required List<dynamic> values,
    String? orderBy,
    bool descending = false,
    int limit = 10,
    dynamic startAfter,
  }) async {
    // Firestore không cho phép truy vấn 'whereIn' với danh sách rỗng.
    if (values.isEmpty) {
      _log.info("Danh sách giá trị rỗng cho truy vấn 'whereIn' trên collection '$collection', trả về danh sách trống.");
      return [];
    }

    final path = collection;
    _log.info("Bắt đầu truy vấn 'whereIn' trên trường '$field' trong collection: '$path'");
    _log.fine("Tham số truy vấn: orderBy='$orderBy', descending=$descending, limit=$limit, startAfter=$startAfter");

    try {
      // Chia nhỏ danh sách giá trị nếu nó quá lớn (giới hạn của Firestore là 30 cho 'in')
      List<Map<String, dynamic>> results = [];
      for (var i = 0; i < values.length; i += 30) {
        final sublist = values.sublist(i, i + 30 > values.length ? values.length : i + 30);

        Query query = _firestore.collection(collection).where(field, whereIn: sublist);

        if (orderBy != null) {
          query = query.orderBy(orderBy, descending: descending);
          if (startAfter != null) {
            query = query.startAfter([startAfter]);
          }
        }
        query = query.limit(limit);

        final snapshot = await query.get();
        _log.info("Lấy được ${snapshot.docs.length} tài liệu từ truy vấn con.");

        results.addAll(snapshot.docs.map((doc) {
          final data = doc.data() as Map<String, dynamic>;
          data['id'] = doc.id;
          return data;
        }));
      }

      _log.info("Truy vấn 'whereIn' thành công, tổng cộng lấy được ${results.length} tài liệu từ '$collection'.");
      // Lưu ý: Kết quả từ nhiều truy vấn con có thể cần được sắp xếp lại và giới hạn ở phía client nếu cần.
      // Tuy nhiên, trong trường hợp phân trang, cách tiếp cận này là đủ tốt.
      return results;
    } on FirebaseException catch (e) {
      throw _handleFirestoreException(e, path, "truy vấn 'whereIn' trên trường '$field'");
    } catch (e, stackTrace) {
      _log.severe("Lỗi không xác định khi truy vấn 'whereIn' trên '$path'.", e, stackTrace);
      throw DatabaseServiceUnknownException("Lỗi không xác định khi truy vấn 'whereIn': ${e.toString()}");
    }
  }
}
