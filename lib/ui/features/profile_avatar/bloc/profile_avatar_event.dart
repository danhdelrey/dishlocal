part of 'profile_avatar_bloc.dart';

sealed class ProfileAvatarEvent extends Equatable {
  const ProfileAvatarEvent();

  @override
  List<Object> get props => [];
}

final class ProfileAvatarFetched extends ProfileAvatarEvent{}