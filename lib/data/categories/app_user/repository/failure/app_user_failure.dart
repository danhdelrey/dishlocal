import 'package:dishlocal/data/error/repository_failure.dart';

/// Failure cơ sở cho các lỗi liên quan đến người dùng/xác thực.
sealed class AppUserFailure extends RepositoryFailure {
  const AppUserFailure(super.message);
}

// --- Failures for signInWithGoogle ---

/// Failure xảy ra khi người dùng hủy quá trình đăng nhập.
class SignInCancelledFailure extends AppUserFailure {
  const SignInCancelledFailure() : super('Quá trình đăng nhập đã bị hủy.');
}

/// Failure xảy ra khi có lỗi từ phía dịch vụ (Google, Firebase Auth).
class SignInServiceFailure extends AppUserFailure {
  const SignInServiceFailure(super.message);
}

// --- Failures for createUsername ---

/// Failure xảy ra khi người dùng chưa đăng nhập nhưng cố gắng tạo username.
class NotAuthenticatedFailure extends AppUserFailure {
  const NotAuthenticatedFailure() : super('Người dùng chưa được xác thực.');
}

/// Failure xảy ra khi không có quyền ghi vào database.
class UpdatePermissionDeniedFailure extends AppUserFailure {
  const UpdatePermissionDeniedFailure() : super('Không có quyền cập nhật thông tin người dùng.');
}

// --- Failures for signOut ---
class SignOutFailure extends AppUserFailure {
  const SignOutFailure(super.message);
}

// --- General Failures ---

/// Failure xảy ra do lỗi truy cập cơ sở dữ liệu (đọc/ghi).
class DatabaseFailure extends AppUserFailure {
  const DatabaseFailure(super.message);
}

/// Failure chung, không xác định được.
class UnknownFailure extends AppUserFailure {
  const UnknownFailure({String message = 'Đã xảy ra lỗi không mong muốn.'}) : super(message);
}
