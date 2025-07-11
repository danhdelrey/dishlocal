part of 'review_bloc.dart';

@freezed
class ReviewEvent with _$ReviewEvent {
  /// Sự kiện được gọi một lần khi BLoC được tạo để thiết lập trạng thái ban đầu.
  /// Nó cũng có thể được dùng để tải dữ liệu có sẵn nếu người dùng đang chỉnh sửa.
  const factory ReviewEvent.initialized({
    @Default([]) List<ReviewItem> initialReviews,
  }) = _Initialized;

  /// Sự kiện khi người dùng thay đổi số sao của một hạng mục.
  const factory ReviewEvent.ratingChanged({
    required ReviewCategory category,
    required double newRating,
  }) = _RatingChanged;

  /// Sự kiện khi người dùng chọn hoặc bỏ chọn một lựa chọn chi tiết.
  const factory ReviewEvent.choiceToggled({
    required ReviewCategory category,
    required ReviewChoice choice,
  }) = _ChoiceToggled;
}
