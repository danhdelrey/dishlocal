
abstract class GeocodingService {
  /// Chuyển đổi một đối tượng Position thành một chuỗi địa chỉ có thể đọc được.
  Future<String> getAddressFromPosition(double latitude, double longitude);
}
