part of 'account_setup_bloc.dart';

// Enum để xác định trường nào trong form cần được focus.
enum AccountSetupField {
  username,
  displayName,
  bio,
}

class AccountSetupState extends Equatable {
  const AccountSetupState({
    this.appUser,
    this.usernameInput = const UsernameInput.pure(),
    this.displayNameInput = const DisplayNameInput.pure(),
    this.bioInput = const BioInput.pure(),
    this.formzSubmissionStatus = FormzSubmissionStatus.initial,
    this.fieldToFocus,
  });

  final AppUser? appUser;

  // Khai báo các trường input của form.
  final UsernameInput usernameInput;
  final DisplayNameInput displayNameInput;
  final BioInput bioInput; // Tiểu sử là không bắt buộc

  // Trạng thái của toàn bộ form.
  final FormzSubmissionStatus formzSubmissionStatus;

  // Trạng thái cho biết trường nào cần được focus. UI sẽ lắng nghe và hành động.
  final AccountSetupField? fieldToFocus;

  AccountSetupState copyWith({
    AppUser? appUser,
    UsernameInput? usernameInput,
    DisplayNameInput? displayNameInput,
    BioInput? bioInput,
    FormzSubmissionStatus? formzSubmissionStatus,
    // ValueGetter<T?> cho phép gán giá trị null để xóa yêu cầu focus.
    ValueGetter<AccountSetupField?>? fieldToFocus,
  }) {
    return AccountSetupState(
      appUser: appUser ?? this.appUser,
      usernameInput: usernameInput ?? this.usernameInput,
      displayNameInput: displayNameInput ?? this.displayNameInput,
      bioInput: bioInput ?? this.bioInput,
      formzSubmissionStatus: formzSubmissionStatus ?? this.formzSubmissionStatus,
      // Sử dụng ValueGetter để có thể gán giá trị null một cách tường minh.
      fieldToFocus: fieldToFocus != null ? fieldToFocus() : this.fieldToFocus,
    );
  }

  @override
  List<Object?> get props => [
        appUser,
        usernameInput,
        displayNameInput,
        bioInput,
        formzSubmissionStatus,
        fieldToFocus,
      ];
}
