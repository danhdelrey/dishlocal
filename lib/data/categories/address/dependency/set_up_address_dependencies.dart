import 'package:dishlocal/app/config/set_up_dependencies.dart';
import 'package:dishlocal/data/categories/address/repository/implementation/address_repository_impl.dart';
import 'package:dishlocal/data/categories/address/repository/interface/address_repository.dart';

Future<void> setUpAddressDependencies() async {
  getIt.registerSingleton<AddressRepository>(AddressRepositoryImpl());
}
