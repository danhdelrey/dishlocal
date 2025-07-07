part of 'filter_sort_bloc.dart';

@freezed
class FilterSortState with _$FilterSortState {
  /// Trạng thái ban đầu, đang chờ khởi tạo.
  const factory FilterSortState.initial() = FilterSortInitial;

  /// Trạng thái đã tải xong, chứa tất cả dữ liệu lọc và sắp xếp.
  const factory FilterSortState.loaded({
    // Dữ liệu đầy đủ để hiển thị
    required List<FoodCategory> allCategories,
    required List<PriceRange> allRanges,
    required List<SortOption> allSortOptions,

    // Dữ liệu người dùng đã chọn
    required Set<FoodCategory> selectedCategories,
    required PriceRange? selectedRange,
    required SortOption selectedSortOption,
  }) = FilterSortLoaded;
}
