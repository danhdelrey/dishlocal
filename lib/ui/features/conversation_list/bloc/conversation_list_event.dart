part of 'conversation_list_bloc.dart';

@freezed
sealed class ConversationListEvent with _$ConversationListEvent {
  /// Bắt đầu tải danh sách lần đầu tiên khi mở màn hình.
  const factory ConversationListEvent.started() = _Started;

  /// Tải lại danh sách, ví dụ khi người dùng thực hiện pull-to-refresh.
  const factory ConversationListEvent.refreshed() = _Refreshed;

  const factory ConversationListEvent.listChanged() = _ListChanged;
}
