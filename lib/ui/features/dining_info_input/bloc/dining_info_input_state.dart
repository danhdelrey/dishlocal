// ignore_for_file: unnecessary_this

part of 'dining_info_input_bloc.dart';

class DiningInfoInputState extends Equatable {
  const DiningInfoInputState({
    this.dishNameInput = const DishNameInput.pure(),
    this.formzSubmissionStatus = FormzSubmissionStatus.initial,
    this.dishNameFocusNode,
    this.diningLocationNameInput = const DiningLocationNameInput.pure(),
  });

  //các thuộc tính
  final DishNameInput dishNameInput; 
  final DiningLocationNameInput diningLocationNameInput;

  final FormzSubmissionStatus formzSubmissionStatus;

  final FocusNode? dishNameFocusNode;

  //trạng thái
  DiningInfoInputState copyWith({
    DishNameInput? dishNameInput,
    DiningLocationNameInput? diningLocationNameInput,
    FormzSubmissionStatus? formzSubmissionStatus,
  }) {
    return DiningInfoInputState(
      dishNameInput: dishNameInput ?? this.dishNameInput,
      formzSubmissionStatus: formzSubmissionStatus ?? this.formzSubmissionStatus,
      dishNameFocusNode: dishNameFocusNode ?? this.dishNameFocusNode,
      diningLocationNameInput: diningLocationNameInput ?? this.diningLocationNameInput,
    );
  }

  @override
  List<Object?> get props => [
        dishNameInput,
        formzSubmissionStatus,
        dishNameFocusNode,
        diningLocationNameInput,
      ];
}
