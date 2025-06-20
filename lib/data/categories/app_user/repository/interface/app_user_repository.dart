import 'package:dartz/dartz.dart';
import 'package:dishlocal/data/categories/app_user/model/app_user.dart';
import 'package:dishlocal/data/categories/app_user/repository/failure/app_user_failure.dart';

abstract class AppUserRepository {
  // Stream để lắng nghe trạng thái đăng nhập và thông tin user
  // Lỗi trong stream sẽ được xử lý bằng cách phát ra một event lỗi.
  Stream<AppUser?> get user;

  Future<Either<AppUserFailure, AppUser>> getCurrentUser();
  Future<Either<AppUserFailure, AppUser>> getUserWithId(String userId);
  String? getCurrentUserId();

  // Đăng nhập và kiểm tra username
  // THAY ĐỔI: Trả về Either<Failure, void>
  Future<Either<AppUserFailure, void>> signInWithGoogle();

  Future<Either<AppUserFailure, void>> updateUsername(String username);
  Future<Either<AppUserFailure, void>> updateBio(String? bio);
  Future<Either<AppUserFailure, void>> updateDisplayName(String displayName);

  // Đăng xuất
  // THAY ĐỔI: Trả về Either<Failure, void>
  Future<Either<AppUserFailure, void>> signOut();
}
