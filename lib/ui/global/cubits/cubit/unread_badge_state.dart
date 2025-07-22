part of 'unread_badge_cubit.dart';

@freezed
sealed class UnreadBadgeState with _$UnreadBadgeState {
  const factory UnreadBadgeState({
    @Default(0) int totalUnreadCount,
    @Default([]) List<Conversation> conversations,
    @Default(true) bool isLoading, // Thêm cờ loading
  }) = _UnreadBadgeState;
}
