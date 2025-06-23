part of 'auth_bloc.dart';

sealed class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object?> get props => [];
}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class Unauthenticated extends AuthState {}

// <<< THAY ĐỔI: Đổi tên và đơn giản hóa State này
class NeedsProfileSetup extends AuthState {
  // Chỉ cần userId để biết ai cần tạo hồ sơ.
  // Màn hình setup sẽ dùng ID này để gọi repository.completeProfileSetup
  final String userId;
  const NeedsProfileSetup(this.userId);
  @override
  List<Object?> get props => [userId];
}

class Authenticated extends AuthState {
  final AppUser user;
  const Authenticated(this.user);
  @override
  List<Object?> get props => [user];
}

class AuthFailure extends AuthState {
  final String message;
  const AuthFailure(this.message);
  @override
  List<Object?> get props => [message];
}
