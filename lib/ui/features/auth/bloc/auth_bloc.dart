import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dishlocal/data/categories/app_user/model/app_user.dart';
import 'package:dishlocal/data/categories/app_user/repository/failure/app_user_failure.dart';
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

  AuthBloc({required AppUserRepository userRepository}) // Sửa lại constructor để nhận dependency
      : _userRepository = userRepository,
        super(AuthInitial()) {
    _log.info('Khởi tạo AuthBloc.');

    _log.fine('Bắt đầu lắng nghe luồng (stream) người dùng từ AppUserRepository.');
    // THAY ĐỔI: Xử lý lỗi từ stream
    _userSubscription = _userRepository.user.listen(
      (user) {
        _log.info('Nhận được cập nhật trạng thái người dùng từ luồng. Đang thêm sự kiện AuthStatusChanged.');
        add(AuthStatusChanged(user));
      },
      onError: (error) {
        // Khi stream ném ra lỗi (ví dụ: DatabaseFailure từ repository),
        // chúng ta sẽ bắt nó ở đây và chuyển thành một State lỗi.
        _log.severe('Lỗi trong luồng người dùng của repository: $error');
        add(AuthStreamErrorOccurred(error.toString()));
      },
    );

    on<AuthStatusChanged>(_onAuthStatusChanged);
    on<GoogleSignInRequested>(_onGoogleSignInRequested);
    on<UsernameCreated>(_onUsernameCreated);
    on<SignOutRequested>(_onSignOutRequested);
    on<AuthStreamErrorOccurred>(_onAuthStreamErrorOccurred); // THÊM HANDLER MỚI
  }

  // Phương thức helper để ánh xạ Failure sang State
  // Giúp logic trong `fold` gọn hơn và có thể tái sử dụng
  AuthState _mapFailureToState(AppUserFailure failure) {
    _log.warning('Ánh xạ Failure sang State. Loại Failure: ${failure.runtimeType}');
    return switch (failure) {
      SignInCancelledFailure() => Unauthenticated(), // Quay về trạng thái chưa đăng nhập
      NotAuthenticatedFailure() => Unauthenticated(),
      // Các lỗi khác thì hiển thị thông báo
      _ => AuthFailure(failure.message),
    };
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

  Future<void> _onGoogleSignInRequested(GoogleSignInRequested event, Emitter<AuthState> emit) async {
    _log.info('Bắt đầu xử lý sự kiện GoogleSignInRequested.');
    _log.fine('Đang phát ra trạng thái AuthLoading.');
    emit(AuthLoading());

    // THAY ĐỔI: Sử dụng Either và fold
    final result = await _userRepository.signInWithGoogle();

    result.fold(
      (failure) {
        _log.severe('Đăng nhập Google thất bại. Failure: ${failure.runtimeType}');
        emit(_mapFailureToState(failure));
      },
      (_) {
        // Thành công không cần làm gì ở đây.
        // Stream `user` sẽ tự động nhận được user mới và kích hoạt `AuthStatusChanged`.
        _log.info('Yêu cầu signInWithGoogle đến repository đã hoàn tất thành công. Chờ cập nhật từ stream...');
      },
    );
  }

  Future<void> _onUsernameCreated(UsernameCreated event, Emitter<AuthState> emit) async {
    _log.info("Bắt đầu xử lý sự kiện UsernameCreated với username: '${event.username}'.");
    // Giữ state hiện tại (Authenticated hoặc NeedsUsername) thay vì loading toàn màn hình
    // Có thể thêm một flag loading vào state hiện tại nếu muốn hiển thị indicator nhỏ.
    // Ví dụ: emit(Authenticated(state.user, isLoading: true));
    // Ở đây, để đơn giản, chúng ta không emit state loading.
    
    final result = await _userRepository.updateUsername(event.username);

    result.fold(
      (failure) {
        _log.severe("Đã xảy ra lỗi khi tạo username '${event.username}'. Failure: ${failure.runtimeType}");
        emit(_mapFailureToState(failure));
      },
      (_) {
        _log.info('Yêu cầu createUsername đến repository đã hoàn tất thành công. Chờ cập nhật từ stream...');
        // Tương tự, stream sẽ lo phần còn lại.
      },
    );
  }

  Future<void> _onSignOutRequested(SignOutRequested event, Emitter<AuthState> emit) async {
    _log.info('Bắt đầu xử lý sự kiện SignOutRequested.');
    emit(AuthLoading()); // Hiển thị loading khi đăng xuất

    final result = await _userRepository.signOut();

    result.fold(
      (failure) {
        _log.severe('Lỗi xảy ra trong quá trình đăng xuất. Failure: ${failure.runtimeType}');
        // Dù đăng xuất lỗi, vẫn nên đưa người dùng về trạng thái Unauthenticated
        // và hiển thị lỗi qua một cơ chế khác (snackbar, dialog).
        // Ở đây, chúng ta vẫn emit AuthFailure.
        emit(_mapFailureToState(failure));
      },
      (_) {
        _log.info('Đăng xuất thành công ở tầng repository.');
        // Khi đăng xuất thành công, stream `user` sẽ phát ra `null`,
        // và `_onAuthStatusChanged` sẽ xử lý việc emit `Unauthenticated`.
        // Vì vậy, không cần emit gì ở đây.
      },
    );
  }

  // Handler mới để xử lý lỗi từ stream
  void _onAuthStreamErrorOccurred(AuthStreamErrorOccurred event, Emitter<AuthState> emit) {
    _log.info('Xử lý lỗi từ stream: ${event.errorMessage}');
    emit(AuthFailure(event.errorMessage));
  }

  @override
  Future<void> close() {
    _log.info('Đóng AuthBloc. Đang hủy đăng ký (cancel) luồng người dùng.');
    _userSubscription?.cancel();
    return super.close();
  }
}
