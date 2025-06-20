part of 'view_post_bloc.dart';

@freezed
class ViewPostState with _$ViewPostState {
  const factory ViewPostState.initial() = _Initial;
  const factory ViewPostState.loading() = _Loading;
  const factory ViewPostState.success(
    {required Post post}
  ) = _Success;
  const factory ViewPostState.failure() = _Failure;
}
