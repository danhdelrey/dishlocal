part of 'map_bloc.dart';

@freezed
class MapState with _$MapState {
  /// Trạng thái ban đầu, chưa có hoạt động gì
  const factory MapState.initial() = _Initial;

  /// Đang trong quá trình gọi API để tìm đường
  const factory MapState.routeFinding() = _RouteFinding;

  /// Tìm đường thất bại
  const factory MapState.routeFindingFailure(DirectionFailure failure) = _RouteFindingFailure;

  /// Đã tìm thấy đường đi, hiển thị trên bản đồ để người dùng xem trước
  const factory MapState.routeFound({
    required Direction direction,
    // Thường sẽ có thêm đối tượng Polyline để vẽ, nhưng để đơn giản ta chỉ cần direction
  }) = _RouteFound;

  /// Đang trong chế độ chỉ đường (navigation)
  const factory MapState.navigationInProgress({
    required Direction direction,
    required LocationData userLocation,
    required StepModel currentStep, // Step hiện tại để hiển thị chỉ dẫn
    required double distanceToNextManeuver, // Khoảng cách đến khúc cua tiếp theo
  }) = _NavigationInProgress;

  /// Đã đến đích, chờ người dùng xác nhận
  const factory MapState.arrived() = _Arrived;

  /// Đang tính toán lại lộ trình khi người dùng đi lạc
  const factory MapState.rerouting() = _Rerouting;
}
