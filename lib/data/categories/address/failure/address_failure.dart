import 'package:dishlocal/data/error/repository_failure.dart';

sealed class AddressFailure extends RepositoryFailure {
  const AddressFailure(super.message);
}

class ServiceDisabledFailure extends AddressFailure {
  const ServiceDisabledFailure() : super('Dịch vụ vị trí đã bị tắt');
}

class PermissionDeniedFailure extends AddressFailure {
  const PermissionDeniedFailure() : super('Quyền truy cập vị trí đã bị tắt');
}

class PermissionPermanentlyDeniedFailure extends AddressFailure {
  const PermissionPermanentlyDeniedFailure() : super('Quyền truy cập vị trí đã bị tắt vĩnh viễn');
}

class GeocodingFailure extends AddressFailure {
  const GeocodingFailure(super.message);
}

class UnknownFailure extends AddressFailure {
  const UnknownFailure() : super('Lỗi không xác định khi lấy vị trí');
}
