import 'package:dartz/dartz.dart';
import 'package:dishlocal/data/error/repository_failure.dart';
import 'package:dishlocal/data/categories/address/model/address.dart';

abstract class AddressRepository {
  Future<Either<RepositoryFailure, Address>> getCurrentAddress();
}
