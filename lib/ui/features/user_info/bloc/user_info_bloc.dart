import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:dishlocal/data/categories/app_user/model/app_user.dart';
import 'package:dishlocal/data/categories/app_user/repository/failure/app_user_failure.dart';
import 'package:dishlocal/data/categories/app_user/repository/interface/app_user_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:logging/logging.dart';

part 'user_info_event.dart';
part 'user_info_state.dart';

@injectable
class UserInfoBloc extends Bloc<UserInfoEvent, UserInfoState> {
  final _log = Logger('UserInfoBloc');
  final AppUserRepository _appUserRepository;

  UserInfoBloc(this._appUserRepository) : super(UserInfoInitial()) {
    on<UserInfoRequested>(_onUserInfoRequested);
  }

  Future<void> _onUserInfoRequested(
    UserInfoRequested event,
    Emitter<UserInfoState> emit,
  ) async {
    final targetUserId = event.userId; // ID của người dùng cần hiển thị thông tin
    _log.info('▶️ Bắt đầu xử lý UserInfoRequested. TargetUserId: ${targetUserId ?? "người dùng hiện tại"}');
    emit(UserInfoLoading()); // <-- Thay đổi: Sử dụng tên lớp trực tiếp

    try {
      // BƯỚC 1: Lấy ID của người dùng hiện tại (người đang xem)
      final currentUserId = _appUserRepository.getCurrentUserId();
      _log.fine('🆔 Người xem hiện tại (currentUserId): $currentUserId');

      late final Either<AppUserFailure, AppUser> result;

      // BƯỚC 2: Quyết định phương thức repository cần gọi
      if (targetUserId != null && targetUserId.isNotEmpty) {
        // TRƯỜNG HỢP 1: Lấy thông tin của một người dùng cụ thể
        _log.fine('🔄 Đang lấy thông tin cho người dùng cụ thể: $targetUserId');
        result = await _appUserRepository.getUserWithId(
          userId: targetUserId,
          currentUserId: currentUserId, // <-- ✨ TRUYỀN currentUserId VÀO ĐÂY
        );
      } else {
        // TRƯỜNG HỢP 2: Lấy thông tin của chính người dùng đang đăng nhập
        _log.fine('🔄 Đang lấy thông tin cho người dùng hiện tại...');
        result = await _appUserRepository.getCurrentUser();
      }

      // BƯỚC 3: Xử lý kết quả trả về
      result.fold(
        (failure) {
          _log.severe('❌ Lỗi khi lấy thông tin người dùng.', failure);
          emit(UserInfoFailure()); // <-- Thay đổi: Sử dụng tên lớp trực tiếp
        },
        (appUser) {
          _log.info('✅ Lấy thông tin người dùng thành công: ${appUser.displayName}. isFollowing: ${appUser.isFollowing}');
          emit(UserInfoSuccess(appUser: appUser)); // <-- Thay đổi: Sử dụng tên lớp trực tiếp
        },
      );
    } catch (error, stackTrace) {
      _log.severe('❌ Đã xảy ra lỗi không xác định trong UserInfoBloc.', error, stackTrace);
      emit(UserInfoFailure()); // <-- Thay đổi: Sử dụng tên lớp trực tiếp
    }
  }
}
