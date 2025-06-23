part of 'delete_post_bloc.dart';

@freezed
class DeletePostState with _$DeletePostState {
  const factory DeletePostState.initial() = DeletePostInitial;
  const factory DeletePostState.loading() = DeletePostLoading;
  const factory DeletePostState.success() = DeletePostSuccess;
  const factory DeletePostState.failure() = DeletePostFailure;
}
