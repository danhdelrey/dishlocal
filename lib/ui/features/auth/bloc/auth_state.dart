part of 'auth_bloc.dart';


@freezed
abstract class AuthState with _$AuthState {
  /// Trạng thái ban đầu, ứng dụng chưa biết người dùng đã đăng nhập hay chưa.
  const factory AuthState.initial() = Initial;

  /// Trạng thái đang xử lý một hành động (ví dụ: đang đăng nhập).
  const factory AuthState.inProgress() = InProgress;

  /// Trạng thái người dùng đã được xác thực thành công.
  const factory AuthState.authenticated(AppUser user) = Authenticated;

  /// Trạng thái người dùng chưa được xác thực (chưa đăng nhập hoặc đã đăng xuất).
  const factory AuthState.unauthenticated() = Unauthenticated;

  /// Trạng thái người dùng mới, cần hoàn thành setup profile.
  const factory AuthState.newUser(AppUser user) = NewUser;

  /// Trạng thái có lỗi xảy ra.
  const factory AuthState.failure(AppUserFailure failure) = Failure;
}
