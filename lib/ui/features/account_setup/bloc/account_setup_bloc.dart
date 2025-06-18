import 'package:bloc/bloc.dart';
import 'package:dishlocal/data/categories/app_user/model/app_user.dart';
import 'package:dishlocal/data/categories/app_user/repository/interface/app_user_repository.dart';
import 'package:dishlocal/ui/features/account_setup/form_input/bio_input.dart';
import 'package:dishlocal/ui/features/account_setup/form_input/display_name_input.dart';
import 'package:dishlocal/ui/features/account_setup/form_input/username_input.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:formz/formz.dart';
import 'package:injectable/injectable.dart';
import 'package:logging/logging.dart';

part 'account_setup_event.dart';
part 'account_setup_state.dart';

@injectable
class AccountSetupBloc extends Bloc<AccountSetupEvent, AccountSetupState> {
  final _log = Logger('AccountSetupBloc');

  final AppUserRepository appUserRepository;

  AccountSetupBloc({
    required this.appUserRepository,
  }) : super(const AccountSetupState()) {
    _log.info('Khởi tạo AccountSetupBloc.');
    on<UsernameChanged>(_onUsernameChanged);
    on<DisplayNameChanged>(_onDisplayNameChanged);
    on<BioChanged>(_onBioChanged);
    on<AccountSetupSubmitted>(_onSubmitted);
    on<FocusRequestHandled>(_onFocusRequestHandled);
  }


  void _onUsernameChanged(UsernameChanged event, Emitter<AccountSetupState> emit) {
    _log.fine('Nhận được sự kiện UsernameChanged với giá trị: "${event.username}"');
    final usernameInput = UsernameInput.dirty(value: event.username);
    emit(state.copyWith(
      usernameInput: usernameInput,
    ));
    _log.fine('Đã phát ra (emit) trạng thái mới sau khi thay đổi username.');
  }

  void _onDisplayNameChanged(DisplayNameChanged event, Emitter<AccountSetupState> emit) {
    _log.fine('Nhận được sự kiện DisplayNameChanged với giá trị: "${event.displayName}"');
    final displayNameInput = DisplayNameInput.dirty(value: event.displayName);
    emit(state.copyWith(
      displayNameInput: displayNameInput,
    ));
    _log.fine('Đã phát ra (emit) trạng thái mới sau khi thay đổi tên hiển thị.');
  }

  void _onBioChanged(BioChanged event, Emitter<AccountSetupState> emit) {
    _log.fine('Nhận được sự kiện BioChanged với giá trị: "${event.bio}"');
    final bioInput = BioInput.dirty(value: event.bio);
    emit(state.copyWith(
      bioInput: bioInput,
    ));
    _log.fine('Đã phát ra (emit) trạng thái mới sau khi thay đổi tiểu sử.');
  }

  Future<void> _onSubmitted(AccountSetupSubmitted event, Emitter<AccountSetupState> emit) async {
    _log.info('Nhận được sự kiện AccountSetupSubmitted');

    // Tạo các phiên bản "dirty" của các input từ trạng thái hiện tại.
    // Điều này đảm bảo rằng lỗi sẽ được hiển thị ngay cả khi người dùng chưa từng chạm vào trường đó.
    final usernameInput = UsernameInput.dirty(value: state.usernameInput.value);
    final displayNameInput = DisplayNameInput.dirty(value: state.displayNameInput.value);
    final bioInput = BioInput.dirty(value: state.bioInput.value);

    // Xác thực form với các phiên bản "dirty" này.
    // BioInput sẽ luôn hợp lệ nếu rỗng, nhưng vẫn được kiểm tra lỗi `tooLong`.
    final isFormValid = Formz.validate([
      usernameInput,
      displayNameInput,
      bioInput,
    ]);

    _log.fine('Kết quả xác thực form khi submit: ${isFormValid ? 'Hợp lệ' : 'Không hợp lệ'}.');

    if (isFormValid) {
      emit(state.copyWith(
        formzSubmissionStatus: FormzSubmissionStatus.inProgress,
        usernameInput: usernameInput,
        displayNameInput: displayNameInput,
        bioInput: bioInput,
      ));
      _log.info('Form hợp lệ. Bắt đầu quá trình submit dữ liệu.');
      _log.info('Dữ liệu đã nhập: username="${usernameInput.value}", displayName="${displayNameInput.value}", bio="${bioInput.value}"');

      try {
        await appUserRepository.createUsername(usernameInput.value);
        _log.info('Submit dữ liệu thành công.');
        emit(state.copyWith(formzSubmissionStatus: FormzSubmissionStatus.success));
      } catch (e, st) {
        _log.severe('Submit thất bại', e, st);
        emit(state.copyWith(formzSubmissionStatus: FormzSubmissionStatus.failure));
      }
    } else {
      _log.warning('Form không hợp lệ. Hiển thị lỗi và yêu cầu focus.');

      // Xác định trường lỗi đầu tiên để focus
      AccountSetupField? fieldToFocus;
      if (usernameInput.isNotValid) {
        fieldToFocus = AccountSetupField.username;
      } else if (displayNameInput.isNotValid) {
        fieldToFocus = AccountSetupField.displayName;
      } else if (bioInput.isNotValid) {
        fieldToFocus = AccountSetupField.bio;
      }

      // Phát ra trạng thái mới với:
      // 1. Các input đã được "làm bẩn" (dirty) để UI hiển thị lỗi.
      // 2. Trạng thái submission là `failure`.
      // 3. Yêu cầu focus vào trường lỗi đầu tiên.
      emit(state.copyWith(
        usernameInput: usernameInput,
        displayNameInput: displayNameInput,
        bioInput: bioInput,
        formzSubmissionStatus: FormzSubmissionStatus.failure,
        fieldToFocus: () => fieldToFocus,
      ));
    }
  }

  void _onFocusRequestHandled(FocusRequestHandled event, Emitter<AccountSetupState> emit) {
    _log.fine('UI đã xử lý yêu cầu focus. Đặt lại trạng thái focus.');
    // Sau khi UI đã focus, xóa yêu cầu để tránh việc focus lại mỗi khi build.
    emit(state.copyWith(fieldToFocus: () => null));
  }

  @override
  Future<void> close() {
    _log.fine('Đóng AccountSetupBloc');
    return super.close();
  }
}
