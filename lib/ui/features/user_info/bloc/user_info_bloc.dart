import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dishlocal/data/categories/app_user/model/app_user.dart';
import 'package:dishlocal/data/categories/app_user/repository/interface/app_user_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:logging/logging.dart';

part 'user_info_event.dart';
part 'user_info_state.dart';

@injectable
class UserInfoBloc extends Bloc<UserInfoEvent, UserInfoState> {
  final _log = Logger('UserInfoBloc');

  final AppUserRepository _appUserRepository;

  UserInfoBloc(this._appUserRepository) : super(UserInfoInitial()) {
    on<UserInfoRequested>(_onUserInfoRequested);
  }

  FutureOr<void> _onUserInfoRequested(UserInfoRequested event, Emitter<UserInfoState> emit)  {
    emit(UserInfoLoading());
    final result = _appUserRepository.getCurrentUser();
    result.fold(
      (failure) {
        emit(UserInfoFailure());
      },
      (appUser) {
        emit(UserInfoSuccess(appUser: appUser));
      },
    );
  }
}
