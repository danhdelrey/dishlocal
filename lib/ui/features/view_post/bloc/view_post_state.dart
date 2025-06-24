part of 'view_post_bloc.dart';

@freezed
sealed class ViewPostState with _$ViewPostState {
  const factory ViewPostState.loading() = ViewPostLoading;
  const factory ViewPostState.success({
    required Post post,
    required String currentUserId,
    required AppUser author,
  }) = ViewPostSuccess;
  const factory ViewPostState.failure(String message) = ViewPostFailure; 
}
