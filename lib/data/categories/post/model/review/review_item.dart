import 'package:dishlocal/data/categories/post/model/review/review_enums.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'review_item.freezed.dart';
part 'review_item.g.dart';

/// Class lưu trữ dữ liệu đánh giá cho một hạng mục cụ thể.
@freezed
abstract class ReviewItem with _$ReviewItem {
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory ReviewItem({
    /// Hạng mục đang được đánh giá (Món ăn, Không gian, v.v.).
    required ReviewCategory category,

    /// Điểm đánh giá từ 0-5.
    @Default(0) int rating,

    /// Danh sách các lựa chọn chi tiết mà người dùng đã chọn.
    @Default([]) List<ReviewChoice> selectedChoices,
  }) = _ReviewItem;

  /// Factory constructor để tạo object từ JSON.
  factory ReviewItem.fromJson(Map<String, dynamic> json) => _$ReviewItemFromJson(json);
}
