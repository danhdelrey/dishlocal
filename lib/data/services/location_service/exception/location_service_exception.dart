import 'package:dishlocal/data/error/service_exception.dart';

class LocationServiceDisabled extends ServiceException {
  LocationServiceDisabled() : super('Dịch vụ vị trí đã bị tắt');
}

class LocationPermissionDenied extends ServiceException {
  LocationPermissionDenied() : super('Quyền truy cập dịch vụ vị trí đã bị tắt');
}

class LocationPermissionPermanentlyDenied extends ServiceException {
  LocationPermissionPermanentlyDenied() : super('Quyền truy cập dịch vụ vị trí đã bị tắt vĩnh viễn');
}
