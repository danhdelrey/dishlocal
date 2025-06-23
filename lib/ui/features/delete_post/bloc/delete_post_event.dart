part of 'delete_post_bloc.dart';

@freezed
abstract class DeletePostEvent with _$DeletePostEvent {
  const factory DeletePostEvent.deletePostRequested(
    {required Post post}
  ) = DeletePostRequested;
  
  
}