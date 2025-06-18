import 'dart:io';

abstract class StorageService {
  /// Tải lên một tệp tin vào một đường dẫn cụ thể trên cloud storage.
  ///
  /// Trả về [String] là URL để có thể tải xuống tệp tin sau khi tải lên thành công.
  ///
  /// Ném ra một [StorageServiceException] nếu có lỗi xảy ra.
  ///
  /// - [path]: Đường dẫn trên cloud để lưu tệp, ví dụ: 'posts/user_id/image.jpg'.
  /// - [file]: Đối tượng tệp tin локал cần tải lên.
  Future<String> uploadFile({
    required String path,
    required File file,
  });

  /// Xóa một tệp tin tại một đường dẫn cụ thể trên cloud storage.
  ///
  /// Ném ra [ObjectNotFoundException] nếu tệp không tồn tại.
  /// Ném ra [UnauthorizedException] nếu không có quyền xóa.
  ///
  /// - [path]: Đường dẫn trên cloud của tệp cần xóa.
  Future<void> deleteFile({
    required String path,
  });
}
