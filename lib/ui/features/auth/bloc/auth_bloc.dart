import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dishlocal/data/categories/app_user/model/app_user.dart';
import 'package:dishlocal/data/categories/app_user/repository/interface/app_user_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

part 'auth_event.dart';
part 'auth_state.dart';

@injectable
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AppUserRepository _userRepository;
  StreamSubscription<AppUser?>? _userSubscription;

  AuthBloc(this._userRepository) : super(AuthInitial()) {
    _userSubscription = _userRepository.user.listen((user) {
      add(AuthStatusChanged(user));
    });

    on<AuthStatusChanged>(_onAuthStatusChanged);
    on<GoogleSignInRequested>(_onGoogleSignInRequested);
    on<UsernameCreated>(_onUsernameCreated);
    on<SignOutRequested>(_onSignOutRequested);
  }

  void _onAuthStatusChanged(AuthStatusChanged event, Emitter<AuthState> emit) {
    final user = event.user;
    if (user == null) {
      emit(Unauthenticated());
    } else {
      if (user.username == null || user.username!.isEmpty) {
        emit(NeedsUsername(user));
      } else {
        emit(Authenticated(user));
      }
    }
  }

  void _onGoogleSignInRequested(GoogleSignInRequested event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      await _userRepository.signInWithGoogle();
    } catch (e) {
      emit(AuthFailure(e.toString()));
    }
  }

  void _onUsernameCreated(UsernameCreated event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      await _userRepository.createUsername(event.username);
    } catch (e) {
      emit(AuthFailure(e.toString()));
    }
  }

  void _onSignOutRequested(SignOutRequested event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    await _userRepository.signOut();
    emit(Unauthenticated());
  }

  @override
  Future<void> close() {
    _userSubscription?.cancel();
    return super.close();
  }
}
