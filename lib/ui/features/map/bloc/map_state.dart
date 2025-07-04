part of 'map_bloc.dart';

@freezed
class MapState with _$MapState {
  /// Trạng thái khởi tạo, chưa có hoạt động nào.
  const factory MapState.initial() = _Initial;

  /// Đang tải dữ liệu chỉ đường lần đầu tiên.
  const factory MapState.loading() = _Loading;

  /// Nhận và cập nhật chỉ đường thành công.
  /// Chứa cả [direction] và [userLocation] để UI có thể cập nhật
  /// cả đường đi và vị trí của người dùng.
  const factory MapState.success({
    required Direction direction,
    required LocationData userLocation,
  }) = _Success;

  /// Có lỗi xảy ra trong quá trình lấy vị trí hoặc chỉ đường.
  const factory MapState.failure({
    required DirectionFailure failure,
  }) = _Failure;
}
