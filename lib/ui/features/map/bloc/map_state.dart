part of 'map_bloc.dart';

@freezed
class MapState with _$MapState {
  /// Trạng thái khởi tạo, chưa có hành động nào xảy ra.
  const factory MapState.initial() = Initial;

  /// Trạng thái đang tải dữ liệu tuyến đường ban đầu.
  const factory MapState.loadInProgress() = LoadInProgress;

  /// Trạng thái tải tuyến đường thất bại.
  /// Chứa [failure] để UI có thể hiển thị thông báo lỗi phù hợp.
  const factory MapState.loadFailure(DirectionFailure failure) = LoadFailure;

  /// Trạng thái hiển thị tuyến đường thành công, ở chế độ xem trước.
  /// Người dùng có thể tự do di chuyển, phóng to/thu nhỏ bản đồ.
  ///
  /// - [direction]: Dữ liệu chỉ đường đã tải.
  const factory MapState.preview(Direction direction) = Preview;

  /// Trạng thái đang trong chế độ chỉ đường (điều hướng).
  /// Bản đồ sẽ tự động theo dõi và căn giữa vào vị trí của người dùng.
  ///
  /// - [direction]: Dữ liệu chỉ đường gốc.
  /// - [currentLocation]: Vị trí hiện tại của người dùng, được cập nhật liên tục.
  const factory MapState.navigating({
    required Direction direction,
    required LocationData currentLocation,
  }) = Navigating;
}
