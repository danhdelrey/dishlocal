part of 'conversation_list_bloc.dart';

@freezed
sealed class ConversationListState with _$ConversationListState {
  const factory ConversationListState.initial() = ConversationListInitial;
  const factory ConversationListState.loading() = ConversationListLoading;
  const factory ConversationListState.loaded({
    required List<Conversation> conversations,
  }) = ConversationListLoaded;
  const factory ConversationListState.error({
    required String message,
  }) = ConversationListError;
}
