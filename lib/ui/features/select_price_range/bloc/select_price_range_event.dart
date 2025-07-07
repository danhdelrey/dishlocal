part of 'select_price_range_bloc.dart';

@freezed
class SelectPriceRangeEvent with _$SelectPriceRangeEvent {
  /// Sự kiện để khởi tạo BLoC với dữ liệu cần thiết.
  const factory SelectPriceRangeEvent.initialized({
    /// Danh sách tất cả các khoảng giá có thể chọn.
    required List<PriceRange> allRanges,

    /// Khoảng giá đã được chọn sẵn ban đầu (nếu có).
    PriceRange? initialSelection,
  }) = _Initialized;

  /// Sự kiện khi người dùng nhấn vào một khoảng giá.
  const factory SelectPriceRangeEvent.rangeToggled(PriceRange range) = _RangeToggled;
}
