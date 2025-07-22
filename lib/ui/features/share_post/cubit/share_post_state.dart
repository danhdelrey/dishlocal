part of 'share_post_cubit.dart';

@freezed
sealed class SharePostState with _$SharePostState {
  const factory SharePostState.initial() = SharePostInitial;
  const factory SharePostState.loading() = SharePostLoading;
  const factory SharePostState.loaded(List<Conversation> conversations) = SharePostLoaded;
  const factory SharePostState.error(String message) = SharePostError;

  // Trạng thái cho việc gửi tin nhắn
  const factory SharePostState.sendSuccess({
    required String conversationId,
    required AppUser otherUser,
  }) = SharePostSendSuccess;
  const factory SharePostState.sendError(String message) = SharePostSendError;
}
