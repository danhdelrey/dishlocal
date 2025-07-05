part of 'map_bloc.dart';

@freezed
class MapEvent with _$MapEvent {
  /// Sự kiện được gọi để yêu cầu tìm đường đi giữa các điểm.
  /// Đây là sự kiện khởi đầu cho việc hiển thị tuyến đường trên bản đồ.
  const factory MapEvent.routeRequested({
    required List<List<double>> coordinates,
    @Default('driving-traffic') String profile,
  }) = _RouteRequested;

  /// Sự kiện được gọi khi người dùng bắt đầu chế độ điều hướng (turn-by-turn).
  const factory MapEvent.navigationStarted() = _NavigationStarted;

  /// Sự kiện nội bộ để cập nhật vị trí mới nhất của người dùng từ stream.
  const factory MapEvent.locationUpdated({
    required LocationData locationData,
  }) = _LocationUpdated;

  /// Sự kiện nội bộ được gọi khi stream vị trí gặp lỗi.
  const factory MapEvent.locationStreamFailed({
    required DirectionFailure failure,
  }) = _LocationStreamFailed;
}
