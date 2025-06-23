import 'package:dishlocal/data/error/repository_failure.dart';

// file: lib/domain/app_user/app_user_failures.dart

sealed class AppUserFailure extends RepositoryFailure {
  const AppUserFailure(super.message);
}

class SignInCancelledFailure extends AppUserFailure {
  const SignInCancelledFailure() : super('Người dùng đã hủy đăng nhập.');
}

class SignInServiceFailure extends AppUserFailure {
  const SignInServiceFailure(super.message);
}

class SignOutFailure extends AppUserFailure {
  const SignOutFailure(super.message);
}

class NotAuthenticatedFailure extends AppUserFailure {
  const NotAuthenticatedFailure() : super('Người dùng chưa được xác thực.');
}

class DatabaseFailure extends AppUserFailure {
  const DatabaseFailure(super.message);
}

class UpdatePermissionDeniedFailure extends AppUserFailure {
  const UpdatePermissionDeniedFailure() : super('Không có quyền cập nhật thông tin.');
}

class UserNotFoundFailure extends AppUserFailure {
  const UserNotFoundFailure() : super('Không tìm thấy người dùng.');
}

class UnknownFailure extends AppUserFailure {
  const UnknownFailure({String message = 'Lỗi không xác định'}) : super(message);
}
