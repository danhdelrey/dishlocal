import 'package:dishlocal/data/error/service_exception.dart';

/// Exception cơ sở cho các lỗi liên quan đến dịch vụ xác thực.
/// Việc có một lớp cơ sở giúp bắt lỗi dễ dàng hơn.
sealed class AuthenticationServiceException extends ServiceException {
  AuthenticationServiceException(super.message);
}

/// Bị throw khi người dùng chủ động hủy quá trình đăng nhập Google.
class GoogleSignInCancelledException extends AuthenticationServiceException {
  GoogleSignInCancelledException() : super('Người dùng đã hủy quá trình đăng nhập.');
}

/// Bị throw khi có lỗi xảy ra từ phía Google Sign-In SDK (ví dụ: lỗi mạng, lỗi dịch vụ).
class GoogleSignInException extends AuthenticationServiceException {
  GoogleSignInException(super.message);
}



/// Bị throw khi có lỗi xảy ra trong quá trình đăng xuất.
class SignOutException extends AuthenticationServiceException {
  SignOutException(super.message);
}

/// Bị throw khi có một lỗi không xác định xảy ra trong dịch vụ xác thực.
class AuthenticationServiceUnknownException extends AuthenticationServiceException {
  AuthenticationServiceUnknownException(super.message);
}

///Bị throw khi có lỗi xảy ra từ phía Supabase
class SupabaseSignInException extends AuthenticationServiceException {
  SupabaseSignInException(super.message);
}

/// Bị throw khi có lỗi xảy ra từ phía Firebase Authentication khi đang đăng nhập (ví dụ: credential không hợp lệ).
class FirebaseSignInException extends AuthenticationServiceException {
  FirebaseSignInException(super.message);
}
