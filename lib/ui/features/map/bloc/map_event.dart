part of 'map_bloc.dart';

@freezed
class MapEvent with _$MapEvent {
  /// Sự kiện được gửi khi cần tải một tuyến đường mới.
  ///
  /// - [coordinates]: Danh sách các điểm cần đi qua.
  /// - [profile]: (Tùy chọn) Phương thức di chuyển.
  /// - [optimized]: (Tùy chọn) Có cần tối ưu hóa thứ tự các điểm hay không.
  const factory MapEvent.routeRequested({
    required List<List<double>> coordinates,
    String? profile,
    @Default(false) bool optimized,
  }) = _RouteRequested;

  /// Sự kiện được gửi khi người dùng bấm nút "Bắt đầu chỉ đường".
  /// Chuyển từ trạng thái `preview` sang `navigating`.
  const factory MapEvent.navigationStarted() = _NavigationStarted;

  /// Sự kiện được gửi khi người dùng dừng chế độ chỉ đường.
  /// Chuyển từ trạng thái `navigating` về lại `preview`.
  const factory MapEvent.navigationStopped() = _NavigationStopped;

  /// (Sự kiện nội bộ) Được gửi khi có cập nhật vị trí mới từ stream.
  const factory MapEvent.locationUpdated(
    Either<DirectionFailure, LocationData> locationUpdate,
  ) = _LocationUpdated;
}
