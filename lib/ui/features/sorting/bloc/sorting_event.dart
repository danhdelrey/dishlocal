part of 'sorting_bloc.dart';

@freezed
class SortingEvent with _$SortingEvent {
  const factory SortingEvent.started() = _Started;
}