part of 'user_info_bloc.dart';

sealed class UserInfoState extends Equatable {
  const UserInfoState();

  @override
  List<Object?> get props => [];
}

final class UserInfoInitial extends UserInfoState {}

final class UserInfoLoading extends UserInfoState {}

final class UserInfoSuccess extends UserInfoState {
  final AppUser appUser;

  const UserInfoSuccess({required this.appUser});
  @override
  List<Object?> get props => [appUser];
}

final class UserInfoFailure extends UserInfoState {}
