import 'package:dishlocal/app/config/set_up_locators.dart';
import 'package:camera/camera.dart';

Future<void> setUpCameraServiceLocator() async {
  
  final cameras = await availableCameras();

  locator.registerSingleton<CameraDescription>(cameras.first);
}
