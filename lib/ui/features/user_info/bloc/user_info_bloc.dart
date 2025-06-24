import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dishlocal/data/categories/app_user/model/app_user.dart';
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
    final targetUserId = event.userId;
    _log.info('▶️ Bắt đầu xử lý UserInfoRequested. TargetUserId: ${targetUserId ?? "người dùng hiện tại"}');
    emit( UserInfoLoading()); // Sử dụng constructor của freezed

    // Với repository đã được cải tiến, chúng ta chỉ cần một lời gọi duy nhất.
    // Không cần if-else, không cần try-catch.
    final result = await _appUserRepository.getUserProfile(targetUserId);

    // Xử lý kết quả trả về bằng .fold() một cách an toàn.
    result.fold(
      // ---- TRƯỜNG HỢP THẤT BẠI ----
      (failure) {
        _log.severe('❌ Lỗi khi lấy thông tin người dùng: $failure');

        // Dịch failure thành một thông báo lỗi thân thiện để hiển thị cho người dùng.
        // final message = switch (failure) {
        //   UserNotFoundFailure() => 'Không tìm thấy người dùng này.',
        //   NotAuthenticatedFailure() => 'Bạn cần đăng nhập để xem trang cá nhân.',
        //   _ => 'Không thể tải thông tin. Vui lòng thử lại sau.',
        // };

        // Emit trạng thái failure kèm theo thông điệp lỗi.
        emit(UserInfoFailure());
      },
      // ---- TRƯỜDNG HỢP THÀNH CÔNG ----
      (appUser) {
        _log.info('✅ Lấy thông tin người dùng thành công: ${appUser.displayName}. isFollowing: ${appUser.isFollowing}');
        emit(UserInfoSuccess(appUser: appUser));
      },
    );
  }
}
