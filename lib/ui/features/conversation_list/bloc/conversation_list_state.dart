part of 'conversation_list_bloc.dart';

@freezed
sealed class ConversationListState with _$ConversationListState {
  const factory ConversationListState.loading() = ConversationListLoading;
  const factory ConversationListState.loaded(List<Conversation> conversations) = ConversationListLoaded;
}
