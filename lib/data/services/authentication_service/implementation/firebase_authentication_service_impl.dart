import 'package:dishlocal/data/services/authentication_service/interface/authentication_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:injectable/injectable.dart';
import 'package:logging/logging.dart';

@LazySingleton(as: AuthenticationService)
class FirebaseAuthenticationService implements AuthenticationService {
  final _log = Logger('FirebaseAuthenticationService');
  final GoogleSignIn _googleSignIn;
  final FirebaseAuth _firebaseAuth;

  FirebaseAuthenticationService(
    this._googleSignIn,
    this._firebaseAuth,
  ) {
    _log.info('Khởi tạo FirebaseAuthenticationService.');
  }

  @override
  Stream<User?> get authStateChanges {
    _log.info('Truy cập vào luồng (stream) theo dõi thay đổi trạng thái xác thực.');
    return _firebaseAuth.authStateChanges();
  }

  @override
  User? getCurrentUser() {
    _log.info('Bắt đầu lấy thông tin người dùng hiện tại.');
    final user = _firebaseAuth.currentUser;
    if (user != null) {
      _log.info('Tìm thấy người dùng hiện tại. UID: ${user.uid}');
    } else {
      _log.warning('Không có người dùng nào đang đăng nhập (currentUser là null).');
    }
    return user;
  }

  @override
  Future<UserCredential> signInWithGoogle() async {
    _log.info('Bắt đầu quá trình đăng nhập với Google.');
    try {
      _log.fine('Đang yêu cầu đăng nhập tài khoản Google...');
      final googleUser = await _googleSignIn.signIn();

      if (googleUser == null) {
        _log.warning('Người dùng đã hủy quá trình đăng nhập Google.');
        // Người dùng đã hủy đăng nhập
        throw FirebaseAuthException(code: 'USER_CANCELLED');
      }

      _log.info('Đăng nhập Google thành công cho người dùng: ${googleUser.email}.');
      _log.fine('Đang lấy token xác thực từ Google...');
      final googleAuth = await googleUser.authentication;

      _log.fine('Đang tạo thông tin xác thực (credential) cho Firebase từ token của Google.');
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      _log.fine('Đang đăng nhập vào Firebase với credential của Google...');
      final userCredential = await _firebaseAuth.signInWithCredential(credential);
      _log.info('Đăng nhập vào Firebase thành công. UID người dùng: ${userCredential.user?.uid}');

      return userCredential;
    } catch (e, stackTrace) {
      _log.severe('Đã xảy ra lỗi trong quá trình đăng nhập với Google.', e, stackTrace);
      // Xử lý các lỗi khác
      rethrow;
    }
  }

  @override
  Future<void> signOut() async {
    final user = _firebaseAuth.currentUser;
    _log.info('Bắt đầu quá trình đăng xuất cho người dùng: ${user?.uid ?? "N/A"}.');
    try {
      _log.fine('Đang đăng xuất khỏi Google...');
      await _googleSignIn.signOut();
      _log.fine('Đăng xuất khỏi Google thành công.');

      _log.fine('Đang đăng xuất khỏi Firebase...');
      await _firebaseAuth.signOut();
      _log.fine('Đăng xuất khỏi Firebase thành công.');

      _log.info('Quá trình đăng xuất hoàn tất.');
    } catch (e, stackTrace) {
      _log.severe('Đã xảy ra lỗi trong quá trình đăng xuất.', e, stackTrace);
      // Mặc dù không có trong code gốc, nhưng việc bắt lỗi và rethrow ở đây là thực hành tốt
      // để đảm bảo log được ghi lại mà không thay đổi luồng xử lý lỗi.
      rethrow;
    }
  }
}
