import 'package:dartz/dartz.dart';
import 'package:dishlocal/app/config/set_up_dependencies.dart';
import 'package:dishlocal/data/categories/address/failure/address_failure.dart' as address_failure;
import 'package:dishlocal/data/categories/address/model/address.dart';
import 'package:dishlocal/data/categories/address/repository/interface/address_repository.dart';
import 'package:dishlocal/data/services/location_service/interface/location_service.dart';
import 'package:logging/logging.dart';
import 'package:dishlocal/data/services/location_service/exception/location_service_exception.dart' as location_service_exception;

class AddressRepositoryImpl implements AddressRepository {
  final _log = Logger('AddressRepositoryImpl');
  final LocationService _locationService = getIt<LocationService>();

  @override
  Future<Either<address_failure.AddressFailure, Address>> getCurrentAddress() async {
    _log.fine('getCurrentAddress(): bắt đầu lấy địa chỉ hiện tại');
    try {
      final result = await _locationService.getCurrentCoordinates();
      _log.fine('getCurrentAddress(): lấy địa chỉ hiện tại thành công');
      return Right(Address(latitude: result['latitude']!, longitude: result['longitude']!, address: 'Địa chỉ là ${result.toString()}'));
    } on location_service_exception.LocationServiceDisabledException {
      _log.severe('getCurrentAddress(): Dịch vụ định vị bị tắt');
      return const Left(address_failure.ServiceDisabledFailure());
    } on location_service_exception.LocationPermissionDeniedException {
      _log.severe('getCurrentAddress(): Quyền truy cập vị trí bị từ chối');
      return const Left(address_failure.PermissionDeniedFailure());
    } on location_service_exception.LocationPermissionPermanentlyDeniedException {
      _log.severe('getCurrentAddress(): Quyền truy cập vị trí bị từ chối vĩnh viễn');
      return const Left(address_failure.PermissionPermanentlyDeniedFailure());
    } on location_service_exception.LocationServiceUnknownException {
      _log.severe('getCurrentAddress(): Lỗi không xác định khi truy cập vị trí');
      return const Left(address_failure.UnknownFailure());
    }
  }
}
