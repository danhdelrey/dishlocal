import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthenticationService {
  Future<UserCredential> signInWithGoogle();
  Future<void> signOut();
  Stream<User?> get authStateChanges;
  User? getCurrentUser();
  String? getCurrentUserId();
}
