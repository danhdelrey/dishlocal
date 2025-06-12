import 'package:bloc/bloc.dart';
import 'package:dishlocal/data/categories/address/model/address.dart';
import 'package:dishlocal/ui/features/dining_info_input/form_input/dish_name_input.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:formz/formz.dart';

part 'dining_info_input_event.dart';
part 'dining_info_input_state.dart';

class DiningInfoInputBloc extends Bloc<DiningInfoInputEvent, DiningInfoInputState> {
  DiningInfoInputBloc({
    required FocusNode dishNameFocusNode,
    required String imagePath,
    required Address address,
  }) : super(DiningInfoInputState(
          dishNameFocusNode: dishNameFocusNode,
          imagePath: imagePath,
          address: address,
        )) {
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
      // 1. Mark all fields as dirty to show errors if they are empty
      final dishNameInput = DishNameInput.dirty(value: state.dishNameInput.value);
      // ... mark other required fields as dirty ...

      // 2. Emit the new state with dirty fields
      emit(state.copyWith(
        dishNameInput: dishNameInput,
        formzSubmissionStatus: Formz.validate([
          dishNameInput,
        ])
            ? FormzSubmissionStatus.success
            : FormzSubmissionStatus.failure,
      ));

      // 3. Check the updated state
      if (state.formzSubmissionStatus.isSuccess) {
        // It's valid, proceed to submit (call API, etc.)
        emit(state.copyWith(formzSubmissionStatus: FormzSubmissionStatus.inProgress));
        // ... await API call ...
      } else {
        // It's invalid. Find the first error and focus it.
        if (state.dishNameInput.isNotValid) {
          // state.nameFocusNode is the FocusNode we received from the UI.
          // It's guaranteed to not be null because we required it in the constructor.
          state.dishNameFocusNode!.requestFocus(); // Gọi requestFocus()
          return; // Stop after focusing on the first error.
        }
        // if (state.location.isInvalid) {
        //   state.locationFocusNode!.requestFocus();
        //   return;
        // }
        // ... check other fields ...
      }
    });
  }
}
