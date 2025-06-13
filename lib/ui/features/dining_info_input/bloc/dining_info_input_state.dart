part of 'dining_info_input_bloc.dart';

// Enum để chỉ định trường nào cần focus, tách biệt logic khỏi UI.
enum DiningInfoInputField {
  dishName,
  diningLocationName,
}

class DiningInfoInputState extends Equatable {
  const DiningInfoInputState({
    this.dishNameInput = const DishNameInput.pure(),
    this.diningLocationNameInput = const DiningLocationNameInput.pure(),
    this.formzSubmissionStatus = FormzSubmissionStatus.initial,
    this.fieldToFocus, // Thay thế FocusNode
  });

  final DishNameInput dishNameInput;
  final DiningLocationNameInput diningLocationNameInput;
  final FormzSubmissionStatus formzSubmissionStatus;

  // Trạng thái cho biết trường nào cần được focus. UI sẽ lắng nghe và hành động.
  final DiningInfoInputField? fieldToFocus;

  DiningInfoInputState copyWith({
    DishNameInput? dishNameInput,
    DiningLocationNameInput? diningLocationNameInput,
    FormzSubmissionStatus? formzSubmissionStatus,
    // Cho phép gán giá trị null để xóa yêu cầu focus
    ValueGetter<DiningInfoInputField?>? fieldToFocus, //ValueGetter<T?> là một cách hay để cho phép copyWith gán giá trị null. Khi gọi state.copyWith(fieldToFocus: () => null), nó sẽ xóa yêu cầu focus.
  }) {
    return DiningInfoInputState(
      dishNameInput: dishNameInput ?? this.dishNameInput,
      diningLocationNameInput: diningLocationNameInput ?? this.diningLocationNameInput,
      formzSubmissionStatus: formzSubmissionStatus ?? this.formzSubmissionStatus,
      // Sử dụng ValueGetter để có thể gán giá trị null một cách tường minh
      fieldToFocus: fieldToFocus != null ? fieldToFocus() : this.fieldToFocus,
    );
  }

  @override
  List<Object?> get props => [
        dishNameInput,
        diningLocationNameInput,
        formzSubmissionStatus,
        fieldToFocus,
      ];
}
