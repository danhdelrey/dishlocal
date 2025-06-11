// Exception tùy chỉnh cho Geocoding
import 'package:dishlocal/data/error/service_exception.dart';

class GeocodingServiceException extends ServiceException {
  GeocodingServiceException(super.message);
}
