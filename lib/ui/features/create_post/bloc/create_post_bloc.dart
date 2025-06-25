// dining_info_input_bloc.dart
import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:dishlocal/data/categories/address/model/address.dart';
import 'package:dishlocal/data/categories/app_user/repository/interface/app_user_repository.dart';
import 'package:dishlocal/data/categories/moderation/repository/interface/moderation_repository.dart';
import 'package:dishlocal/data/categories/post/model/post.dart';
import 'package:dishlocal/data/categories/post/repository/interface/post_repository.dart';
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
  final ModerationRepository _moderationRepository;

  // Loại bỏ các trường state private. Nguồn chân lý duy nhất là `state`.
  // Không còn phụ thuộc vào FocusNode.
  CreatePostBloc(
    this._postRepository,
    this._appUserRepository,
    this._moderationRepository,
  ) : super(const CreatePostState()) {
    _log.info('Khởi tạo DiningInfoInputBloc.');

    on<CreatePostInitialized>(_onCreatePostInitialized);

    on<DishNameInputChanged>(_onDishNameChanged);
    on<DiningLocationNameInputChanged>(_onDiningLocationNameChanged);
    on<ExactAddressInputChanged>(_onExactAddressInputChanged);
    on<InsightInputChanged>(_onInsightInputChanged);
    on<MoneyInputChanged>(_onMoneyInputChanged);

    on<CreatePostRequested>(_onCreatePostRequested);
    on<FocusRequestHandled>(_onFocusRequestHandled);
  }

  void _onCreatePostInitialized(CreatePostInitialized event, Emitter<CreatePostState> emit) {
    if (event.postToUpdate != null) {
      final dishNameInput = DishNameInput.dirty(value: event.postToUpdate!.dishName ?? '');
      final diningLocationNameInput = DiningLocationNameInput.dirty(value: event.postToUpdate!.diningLocationName ?? '');
      final exactAddressInput = ExactAddressInput.dirty(value: event.postToUpdate!.address?.exactAddress ?? '');
      final insightInput = InsightInput.dirty(value: event.postToUpdate!.insight ?? '');
      final moneyInput = MoneyInput.dirty(value: event.postToUpdate!.price);

      emit(state.copyWith(
        dishNameInput: dishNameInput,
        diningLocationNameInput: diningLocationNameInput,
        exactAddressInput: exactAddressInput,
        insightInput: insightInput,
        moneyInput: moneyInput,
      ));
    }
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
    _log.info('▶️ Nhận được sự kiện CreatePostRequested.');

    // === GIAI ĐOẠN 1: VALIDATE FORM ===
    final dishNameInput = DishNameInput.dirty(value: state.dishNameInput.value);
    final diningLocationNameInput = DiningLocationNameInput.dirty(value: state.diningLocationNameInput.value);
    final exactAddressInput = ExactAddressInput.dirty(value: state.exactAddressInput.value);
    final insightInput = InsightInput.dirty(value: state.insightInput.value);
    final moneyInput = MoneyInput.dirty(value: state.moneyInput.value);

    final isFormValid = Formz.validate([
      dishNameInput,
      diningLocationNameInput,
      exactAddressInput,
      insightInput,
      moneyInput,
    ]);

    _log.fine('🔍 Kết quả xác thực form: ${isFormValid ? 'Hợp lệ' : 'Không hợp lệ'}.');

    if (!isFormValid) {
      _log.warning('Form không hợp lệ. Hiển thị lỗi và yêu cầu focus.');
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

      emit(state.copyWith(
        dishNameInput: dishNameInput,
        diningLocationNameInput: diningLocationNameInput,
        exactAddressInput: exactAddressInput,
        insightInput: insightInput,
        moneyInput: moneyInput,
        formzSubmissionStatus: FormzSubmissionStatus.failure,
        fieldToFocus: () => fieldToFocus,
      ));
      return; // Thoát khỏi hàm ngay lập tức
    }
    // === GIAI ĐOẠN 2: KIỂM DUYỆT & SUBMIT ===

    // [TỐI ƯU HÓA] Emit trạng thái inProgress MỘT LẦN DUY NHẤT ở đây.
    _log.info('⏳ Form hợp lệ. Bắt đầu quá trình kiểm duyệt và submit...');
    emit(state.copyWith(
      formzSubmissionStatus: FormzSubmissionStatus.inProgress,
      errorMessage: null, // Xóa lỗi cũ trước khi bắt đầu
    ));

    // -- BƯỚC 2.1: KIỂM DUYỆT NỘI DUNG --
    final textToModerate = '${dishNameInput.value} ${diningLocationNameInput.value} ${insightInput.value}';
    _log.info('🛡️ Đang gọi _moderationRepository.moderateText()...');
    final moderationResult = await _moderationRepository.moderate(text: textToModerate);
    final moderationFailure = moderationResult.fold((f) => f, (_) => null);
    if (moderationFailure != null) {
      _log.warning('❌ Kiểm duyệt văn bản thất bại. Failure: ${moderationFailure.message}');
      emit(state.copyWith(
        formzSubmissionStatus: FormzSubmissionStatus.failure,
        errorMessage: moderationFailure.message,
      ));
      return;
    }
    _log.info('👍 Văn bản đã qua kiểm duyệt thành công.');

    // === GIAI ĐOẠN 3: SUBMIT DỮ LIỆU (NẾU KIỂM DUYỆT THÀNH CÔNG) ===
    _log.info('📤 Đang tiến hành tạo hoặc cập nhật bài viết...');
    if (event.postToUpdate != null) {
      final updateResult = await _postRepository.updatePost(
        event.postToUpdate!.copyWith(
          address: event.postToUpdate!.address?.copyWith(
            exactAddress: state.exactAddressInput.value,
          ),
          diningLocationName: state.diningLocationNameInput.value,
          dishName: state.dishNameInput.value,
          insight: state.insightInput.value,
          price: state.moneyInput.value,
        ),
      );
      updateResult.fold(
        (failure) {
          _log.severe('Cập nhật post thất bại', failure);
          emit(state.copyWith(formzSubmissionStatus: FormzSubmissionStatus.failure));
        },
        (_) {
          _log.info('Cập nhật post thành công');
          emit(state.copyWith(formzSubmissionStatus: FormzSubmissionStatus.success));
        },
      );
    } else {
      final appUserResult = await _appUserRepository.getCurrentUser();
      if (appUserResult.isLeft()) {
        _log.severe('Không lấy được user hiện tại.');
        emit(state.copyWith(formzSubmissionStatus: FormzSubmissionStatus.failure));
        return;
      }
      final appUser = appUserResult.getOrElse(() => throw Exception("User null")); // safe vì đã kiểm tra

      final postId = uuid.v4();
      final createNewPostResult = await _postRepository.createPost(
        post: Post(
          postId: postId,
          authorUserId: appUser.userId,
          authorUsername: appUser.username!,
          authorAvatarUrl: appUser.photoUrl,
          dishName: dishNameInput.value,
          blurHash: event.blurHash,
          diningLocationName: diningLocationNameInput.value,
          address: event.address.copyWith(exactAddress: exactAddressInput.value),
          price: moneyInput.value,
          insight: insightInput.value,
          createdAt: event.createdAt,
          likeCount: 0,
          saveCount: 0,
          isLiked: false,
          isSaved: false,
        ),
        imageFile: File(event.imagePath),
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
