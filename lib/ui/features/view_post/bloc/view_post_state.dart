part of 'view_post_bloc.dart';

@freezed
sealed class ViewPostState with _$ViewPostState {
  const factory ViewPostState.loading() = Loading;
  const factory ViewPostState.success({
    required Post post,
    required String currentUserId,
  }) = Success;
  const factory ViewPostState.failure() = Failure;
}
