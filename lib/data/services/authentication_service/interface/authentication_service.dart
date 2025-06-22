import 'package:dishlocal/data/services/authentication_service/model/app_user_credential.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthenticationService {
  Future<AppUserCredential> signInWithGoogle();
  Future<void> signOut();
  Stream<AppUserCredential?> get authStateChanges;
  AppUserCredential? getCurrentUser();
  String? getCurrentUserId();
}
