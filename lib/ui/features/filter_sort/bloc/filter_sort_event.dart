part of 'filter_sort_bloc.dart';

@freezed
class FilterSortEvent with _$FilterSortEvent {
  /// Khởi tạo BLoC với trạng thái ban đầu (có thể có hoặc không).
  const factory FilterSortEvent.initialized({
    FilterSortParams? initialParams,
  }) = _Initialized;

  /// Lật/tắt một danh mục thức ăn.
  const factory FilterSortEvent.categoryToggled(FoodCategory category) = _CategoryToggled;

  /// Lật/tắt nút "Chọn tất cả" cho danh mục.
  const factory FilterSortEvent.allCategoriesToggled() = _AllCategoriesToggled;

  /// Lật/tắt một khoảng giá.
  const factory FilterSortEvent.priceRangeToggled(PriceRange range) = _PriceRangeToggled;

  /// Chọn một tùy chọn sắp xếp mới.
  const factory FilterSortEvent.sortOptionSelected(SortOption option) = _SortOptionSelected;

  const factory FilterSortEvent.sortDirectionToggled() = _SortDirectionToggled;

  const factory FilterSortEvent.distanceRangeToggled(DistanceRange distance) = _DistanceRangeToggled;

  /// Xóa tất cả các bộ lọc về trạng thái mặc định.
  const factory FilterSortEvent.filtersCleared() = _FiltersCleared;

  const factory FilterSortEvent.filtersSubmitted() = _FiltersSubmitted;
}
