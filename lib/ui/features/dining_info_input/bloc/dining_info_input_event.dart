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

final class ExactAddressInputChanged extends DiningInfoInputEvent {
  const ExactAddressInputChanged({required this.exactAddress});
  final String exactAddress;

  @override
  List<Object?> get props => [exactAddress];
}

final class InsightInputChanged extends DiningInfoInputEvent {
  const InsightInputChanged({required this.insight});
  final String insight;

  @override
  List<Object?> get props => [insight];
}

final class MoneyInputChanged extends DiningInfoInputEvent {
  const MoneyInputChanged({required this.money});
  final String money;

  @override
  List<Object?> get props => [money];
}

final class DiningInfoInputSubmitted extends DiningInfoInputEvent {}

// Sự kiện mới để báo hiệu rằng yêu cầu focus đã được UI xử lý
final class FocusRequestHandled extends DiningInfoInputEvent {}
