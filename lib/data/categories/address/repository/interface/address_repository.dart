import 'package:dartz/dartz.dart';
import 'package:dishlocal/data/categories/address/failure/address_failure.dart';
import 'package:dishlocal/data/categories/address/model/address.dart';

abstract class AddressRepository {
  Future<Either<AddressFailure, Address>> getCurrentAddress();
  Future<Either<AddressFailure, double>> calculateDistance(double toLat, double toLong);
}
