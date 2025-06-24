// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dishlocal/data/services/authentication_service/exception/authentication_service_exception.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:injectable/injectable.dart';
import 'package:logging/logging.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'package:dishlocal/data/services/authentication_service/interface/authentication_service.dart';
import 'package:dishlocal/data/services/authentication_service/model/app_user_credential.dart';

@LazySingleton(as: AuthenticationService)
class SupabaseAuthenticationServiceImpl implements AuthenticationService {
  final _log = Logger('SupabaseAuthenticationServiceImpl');
  final _supabase = Supabase.instance.client;

  final _googleSignIn = GoogleSignIn(serverClientId: '994917582362-of3lhbikvpjtst2jsnqmd98u0q32ehmh.apps.googleusercontent.com');

  // Helper private để map từ Supabase User sang AppUserCredential
  /// Helper private để map từ Supabase User sang AppUserCredential đầy đủ.
  AppUserCredential _mapSupabaseUserToAppUserCredential(User user) {
    // Supabase trả về thời gian dưới dạng chuỗi ISO 8601, cần parse sang DateTime.
    final creationTime = DateTime.tryParse(user.createdAt);
    final lastSignInTime = user.lastSignInAt != null ? DateTime.tryParse(user.lastSignInAt!) : null;

    return AppUserCredential(
      // --- Thông tin cơ bản ---
      uid: user.id,
      email: user.email,
      phoneNumber: user.phone,

      // --- Trạng thái xác thực ---
      // Supabase dùng `emailConfirmedAt` để chỉ báo email đã được xác thực.
      isEmailVerified: user.emailConfirmedAt != null,
      isAnonymous: user.isAnonymous,

      // --- Metadata ---
      // Tên và ảnh đại diện từ OAuth thường nằm trong userMetadata.
      displayName: user.userMetadata?['full_name'] ?? user.userMetadata?['name'],
      photoUrl: user.userMetadata?['avatar_url'] ?? 'https://static.vecteezy.com/system/resources/thumbnails/009/292/244/small/default-avatar-icon-of-social-media-user-vector.jpg',

      // `appMetadata` chứa thông tin về nhà cung cấp.
      providerId: user.appMetadata['provider'],

      // --- Dấu vết thời gian ---
      creationTime: creationTime,
      lastSignInTime: lastSignInTime,
    );
  }

  @override
  Stream<AppUserCredential?> get authStateChanges {
    _log.info('Lắng nghe thay đổi trạng thái xác thực (authStateChanges)...');
    // Lắng nghe stream gốc từ Supabase
    return _supabase.auth.onAuthStateChange.map((authState) {
      final user = authState.session?.user;
      if (user == null) {
        _log.info('Không có người dùng nào được xác thực (session is null).');
        return null;
      } else {
        _log.info('Trạng thái xác thực thay đổi, người dùng: ${user.id}');
        return _mapSupabaseUserToAppUserCredential(user);
      }
    });
  }

  @override
  AppUserCredential? getCurrentUser() {
    final currentUser = _supabase.auth.currentUser;
    if (currentUser == null) {
      _log.info('getCurrentUser: Không có người dùng hiện tại.');
      return null;
    }
    _log.info('getCurrentUser: Tìm thấy người dùng hiện tại: ${currentUser.id}');
    return _mapSupabaseUserToAppUserCredential(currentUser);
  }

  @override
  String? getCurrentUserId() {
    final userId = _supabase.auth.currentUser?.id;
    _log.info('getCurrentUserId: ID người dùng là: $userId');
    return userId;
  }

  @override
  Future<AppUserCredential> signInWithGoogle() async {
    _log.info('Bắt đầu quá trình đăng nhập với Google...');

    try {
      final googleUser = await _googleSignIn.signIn();

      if (googleUser == null) {
        _log.warning('Người dùng đã hủy quá trình đăng nhập Google.');
        throw GoogleSignInCancelledException();
      }

      _log.info('Đã lấy được thông tin người dùng từ Google.');
      final googleAuth = await googleUser.authentication;
      final accessToken = googleAuth.accessToken;
      final idToken = googleAuth.idToken;

      if (idToken == null) {
        _log.severe('Không lấy được idToken từ Google. Quá trình không thể tiếp tục.');
        throw GoogleSignInException(
          'Không thể lấy ID token từ Google, vui lòng thử lại.',
        );
      }

      _log.info('Đang gửi idToken tới Supabase để xác thực...');
      // 3. Đăng nhập vào Supabase bằng ID Token
      final authResponse = await _supabase.auth.signInWithIdToken(
        provider: OAuthProvider.google,
        idToken: idToken,
        accessToken: accessToken,
      );

      if (authResponse.user == null) {
        _log.severe('Supabase trả về user null sau khi signInWithIdToken.');
        throw SupabaseSignInException('Xác thực với Supabase thất bại, không có thông tin người dùng.');
      }

      final appUser = _mapSupabaseUserToAppUserCredential(authResponse.user!);
      _log.info('Đăng nhập Google và xác thực Supabase thành công cho user: ${appUser.uid}');
      return appUser;
    } on AuthException catch (e, st) {
      _log.severe('Lỗi xác thực từ Supabase: ${e.message}', e, st);
      throw SupabaseSignInException(e.message);
    } on GoogleSignInCancelledException {
      // Re-throw để không bị bắt bởi catch (e) bên dưới
      rethrow;
    } catch (e, st) {
      _log.severe('Lỗi không xác định trong quá trình signInWithGoogle', e, st);
      // Kiểm tra lỗi mạng từ phía google_sign_in
      if (e.toString().contains('network error')) {
        throw GoogleSignInException('Lỗi mạng, không thể kết nối đến dịch vụ của Google.');
      }
      throw AuthenticationServiceUnknownException(e.toString());
    }
  }

  @override
  Future<void> signOut() async {
    _log.info('Bắt đầu quá trình đăng xuất...');
    try {
      await _supabase.auth.signOut();
      await _googleSignIn.signOut();
      _log.info('Đăng xuất khỏi Supabase thành công.');
    } catch (e, st) {
      _log.severe('Lỗi khi đăng xuất khỏi Supabase', e, st);
      throw SignOutException(e.toString());
    }
  }
}
