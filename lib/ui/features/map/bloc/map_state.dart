part of 'map_bloc.dart';

@freezed
sealed class MapState with _$MapState {
  /// Trạng thái khởi tạo, chưa có hành động nào xảy ra.
  const factory MapState.initial() = _Initial;

  /// Trạng thái đang tải dữ liệu chỉ đường.
  /// UI nên hiển thị một chỉ báo tải (loading indicator).
  const factory MapState.loadInProgress() = _LoadInProgress;

  /// Trạng thái đã tìm thấy đường đi thành công.
  /// Chứa thông tin về tuyến đường và vị trí hiện tại của người dùng.
  /// Đây là trạng thái xem trước tuyến đường.
  const factory MapState.loadSuccess({
    required Direction direction,
    required LocationData? currentLocation,
  }) = _LoadSuccess;

  /// Trạng thái tìm đường thất bại.
  /// Chứa thông tin lỗi để UI có thể hiển thị thông báo phù hợp.
  const factory MapState.loadFailure({
    required DirectionFailure failure,
  }) = _LoadFailure;

  /// Trạng thái đang trong chế độ điều hướng (giống Google Maps).
  /// UI sẽ thay đổi để tập trung vào vị trí người dùng và các chỉ dẫn tiếp theo.
  const factory MapState.navigation({
    required Direction direction,
    required LocationData currentLocation,
  }) = _Navigation;
}
