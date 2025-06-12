// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:geolocator/geolocator.dart';
import 'package:injectable/injectable.dart';
import 'package:logging/logging.dart';

import 'package:dishlocal/data/services/location_service/exception/location_service_exception.dart' as location_service_exception;
import 'package:dishlocal/data/services/location_service/implementation/geolocator_wrapper.dart';
import 'package:dishlocal/data/services/location_service/interface/location_service.dart';

// Chú thích này nói rằng:
// - Đây là một Lazy Singleton.
// - Nó là triển khai của `LocationService`.
@LazySingleton(as: LocationService)
class GeolocatorServiceImpl implements LocationService {
  final _log = Logger('GeolocatorServiceImpl');
  final GeolocatorWrapper geolocatorWrapper;

  GeolocatorServiceImpl({
    required this.geolocatorWrapper,
  });

  @override
  Future<bool> isLocationServiceEnabled() {
    _log.fine('Đang gọi Geolocator.isLocationServiceEnabled()');
    return geolocatorWrapper.isLocationServiceEnabled();
  }

  @override
  Future<LocationPermission> checkPermission() {
    _log.fine('Đang gọi Geolocator.checkPermission()');
    return geolocatorWrapper.checkPermission();
  }

  @override
  Future<LocationPermission> requestPermission() {
    _log.fine('Đang gọi Geolocator.requestPermission()');
    return geolocatorWrapper.requestPermission();
  }

  /// PHƯƠNG THỨC CHÍNH ĐÃ ĐƯỢC REFACTOR
  @override
  Future<Position> getCurrentPosition() async {
    _log.info('Event: Bắt đầu luồng lấy vị trí hiện tại...');

    // BƯỚC 1: KIỂM TRA DỊCH VỤ VỊ TRÍ
    final serviceEnabled = await isLocationServiceEnabled();
    if (!serviceEnabled) {
      _log.warning('Dịch vụ vị trí đã bị tắt.');
      throw location_service_exception.LocationServiceDisabledException();
    }
    _log.info('Dịch vụ vị trí đã được bật.');

    // BƯỚC 2: KIỂM TRA VÀ XỬ LÝ QUYỀN
    await _handleLocationPermission();
    _log.info('Quyền vị trí đã được cấp.');

    // BƯỚC 3: LẤY VỊ TRÍ
    try {
      _log.fine('Đang lấy vị trí hiện tại (Geolocator.getCurrentPosition)...');
      final position = await geolocatorWrapper.getCurrentPosition();
      _log.info('Lấy vị trí thành công: Lat ${position.latitude}, Lon ${position.longitude}');
      return position;
    } catch (e, stackTrace) {
      // Bắt các lỗi không lường trước được từ chính getCurrentPosition
      _log.severe('Lỗi không xác định khi lấy vị trí: $e', e, stackTrace);
      throw location_service_exception.LocationServiceUnknownException();
    }
  }

  /// Phương thức helper riêng tư để xử lý logic quyền, giúp `getCurrentPosition` gọn gàng hơn.
  Future<void> _handleLocationPermission() async {
    _log.fine('Bắt đầu xử lý quyền vị trí...');
    var permission = await checkPermission();
    _log.info('Trạng thái quyền ban đầu: ${permission.name}');

    if (permission == LocationPermission.denied) {
      _log.info('Quyền bị từ chối, đang yêu cầu lại...');
      permission = await requestPermission();
      _log.info('Kết quả yêu cầu quyền lại: ${permission.name}');

      if (permission == LocationPermission.denied) {
        _log.warning('Người dùng đã từ chối cấp quyền.');
        throw location_service_exception.LocationPermissionDeniedException();
      }
    }

    if (permission == LocationPermission.deniedForever) {
      _log.severe('Quyền vị trí đã bị từ chối vĩnh viễn.');
      throw location_service_exception.LocationPermissionPermanentlyDeniedException();
    }
  }
}
