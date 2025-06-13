part of 'dining_info_input_bloc.dart';

sealed class DiningInfoInputEvent extends Equatable {
  const DiningInfoInputEvent();

  @override
  List<Object?> get props => [];
}

final class DishNameInputChanged extends DiningInfoInputEvent {
  const DishNameInputChanged({required this.dishName});
  final String dishName;

  @override
  List<Object?> get props => [dishName];
}

final class DiningLocationNameInputChanged extends DiningInfoInputEvent {
  const DiningLocationNameInputChanged({required this.diningLocationName});
  final String diningLocationName;

  @override
  List<Object?> get props => [diningLocationName];
}

final class DiningInfoInputSubmitted extends DiningInfoInputEvent {}

// Sự kiện mới để báo hiệu rằng yêu cầu focus đã được UI xử lý
final class FocusRequestHandled extends DiningInfoInputEvent {}
