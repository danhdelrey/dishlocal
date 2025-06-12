import 'package:bloc/bloc.dart';
import 'package:dishlocal/ui/features/dining_info_input/form_input/dish_name_input.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:formz/formz.dart';

part 'dining_info_input_event.dart';
part 'dining_info_input_state.dart';

class DiningInfoInputBloc extends Bloc<DiningInfoInputEvent, DiningInfoInputState> {
  DiningInfoInputBloc() : super(const DiningInfoInputState()) {
    on<DishNameInputChanged>((event, emit) {
      final dishNameInput = DishNameInput.dirty(value: event.dishName);
      emit(
        state.copyWith(
          dishNameInput: dishNameInput,
          formzSubmissionStatus: Formz.validate(
            // BONUS: Kiểm tra luôn xem toàn bộ form có hợp lệ không, nếu có nhiều thì [name, email, password,...]
            [
              dishNameInput,
            ],
          )
              ? FormzSubmissionStatus.success
              : FormzSubmissionStatus.failure,
        ),
      );
    });

    on<DiningInfoInputSubmitted>((event, emit) async {
      if (state.formzSubmissionStatus.isSuccess) {
        emit(state.copyWith(formzSubmissionStatus: FormzSubmissionStatus.inProgress));
        try {
          await Future.delayed(const Duration(seconds: 5));
          emit(state.copyWith(formzSubmissionStatus: FormzSubmissionStatus.success));
        } catch (_) {
          emit(state.copyWith(formzSubmissionStatus: FormzSubmissionStatus.failure));
        }
      }
    });
  }
}
