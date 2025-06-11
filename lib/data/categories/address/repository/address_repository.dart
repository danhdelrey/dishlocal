import 'package:dartz/dartz.dart';
import 'package:dishlocal/core/error/failure.dart';
import 'package:dishlocal/data/categories/address/model/address.dart';

abstract class AddressRepository {
  Future<Either<Failure,Address>> getCurrentAddress();
}
