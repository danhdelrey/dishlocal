import 'package:bloc/bloc.dart';
import 'package:dishlocal/data/categories/app_user/model/app_user.dart';
import 'package:dishlocal/data/categories/app_user/repository/failure/app_user_failure.dart';
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

    // "Làm bẩn" tất cả các input từ trạng thái hiện tại để kích hoạt validation.
    final usernameInput = UsernameInput.dirty(value: state.usernameInput.value);
    final displayNameInput = DisplayNameInput.dirty(value: state.displayNameInput.value);
    final bioInput = BioInput.dirty(value: state.bioInput.value);

    // Xác thực toàn bộ form.
    final isFormValid = Formz.validate([
      usernameInput,
      displayNameInput,
      bioInput,
    ]);

    _log.fine('Kết quả xác thực form khi submit: ${isFormValid ? 'Hợp lệ' : 'Không hợp lệ'}.');

    if (isFormValid) {
      // Nếu form hợp lệ, chuyển sang trạng thái đang xử lý và xóa lỗi cũ.
      emit(state.copyWith(
        formzSubmissionStatus: FormzSubmissionStatus.inProgress,
        errorMessage: null,
        usernameInput: usernameInput,
        displayNameInput: displayNameInput,
        bioInput: bioInput,
      ));

      _log.info('Form hợp lệ. Gọi `completeProfileSetup` từ repository...');
      _log.info('Dữ liệu gửi đi: username="${usernameInput.value}", displayName="${displayNameInput.value}", bio="${bioInput.value}"');

      // Gọi một phương thức duy nhất trong repository với đầy đủ các trường.
      final result = await appUserRepository.completeProfileSetup(
        username: usernameInput.value,
        displayName: displayNameInput.value,
        bio: bioInput.value,
      );

      // Xử lý kết quả trả về từ repository (Thành công hoặc Thất bại).
      result.fold(
        (failure) {
          // Trường hợp thất bại: Dịch lỗi từ Failure sang thông báo cho người dùng.
          _log.severe('Submit thất bại do lỗi từ repository: $failure');

          final errorMessage = switch (failure) {
            // Các trường hợp lỗi từ Authentication
            SignInCancelledFailure() => 'Bạn đã hủy quá trình đăng nhập.',
            SignInServiceFailure(message: final msg) => msg,
            SignOutFailure(message: final msg) => msg,

            // Các trường hợp lỗi từ Database
            UserNotFoundFailure() => 'Không tìm thấy thông tin người dùng.',
            UpdatePermissionDeniedFailure() => 'Bạn không có quyền thực hiện hành động này.',
            DatabaseFailure(message: final msg) => msg, // Sẽ hiển thị lỗi cụ thể
            NotAuthenticatedFailure() => 'Người dùng chưa được xác thực.',

            // Lỗi chung
            UnknownFailure() => 'Đã có lỗi không mong muốn xảy ra. Vui lòng thử lại.',            
          };

          emit(state.copyWith(
            formzSubmissionStatus: FormzSubmissionStatus.failure,
            errorMessage: errorMessage, // Gửi thông báo lỗi cụ thể cho UI.
          ));
        },
        (_) {
          // Trường hợp thành công: AuthBloc sẽ tự động xử lý việc điều hướng.
          _log.info('✅ Submit dữ liệu và hoàn thành setup thành công.');
          emit(state.copyWith(
            formzSubmissionStatus: FormzSubmissionStatus.success,
          ));
        },
      );
    } else {
      // Nếu form không hợp lệ, xác định trường lỗi đầu tiên để focus.
      _log.warning('Form không hợp lệ. Hiển thị lỗi và yêu cầu focus.');

      AccountSetupField? fieldToFocus;
      if (usernameInput.isNotValid) {
        fieldToFocus = AccountSetupField.username;
      } else if (displayNameInput.isNotValid) {
        fieldToFocus = AccountSetupField.displayName;
      } else if (bioInput.isNotValid) {
        fieldToFocus = AccountSetupField.bio;
      }

      // Phát ra trạng thái mới với các input đã được "làm bẩn" và yêu cầu focus.
      emit(state.copyWith(
        usernameInput: usernameInput,
        displayNameInput: displayNameInput,
        bioInput: bioInput,
        formzSubmissionStatus: FormzSubmissionStatus.failure,
        fieldToFocus: () => fieldToFocus,
        errorMessage: 'Vui lòng kiểm tra lại các thông tin đã nhập.', // Thêm một thông báo chung
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
