// dining_info_input_bloc.dart
import 'package:bloc/bloc.dart';
import 'package:dishlocal/ui/features/dining_info_input/form_input/dining_location_name_input.dart';
import 'package:dishlocal/ui/features/dining_info_input/form_input/dish_name_input.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:formz/formz.dart';
import 'package:injectable/injectable.dart';
import 'package:logging/logging.dart';

part 'dining_info_input_event.dart';
part 'dining_info_input_state.dart';

@injectable // Đánh dấu để injectable có thể quản lý
class DiningInfoInputBloc extends Bloc<DiningInfoInputEvent, DiningInfoInputState> {
  final _log = Logger('DiningInfoInputBloc');

  // Loại bỏ các trường state private. Nguồn chân lý duy nhất là `state`.
  // Không còn phụ thuộc vào FocusNode.
  DiningInfoInputBloc() : super(const DiningInfoInputState()) {
    _log.info('Khởi tạo DiningInfoInputBloc.');

    // Gán sự kiện cho các trình xử lý riêng biệt để code sạch sẽ, dễ đọc
    on<DishNameInputChanged>(_onDishNameChanged);
    on<DiningLocationNameInputChanged>(_onDiningLocationNameChanged);
    on<DiningInfoInputSubmitted>(_onSubmitted);
    on<FocusRequestHandled>(_onFocusRequestHandled);
  }

  void _onDishNameChanged(DishNameInputChanged event, Emitter<DiningInfoInputState> emit) {
    _log.fine('Nhận được sự kiện DishNameInputChanged với giá trị: "${event.dishName}"');
    final dishNameInput = DishNameInput.dirty(value: event.dishName);

    emit(state.copyWith(
      dishNameInput: dishNameInput,
    ));
    _log.fine('Đã phát ra (emit) trạng thái mới sau khi thay đổi tên món ăn.');
  }

  void _onDiningLocationNameChanged(
    DiningLocationNameInputChanged event,
    Emitter<DiningInfoInputState> emit,
  ) {
    _log.fine('Nhận được sự kiện DiningLocationNameInputChanged với giá trị: "${event.diningLocationName}"');
    final diningLocationNameInput = DiningLocationNameInput.dirty(value: event.diningLocationName);

    emit(state.copyWith(
      diningLocationNameInput: diningLocationNameInput,
    ));
    _log.fine('Đã phát ra (emit) trạng thái mới sau khi thay đổi tên quán ăn.');
  }

  Future<void> _onSubmitted(DiningInfoInputSubmitted event, Emitter<DiningInfoInputState> emit) async {
    _log.info('Nhận được sự kiện DiningInfoInputSubmitted');

    // Luôn sử dụng trạng thái hiện tại (`state`) làm nguồn chân lý
    final isFormValid = Formz.validate([
      state.dishNameInput,
      state.diningLocationNameInput,
    ]);

    _log.fine('Kết quả xác thực form khi submit: ${isFormValid ? 'Hợp lệ' : 'Không hợp lệ'}.');

    if (isFormValid) {
      emit(state.copyWith(formzSubmissionStatus: FormzSubmissionStatus.inProgress));
      _log.info('Form hợp lệ. Bắt đầu quá trình submit dữ liệu.');
      _log.info('Dữ liệu được submit là: \n Tên món ăn: ${state.dishNameInput.value} \n Tên quán ăn: ${state.diningLocationNameInput.value}');
      try {
        await Future.delayed(const Duration(seconds: 1)); // Giả lập network call
        _log.info('Submit dữ liệu thành công');
        emit(state.copyWith(formzSubmissionStatus: FormzSubmissionStatus.success));
      } catch (e) {
        _log.severe('Submit thất bại', e);
        emit(state.copyWith(formzSubmissionStatus: FormzSubmissionStatus.failure));
      }
    } else {
      _log.warning('Form không hợp lệ. Yêu cầu focus vào trường lỗi.');

      // Xác định trường lỗi đầu tiên và phát ra trạng thái yêu cầu focus.
      // BLoC không tự mình focus, nó chỉ yêu cầu UI làm việc đó.
      DiningInfoInputField? fieldToFocus;
      if (state.dishNameInput.isNotValid) {
        fieldToFocus = DiningInfoInputField.dishName;
      } else if (state.diningLocationNameInput.isNotValid) {
        fieldToFocus = DiningInfoInputField.diningLocationName;
      }

      emit(state.copyWith(
        formzSubmissionStatus: FormzSubmissionStatus.failure,
        // Yêu cầu UI focus vào trường được chỉ định
        fieldToFocus: () => fieldToFocus,
      ));
    }
  }

  void _onFocusRequestHandled(FocusRequestHandled event, Emitter<DiningInfoInputState> emit) {
    _log.fine('UI đã xử lý yêu cầu focus. Đặt lại trạng thái focus.');
    // Sau khi UI đã focus, xóa yêu cầu để tránh việc focus lại mỗi khi build.
    emit(state.copyWith(fieldToFocus: () => null));
  }

  @override
  Future<void> close() {
    _log.fine('Đóng DiningInfoInputBloc');
    return super.close();
  }
}
