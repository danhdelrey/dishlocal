part of 'review_bloc.dart';

@freezed
class ReviewState with _$ReviewState {
  /// Trạng thái khởi tạo, trước khi dữ liệu được thiết lập.
  const factory ReviewState.initial() = Initial;

  /// Trạng thái chính, chứa tất cả dữ liệu đánh giá.
  const factory ReviewState.ready({
    /// Sử dụng Map để truy cập nhanh dữ liệu của từng hạng mục.
    /// Key: Hạng mục (Món ăn, Không gian...).
    /// Value: Dữ liệu đánh giá tương ứng (sao, các lựa chọn).
    required Map<ReviewCategory, ReviewItem> reviewData,

    /// Cờ để xác định xem người dùng đã đánh giá ít nhất một hạng mục hay chưa.
    /// Hữu ích để bật/tắt nút "Đăng bài".
    @Default(false) bool isSubmittable,
  }) = Ready;
}
