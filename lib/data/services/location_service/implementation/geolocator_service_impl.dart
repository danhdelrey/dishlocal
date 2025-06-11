import 'package:dishlocal/data/services/location_service/interface/location_service.dart';
import 'package:geolocator/geolocator.dart';
import 'package:logging/logging.dart';
import 'package:dishlocal/data/services/location_service/exception/location_service_exception.dart' as location_service_exception;

class GeolocatorServiceImpl implements LocationService {
  final _log = Logger('GeolocatorServiceImpl');

  @override
  Future<Map<String, double>> getCurrentCoordinates() async {
    _log.info('Event CurrentLocationRequested: Bắt đầu lấy vị trí hiện tại...');

    try {
      // BƯỚC 1: KIỂM TRA DỊCH VỤ VỊ TRÍ
      _log.fine('Đang kiểm tra dịch vụ vị trí (isLocationServiceEnabled)...');
      final serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        _log.warning('Dịch vụ vị trí đã bị tắt.');
        throw (location_service_exception.LocationServiceDisabledException());
      }
      _log.info('Dịch vụ vị trí đã được bật.');

      // BƯỚC 2: KIỂM TRA VÀ YÊU CẦU QUYỀN
      _log.fine('Đang kiểm tra quyền vị trí (checkPermission)...');
      var permission = await Geolocator.checkPermission();
      _log.info('Trạng thái quyền ban đầu: ${permission.name}');

      if (permission == LocationPermission.denied) {
        _log.info('Quyền bị từ chối, đang yêu cầu lại (requestPermission)...');
        permission = await Geolocator.requestPermission();
        _log.info('Kết quả yêu cầu quyền lại: ${permission.name}');

        if (permission == LocationPermission.denied) {
          _log.warning('Người dùng đã từ chối cấp quyền.');
          throw (location_service_exception.LocationPermissionDeniedException());
        }
      }

      if (permission == LocationPermission.deniedForever) {
        _log.severe('Quyền vị trí đã bị từ chối vĩnh viễn.');
        // Emit state cụ thể để UI hướng dẫn người dùng mở cài đặt
        throw (location_service_exception.LocationPermissionPermanentlyDeniedException());
      }

      _log.info('Quyền vị trí đã được cấp.');

      // BƯỚC 3: LẤY VỊ TRÍ HIỆN TẠI
      // Khi đến được đây, chúng ta chắc chắn đã có quyền
      _log.fine('Đang lấy vị trí hiện tại (getCurrentPosition)...');
      final position = await Geolocator.getCurrentPosition();
      _log.info('Lấy vị trí thành công: Lat ${position.latitude}, Lon ${position.longitude}');

      return {
        'latitude' : position.latitude,
        'longitude' : position.longitude,
      };
      
    } catch (e, stackTrace) {
      // 5. Bắt các lỗi không lường trước được
      _log.severe('Lỗi không xác định khi lấy vị trí: $e', e, stackTrace);
      throw (location_service_exception.LocationServiceUnknownException());
    }
  }
}
