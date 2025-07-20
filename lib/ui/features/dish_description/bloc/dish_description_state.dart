part of 'dish_description_bloc.dart';

@freezed
sealed class DishDescriptionState with _$DishDescriptionState {
  /// Trạng thái ban đầu, chưa có mô tả nào được tạo.
  const factory DishDescriptionState.initial() = DishDescriptionInitial;

  /// Trạng thái đang tải, cho biết quá trình tạo mô tả đang diễn ra.
  const factory DishDescriptionState.loading() = DishDescriptionLoading;

  /// Trạng thái thành công, chứa mô tả đã được tạo.
  const factory DishDescriptionState.success({required String description}) = DishDescriptionSuccess;

  /// Trạng thái thất bại, chứa thông báo lỗi.
  const factory DishDescriptionState.failure({required String errorMessage}) = DishDescriptionFailure;
}
