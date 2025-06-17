part of 'profile_avatar_bloc.dart';

sealed class ProfileAvatarState extends Equatable {
  const ProfileAvatarState();

  @override
  List<Object?> get props => [];
}

final class ProfileAvatarInitial extends ProfileAvatarState {}

final class ProfileAvatarLoading extends ProfileAvatarState {}

final class ProfileAvatarSuccess extends ProfileAvatarState {
  final String imageUrl;

  const ProfileAvatarSuccess({required this.imageUrl});
  @override
  List<Object?> get props => [imageUrl];
}

final class ProfileAvatarFailure extends ProfileAvatarState {}
