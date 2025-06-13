import 'package:bloc/bloc.dart';
import 'package:dishlocal/data/categories/address/model/address.dart';
import 'package:dishlocal/ui/features/dining_info_input/form_input/dish_name_input.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:formz/formz.dart';
import 'package:logging/logging.dart';

part 'dining_info_input_event.dart';
part 'dining_info_input_state.dart';

class DiningInfoInputBloc extends Bloc<DiningInfoInputEvent, DiningInfoInputState> {
  final _log = Logger('DiningInfoInputBloc');

  DiningInfoInputBloc({
    required FocusNode dishNameFocusNode,
    required String imagePath,
    required Address address,
  }) : super(DiningInfoInputState(
          dishNameFocusNode: dishNameFocusNode,
          imagePath: imagePath,
          address: address,
        )) {
    // Ghi log ngay khi BLoC được khởi tạo
    _log.info(
      'Khởi tạo DiningInfoInputBloc. '
      'ImagePath: "$imagePath", Address: "${address.toString()}"',
    );

    on<DishNameInputChanged>((event, emit) {
      _log.fine('Nhận được sự kiện DishNameInputChanged với giá trị: "${event.dishName}"');
      final dishNameInput = DishNameInput.dirty(value: event.dishName);

      // Xác thực form để lấy trạng thái mới
      final isFormValid = Formz.validate([dishNameInput]);
      _log.fine(
        'Xác thực tên món ăn: ${dishNameInput.isValid ? 'Hợp lệ' : 'Không hợp lệ'}. '
        'Lỗi: ${dishNameInput.error}. '
        'Trạng thái toàn bộ form: ${isFormValid ? 'Hợp lệ' : 'Không hợp lệ'}',
      );

      emit(state.copyWith(dishNameInput: dishNameInput));
      _log.fine('Đã phát ra (emit) trạng thái mới sau khi thay đổi tên món ăn.');
    });

    on<DiningInfoInputSubmitted>((event, emit) async {
      _log.info('Nhận được sự kiện DiningInfoInputSubmitted');

      // 1. Luôn tạo phiên bản 'dirty' của các input để kiểm tra
      //    khi người dùng chủ động submit.
      final dishNameInput = DishNameInput.dirty(value: state.dishNameInput.value);
      // ... tạo các phiên bản 'dirty' của các trường khác nếu có ...

      // 2. Xác thực form với các phiên bản 'dirty' này.
      final isFormValid = Formz.validate([dishNameInput]);
      _log.fine('Kết quả xác thực form khi submit: ${isFormValid ? 'Hợp lệ' : 'Không hợp lệ'}.');

      // 3. Emit trạng thái mới với các input đã được cập nhật (dirty)
      //    và trạng thái submit tương ứng.
      //    Dù form hợp lệ hay không, chúng ta vẫn cần emit các input 'dirty'
      //    để UI có thể hiển thị lỗi nếu cần.
      emit(state.copyWith(
        dishNameInput: dishNameInput,
        formzSubmissionStatus: isFormValid ? FormzSubmissionStatus.inProgress : FormzSubmissionStatus.failure,
      ));

      // 4. Chỉ thực hiện các hành động tiếp theo (submit hoặc focus)
      //    khi form hợp lệ.
      if (isFormValid) {
        // Form hợp lệ, tiến hành submit
        _log.info('Form hợp lệ. Bắt đầu quá trình submit dữ liệu.');
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
        // Không cần emit lại ở đây vì đã emit ở bước 3.
        // Chỉ cần thực hiện side-effect là focus.
        if (dishNameInput.isNotValid) {
          _log.fine('Trường Tên món ăn (dishName) không hợp lệ. Yêu cầu focus.');
          state.dishNameFocusNode!.requestFocus();
          _log.fine('Đã focus vào trường dishNameInput');
          return; // Dừng lại sau khi focus vào lỗi đầu tiên.
        }
        // ... kiểm tra và focus các trường khác ...
      }
    });
  }
}
