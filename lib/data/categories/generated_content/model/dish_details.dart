import 'package:freezed_annotation/freezed_annotation.dart';

part 'dish_details.freezed.dart';
part 'dish_details.g.dart';

/// Đại diện cho thông tin chi tiết, có cấu trúc về một món ăn,
/// được tạo ra bởi AI theo một schema cụ thể.
@freezed
abstract class DishDetails with _$DishDetails {
  const factory DishDetails({
    /// Mô tả tổng quan, khách quan về món ăn.
    required String overview,

    /// Danh sách các thành phần chính.
    required List<String> mainIngredients,

    /// Mô tả ngắn gọn về cách chế biến phổ biến.
    required String preparation,

    /// Nguồn gốc hoặc vùng miền nổi tiếng với món ăn này.
    required String origin,

    /// Hương vị đặc trưng của món ăn.
    required String flavorProfile,

    /// Mục đích sử dụng phổ biến (bữa sáng, trưa, tối, ăn vặt...).
    required String usage,
  }) = _DishDetails;

  /// Factory constructor để tạo instance từ JSON.
  factory DishDetails.fromJson(Map<String, dynamic> json) => _$DishDetailsFromJson(json);

  static const Map<String, dynamic> validationSchema = {
    'type': 'OBJECT',
    'properties': {
      'isMatch': {'type': 'BOOLEAN'},
      'reason': {'type': 'STRING'},
    },
    'required': ['isMatch'],
  };

  /// Schema để tạo mô tả chi tiết, có cấu trúc về món ăn.
  /// Schema này khớp với model `DishDetails`.
  static const Map<String, dynamic> detailedDescriptionSchema = {
    'type': 'OBJECT',
    'properties': {
      'overview': {'type': 'STRING', 'description': 'Mô tả tổng quan, khách quan về món ăn.'},
      'mainIngredients': {
        'type': 'ARRAY',
        'description': 'Danh sách các thành phần chính của món ăn.',
        'items': {'type': 'STRING'}
      },
      'preparation': {'type': 'STRING', 'description': 'Mô tả ngắn gọn về cách chế biến phổ biến.'},
      'origin': {'type': 'STRING', 'description': 'Nguồn gốc hoặc vùng miền nổi tiếng với món ăn này.'},
      'flavorProfile': {'type': 'STRING', 'description': 'Hương vị đặc trưng của món ăn.'},
      'usage': {'type': 'STRING', 'description': 'Mục đích sử dụng phổ biến (bữa sáng, trưa, tối, ăn vặt...)'}
    },
    'required': ['overview', 'mainIngredients', 'preparation', 'origin', 'flavorProfile', 'usage']
  };
}
