// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:logging/logging.dart';

import 'package:dishlocal/data/categories/address/failure/address_failure.dart' as address_failure;
import 'package:dishlocal/data/categories/address/model/address.dart';
import 'package:dishlocal/data/categories/address/repository/interface/address_repository.dart';
import 'package:dishlocal/data/services/geocoding_service/exception/geocoding_service_exception.dart';
import 'package:dishlocal/data/services/geocoding_service/interface/geocoding_service.dart';
import 'package:dishlocal/data/services/location_service/exception/location_service_exception.dart' as location_service_exception;
import 'package:dishlocal/data/services/location_service/interface/location_service.dart';

@LazySingleton(as: AddressRepository)
class AddressRepositoryImpl implements AddressRepository {
  final _log = Logger('AddressRepositoryImpl');

  // 1. Nhận các phụ thuộc qua constructor (Dependency Injection)
  final LocationService _locationService;
  final GeocodingService _geocodingService;

  AddressRepositoryImpl(
    this._locationService,
    this._geocodingService,
  );

  @override
  Future<Either<address_failure.AddressFailure, Address>> getCurrentAddress() async {
    _log.fine('getCurrentAddress(): bắt đầu luồng lấy địa chỉ hiện tại');

    try {
      // BƯỚC 1: LẤY TỌA ĐỘ TỪ LOCATION SERVICE
      // Sử dụng phương thức đã refactor, trả về Position
      final position = await _locationService.getCurrentPosition();
      _log.info('Lấy tọa độ thành công: ${position.latitude}, ${position.longitude}');

      // BƯỚC 2: LẤY ĐỊA CHỈ TỪ GEOCODING SERVICE
      final addressString = await _geocodingService.getAddressFromPosition(position.latitude, position.longitude);
      _log.info('Lấy chuỗi địa chỉ thành công: $addressString');

      // BƯỚC 3: TẠO ĐỐI TƯỢNG HOÀN CHỈNH VÀ TRẢ VỀ THÀNH CÔNG (RIGHT)
      final address = Address(
        latitude: position.latitude,
        longitude: position.longitude,
        displayName: addressString, // Dùng địa chỉ thật, không phải chuỗi cứng
      );
      return Right(address);

      // 5. BẮT LỖI VÀ "DỊCH" SANG FAILURE (LEFT)
    } on location_service_exception.LocationServiceDisabledException {
      _log.warning('Dịch vụ định vị bị tắt.');
      return const Left(address_failure.ServiceDisabledFailure());
    } on location_service_exception.LocationPermissionDeniedException {
      _log.warning('Quyền truy cập vị trí bị từ chối.');
      return const Left(address_failure.PermissionDeniedFailure());
    } on location_service_exception.LocationPermissionPermanentlyDeniedException {
      _log.severe('Quyền truy cập vị trí bị từ chối vĩnh viễn.');
      return const Left(address_failure.PermissionPermanentlyDeniedFailure());
    } on GeocodingServiceException catch (e) {
      // Bắt lỗi từ service mới
      _log.severe('Lỗi từ GeocodingService: ${e.message}');
      return Left(address_failure.GeocodingFailure(e.message));
    } catch (e) {
      // Bắt tất cả các lỗi còn lại (từ cả hai service)
      _log.severe('Lỗi không xác định trong AddressRepository: $e');
      return const Left(address_failure.UnknownFailure());
    }
  }
}
