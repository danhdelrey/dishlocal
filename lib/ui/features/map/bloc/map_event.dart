part of 'map_bloc.dart';

@freezed
class MapEvent with _$MapEvent {
  const factory MapEvent.findRouteRequested({
    required LatLng start,
    required LatLng destination,
  }) = _FindRouteRequested;

  /// Kích hoạt chế độ chỉ đường sau khi đã tìm thấy route
  const factory MapEvent.navigationStarted() = _NavigationStarted;

  /// Event nội bộ, được kích hoạt bởi stream từ LocationService
  const factory MapEvent.userLocationUpdated(LocationData newLocation) = _UserLocationUpdated;

  /// Người dùng xác nhận đã đến nơi
  const factory MapEvent.arrivalConfirmed() = _ArrivalConfirmed;

  /// Reset BLoC về trạng thái ban đầu
  const factory MapEvent.reset() = _Reset;
}
