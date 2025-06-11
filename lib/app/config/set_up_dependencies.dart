import 'package:dishlocal/data/categories/address/dependency/set_up_address_dependencies.dart';
import 'package:dishlocal/data/services/location_service/dependency/set_up_location_service_dependencies.dart';
import 'package:dishlocal/utils/set_up_utils_dependencies.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

Future<void> setUpDependencies() async {
  await setUpUtilsDependencies();
  await setUpLocationServiceDependencies();
  await setUpAddressDependencies();
}
