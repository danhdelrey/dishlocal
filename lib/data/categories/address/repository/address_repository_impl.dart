import 'package:dartz/dartz.dart';
import 'package:dishlocal/data/error/repository_failure.dart';
import 'package:dishlocal/data/categories/address/model/address.dart';
import 'package:dishlocal/data/categories/address/repository/address_repository.dart';

class AddressRepositoryImpl implements AddressRepository {
  @override
  Future<Either<RepositoryFailure, Address>> getCurrentAddress() {
    // TODO: implement getCurrentAddress
    throw UnimplementedError();
  }
}
