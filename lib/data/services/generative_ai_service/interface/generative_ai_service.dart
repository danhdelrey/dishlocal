
abstract class GenerativeAiService {
  /// Tạo mô tả cho một món ăn dựa trên hình ảnh và tên của nó.
  ///
  /// Ném ra [GenerativeAiServiceException] hoặc các lớp con của nó nếu có lỗi xảy ra.
  ///
  /// - [imageUrl]: URL công khai của hình ảnh món ăn.
  /// - [dishName]: Tên của món ăn.
  ///
  /// Trả về một [Future<String>] chứa mô tả được tạo ra.
  Future<String> generateDishDescription({
    required String imageUrl,
    required String dishName,
  });
}
