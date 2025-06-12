import 'package:geolocator/geolocator.dart';
import 'package:injectable/injectable.dart';

// Class này không có logic, chỉ đơn giản là gọi các hàm tĩnh tương ứng.
// Nó hoạt động như một "bộ chuyển đổi" (Adapter).
@injectable // Đăng ký với DI để có thể inject vào các service khác
class GeolocatorWrapper {
  Future<bool> isLocationServiceEnabled() => Geolocator.isLocationServiceEnabled();

  Future<LocationPermission> checkPermission() => Geolocator.checkPermission();

  Future<LocationPermission> requestPermission() => Geolocator.requestPermission();

  Future<Position> getCurrentPosition() => Geolocator.getCurrentPosition();
}
