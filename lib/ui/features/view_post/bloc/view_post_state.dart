part of 'view_post_bloc.dart';

@freezed
sealed class ViewPostState with _$ViewPostState {
  const factory ViewPostState.initial() = Initial;
  const factory ViewPostState.loading() = Loading;
  const factory ViewPostState.success(
    {required Post post}
  ) = Success;
  const factory ViewPostState.failure() = Failure;
}
