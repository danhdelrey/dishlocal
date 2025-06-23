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
        super(Unauthenticated()) {
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
      // Chỉ phát ra Unauthenticated nếu trạng thái hiện tại không phải là Unauthenticated
      // để tránh emit không cần thiết.
      if (state is! Unauthenticated) {
        emit(Unauthenticated());
      }
    } else {
      _log.fine('Người dùng đã xác thực. UID: ${user.userId}.');
      // Logic cũ ở đây đã tốt, nhưng có thể bị ghi đè bởi logic từ signInWithGoogle.
      // Chúng ta sẽ giữ nó để xử lý các thay đổi từ stream (ví dụ: admin xóa username)
      if (user.username == null || user.username!.isEmpty) {
        _log.fine('Luồng phát hiện người dùng chưa có username. Đang phát ra trạng thái NeedsProfileSetup.');
        emit(NeedsProfileSetup(user.userId)); // <<< THAY ĐỔI: Chỉ cần userId để thiết lập
      } else {
        _log.fine('Luồng phát hiện người dùng đã có username. Đang phát ra trạng thái Authenticated.');
        emit(Authenticated(user));
      }
    }
  }

   Future<void> _onGoogleSignInRequested(GoogleSignInRequested event, Emitter<AuthState> emit) async {
    _log.info('Bắt đầu xử lý sự kiện GoogleSignInRequested.');
    emit(AuthLoading());

    // <<< THAY ĐỔI: Toàn bộ logic `fold` được viết lại
    final result = await _userRepository.signInWithGoogle();

    result.fold(
      (failure) {
        // Xử lý lỗi
        _log.severe('Đăng nhập Google thất bại. Failure: ${failure.runtimeType}');
        emit(_mapFailureToState(failure));
      },
      (signInResult) {
        // Xử lý các trường hợp thành công
        _log.info('signInWithGoogle thành công. Kết quả: ${signInResult.runtimeType}');
        switch (signInResult) {
          // Trường hợp 1: Đăng nhập thành công và đã có hồ sơ
          case SignInSuccess success:
            // Stream `user` sẽ sớm phát ra `AppUser` này,
            // và `_onAuthStatusChanged` sẽ xử lý việc emit `Authenticated`.
            // Vì vậy, chúng ta không cần làm gì ở đây, chỉ cần chờ.
            _log.fine('Kết quả là SignInSuccess. Chờ stream cập nhật...');
          // Có thể emit Authenticated ngay tại đây nếu muốn phản hồi nhanh hơn
          // emit(Authenticated(success.user));

          // Trường hợp 2: Đăng nhập thành công nhưng là người dùng mới
          case SignInRequiresProfileSetup setup:
            // Đây là lúc chúng ta cần chủ động emit một State mới
            _log.fine('Kết quả là SignInRequiresProfileSetup. Đang phát ra trạng thái NeedsProfileSetup.');
            // Chúng ta emit trạng thái này để UI biết phải chuyển đến màn hình tạo username.
            emit(NeedsProfileSetup(setup.credential.uid));
        }
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
