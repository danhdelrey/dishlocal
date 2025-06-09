import 'package:dishlocal/app/config/set_up_dependencies.dart';
import 'package:dishlocal/utils/image_processor.dart';

Future<void> setUpUtilsDependencies() async {
  getIt.registerSingleton<ImageProcessor>(ImageProcessor());
}
