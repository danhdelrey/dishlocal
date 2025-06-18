part of 'create_post_bloc.dart';

sealed class CreatePostEvent extends Equatable {
  const CreatePostEvent();

  @override
  List<Object?> get props => [];
}

final class DishNameInputChanged extends CreatePostEvent {
  const DishNameInputChanged({required this.dishName});
  final String dishName;

  @override
  List<Object?> get props => [dishName];
}

final class DiningLocationNameInputChanged extends CreatePostEvent {
  const DiningLocationNameInputChanged({required this.diningLocationName});
  final String diningLocationName;

  @override
  List<Object?> get props => [diningLocationName];
}

final class ExactAddressInputChanged extends CreatePostEvent {
  const ExactAddressInputChanged({required this.exactAddress});
  final String exactAddress;

  @override
  List<Object?> get props => [exactAddress];
}

final class InsightInputChanged extends CreatePostEvent {
  const InsightInputChanged({required this.insight});
  final String insight;

  @override
  List<Object?> get props => [insight];
}

final class MoneyInputChanged extends CreatePostEvent {
  const MoneyInputChanged({required this.money});
  final String money;

  @override
  List<Object?> get props => [money];
}

final class CreatePostRequested extends CreatePostEvent {
  final Address address;
  final String imagePath;
  final DateTime createdAt;

  const CreatePostRequested({required this.address, required this.imagePath, required this.createdAt});
  @override
  List<Object?> get props => [address, imagePath, createdAt];
}

// Sự kiện mới để báo hiệu rằng yêu cầu focus đã được UI xử lý
final class FocusRequestHandled extends CreatePostEvent {}
