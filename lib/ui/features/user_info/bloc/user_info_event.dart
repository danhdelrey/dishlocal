part of 'user_info_bloc.dart';

sealed class UserInfoEvent extends Equatable {
  const UserInfoEvent();

  @override
  List<Object?> get props => [];
}

final class UserInfoRequested extends UserInfoEvent {
  final String? userId;
  const UserInfoRequested({this.userId});
  @override
  List<Object?> get props => [userId];
}
