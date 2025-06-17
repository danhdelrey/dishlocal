import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dishlocal/data/categories/app_user/repository/interface/app_user_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:logging/logging.dart';

part 'profile_avatar_event.dart';
part 'profile_avatar_state.dart';

@injectable
class ProfileAvatarBloc extends Bloc<ProfileAvatarEvent, ProfileAvatarState> {
  final _log = Logger('ProfileAvatarBloc');
  final AppUserRepository _appUserRepository;
  ProfileAvatarBloc(this._appUserRepository) : super(ProfileAvatarInitial()) {
    on<ProfileAvatarFetched>(_onProfileAvatarFetched);
  }

  FutureOr<void> _onProfileAvatarFetched(ProfileAvatarFetched event, Emitter<ProfileAvatarState> emit) async {
    emit(ProfileAvatarLoading());
    final result = await _appUserRepository.getCurrentUser();
    result.fold(
      (failure) {
        emit(ProfileAvatarFailure());
      },
      (appUser) {
        emit(
          ProfileAvatarSuccess(
            imageUrl: appUser.photoUrl ?? 'https://www.svgrepo.com/show/452030/avatar-default.svg',
          ),
        );
      },
    );
  }
}
