part of 'post_bloc.dart';

@freezed
sealed class PostEvent with _$PostEvent {
  const factory PostEvent.fetchNextPostPageRequested({DateTime? pageKey}) = _FetchNextPostPageRequested;
}
