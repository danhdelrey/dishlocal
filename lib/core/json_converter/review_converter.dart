// Converter cho ReviewCategory (text <-> enum)
import 'package:dishlocal/data/categories/post/model/review/review_enums.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

class ReviewCategoryConverter implements JsonConverter<ReviewCategory, String> {
  const ReviewCategoryConverter();

  @override
  ReviewCategory fromJson(String json) {
    // Chuyển đổi an toàn từ string trong DB thành enum
    // .byName sẽ throw exception nếu không tìm thấy, bạn có thể thêm try-catch nếu cần
    return ReviewCategory.values.byName(json);
  }

  @override
  String toJson(ReviewCategory object) {
    // Chuyển từ enum thành string để lưu vào DB
    return object.name;
  }
}

// Converter cho List<ReviewChoice> (text[] <-> List<enum>)
class ReviewChoiceListConverter implements JsonConverter<List<ReviewChoice>, List<dynamic>> {
  const ReviewChoiceListConverter();

  @override
  List<ReviewChoice> fromJson(List<dynamic> json) {
    // Chuyển đổi danh sách các string từ DB thành danh sách các enum
    return json.map((e) => ReviewChoice.values.byName(e as String)).toList();
  }

  @override
  List<String> toJson(List<ReviewChoice> object) {
    // Chuyển danh sách enum thành danh sách string để lưu vào DB
    return object.map((e) => e.name).toList();
  }
}
