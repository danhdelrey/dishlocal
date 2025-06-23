part of 'create_post_bloc.dart';

//2. Thêm trường của form vào enum
enum CreatePostInputField {
  dishName,
  diningLocationName,
  exactAddress,
  insightInput,
  moneyInput,
}

class CreatePostState extends Equatable {
  const CreatePostState({
    //3. Khởi tạo trường của form trong constructor
    this.dishNameInput = const DishNameInput.pure(),
    this.diningLocationNameInput = const DiningLocationNameInput.pure(),
    this.exactAddressInput = const ExactAddressInput.pure(),
    this.insightInput = const InsightInput.pure(),
    this.moneyInput = const MoneyInput.pure(),
    this.formzSubmissionStatus = FormzSubmissionStatus.initial,
    this.fieldToFocus,
    this.errorMessage,
  });

  final String? errorMessage;

  //1. Khai báo trường của form
  final DishNameInput dishNameInput;
  final DiningLocationNameInput diningLocationNameInput;
  final ExactAddressInput exactAddressInput;
  final InsightInput insightInput;
  final MoneyInput moneyInput;

  //trạng thái của form
  final FormzSubmissionStatus formzSubmissionStatus;

  // Trạng thái cho biết trường nào cần được focus. UI sẽ lắng nghe và hành động.
  final CreatePostInputField? fieldToFocus;

  CreatePostState copyWith({
    String? errorMessage,
    //4. Thêm trường của form vào copyWith
    DishNameInput? dishNameInput,
    DiningLocationNameInput? diningLocationNameInput,
    ExactAddressInput? exactAddressInput,
    FormzSubmissionStatus? formzSubmissionStatus,
    InsightInput? insightInput,
    MoneyInput? moneyInput,
    // Cho phép gán giá trị null để xóa yêu cầu focus
    ValueGetter<CreatePostInputField?>? fieldToFocus, //ValueGetter<T?> là một cách hay để cho phép copyWith gán giá trị null. Khi gọi state.copyWith(fieldToFocus: () => null), nó sẽ xóa yêu cầu focus.
  }) {
    return CreatePostState(
      errorMessage: errorMessage ?? this.errorMessage,
      //5. thêm trường của form vào
      dishNameInput: dishNameInput ?? this.dishNameInput,
      diningLocationNameInput: diningLocationNameInput ?? this.diningLocationNameInput,
      exactAddressInput: exactAddressInput ?? this.exactAddressInput,
      insightInput: insightInput ?? this.insightInput,
      moneyInput: moneyInput ?? this.moneyInput,

      formzSubmissionStatus: formzSubmissionStatus ?? this.formzSubmissionStatus,
      // Sử dụng ValueGetter để có thể gán giá trị null một cách tường minh
      fieldToFocus: fieldToFocus != null ? fieldToFocus() : this.fieldToFocus,
    );
  }

  //6. thêm trường của form vào props
  @override
  List<Object?> get props => [
        dishNameInput,
        diningLocationNameInput,
        formzSubmissionStatus,
        fieldToFocus,
        exactAddressInput,
        insightInput,
        moneyInput,
        errorMessage,
      ];
}
