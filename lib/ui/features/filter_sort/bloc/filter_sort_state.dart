part of 'filter_sort_bloc.dart';

@freezed
class FilterSortState with _$FilterSortState {
  const factory FilterSortState.initial() = FilterSortInitial;

  const factory FilterSortState.loaded({
    // Dữ liệu tĩnh để hiển thị các lựa chọn trên UI
    required List<FoodCategory> allCategories,
    required List<PriceRange> allRanges,
    required List<SortOption> allSortOptions,

    // MỚI: Một đối tượng duy nhất chứa tất cả các lựa chọn hiện tại
    required FilterSortParams currentParams,
  }) = FilterSortLoaded;
}
