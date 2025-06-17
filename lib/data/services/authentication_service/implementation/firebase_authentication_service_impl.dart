import 'package:dishlocal/data/services/authentication_service/interface/authentication_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: AuthenticationService)
class FirebaseAuthenticationService implements AuthenticationService {
  final GoogleSignIn _googleSignIn;
  final FirebaseAuth _firebaseAuth;

  FirebaseAuthenticationService(
    this._googleSignIn,
    this._firebaseAuth,
  );

  @override
  Stream<User?> get authStateChanges => _firebaseAuth.authStateChanges();

  @override
  User? getCurrentUser() => _firebaseAuth.currentUser;

  @override
  Future<UserCredential> signInWithGoogle() async {
    try {
      final googleUser = await _googleSignIn.signIn();
      if (googleUser == null) {
        // Người dùng đã hủy đăng nhập
        throw FirebaseAuthException(code: 'USER_CANCELLED');
      }

      final googleAuth = await googleUser.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      return await _firebaseAuth.signInWithCredential(credential);
    } catch (e) {
      // Xử lý các lỗi khác
      rethrow;
    }
  }

  @override
  Future<void> signOut() async {
    await _googleSignIn.signOut();
    await _firebaseAuth.signOut();
  }
}
