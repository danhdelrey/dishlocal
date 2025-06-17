part of 'auth_bloc.dart';

sealed class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object?> get props => [];
}

class AuthStatusChanged extends AuthEvent {
  final AppUser? user;
  const AuthStatusChanged(this.user);
  @override
  List<Object?> get props => [user];
}

class GoogleSignInRequested extends AuthEvent {}

class UsernameCreated extends AuthEvent {
  final String username;
  const UsernameCreated(this.username);
  @override
  List<Object?> get props => [username];
}

class SignOutRequested extends AuthEvent {}
