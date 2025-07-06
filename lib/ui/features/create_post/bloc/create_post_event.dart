part of 'create_post_bloc.dart';

sealed class CreatePostEvent extends Equatable {
  const CreatePostEvent();

  @override
  List<Object?> get props => [];
}

final class CreatePostInitialized extends CreatePostEvent {
  final Post? postToUpdate;

  const CreatePostInitialized({ this.postToUpdate});
  @override
  List<Object?> get props => [postToUpdate];
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
  final String blurHash;
  final DateTime createdAt;
  final FoodCategory? foodCategory;
  final Post? postToUpdate;

  const CreatePostRequested({required this.address, required this.imagePath, required this.createdAt, required this.blurHash, this.postToUpdate, this.foodCategory});
  @override
  List<Object?> get props => [address, imagePath, createdAt];
}


// Sự kiện mới để báo hiệu rằng yêu cầu focus đã được UI xử lý
final class FocusRequestHandled extends CreatePostEvent {}
