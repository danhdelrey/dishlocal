import 'package:dishlocal/data/categories/app_user/model/app_user.dart';

abstract class AppUserRepository {
  // Stream để lắng nghe trạng thái đăng nhập và thông tin user
  Stream<AppUser?> get user;

  // Đăng nhập và kiểm tra username
  Future<void> signInWithGoogle();

  // Tạo username
  Future<void> createUsername(String username);

  // Đăng xuất
  Future<void> signOut();
}
