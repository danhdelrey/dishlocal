import 'package:dishlocal/app/config/set_up_dependencies.dart';
import 'package:dishlocal/data/services/location_service/implementation/geolocator_service_impl.dart';
import 'package:dishlocal/data/services/location_service/interface/location_service.dart';

Future<void> setUpLocationServiceDependencies() async {
  getIt.registerSingleton<LocationService>(GeolocatorServiceImpl());
}
