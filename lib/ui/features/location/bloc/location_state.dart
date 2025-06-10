part of 'location_bloc.dart';

sealed class LocationState extends Equatable {
  const LocationState();

  @override
  List<Object> get props => [];
}

final class LocationInitial extends LocationState {}

final class LocationLoading extends LocationState {}

final class LocationSuccess extends LocationState {
  final Position position;

  const LocationSuccess({required this.position});
  @override
  List<Object> get props => [position];
}

final class LocationFailure extends LocationState {
  final String failureMessage;

  const LocationFailure({required this.failureMessage});
  @override
  List<Object> get props => [failureMessage];
}

// State lỗi khi dịch vụ vị trí bị tắt
final class LocationServiceDisabled extends LocationState {}

// State lỗi khi quyền bị từ chối (có thể yêu cầu lại)
final class LocationPermissionDenied extends LocationState {}

// State lỗi khi quyền bị từ chối vĩnh viễn
final class LocationPermissionPermanentlyDenied extends LocationState {}
