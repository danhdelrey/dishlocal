import 'package:geolocator/geolocator.dart';

abstract class LocationService {
  /// Kiểm tra xem dịch vụ vị trí trên thiết bị có được bật hay không.
  Future<bool> isLocationServiceEnabled();

  /// Kiểm tra trạng thái quyền truy cập vị trí hiện tại của ứng dụng.
  Future<LocationPermission> checkPermission();

  /// Yêu cầu người dùng cấp quyền truy cập vị trí.
  /// Sẽ hiển thị một dialog hệ thống.
  Future<LocationPermission> requestPermission();

  /// Lấy tọa độ (latitude, longitude) hiện tại.
  /// Ném ra exception nếu dịch vụ bị tắt hoặc không có quyền.
  ///
  /// Phương thức này là một "facade" kết hợp các bước kiểm tra và lấy vị trí,
  /// phù hợp cho các trường hợp sử dụng phổ biến.
  Future<Position> getCurrentPosition();

  /// Lấy stream vị trí liên tục của người dùng.
  Stream<Position> getLocationStream();
}
