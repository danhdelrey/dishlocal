part of 'current_address_bloc.dart';

sealed class CurrentAddressState extends Equatable {
  const CurrentAddressState();

  @override
  List<Object> get props => [];
}

final class CurrentAddressInitial extends CurrentAddressState {}

final class CurrentAddressLoading extends CurrentAddressState {}

final class CurrentAddressSuccess extends CurrentAddressState {
  final Address address;

  const CurrentAddressSuccess({required this.address});

  @override
  List<Object> get props => [address];
}

// State lỗi chung
final class CurrentAddressFailure extends CurrentAddressState {
  final String message;

  const CurrentAddressFailure(this.message);

  @override
  List<Object> get props => [message];
}

// State lỗi khi dịch vụ vị trí bị tắt
final class LocationServiceDisabled extends CurrentAddressState {}

// State lỗi khi quyền bị từ chối (có thể yêu cầu lại)
final class LocationPermissionDenied extends CurrentAddressState {}

// State lỗi khi quyền bị từ chối vĩnh viễn
final class LocationPermissionPermanentlyDenied extends CurrentAddressState {}
