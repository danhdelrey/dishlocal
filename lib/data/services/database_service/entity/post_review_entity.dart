import 'package:dishlocal/core/json_converter/date_time_converter.dart';
import 'package:dishlocal/core/json_converter/review_converter.dart';
import 'package:dishlocal/data/categories/post/model/review/review_enums.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'post_review_entity.freezed.dart';
part 'post_review_entity.g.dart';

/// Đại diện cho một bản ghi trong bảng `post_reviews`.
@freezed
abstract class PostReviewEntity with _$PostReviewEntity {
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory PostReviewEntity({
    /// PK: Primary Key, định danh duy nhất của review.
    required String id,

    /// FK: Foreign Key, tham chiếu đến `posts.id`.
    required String postId,

    /// Hạng mục đánh giá (food, ambiance, price, service).
    @ReviewCategoryConverter() 
    required ReviewCategory category,

    /// Điểm đánh giá từ 0 đến 5.
    required int rating,

    /// Danh sách các lựa chọn chi tiết người dùng đã chọn (ví dụ: 'foodFlavorful', 'ambianceClean').
    @ReviewChoiceListConverter()
    @Default([]) List<ReviewChoice> selectedChoices,

    /// Thời điểm review được tạo.
    @DateTimeConverter() 
    required DateTime createdAt,
  }) = _PostReviewEntity;

  factory PostReviewEntity.fromJson(Map<String, dynamic> json) =>
      _$PostReviewEntityFromJson(json);
}