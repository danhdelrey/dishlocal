// dining_info_input_bloc.dart
import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:dishlocal/data/categories/address/model/address.dart';
import 'package:dishlocal/data/categories/app_user/model/app_user.dart';
import 'package:dishlocal/data/categories/app_user/repository/interface/app_user_repository.dart';
import 'package:dishlocal/data/categories/post/model/post.dart';
import 'package:dishlocal/data/categories/post/repository/interface/post_repository.dart';
import 'package:dishlocal/data/services/storage_service/interface/storage_service.dart';
import 'package:dishlocal/ui/features/create_post/form_input/dining_location_name_input.dart';
import 'package:dishlocal/ui/features/create_post/form_input/dish_name_input.dart';
import 'package:dishlocal/ui/features/create_post/form_input/exact_address_input.dart';
import 'package:dishlocal/ui/features/create_post/form_input/insight_input.dart';
import 'package:dishlocal/ui/features/create_post/form_input/money_input.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_multi_formatter/formatters/formatter_extension_methods.dart';
import 'package:flutter_multi_formatter/formatters/money_input_enums.dart';
import 'package:formz/formz.dart';
import 'package:injectable/injectable.dart';
import 'package:intl/intl.dart';
import 'package:logging/logging.dart';
import 'package:uuid/uuid.dart';

part 'create_post_event.dart';
part 'create_post_state.dart';

@injectable // Đánh dấu để injectable có thể quản lý
class CreatePostBloc extends Bloc<CreatePostEvent, CreatePostState> {
  final _log = Logger('DiningInfoInputBloc');
  static const uuid = Uuid();

  final PostRepository _postRepository;
  final AppUserRepository _appUserRepository;

  // Loại bỏ các trường state private. Nguồn chân lý duy nhất là `state`.
  // Không còn phụ thuộc vào FocusNode.
  CreatePostBloc(
    this._postRepository,
    this._appUserRepository,
  ) : super(const CreatePostState()) {
    _log.info('Khởi tạo DiningInfoInputBloc.');

    on<DishNameInputChanged>(_onDishNameChanged);
    on<DiningLocationNameInputChanged>(_onDiningLocationNameChanged);
    on<ExactAddressInputChanged>(_onExactAddressInputChanged);
    on<InsightInputChanged>(_onInsightInputChanged);
    on<MoneyInputChanged>(_onMoneyInputChanged);

    on<CreatePostRequested>(_onCreatePostRequested);
    on<FocusRequestHandled>(_onFocusRequestHandled);
  }

  void _onDishNameChanged(DishNameInputChanged event, Emitter<CreatePostState> emit) {
    _log.fine('Nhận được sự kiện DishNameInputChanged với giá trị: "${event.dishName}"');
    final dishNameInput = DishNameInput.dirty(value: event.dishName);

    emit(state.copyWith(
      dishNameInput: dishNameInput,
    ));
    _log.fine('Đã phát ra (emit) trạng thái mới sau khi thay đổi tên món ăn.');
  }

  void _onDiningLocationNameChanged(
    DiningLocationNameInputChanged event,
    Emitter<CreatePostState> emit,
  ) {
    _log.fine('Nhận được sự kiện DiningLocationNameInputChanged với giá trị: "${event.diningLocationName}"');
    final diningLocationNameInput = DiningLocationNameInput.dirty(value: event.diningLocationName);

    emit(state.copyWith(
      diningLocationNameInput: diningLocationNameInput,
    ));
    _log.fine('Đã phát ra (emit) trạng thái mới sau khi thay đổi tên quán ăn.');
  }

  void _onExactAddressInputChanged(ExactAddressInputChanged event, Emitter<CreatePostState> emit) {
    _log.fine('Nhận được sự kiện ExactAddressInputChanged với giá trị: "${event.exactAddress}"');
    final exactAddressInput = ExactAddressInput.dirty(value: event.exactAddress);

    emit(state.copyWith(
      exactAddressInput: exactAddressInput,
    ));
    _log.fine('Đã phát ra (emit) trạng thái mới sau khi thay đổi vị trí cụ thể.');
  }

  void _onInsightInputChanged(InsightInputChanged event, Emitter<CreatePostState> emit) {
    _log.fine('Nhận được sự kiện InsightInputChanged với giá trị: "${event.insight}"');
    final insightInput = InsightInput.dirty(value: event.insight);

    emit(state.copyWith(
      insightInput: insightInput,
    ));
    _log.fine('Đã phát ra (emit) trạng thái mới sau khi thay đổi cảm nhận.');
  }

  void _onMoneyInputChanged(MoneyInputChanged event, Emitter<CreatePostState> emit) {
    _log.fine('Nhận được sự kiện MoneyInputChanged với giá trị: "${event.money}"');

    final regex = RegExp(r'[.\sđ]');
    final normalizedMoneyString = event.money.replaceAll(regex, '');
    _log.fine('"${event.money}" sau khi normalize lại thành: "$normalizedMoneyString"');

    final normalizedMoney = int.parse(normalizedMoneyString);
    final denormalizedMoneyString = normalizedMoney.toCurrencyString(
      trailingSymbol: 'đ',
      mantissaLength: 0,
      thousandSeparator: ThousandSeparator.Period,
      useSymbolPadding: true,
    ); //này để init value cho textfield
    _log.fine('NormalizedMoneyString "$normalizedMoneyString" -parse int---> "$normalizedMoney" ---> sau khi denormalized lại thành: "$denormalizedMoneyString"');

    final moneyInput = MoneyInput.dirty(value: normalizedMoney);
    emit(state.copyWith(
      moneyInput: moneyInput,
    ));
    _log.fine('Đã phát ra (emit) trạng thái mới sau khi thay đổi giá tiền.');
  }

  Future<void> _onCreatePostRequested(CreatePostRequested event, Emitter<CreatePostState> emit) async {
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

      final appUserResult = await _appUserRepository.getCurrentUser();
      appUserResult.fold(
        (failure) {},
        (appUser) async {
          final postId = uuid.v4();
          final uploadImageResult = await _postRepository.uploadPostImage(File(event.imagePath), postId);
          uploadImageResult.fold(
            (failure) {},
            (imageUrl) async {
              final createNewPostResult = await _postRepository.createNewPost(
                Post(
                  postId: postId,
                  authorUserId: appUser.userId,
                  authorUsername: appUser.username!,
                  authorAvatarUrl: appUser.photoUrl,
                  imageUrl: imageUrl,
                  dishName: dishNameInput.value,
                  diningLocationName: diningLocationNameInput.value,
                  address: event.address,
                  price: moneyInput.value,
                  insight: insightInput.value,
                  createdAt: event.createdAt,
                  likeCount: 0,
                  saveCount: 0,
                ),
              );
              createNewPostResult.fold(
                (failure) {
                  _log.severe('Submit thất bại', failure);
                  emit(state.copyWith(formzSubmissionStatus: FormzSubmissionStatus.failure));
                },
                (_) {
                  _log.info('Submit dữ liệu thành công');
                  emit(state.copyWith(formzSubmissionStatus: FormzSubmissionStatus.success));
                },
              );
            },
          );
        },
      );

     
    } else {
      _log.warning('Form không hợp lệ. Hiển thị lỗi và yêu cầu focus.');

      // Xác định trường lỗi đầu tiên để focus
      CreatePostInputField? fieldToFocus;
      if (dishNameInput.isNotValid) {
        fieldToFocus = CreatePostInputField.dishName;
      } else if (moneyInput.isNotValid) {
        fieldToFocus = CreatePostInputField.moneyInput;
      } else if (diningLocationNameInput.isNotValid) {
        fieldToFocus = CreatePostInputField.diningLocationName;
      } else if (exactAddressInput.isNotValid) {
        fieldToFocus = CreatePostInputField.exactAddress;
      } else if (insightInput.isNotValid) {
        fieldToFocus = CreatePostInputField.insightInput;
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

  void _onFocusRequestHandled(FocusRequestHandled event, Emitter<CreatePostState> emit) {
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
