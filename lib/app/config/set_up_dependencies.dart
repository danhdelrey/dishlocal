import 'package:dishlocal/utils/set_up_utils_dependencies.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

Future<void> setUpDependencies() async {
  await setUpUtilsDependencies();
}
