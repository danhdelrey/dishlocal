part of 'follow_bloc.dart';

@freezed
sealed class FollowState with _$FollowState {
  const factory FollowState({
    /// Số lượng người theo dõi của người dùng mục tiêu.
    @Default(0) int followerCount,

    /// `true` nếu người dùng hiện tại đang theo dõi người dùng mục tiêu.
    @Default(false) bool isFollowing,
  }) = _FollowState;
}
