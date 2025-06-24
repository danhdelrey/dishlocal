import 'package:dishlocal/data/services/database_service/model/batch_operation.dart';

abstract class NoSqlDatabaseService {
  //----------------------------------------------------//
  //--- THAO TÁC VỚI DOCUMENT GỐC (TOP-LEVEL) ---//
  //----------------------------------------------------//

  /// Lấy một document duy nhất từ collection.
  Future<Map<String, dynamic>?> getDocument({
    required String collection,
    required String docId,
  });

  /// Tạo mới hoặc ghi đè hoàn toàn một document với một ID cụ thể.
  Future<void> setDocument({
    required String collection,
    required String docId,
    required Map<String, dynamic> data,
  });

  /// Cập nhật các trường dữ liệu trong một document.
  /// Chỉ ghi đè các trường được cung cấp trong [data].
  Future<void> updateDocument({
    required String collection,
    required String docId,
    required Map<String, dynamic> data,
  });

  /// Thêm một document mới vào collection và để Firebase tự động tạo ID.
  /// Trả về ID của document vừa được tạo.
  Future<String> addDocument({
    required String collection,
    required Map<String, dynamic> data,
  });

  /// Xóa một document khỏi collection.
  Future<void> deleteDocument({
    required String collection,
    required String docId,
  });

  /// Lấy danh sách các document từ một collection với các tùy chọn truy vấn.
  Future<List<Map<String, dynamic>>> getDocuments({
    required String collection,
    String? orderBy,
    bool descending = false,
    int limit = 10,
    dynamic startAfter, // Thường là DocumentSnapshot để phân trang
  });

  //-------------------------------------------------------//
  //--- THAO TÁC VỚI SUB-DOCUMENT (TÀI LIỆU CON) ---//
  //-------------------------------------------------------//

  /// Lấy một sub-document cụ thể.
  Future<Map<String, dynamic>?> getSubDocument({
    required String parentCollection,
    required String parentDocId,
    required String subCollection,
    required String subDocId,
  });

  /// Thêm một sub-document mới vào sub-collection và để Firebase tự tạo ID.
  /// Trả về ID của sub-document vừa tạo.
  Future<String> addSubDocument({
    required String parentCollection,
    required String parentDocId,
    required String subCollection,
    required Map<String, dynamic> data,
  });

  /// Tạo mới hoặc ghi đè hoàn toàn một sub-document với một ID cụ thể.
  Future<void> setSubDocument({
    required String parentCollection,
    required String parentDocId,
    required String subCollection,
    required String subDocId,
    required Map<String, dynamic> data,
  });

  /// Cập nhật dữ liệu cho một sub-document.
  Future<void> updateSubDocument({
    required String parentCollection,
    required String parentDocId,
    required String subCollection,
    required String subDocId,
    required Map<String, dynamic> data,
  });

  /// Xóa một sub-document.
  Future<void> deleteSubDocument({
    required String parentCollection,
    required String parentDocId,
    required String subCollection,
    required String subDocId,
  });

  /// Lấy danh sách các sub-document từ một sub-collection.
  Future<List<Map<String, dynamic>>> getSubDocuments({
    required String parentCollection,
    required String parentDocId,
    required String subCollection,
    String? orderBy,
    bool descending = false,
    int limit = 10,
    dynamic startAfter,
  });

  /// Thực thi một danh sách các thao tác ghi một cách nguyên tử.
  /// Phương thức này nhận một list các `BatchOperation` đã được định nghĩa trước.
  /// Nó đảm bảo tất cả các thao tác thành công, hoặc không thao tác nào được thực hiện.
  Future<void> executeBatch(List<BatchOperation> operations);

  /// Lấy tất cả các tài liệu trong một collection có ID nằm trong danh sách `ids` được cung cấp.
  /// Sử dụng truy vấn 'whereIn' trên FieldPath.documentId để tối ưu hiệu suất.
  ///
  /// - `collection`: Đường dẫn đến collection (ví dụ: 'users/userId/likes').
  /// - `ids`: Danh sách các ID của tài liệu cần lấy.
  Future<List<Map<String, dynamic>>> getDocumentsWhereIdIn({
    required String collection,
    required List<String> ids,
  });

  Future<List<Map<String, dynamic>>> getDocumentsWhere({
    required String collection,
    required String field,
    required List<dynamic> values, // Danh sách giá trị cho 'whereIn'
    String? orderBy,
    bool descending = false,
    int limit = 10,
    dynamic startAfter,
  });
}
