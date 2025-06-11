abstract class LocationService {
  Future<bool> isServiceEnabled();
  Future<Map<String, double>> getCurrentCoordinates();
  
}
