import 'package:dishlocal/data/error/service_exception.dart';

class LocationServiceDisabledException extends ServiceException {
  LocationServiceDisabledException() : super('Dịch vụ vị trí đã bị tắt');
}

class LocationPermissionDeniedException extends ServiceException {
  LocationPermissionDeniedException() : super('Quyền truy cập dịch vụ vị trí đã bị tắt');
}

class LocationPermissionPermanentlyDeniedException extends ServiceException {
  LocationPermissionPermanentlyDeniedException() : super('Quyền truy cập dịch vụ vị trí đã bị tắt vĩnh viễn');
}

class LocationServiceUnknownException extends ServiceException {
  LocationServiceUnknownException() : super('Lỗi không xác định khi lấy vị trí');
}
