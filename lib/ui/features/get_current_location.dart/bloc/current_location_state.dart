part of 'current_location_bloc.dart';

sealed class CurrentLocationState extends Equatable {
  const CurrentLocationState();

  @override
  List<Object> get props => [];
}

final class CurrentLocationInitial extends CurrentLocationState {}

final class CurrentLocationLoading extends CurrentLocationState {}

final class CurrentLocationSuccess extends CurrentLocationState {
  final Position position;

  const CurrentLocationSuccess({required this.position});

  @override
  List<Object> get props => [position];
}

// State lỗi chung
final class CurrentLocationFailure extends CurrentLocationState {
  final String message;

  const CurrentLocationFailure(this.message);

  @override
  List<Object> get props => [message];
}

// State lỗi khi dịch vụ vị trí bị tắt
final class LocationServiceDisabled extends CurrentLocationState {}

// State lỗi khi quyền bị từ chối (có thể yêu cầu lại)
final class LocationPermissionDenied extends CurrentLocationState {}

// State lỗi khi quyền bị từ chối vĩnh viễn
final class LocationPermissionPermanentlyDenied extends CurrentLocationState {}
