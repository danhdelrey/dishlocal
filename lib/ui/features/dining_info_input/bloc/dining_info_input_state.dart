part of 'dining_info_input_bloc.dart';

class DiningInfoInputState extends Equatable {
  const DiningInfoInputState({
    this.dishNameInput = const DishNameInput.pure(),
    this.formzSubmissionStatus = FormzSubmissionStatus.initial,
  });

  final DishNameInput dishNameInput;
  final FormzSubmissionStatus formzSubmissionStatus;

  DiningInfoInputState copyWith({
    DishNameInput? dishNameInput,
    FormzSubmissionStatus? formzSubmissionStatus,
  }) {
    return DiningInfoInputState(
      dishNameInput: dishNameInput ?? this.dishNameInput,
      formzSubmissionStatus: formzSubmissionStatus ?? this.formzSubmissionStatus,
    );
  }

  @override
  List<Object> get props => [
        dishNameInput,
        formzSubmissionStatus,
      ];
}
