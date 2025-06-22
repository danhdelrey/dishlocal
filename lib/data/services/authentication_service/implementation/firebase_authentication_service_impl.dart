// file: lib/data/services/authentication_service/implementation/firebase_authentication_service.dart

import 'package:dishlocal/data/services/authentication_service/interface/authentication_service.dart';
// THÊM IMPORT MỚI
import 'package:dishlocal/data/services/authentication_service/exception/authentication_service_exception.dart';
import 'package:dishlocal/data/services/authentication_service/model/app_user_credential.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart'; // Cần cho PlatformException
import 'package:google_sign_in/google_sign_in.dart';
import 'package:injectable/injectable.dart';
import 'package:logging/logging.dart';

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

  AppUserCredential? _mapFirebaseUserToAppUserCredential(User? user) {
    // Nếu user là null, trả về null ngay lập tức.
    if (user == null) {
      return null;
    }

    // Lấy providerId từ danh sách providerData.
    // Thường thì provider đầu tiên là provider chính mà người dùng đã dùng để đăng nhập.
    final providerId = user.providerData.isNotEmpty ? user.providerData.first.providerId : 'unknown'; // Hoặc null, tùy theo logic của bạn

    return AppUserCredential(
      // --- Thông tin cơ bản ---
      uid: user.uid,
      email: user.email,
      phoneNumber: user.phoneNumber,

      // --- Trạng thái xác thực ---
      isEmailVerified: user.emailVerified,
      isAnonymous: user.isAnonymous,

      // --- Metadata từ User và Provider ---
      displayName: user.displayName,
      photoUrl: user.photoURL, // Lưu ý: Firebase dùng photoURL với chữ 'URL' viết hoa
      providerId: providerId,

      // --- Dấu vết thời gian từ metadata ---
      creationTime: user.metadata.creationTime,
      lastSignInTime: user.metadata.lastSignInTime,
    );
  }

  @override
  Stream<AppUserCredential?> get authStateChanges {
    _log.info('Truy cập vào luồng (stream) theo dõi thay đổi trạng thái xác thực.');

    return _firebaseAuth.authStateChanges().map(_mapFirebaseUserToAppUserCredential);
  }

  @override
  AppUserCredential? getCurrentUser() {
    _log.info('Bắt đầu lấy thông tin người dùng hiện tại.');
    final user = _firebaseAuth.currentUser;
    if (user != null) {
      _log.info('Tìm thấy người dùng hiện tại. UID: ${user.uid}');
      return _mapFirebaseUserToAppUserCredential(user);
    } else {
      _log.warning('Không có người dùng nào đang đăng nhập (currentUser là null).');
      return null;
    }
  }

  @override
  Future<AppUserCredential?> signInWithGoogle() async {
    _log.info('Bắt đầu quá trình đăng nhập với Google.');
    try {
      _log.fine('Đang yêu cầu đăng nhập tài khoản Google...');
      final googleUser = await _googleSignIn.signIn();

      if (googleUser == null) {
        _log.warning('Người dùng đã hủy quá trình đăng nhập Google.');
        // THAY ĐỔI: Throw exception tùy chỉnh thay vì của Firebase.
        throw GoogleSignInCancelledException();
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

      return _mapFirebaseUserToAppUserCredential(userCredential.user);
    }
    // THAY ĐỔI: Bắt các loại lỗi cụ thể hơn để throw exception tương ứng.
    on FirebaseAuthException catch (e, stackTrace) {
      _log.severe('Đã xảy ra lỗi FirebaseAuthException trong quá trình đăng nhập.', e, stackTrace);
      throw FirebaseSignInException(e.message ?? 'Lỗi không xác định từ Firebase.');
    } on PlatformException catch (e, stackTrace) {
      // PlatformException thường đến từ các SDK native như google_sign_in
      _log.severe('Đã xảy ra lỗi PlatformException (có thể từ Google Sign In).', e, stackTrace);
      throw GoogleSignInException(e.message ?? 'Lỗi nền tảng, có thể do mạng hoặc dịch vụ.');
    } catch (e, stackTrace) {
      // Bắt lại exception "hủy đăng nhập" của chúng ta để không bị gói vào lỗi "Unknown"
      if (e is GoogleSignInCancelledException) {
        rethrow;
      }
      _log.severe('Đã xảy ra lỗi không xác định trong quá trình đăng nhập với Google.', e, stackTrace);
      // Gói các lỗi không lường trước được khác vào một exception chung.
      throw AuthenticationServiceUnknownException(e.toString());
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
      // THAY ĐỔI: Thay vì rethrow, chúng ta throw một Exception cụ thể,
      // gói lỗi gốc vào trong message để debug.
      throw SignOutException('Lỗi khi đăng xuất: ${e.toString()}');
    }
  }

  @override
  String? getCurrentUserId() {
    return _firebaseAuth.currentUser?.uid;
  }
}
