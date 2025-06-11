import 'package:dartz/dartz.dart';
import 'package:dishlocal/app/config/set_up_dependencies.dart';
import 'package:dishlocal/data/error/repository_failure.dart';
import 'package:dishlocal/data/categories/address/model/address.dart';
import 'package:dishlocal/data/categories/address/repository/interface/address_repository.dart';
import 'package:dishlocal/data/services/location_service/interface/location_service.dart';
import 'package:logging/logging.dart';

class AddressRepositoryImpl implements AddressRepository {

  final _log = Logger('AddressRepositoryImpl');
  final LocationService _locationService = getIt<LocationService>();

  @override
  Future<Either<RepositoryFailure, Address>> getCurrentAddress() {
    // TODO: implement getCurrentAddress
    throw UnimplementedError();
  }
}
