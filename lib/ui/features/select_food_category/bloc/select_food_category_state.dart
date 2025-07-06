part of 'select_food_category_bloc.dart';

@freezed
class SelectFoodCategoryState with _$SelectFoodCategoryState {
  /// Trạng thái ban đầu, chưa có dữ liệu.
  const factory SelectFoodCategoryState.initial() = SelectFoodCategoryInitial;

  /// Trạng thái khi dữ liệu đã sẵn sàng để hiển thị.
  const factory SelectFoodCategoryState.loaded({
    /// Danh sách tất cả các danh mục có thể chọn.
    required List<FoodCategory> allCategories,

    /// Tập hợp các danh mục đang được chọn.
    required Set<FoodCategory> selectedCategories,

    /// Chế độ cho phép chọn nhiều hay không.
    required bool allowMultiSelect,
  }) = SelectFoodCategoryLoaded;
}
