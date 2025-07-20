part of 'dish_description_bloc.dart';

@freezed
sealed class DishDescriptionEvent with _$DishDescriptionEvent {
  /// Sự kiện được kích hoạt khi người dùng yêu cầu tạo mô tả cho món ăn.
  const factory DishDescriptionEvent.generateRequested({
    required String imageUrl,
    required String dishName,
  }) = _GenerateDescriptionRequested;
}
