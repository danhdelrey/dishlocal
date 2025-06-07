import 'package:dishlocal/data/services/camera_service/camera_service_locator.dart';
import 'package:get_it/get_it.dart';

final locator = GetIt.instance;

Future<void> setUpLocators() async {
  await setUpCameraServiceLocator();
}
