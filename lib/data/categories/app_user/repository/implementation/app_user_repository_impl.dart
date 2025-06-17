import 'package:dishlocal/data/categories/app_user/model/app_user.dart';
import 'package:dishlocal/data/categories/app_user/repository/interface/app_user_repository.dart';
import 'package:dishlocal/data/services/authentication_service/interface/authentication_service.dart';
import 'package:dishlocal/data/services/database_service/interface/database_service.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: AppUserRepository)
class UserRepositoryImpl implements AppUserRepository {
  final AuthenticationService _authService;
  final DatabaseService _databaseService;
  static const String _usersCollection = 'users';

  UserRepositoryImpl(
    this._authService,
    this._databaseService,
  );

  @override
  Stream<AppUser?> get user {
    return _authService.authStateChanges.asyncMap((firebaseUser) async {
      if (firebaseUser == null) return null;

      // Sử dụng _dbService để lấy dữ liệu
      final userData = await _databaseService.getDocument(collection: _usersCollection, docId: firebaseUser.uid);

      if (userData != null) {
        return AppUser.fromJson(userData);
      } else {
        // User mới, chưa có trong DB
        return AppUser(
          userId: firebaseUser.uid,
          email: firebaseUser.email,
          photoUrl: firebaseUser.photoURL,
          displayName: firebaseUser.displayName,
        );
      }
    });
  }

  @override
  Future<void> signInWithGoogle() async {
    final userCredential = await _authService.signInWithGoogle();
    final firebaseUser = userCredential.user;
    if (firebaseUser == null) return;

    final userData = await _databaseService.getDocument(collection: _usersCollection, docId: firebaseUser.uid);
    if (userData == null) {
      // User chưa tồn tại, tạo mới bằng _dbService
      final newUser = AppUser(
        userId: firebaseUser.uid,
        email: firebaseUser.email,
        photoUrl: firebaseUser.photoURL,
        displayName: firebaseUser.displayName,
      );
      await _databaseService.setDocument(
        collection: _usersCollection,
        docId: newUser.userId,
        data: newUser.toJson(),
      );
    }
  }

  @override
  Future<void> createUsername(String username) async {
    final firebaseUser = _authService.getCurrentUser();
    if (firebaseUser == null) throw Exception('Not authenticated');

    // Cập nhật username bằng _dbService
    await _databaseService.updateDocument(
      collection: _usersCollection,
      docId: firebaseUser.uid,
      data: {'username': username},
    );
  }

  @override
  Future<void> signOut() async {
    await _authService.signOut();
  }
}
