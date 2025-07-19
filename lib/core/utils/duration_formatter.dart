class DurationFormatter {
  static const double averageSpeedKmPerHour = 40; // Tốc độ trung bình của xe máy
  static const double metersPerKm = 1000;

  /// Ước lượng thời gian di chuyển từ khoảng cách (mét)
  static Duration estimateTravelTime(double distanceMeters) {
    final distanceKm = distanceMeters / metersPerKm;
    final hours = distanceKm / averageSpeedKmPerHour;
    return Duration(milliseconds: (hours * 3600 * 1000).round());
  }

  /// Format thời gian thành chuỗi tiếng Việt
  static String formatEstimatedTime(double distanceMeters) {
    final duration = estimateTravelTime(distanceMeters);

    if (duration.inMinutes < 1) {
      return 'khoảng 1 phút';
    } else if (duration.inHours < 1) {
      return 'khoảng ${duration.inMinutes} phút';
    } else if (duration.inHours < 24) {
      return 'khoảng ${duration.inHours} giờ';
    } else {
      return 'khoảng ${duration.inDays} ngày';
    }
  }
}
