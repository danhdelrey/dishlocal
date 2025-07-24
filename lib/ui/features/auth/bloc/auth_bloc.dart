import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dishlocal/data/categories/app_user/model/app_user.dart';
import 'package:dishlocal/data/categories/app_user/repository/failure/app_user_failure.dart';
import 'package:dishlocal/data/categories/app_user/repository/interface/app_user_repository.dart';
import 'package:dishlocal/data/categories/chat/repository/interface/chat_repository.dart';
import 'package:dishlocal/data/singleton/notification_service.dart';
import 'package:dishlocal/ui/global/cubits/cubit/unread_badge_cubit.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:logging/logging.dart';

part 'auth_event.dart';
part 'auth_state.dart';

part 'auth_bloc.freezed.dart';

@injectable
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final _log = Logger('AuthBloc');
  final AppUserRepository _userRepository;
  final ChatRepository _chatRepository;
  final UnreadBadgeCubit _unreadBadgeCubit; 
  StreamSubscription<AppUser?>? _userSubscription;
  final NotificationService _notificationService;

  AuthBloc(this._userRepository, this._chatRepository, this._unreadBadgeCubit, this._notificationService) : super(const AuthState.initial()) {
    _log.info('✅ AuthBloc được khởi tạo.');

    // Đăng ký các handler cho từng event
    on<AuthCheckRequested>(_onAuthCheckRequested);
    on<_UserChanged>(_onUserChanged);
    on<SignInWithGoogleRequested>(_onSignInWithGoogleRequested);
    on<SignedOut>(_onSignedOut);
  }

  /// Handler cho event [AuthCheckRequested]
  /// Lắng nghe stream thay đổi người dùng từ repository.
  void _onAuthCheckRequested(AuthCheckRequested event, Emitter<AuthState> emit) {
    _log.info('🚀 Bắt đầu lắng nghe thay đổi trạng thái xác thực.');
    // Hủy subscription cũ nếu có để tránh memory leak
    _userSubscription?.cancel();
    _userSubscription = _userRepository.onCurrentUserChanged.listen(
      (user) => add(AuthEvent.userChanged(user)),
    );
  }

  /// Handler cho event [_UserChanged] (event nội bộ)
  /// Được trigger bởi stream listener ở trên.
  void _onUserChanged(_UserChanged event, Emitter<AuthState> emit) {
    final user = event.user;
    if (user == null) {
      _log.info('🚪 Trạng thái người dùng: Unauthenticated.');
      // === THAY ĐỔI: Tắt lắng nghe của badge ===
      _unreadBadgeCubit.stopListening();
      _chatRepository.disposeConversationListSubscription();
      _notificationService.disposeUserLevelSetup();
      emit(const AuthState.unauthenticated());
    } else {
      _log.info('🚪 Thông tin về người dùng trong trạng thái hiện tại: ${user.toString()}');
      if (user.isSetupCompleted) {
        _log.info('👤 Trạng thái người dùng: Authenticated (User: ${user.userId}).');
        // 1. Khởi tạo subscription của Repository (như cũ)
        _chatRepository.initializeConversationListSubscription(userId: user.userId);
        // 2. === THAY ĐỔI: Bật lắng nghe của badge ===
        _unreadBadgeCubit.startListening();
        _notificationService.initUserLevelSetup();
        emit(AuthState.authenticated(user));
      } else {
        _log.info('✨ Trạng thái người dùng: NewUser (User: ${user.userId}).');
        // Người dùng mới chưa thể có tin nhắn, nên không cần bật badge
        _unreadBadgeCubit.stopListening();
        emit(AuthState.newUser(user));
      }
    }
  }

  Future<void> _onSignInWithGoogleRequested(
    SignInWithGoogleRequested event,
    Emitter<AuthState> emit,
  ) async {
    _log.info('⏳ Bắt đầu quá trình đăng nhập Google...');
    emit(const AuthState.inProgress());

    final result = await _userRepository.signInWithGoogle();

    result.fold(
      (failure) {
        _log.severe('❌ Đăng nhập Google thất bại: $failure');
        emit(AuthState.failure(failure));
        // AuthBloc không cần tự emit Unauthenticated,
        // vì nếu _currentUserController là null, GoRouter vẫn sẽ điều hướng đúng.
      },
      (signInResult) {
        _log.info('✅ Đăng nhập thành công với kết quả: $signInResult');
        // 🔥 KHÔNG CẦN LÀM GÌ Ở ĐÂY NỮA!
        // Repository đã đẩy AppUser mới vào stream,
        // `_onUserChanged` sẽ được gọi và `emit` state `NewUser` hoặc `Authenticated`.
        // GoRouter sẽ tự động điều hướng.
      },
    );
  }

  /// Handler cho event [SignedOut]
  Future<void> _onSignedOut(SignedOut event, Emitter<AuthState> emit) async {
    _log.info('⏳ Bắt đầu quá trình đăng xuất...');
    emit(const AuthState.inProgress());

    final result = await _userRepository.signOut();

    // Tương tự như đăng nhập, signOut cũng sẽ trigger stream.
    // _onUserChanged sẽ nhận được giá trị `null` và phát ra state Unauthenticated.
    result.fold(
      (failure) {
        _log.severe('❌ Đăng xuất thất bại: $failure');
        emit(AuthState.failure(failure));
        // Nếu đăng xuất lỗi, có thể người dùng vẫn đang ở trạng thái đăng nhập.
        // Lấy lại user hiện tại để xác định trạng thái đúng.
        final currentUser = _userRepository.latestUser;
        add(AuthEvent.userChanged(currentUser));
      },
      (_) {
        _log.info('✅ Đăng xuất thành công.');
        // Không cần emit state ở đây.
      },
    );
  }

  @override
  Future<void> close() {
    _log.info('🛑 AuthBloc bị đóng, hủy subscription.');
    _userSubscription?.cancel();
    return super.close();
  }
}
