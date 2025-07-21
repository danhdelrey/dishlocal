part of 'chat_bloc.dart';

@freezed
sealed class ChatState with _$ChatState {
  /// Trạng thái khởi tạo, chưa có dữ liệu.
  const factory ChatState.initial() = ChatInitial;

  /// Trạng thái đang tải lần đầu.
  const factory ChatState.loading() = ChatLoading;

  /// Trạng thái tải thành công, chứa dữ liệu để hiển thị.
  const factory ChatState.loaded({
    required String conversationId,
    required String otherUserName,
    required List<Message> messages,
    @Default(false) bool isLoadingMore, // Cờ cho biết đang tải trang tiếp theo
    @Default(false) bool hasReachedMax, // Cờ cho biết đã hết tin nhắn để tải
    @Default(1) int currentPage, // Trang hiện tại
  }) = ChatLoaded;

  /// Trạng thái lỗi.
  const factory ChatState.error({
    required String message,
  }) = ChatError;
}
