// file: lib/data/services/sql_database_service.dart

/// Một lớp tiện ích để định nghĩa việc sắp xếp trong các truy vấn.
class OrderBy {
  final String column;
  final bool ascending;

  const OrderBy(this.column, {this.ascending = true});
}

/// Interface định nghĩa các hành động CRUD cơ bản với một cơ sở dữ liệu SQL.
/// Nó trừu tượng hóa việc triển khai cụ thể (ví dụ: Supabase, một API khác).
abstract class SqlDatabaseService {
  /// Tạo một bản ghi mới trong một bảng.
  ///
  /// - [tableName]: Tên của bảng.
  /// - [data]: Dữ liệu để chèn dưới dạng Map.
  /// - [fromJson]: Một hàm để chuyển đổi kết quả trả về (Map) thành đối tượng <T>.
  ///
  /// Trả về đối tượng <T> đã được tạo (bao gồm các giá trị mặc định từ DB).
  /// Ném ra [UniqueConstraintViolationException], [PermissionDeniedException], v.v.
  Future<T> create<T>({
    required String tableName,
    required Map<String, dynamic> data,
    required T Function(Map<String, dynamic> json) fromJson,
  });

  /// Đọc một danh sách các bản ghi từ một bảng, có thể có bộ lọc.
  ///
  /// - [tableName]: Tên của bảng.
  /// - [fromJson]: Hàm để chuyển đổi mỗi bản ghi thành đối tượng <T>.
  /// - [filters]: (Tùy chọn) Một Map các điều kiện `equals` (ví dụ: {'user_id': 'abc'}).
  /// - [orderBy]: (Tùy chọn) Điều kiện sắp xếp.
  ///
  /// Trả về một `List<T>`.
  Future<List<T>> readList<T>({
    required String tableName,
    required T Function(Map<String, dynamic> json) fromJson,
    Map<String, dynamic>? filters,
    OrderBy? orderBy,
  });

  /// Đọc một bản ghi duy nhất bằng ID của nó.
  ///
  /// Ném ra [RecordNotFoundException] nếu không tìm thấy bản ghi.
  Future<T> readSingleById<T>({
    required String tableName,
    required String id,
    required T Function(Map<String, dynamic> json) fromJson,
  });

  /// Cập nhật một bản ghi hiện có bằng ID của nó.
  ///
  /// Trả về đối tượng <T> đã được cập nhật.
  /// Ném ra [RecordNotFoundException], [PermissionDeniedException], v.v.
  Future<T> update<T>({
    required String tableName,
    required String id,
    required Map<String, dynamic> data,
    required T Function(Map<String, dynamic> json) fromJson,
  });

  /// Xóa một bản ghi bằng ID của nó.
  ///
  /// Ném ra [RecordNotFoundException], [PermissionDeniedException], v.v.
  Future<void> delete({
    required String tableName,
    required String id,
  });

  /// Xóa các bản ghi khớp với một bộ lọc (filters).
  ///
  /// - [tableName]: Tên của bảng.
  /// - [filters]: Một Map các điều kiện `equals` để xác định dòng nào sẽ bị xóa.
  ///   Ví dụ: {'user_id': 'abc', 'post_id': 123}
  ///
  /// Ném ra [PermissionDeniedException], v.v.
  Future<void> deleteWhere({
    required String tableName,
    required Map<String, dynamic> filters,
  });

  Future<void> rpc(String functionName, {Map<String, dynamic>? params});

}
