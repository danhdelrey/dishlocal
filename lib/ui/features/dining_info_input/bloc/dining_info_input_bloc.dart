import 'package:bloc/bloc.dart';
import 'package:dishlocal/ui/features/dining_info_input/form_input/dish_name_input.dart';
import 'package:equatable/equatable.dart';
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
          
          formzSubmissionStatus: Formz.validate( // BONUS: Kiểm tra luôn xem toàn bộ form có hợp lệ không, nếu có nhiều thì [name, email, password,...]
            [
              dishNameInput,
            ],
          )
              ? FormzSubmissionStatus.success
              : FormzSubmissionStatus.failure,
        ),
      );
    });
  }
}
