part of 'view_post_bloc.dart';

@freezed
sealed class ViewPostEvent with _$ViewPostEvent {
  const factory ViewPostEvent.started(
    final Post post,
  ) = Started;

  const factory ViewPostEvent.pageExited({
    required String postId,
  }) = PageExited;
}