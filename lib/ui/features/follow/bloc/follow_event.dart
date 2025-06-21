part of 'follow_bloc.dart';

@freezed
class FollowEvent with _$FollowEvent {
  /// Event được gửi khi người dùng nhấn nút Follow/Unfollow.
  const factory FollowEvent.followToggled() = _FollowToggled;
}
