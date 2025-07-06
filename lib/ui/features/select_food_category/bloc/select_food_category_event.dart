part of 'select_food_category_bloc.dart';

@freezed
class SelectFoodCategoryEvent with _$SelectFoodCategoryEvent {
  /// Sự kiện để khởi tạo BLoC với dữ liệu cần thiết.
  const factory SelectFoodCategoryEvent.initialized({
    required List<FoodCategory> allCategories,
    required bool allowMultiSelect,
    // Các mục đã được chọn sẵn ban đầu (nếu có)
    @Default({}) Set<FoodCategory> initialSelection,
  }) = _Initialized;

  /// Sự kiện khi người dùng nhấn vào một danh mục.
  const factory SelectFoodCategoryEvent.categoryToggled(FoodCategory category) = _CategoryToggled;

  /// Sự kiện khi người dùng nhấn nút "Chọn tất cả" (chỉ dành cho chế độ chọn nhiều).
  const factory SelectFoodCategoryEvent.allToggled() = _AllToggled;
}
