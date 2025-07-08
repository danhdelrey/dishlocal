/// Enum định nghĩa các khoảng cách với các phương thức tiện ích.
///
/// Các khoảng cách được định nghĩa bằng mét (m) để dễ dàng tính toán.
enum DistanceRange {
  // Giá trị max được tính bằng mét
  under1km(0, 1000, '< 1 km'),
  from1kmTo2km(1000, 2000, '1 km - 2 km'),
  from2kmTo5km(2000, 5000, '2 km - 5 km'),
  from5kmTo10km(5000, 10000, '5 km - 10 km'),
  over10km(10000, double.infinity, '> 10 km');

  const DistanceRange(this.minDistance, this.maxDistance, this.displayName);

  /// Khoảng cách tối thiểu (tính bằng mét).
  final double minDistance;

  /// Khoảng cách tối đa (tính bằng mét).
  final double maxDistance;

  /// Tên hiển thị trên UI.
  final String displayName;

  /// Kiểm tra xem một khoảng cách (tính bằng mét) có nằm trong phạm vi này không.
  bool contains(double distanceInMeters) {
    return distanceInMeters >= minDistance && distanceInMeters < maxDistance;
  }
}
