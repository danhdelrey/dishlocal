part of 'chat_bloc.dart';

@freezed
sealed class ChatEvent with _$ChatEvent {
  /// Bắt đầu màn hình chat: tải tin nhắn đầu tiên và lắng nghe real-time.
  const factory ChatEvent.started({
    required String conversationId,
    required AppUser otherUser, // Để hiển thị trên AppBar
  }) = _Started;

  /// Tải thêm tin nhắn khi người dùng cuộn lên đầu danh sách.
  const factory ChatEvent.moreMessagesLoaded() = _MoreMessagesLoaded;

  /// Gửi một tin nhắn văn bản.
  const factory ChatEvent.messageSent({
    required String content,
  }) = _MessageSent;

  /// Gửi một tin nhắn chia sẻ bài post.
  const factory ChatEvent.postShared({
    required String postId,
  }) = _PostShared;

  /// [Sự kiện nội bộ] Được gọi khi có tin nhắn mới từ stream real-time.
  const factory ChatEvent.messageReceived(MessageEntity message) = _MessageReceived;

  const factory ChatEvent.screenStatusChanged({required bool isActive}) = _ScreenStatusChanged;
}
