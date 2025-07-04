import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:dishlocal/data/categories/location/repository/failure/location_failure.dart';
import 'package:dishlocal/data/services/location_service/exception/location_service_exception.dart' as service_exception;
import 'package:geolocator/geolocator.dart';
import 'package:injectable/injectable.dart';
import 'package:logging/logging.dart';

import 'package:dishlocal/data/categories/location/model/location_data.dart';
import 'package:dishlocal/data/categories/location/repository/interface/location_repository.dart';
import 'package:dishlocal/data/services/location_service/interface/location_service.dart';

@LazySingleton(as: LocationRepository)
class LocationRepositoryImpl implements LocationRepository {
  final _log = Logger('LocationRepositoryImpl');
  final LocationService _locationService;
  
  LocationRepositoryImpl(this._locationService);

  @override
  Stream<Either<LocationFailure, LocationData>> getLocationStream() {
    _log.info('Bắt đầu lắng nghe stream vị trí từ repository...');
    // Lấy stream gốc từ service
    final sourceStream = _locationService.getLocationStream();

    // Sử dụng StreamTransformer để xử lý cả dữ liệu và lỗi từ stream gốc.
    // Đây là cách tiếp cận mạnh mẽ và rõ ràng nhất.
    return sourceStream.transform(
      StreamTransformer<Position, Either<LocationFailure, LocationData>>.fromHandlers(
        // Xử lý khi stream gốc phát ra dữ liệu (Position)
        handleData: (position, sink) {
          _log.fine('Repository nhận được Position, chuyển đổi thành LocationData.');
          final locationData = LocationData(
            latitude: position.latitude,
            longitude: position.longitude,
          );
          // Đẩy kết quả thành công (Right) vào stream mới
          sink.add(Right(locationData));
        },
        // Xử lý khi stream gốc phát ra lỗi (Exception)
        handleError: (error, stackTrace, sink) {
          _log.warning('Repository nhận được lỗi từ service: ${error.runtimeType}');
          // Dịch Exception từ tầng Service thành Failure của tầng Repository
          final failure = _mapExceptionToFailure(error);
          // Đẩy kết quả lỗi (Left) vào stream mới
          sink.add(Left(failure));
        },
      ),
    );
  }

  /// Phương thức helper để chuyển đổi Exception sang Failure.
  /// Giúp cho logic trong `getLocationStream` gọn gàng hơn.
  LocationFailure _mapExceptionToFailure(Object error) {
    if (error is service_exception.LocationServiceDisabledException) {
      return const LocationServiceDisabledFailure();
    }
    if (error is service_exception.LocationPermissionDeniedException) {
      return const LocationPermissionDeniedFailure();
    }
    if (error is service_exception.LocationPermissionPermanentlyDeniedException) {
      return const LocationPermissionPermanentlyDeniedFailure();
    }
    // Bắt các trường hợp còn lại và coi là lỗi không xác định.
    _log.severe('Lỗi không xác định trong luồng vị trí repository: $error');
    return const LocationUnknownFailure();
  }
}
