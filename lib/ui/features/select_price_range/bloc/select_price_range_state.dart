part of 'select_price_range_bloc.dart';

@freezed
class SelectPriceRangeState with _$SelectPriceRangeState {
  /// Trạng thái ban đầu, chưa có dữ liệu.
  const factory SelectPriceRangeState.initial() = SelectPriceRangeInitial;

  /// Trạng thái khi dữ liệu đã sẵn sàng để hiển thị.
  const factory SelectPriceRangeState.loaded({
    /// Danh sách tất cả các khoảng giá có thể chọn.
    required List<PriceRange> allRanges,

    /// Khoảng giá đang được chọn (có thể là null nếu không có gì được chọn).
    PriceRange? selectedRange,
  }) = SelectPriceRangeLoaded;
}
