abstract class DistanceService {
  Future<double> calculateDistance({
    required double fromLat,
    required double fromLong,
    required double toLat,
    required double toLong,
  });
}
