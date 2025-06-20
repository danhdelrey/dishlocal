import 'package:bloc/bloc.dart';
import 'package:dishlocal/data/categories/app_user/model/app_user.dart';
import 'package:dishlocal/data/categories/app_user/repository/interface/app_user_repository.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:logging/logging.dart';

part 'follow_event.dart';
part 'follow_state.dart';
part 'follow_bloc.freezed.dart';

@injectable
class FollowBloc extends Bloc<FollowEvent, FollowState> {
  final _log = Logger('FollowBloc');
  final AppUserRepository _appUserRepository;

  /// ID của người dùng mục tiêu (người được theo dõi).
  final String targetUserId;

  /// ID của người dùng hiện tại (người thực hiện hành động).
  final String? currentUserId;

  /// Sử dụng `@factoryParam` để truyền dữ liệu ban đầu của người dùng
  /// mà chúng ta muốn theo dõi/bỏ theo dõi vào BLoC.
  FollowBloc(
    this._appUserRepository,
    @factoryParam AppUser user, // Nhận đối tượng AppUser ban đầu
  )   : targetUserId = user.userId,
        currentUserId = _appUserRepository.getCurrentUserId(),
        super(
          // Khởi tạo state ban đầu từ dữ liệu THẬT của người dùng
          FollowState(
            followerCount: user.followerCount,
            // `isFollowing` có thể null trong model, nên ta mặc định là false nếu không có
            isFollowing: user.isFollowing ?? false,
          ),
        ) {
    on<_FollowToggled>(_onFollowToggled);
  }

  Future<void> _onFollowToggled(
    _FollowToggled event,
    Emitter<FollowState> emit,
  ) async {
    // BƯỚC 0: Kiểm tra các điều kiện tiên quyết
    if (currentUserId == null) {
      _log.warning('Người dùng chưa đăng nhập, không thể theo dõi.');
      // Có thể emit một state để yêu cầu đăng nhập nếu cần
      return;
    }

    if (currentUserId == targetUserId) {
      _log.warning('Người dùng không thể tự theo dõi chính mình.');
      return;
    }

    // BƯỚC 1: Cập nhật UI ngay lập tức (Optimistic Update)
    final oldState = state;
    final newIsFollowing = !oldState.isFollowing;
    final newFollowerCount = newIsFollowing ? oldState.followerCount + 1 : oldState.followerCount - 1;

    emit(state.copyWith(
      isFollowing: newIsFollowing,
      followerCount: newFollowerCount,
    ));
    final action = newIsFollowing ? 'theo dõi' : 'bỏ theo dõi';
    _log.info('UI được cập nhật tạm thời: $action người dùng $targetUserId');

    // BƯỚC 2: Gọi Repository để thực hiện hành động trên server
    final result = await _appUserRepository.followUser(
      targetUserId: targetUserId,
      isFollowing: newIsFollowing,
    );

    // BƯỚC 3: Xử lý kết quả trả về từ Repository
    result.fold(
      // L - Left (Thất bại)
      (failure) {
        _log.severe(
          'Lỗi khi $action người dùng $targetUserId. Hoàn tác lại UI.',
          failure,
        );
        // Hoàn tác lại thay đổi trên UI nếu có lỗi
        emit(oldState);
        // Có thể emit một state để hiển thị SnackBar lỗi cho người dùng
      },
      // R - Right (Thành công)
      (_) {
        _log.info('$action người dùng $targetUserId thành công trên server.');
        // Không cần làm gì cả vì UI đã được cập nhật đúng
      },
    );
  }
}
