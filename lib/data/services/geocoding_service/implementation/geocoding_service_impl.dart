import 'package:dishlocal/data/services/geocoding_service/exception/geocoding_service_exception.dart';
import 'package:dishlocal/data/services/geocoding_service/interface/geocoding_service.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:logging/logging.dart';


class GeocodingServiceImpl implements GeocodingService {
  final _log = Logger('GeocodingServiceImpl');

  @override
  Future<String> getAddressFromPosition(double latitude, double longitude) async {
    try {
      _log.fine('Đang chuyển đổi tọa độ thành địa chỉ...');
      List<Placemark> placemarks = await placemarkFromCoordinates(
        latitude,
        longitude,
      );

      if (placemarks.isNotEmpty) {
        final placemark = placemarks.first;
        // Bạn có thể tùy chỉnh định dạng địa chỉ ở đây
        final address = '${placemark.street}, ${placemark.subAdministrativeArea}, ${placemark.administrativeArea}';
        _log.info('Chuyển đổi địa chỉ thành công: $address');
        return address;
      } else {
        _log.warning('Không tìm thấy địa chỉ cho tọa độ này.');
        throw GeocodingServiceException('No address found for the given coordinates.');
      }
    } catch (e, stackTrace) {
      _log.severe('Lỗi khi gọi API geocoding: $e', e, stackTrace);
      // Ném ra một exception tùy chỉnh để Repository có thể bắt
      throw GeocodingServiceException('Failed to connect to the geocoding service.');
    }
  }
}
