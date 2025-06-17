import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dishlocal/data/categories/app_user/model/app_user.dart';
import 'package:dishlocal/data/categories/app_user/repository/interface/app_user_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:logging/logging.dart';

part 'auth_event.dart';
part 'auth_state.dart';

@injectable
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final _log = Logger('AuthBloc');
  final AppUserRepository _userRepository;
  StreamSubscription<AppUser?>? _userSubscription;

  AuthBloc(this._userRepository) : super(AuthInitial()) {
    _log.info('Khởi tạo AuthBloc.');

    _log.fine('Bắt đầu lắng nghe luồng (stream) người dùng từ AppUserRepository.');
    _userSubscription = _userRepository.user.listen((user) {
      _log.info('Nhận được cập nhật trạng thái người dùng từ luồng. Đang thêm sự kiện AuthStatusChanged.');
      add(AuthStatusChanged(user));
    });

    on<AuthStatusChanged>(_onAuthStatusChanged);
    on<GoogleSignInRequested>(_onGoogleSignInRequested);
    on<UsernameCreated>(_onUsernameCreated);
    on<SignOutRequested>(_onSignOutRequested);
  }

  void _onAuthStatusChanged(AuthStatusChanged event, Emitter<AuthState> emit) {
    _log.info('Bắt đầu xử lý sự kiện AuthStatusChanged.');
    final user = event.user;
    if (user == null) {
      _log.fine('Người dùng là null. Đang phát ra trạng thái Unauthenticated.');
      emit(Unauthenticated());
    } else {
      _log.fine('Người dùng đã xác thực. UID: ${user.userId}.');
      if (user.username == null || user.username!.isEmpty) {
        _log.fine('Người dùng chưa có username. Đang phát ra trạng thái NeedsUsername.');
        emit(NeedsUsername(user));
      } else {
        _log.fine('Người dùng đã có username. Đang phát ra trạng thái Authenticated.');
        emit(Authenticated(user));
      }
    }
  }

  void _onGoogleSignInRequested(GoogleSignInRequested event, Emitter<AuthState> emit) async {
    _log.info('Bắt đầu xử lý sự kiện GoogleSignInRequested.');
    _log.fine('Đang phát ra trạng thái AuthLoading.');
    emit(AuthLoading());
    try {
      await _userRepository.signInWithGoogle();
      _log.info('Yêu cầu signInWithGoogle đến repository đã hoàn tất. Trạng thái xác thực sẽ được cập nhật thông qua luồng (stream).');
    } catch (e, stackTrace) {
      _log.severe('Đã xảy ra lỗi khi đăng nhập Google.', e, stackTrace);
      _log.fine('Đang phát ra trạng thái AuthFailure với lỗi: ${e.toString()}');
      emit(AuthFailure(e.toString()));
    }
  }

  void _onUsernameCreated(UsernameCreated event, Emitter<AuthState> emit) async {
    _log.info("Bắt đầu xử lý sự kiện UsernameCreated với username: '${event.username}'.");
    _log.fine('Đang phát ra trạng thái AuthLoading.');
    emit(AuthLoading());
    try {
      await _userRepository.createUsername(event.username);
      _log.info('Yêu cầu createUsername đến repository đã hoàn tất. Trạng thái người dùng sẽ được cập nhật thông qua luồng.');
    } catch (e, stackTrace) {
      _log.severe("Đã xảy ra lỗi khi tạo username '${event.username}'.", e, stackTrace);
      _log.fine('Đang phát ra trạng thái AuthFailure với lỗi: ${e.toString()}');
      emit(AuthFailure(e.toString()));
    }
  }

  void _onSignOutRequested(SignOutRequested event, Emitter<AuthState> emit) async {
    _log.info('Bắt đầu xử lý sự kiện SignOutRequested.');
    _log.fine('Đang phát ra trạng thái AuthLoading.');
    emit(AuthLoading());
    try {
      await _userRepository.signOut();
      _log.info('Đăng xuất thành công ở tầng repository.');
    } catch (e, stackTrace) {
      _log.severe('Lỗi xảy ra trong quá trình đăng xuất.', e, stackTrace);
      // Để không thay đổi logic, chúng ta cần ném lại lỗi này
      // để nếu BLoC có Error handler, nó vẫn sẽ hoạt động như cũ.
      rethrow;
    }
    // Logic gốc là luôn emit Unauthenticated sau khi gọi signOut, bất kể kết quả từ stream.
    // Chúng ta giữ nguyên logic này.
    _log.fine('Đang phát ra trạng thái Unauthenticated sau khi yêu cầu đăng xuất.');
    emit(Unauthenticated());
  }

  @override
  Future<void> close() {
    _log.info('Đóng AuthBloc. Đang hủy đăng ký (cancel) luồng người dùng.');
    _userSubscription?.cancel();
    return super.close();
  }
}
