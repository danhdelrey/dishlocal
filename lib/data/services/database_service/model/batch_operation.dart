/// Loại thao tác sẽ được thực hiện trong một batch.
enum BatchOperationType {
  /// Ghi đè hoặc tạo mới một tài liệu.
  set,

  /// Cập nhật các trường của một tài liệu hiện có.
  update,

  /// Xóa một tài liệu.
  delete,
}

/// Đại diện cho một thao tác ghi đơn lẻ trong một batch write.
/// Lớp này hoàn toàn độc lập với Firestore, giúp giữ cho lớp repository "sạch".
class BatchOperation {
  /// Loại thao tác (set, update, delete).
  final BatchOperationType type;

  /// Đường dẫn đầy đủ đến tài liệu, ví dụ: 'users/userId123' hoặc
  /// 'posts/postId456/comments/commentId789'.
  final String path;

  /// Dữ liệu để ghi. Chỉ cần thiết cho thao tác `set` và `update`.
  final Map<String, dynamic>? data;


  /// Private constructor để đảm bảo tính hợp lệ.
  BatchOperation._({
    required this.type,
    required this.path,
    this.data,
  });

  /// Tạo một thao tác `set`.
  factory BatchOperation.set({
    required String path,
    required Map<String, dynamic> data,
  }) {
    return BatchOperation._(type: BatchOperationType.set, path: path, data: data);
  }

  /// Tạo một thao tác `update`.
  factory BatchOperation.update({
    required String path,
    required Map<String, dynamic> data,
  }) {
    return BatchOperation._(type: BatchOperationType.update, path: path, data: data);
  }

  /// Tạo một thao tác `delete`.
  factory BatchOperation.delete({
    required String path,
  }) {
    return BatchOperation._(type: BatchOperationType.delete, path: path);
  }

  
}
