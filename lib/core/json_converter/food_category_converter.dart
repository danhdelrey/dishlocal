import 'package:dishlocal/core/enum/food_category.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

class FoodCategoryConverter implements JsonConverter<FoodCategory?, String?> {
  const FoodCategoryConverter();

  @override
  FoodCategory? fromJson(String? json) {
    // Nếu giá trị từ JSON là null, trả về null.
    if (json == null) {
      return null;
    }
    // Nếu giá trị không null, tìm enum tương ứng.
    // Vẫn giữ `orElse` để xử lý trường hợp chuỗi không hợp lệ từ server.
    return FoodCategory.values.firstWhere(
      (category) => category.name == json
    );
  }

  @override
  String? toJson(FoodCategory? object) {
    // Nếu đối tượng enum là null, trả về null để nó được mã hóa thành `null` trong JSON.
    // Nếu không, trả về tên của enum.
    // Cú pháp `?.` đã xử lý việc này một cách gọn gàng.
    return object?.name;
  }
}
