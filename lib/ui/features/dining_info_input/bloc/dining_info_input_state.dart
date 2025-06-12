part of 'dining_info_input_bloc.dart';

class DiningInfoInputState extends Equatable {
  const DiningInfoInputState({
    this.dishNameInput = const DishNameInput.pure(),
    this.formzSubmissionStatus = FormzSubmissionStatus.initial,
    this.dishNameFocusNode
  });

  final DishNameInput dishNameInput;
  final FormzSubmissionStatus formzSubmissionStatus;

  final FocusNode? dishNameFocusNode;

  DiningInfoInputState copyWith({
    DishNameInput? dishNameInput,
    FormzSubmissionStatus? formzSubmissionStatus,
  }) {
    return DiningInfoInputState(
      dishNameInput: dishNameInput ?? this.dishNameInput,
      formzSubmissionStatus: formzSubmissionStatus ?? this.formzSubmissionStatus,
      dishNameFocusNode: dishNameFocusNode ?? this.dishNameFocusNode,
    );
  }

  @override
  List<Object?> get props => [
        dishNameInput,
        formzSubmissionStatus,
        dishNameFocusNode
      ];
}
