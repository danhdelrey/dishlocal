import 'package:dishlocal/core/error/failure.dart';

sealed class AddressFailure extends Failure {
  const AddressFailure(super.message);
}

class ServiceDisabledFailure extends AddressFailure {
  const ServiceDisabledFailure() : super('Dịch vụ vị trí đã bị tắt');
}

class PermissionDenied extends AddressFailure {
  const PermissionDenied() : super('Quyền truy cập vị trí đã bị tắt');
}

class PermissionPermanentlyDenied extends AddressFailure {
  const PermissionPermanentlyDenied() : super('Quyền truy cập vị trí đã bị tắt vĩnh viễn');
}
