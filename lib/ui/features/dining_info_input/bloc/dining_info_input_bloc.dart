// dining_info_input_bloc.dart
import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dishlocal/ui/features/dining_info_input/form_input/dining_location_name_input.dart';
import 'package:dishlocal/ui/features/dining_info_input/form_input/dish_name_input.dart';
import 'package:dishlocal/ui/features/dining_info_input/form_input/exact_address_input.dart';
import 'package:dishlocal/ui/features/dining_info_input/form_input/insight_input.dart';
import 'package:dishlocal/ui/features/dining_info_input/form_input/money_input.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:formz/formz.dart';
import 'package:injectable/injectable.dart';
import 'package:intl/intl.dart';
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

    on<DishNameInputChanged>(_onDishNameChanged);
    on<DiningLocationNameInputChanged>(_onDiningLocationNameChanged);
    on<ExactAddressInputChanged>(_onExactAddressInputChanged);
    on<InsightInputChanged>(_onInsightInputChanged);
    on<MoneyInputChanged>(_onMoneyInputChanged);

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

  void _onExactAddressInputChanged(ExactAddressInputChanged event, Emitter<DiningInfoInputState> emit) {
    _log.fine('Nhận được sự kiện ExactAddressInputChanged với giá trị: "${event.exactAddress}"');
    final exactAddressInput = ExactAddressInput.dirty(value: event.exactAddress);

    emit(state.copyWith(
      exactAddressInput: exactAddressInput,
    ));
    _log.fine('Đã phát ra (emit) trạng thái mới sau khi thay đổi vị trí cụ thể.');
  }

  void _onInsightInputChanged(InsightInputChanged event, Emitter<DiningInfoInputState> emit) {
    _log.fine('Nhận được sự kiện InsightInputChanged với giá trị: "${event.insight}"');
    final insightInput = InsightInput.dirty(value: event.insight);

    emit(state.copyWith(
      insightInput: insightInput,
    ));
    _log.fine('Đã phát ra (emit) trạng thái mới sau khi thay đổi cảm nhận.');
  }

  void _onMoneyInputChanged(MoneyInputChanged event, Emitter<DiningInfoInputState> emit) {
    _log.fine('Nhận được sự kiện MoneyInputChanged với giá trị: "${event.money}"');

    final regex = RegExp(r'[.\sđ]');
    final normalizedMoney = event.money.replaceAll(regex, '');
    _log.fine('"${event.money}" sau khi normalize lại thành: "$normalizedMoney"');

    final moneyInput = MoneyInput.dirty(value: normalizedMoney);

    emit(state.copyWith(
      moneyInput: moneyInput,
    ));
    _log.fine('Đã phát ra (emit) trạng thái mới sau khi thay đổi giá tiền.');
  }

  Future<void> _onSubmitted(DiningInfoInputSubmitted event, Emitter<DiningInfoInputState> emit) async {
    _log.info('Nhận được sự kiện DiningInfoInputSubmitted');

    // Tạo các phiên bản "dirty" của các input từ trạng thái hiện tại.
    // Điều này đảm bảo rằng lỗi sẽ được hiển thị ngay cả khi người dùng chưa từng chạm vào trường đó.
    final dishNameInput = DishNameInput.dirty(value: state.dishNameInput.value);
    final diningLocationNameInput = DiningLocationNameInput.dirty(value: state.diningLocationNameInput.value);
    final exactAddressInput = ExactAddressInput.dirty(value: state.exactAddressInput.value);
    final insightInput = InsightInput.dirty(value: state.insightInput.value);
    final moneyInput = MoneyInput.dirty(value: state.moneyInput.value);

    // Xác thực form với các phiên bản "dirty" này.
    final isFormValid = Formz.validate([
      dishNameInput,
      diningLocationNameInput,
      exactAddressInput,
      insightInput,
      moneyInput,
    ]);

    _log.fine('Kết quả xác thực form khi submit: ${isFormValid ? 'Hợp lệ' : 'Không hợp lệ'}.');

    if (isFormValid) {
      // Logic khi form hợp lệ giữ nguyên
      emit(state.copyWith(
        formzSubmissionStatus: FormzSubmissionStatus.inProgress,
        // Cập nhật lại state với các input để đảm bảo nhất quán, dù chúng không thay đổi
        dishNameInput: dishNameInput,
        diningLocationNameInput: diningLocationNameInput,
        exactAddressInput: exactAddressInput,
        insightInput: insightInput,
        moneyInput: moneyInput,
      ));
      _log.info('Form hợp lệ. Bắt đầu quá trình submit dữ liệu.');
      _log.info('Dữ liệu đã nhập là: ${dishNameInput.value}, ${diningLocationNameInput.value}, ${exactAddressInput.value}, ${insightInput.value}, ${moneyInput.value}');
      try {
        await Future.delayed(const Duration(seconds: 1));
        _log.info('Submit dữ liệu thành công');
        emit(state.copyWith(formzSubmissionStatus: FormzSubmissionStatus.success));
      } catch (e) {
        _log.severe('Submit thất bại', e);
        emit(state.copyWith(formzSubmissionStatus: FormzSubmissionStatus.failure));
      }
    } else {
      _log.warning('Form không hợp lệ. Hiển thị lỗi và yêu cầu focus.');

      // Xác định trường lỗi đầu tiên để focus
      DiningInfoInputField? fieldToFocus;
      if (dishNameInput.isNotValid) {
        fieldToFocus = DiningInfoInputField.dishName;
      } else if (diningLocationNameInput.isNotValid) {
        fieldToFocus = DiningInfoInputField.diningLocationName;
      } else if (exactAddressInput.isNotValid) {
        fieldToFocus = DiningInfoInputField.exactAddress;
      } else if (insightInput.isNotValid) {
        fieldToFocus = DiningInfoInputField.insightInput;
      } else if (moneyInput.isNotValid) {
        fieldToFocus = DiningInfoInputField.moneyInput;
      }

      // Phát ra trạng thái mới với:
      // 1. Các input đã được "làm bẩn" (dirty) để UI hiển thị lỗi.
      // 2. Trạng thái submission là `failure`.
      // 3. Yêu cầu focus vào trường lỗi đầu tiên.
      emit(state.copyWith(
        dishNameInput: dishNameInput,
        diningLocationNameInput: diningLocationNameInput,
        exactAddressInput: exactAddressInput,
        insightInput: insightInput,
        moneyInput: moneyInput,
        formzSubmissionStatus: FormzSubmissionStatus.failure,
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
