import 'package:dishlocal/data/services/distance_service/interface/distance_service.dart';
import 'package:geolocator/geolocator.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: DistanceService)
class HaversineDistanceService implements DistanceService {
  @override
  Future<double> calculateDistance({
    required double fromLat,
    required double fromLong,
    required double toLat,
    required double toLong,
  }) async {
    return Geolocator.distanceBetween(fromLat, fromLong, toLat, toLong);
  }
}
