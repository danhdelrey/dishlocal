import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'sorting_event.dart';
part 'sorting_state.dart';
part 'sorting_bloc.freezed.dart';

class SortingBloc extends Bloc<SortingEvent, SortingState> {
  SortingBloc() : super(_Initial()) {
    on<SortingEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
