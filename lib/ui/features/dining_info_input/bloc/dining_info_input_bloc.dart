import 'package:bloc/bloc.dart';
import 'package:dishlocal/data/categories/address/model/address.dart';
import 'package:dishlocal/ui/features/dining_info_input/form_input/dining_location_name_input.dart';
import 'package:dishlocal/ui/features/dining_info_input/form_input/dish_name_input.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:formz/formz.dart';
import 'package:logging/logging.dart';

part 'dining_info_input_event.dart';
part 'dining_info_input_state.dart';

class DiningInfoInputBloc extends Bloc<DiningInfoInputEvent, DiningInfoInputState> {
  final _log = Logger('DiningInfoInputBloc');

  DishNameInput _dishNameInput = const DishNameInput.dirty();
  DiningLocationNameInput _diningLocationNameInput = const DiningLocationNameInput.dirty();

  DiningInfoInputBloc({
    required FocusNode dishNameFocusNode,
  }) : super(DiningInfoInputState(
          dishNameFocusNode: dishNameFocusNode,
        )) {
    // Ghi log ngay khi BLoC được khởi tạo
    _log.info('Khởi tạo DiningInfoInputBloc. ');

    on<DishNameInputChanged>((event, emit) {
      _log.fine('Nhận được sự kiện DishNameInputChanged với giá trị: "${event.dishName}"');
      _dishNameInput = DishNameInput.dirty(value: event.dishName);

      final isFormValid = _validateForm();
      _log.fine(
        'Xác thực tên món ăn: ${_dishNameInput.isValid ? 'Hợp lệ' : 'Không hợp lệ'}. '
        'Lỗi: ${_dishNameInput.error}. '
        'Trạng thái toàn bộ form: ${isFormValid ? 'Hợp lệ' : 'Không hợp lệ'}',
      );

      emit(state.copyWith(dishNameInput: _dishNameInput));
      _log.fine('Đã phát ra (emit) trạng thái mới sau khi thay đổi tên món ăn.');
    });

    on<DiningLocationNameInputChanged>((event, emit) {
      _log.fine('Nhận được sự kiện DishNameInputChanged với giá trị: "${event.diningLocationName}"');
      _diningLocationNameInput = DiningLocationNameInput.dirty(value: event.diningLocationName);

      // Xác thực form để lấy trạng thái mới
      final isFormValid = _validateForm();
      _log.fine(
        'Xác thực tên món ăn: ${_diningLocationNameInput.isValid ? 'Hợp lệ' : 'Không hợp lệ'}. '
        'Lỗi: ${_diningLocationNameInput.error}. '
        'Trạng thái toàn bộ form: ${isFormValid ? 'Hợp lệ' : 'Không hợp lệ'}',
      );

      emit(state.copyWith(diningLocationNameInput: _diningLocationNameInput));
      _log.fine('Đã phát ra (emit) trạng thái mới sau khi thay đổi tên món ăn.');
    });

    on<DiningInfoInputSubmitted>((event, emit) async {
      _log.info('Nhận được sự kiện DiningInfoInputSubmitted');

      // 2. Xác thực form với các phiên bản 'dirty' này.
      final isFormValid = _validateForm();

      _log.fine('Kết quả xác thực form khi submit: ${isFormValid ? 'Hợp lệ' : 'Không hợp lệ'}.');

      // 3. Emit trạng thái mới với các input đã được cập nhật (dirty)
      //    và trạng thái submit tương ứng.
      //    Dù form hợp lệ hay không, chúng ta vẫn cần emit các input 'dirty'
      //    để UI có thể hiển thị lỗi nếu cần.
      emit(state.copyWith(
        dishNameInput: _dishNameInput,
        diningLocationNameInput: _diningLocationNameInput,
        formzSubmissionStatus: isFormValid ? FormzSubmissionStatus.inProgress : FormzSubmissionStatus.failure,
      ));

      // 4. Chỉ thực hiện các hành động tiếp theo (submit hoặc focus)
      //    khi form hợp lệ.
      if (isFormValid) {
        // Form hợp lệ, tiến hành submit
        _log.info('Form hợp lệ. Bắt đầu quá trình submit dữ liệu.');
        _log.info('Dữ liệu được submit là: \n Tên món ăn: ${_dishNameInput.value} \n Tên quán ăn: ${_diningLocationNameInput.value}');
        try {
          // Giả lập quá trình submit
          await Future.delayed(const Duration(seconds: 5));
          _log.info('Submit dữ liệu thành công');
          emit(state.copyWith(formzSubmissionStatus: FormzSubmissionStatus.success));
        } catch (e) {
          _log.severe('Submit thất bại', e);
          emit(state.copyWith(formzSubmissionStatus: FormzSubmissionStatus.failure));
        }
      } else {
        // Form không hợp lệ, tìm lỗi đầu tiên và focus vào nó.
        _log.warning('Form không hợp lệ. Yêu cầu focus vào trường lỗi.');
        // Chỉ cần thực hiện side-effect là focus.
        if (_dishNameInput.isNotValid) {
          _log.fine('Trường Tên món ăn (dishName) không hợp lệ. Yêu cầu focus.');
          state.dishNameFocusNode!.requestFocus();
          _log.fine('Đã focus vào trường dishNameInput');
          return; // Dừng lại sau khi focus vào lỗi đầu tiên.
        }
        // ... kiểm tra và focus các trường khác ...
      }
    });
  }

  bool _validateForm() {
    return Formz.validate([
      _dishNameInput,
      _diningLocationNameInput,
    ]);
  }

  @override
  Future<void> close() {
    _log.fine('Đóng DiningInfoInputBloc');
    return super.close();
  }
}
