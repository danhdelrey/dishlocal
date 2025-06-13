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

      emit(
        state.copyWith(
          dishNameInput: dishNameInput,
          isFormValid: isFormValid,
        ),
      );
      _log.fine('Đã phát ra (emit) trạng thái mới sau khi thay đổi tên món ăn.');
    });

    on<DiningInfoInputSubmitted>((event, emit) async {
      _log.info('Nhận được sự kiện DiningInfoInputSubmitted.');

      // 1. Đánh dấu tất cả các trường là 'dirty' để hiển thị lỗi nếu chúng trống
      _log.fine('Đánh dấu các trường là "dirty" để kiểm tra validation khi submit.');
      final dishNameInput = DishNameInput.dirty(value: state.dishNameInput.value);
      // ... đánh dấu các trường bắt buộc khác là 'dirty' ...

      // 2. Phát ra trạng thái mới với các trường 'dirty'
      final isFormValid = Formz.validate([dishNameInput]);
      _log.fine('Kết quả xác thực form khi submit: ${isFormValid ? 'Hợp lệ' : 'Không hợp lệ'}.');

      emit(state.copyWith(
        dishNameInput: dishNameInput,
        isFormValid: isFormValid,
      ));
      _log.fine('Đã phát ra (emit) trạng thái mới sau khi đánh dấu "dirty" và xác thực lại.');

      // 3. Kiểm tra trạng thái đã cập nhật
      if (state.isFormValid) {
        // Form hợp lệ, tiến hành submit
        _log.info('Form hợp lệ. Bắt đầu quá trình submit dữ liệu.');
        emit(state.copyWith(formzSubmissionStatus: FormzSubmissionStatus.inProgress));
        _log.info('Đã phát ra (emit) trạng thái inProgress.');
        // ... await API call ...
        _log.info('... Giả lập đang chờ gọi API thành công ...');
        emit(state.copyWith(formzSubmissionStatus: FormzSubmissionStatus.success));
      } else {
        // Form không hợp lệ. Tìm lỗi đầu tiên và focus vào nó.
        _log.warning('Form không hợp lệ. Tìm trường nhập liệu bị lỗi để focus.');
        emit(state.copyWith(formzSubmissionStatus: FormzSubmissionStatus.failure));
        if (state.dishNameInput.isNotValid) {
          // state.dishNameFocusNode là FocusNode chúng ta nhận được từ UI.
          // Nó được đảm bảo không null vì chúng ta đã yêu cầu trong constructor.
          _log.fine('Trường Tên món ăn (dishName) không hợp lệ. Yêu cầu focus.');
          state.dishNameFocusNode!.requestFocus();
          _log.fine('Đã focus vào trường dishNameInput');
          return; // Dừng lại sau khi focus vào lỗi đầu tiên.
        }
        // if (state.location.isInvalid) {
        //   _log.fine('Trường Vị trí (location) không hợp lệ. Yêu cầu focus.');
        //   state.locationFocusNode!.requestFocus();
        //   return;
        // }
        // ... kiểm tra các trường khác ...
      }
    });
  }
}
