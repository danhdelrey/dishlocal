part of 'post_bloc.dart';

@freezed
sealed class PostState with _$PostState {
  const factory PostState.initial() = _Initial;
  const factory PostState.failure(String message) = _Failure;
}


