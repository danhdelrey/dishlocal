part of 'map_bloc.dart';

@freezed
class MapEvent with _$MapEvent {
  /// Kích hoạt bởi UI để bắt đầu theo dõi và chỉ đường.
  /// [destinationCoordinates] là một List chứa [longitude, latitude].
  const factory MapEvent.navigationStarted({
    required List<double> destinationCoordinates,
  }) = _NavigationStarted;

  /// Event nội bộ, được kích hoạt khi stream vị trí trả về dữ liệu mới.
  const factory MapEvent.locationUpdated({
    required LocationData userLocation,
  }) = _LocationUpdated;

  /// Event nội bộ, được kích hoạt khi stream vị trí báo lỗi.
  const factory MapEvent.locationStreamFailed({
    required DirectionFailure failure,
  }) = _LocationStreamFailed;
}
