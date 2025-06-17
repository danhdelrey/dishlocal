part of 'auth_bloc.dart';

sealed class AuthState extends Equatable {
  const AuthState();
  
  @override
  List<Object?> get props => [];
}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class Unauthenticated extends AuthState {}

class NeedsUsername extends AuthState {
  final AppUser user;
  const NeedsUsername(this.user);
  @override
  List<Object?> get props => [user];
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
