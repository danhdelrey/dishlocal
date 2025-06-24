

part of 'auth_bloc.dart';

@freezed
abstract class AuthEvent with _$AuthEvent {
  /// Event được gọi khi ứng dụng khởi động để kiểm tra trạng thái đăng nhập.
  /// Hoặc khi muốn lắng nghe sự thay đổi trạng thái auth.
  const factory AuthEvent.authCheckRequested() = AuthCheckRequested;

  /// Event được gọi khi người dùng nhấn nút đăng nhập Google.
  const factory AuthEvent.signInWithGoogleRequested() = SignInWithGoogleRequested;

  /// Event được gọi khi người dùng muốn đăng xuất.
  const factory AuthEvent.signedOut() = SignedOut;

  /// Event nội bộ, được gọi khi stream từ repository phát ra một AppUser mới.
  const factory AuthEvent.userChanged(AppUser? user) = _UserChanged;
}
