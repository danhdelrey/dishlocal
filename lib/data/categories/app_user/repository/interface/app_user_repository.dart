import 'package:dartz/dartz.dart';
import 'package:dishlocal/data/categories/app_user/model/app_user.dart';
import 'package:dishlocal/data/categories/app_user/repository/failure/app_user_failure.dart';

abstract class AppUserRepository {
  // Stream để lắng nghe trạng thái đăng nhập và thông tin user
  // Lỗi trong stream sẽ được xử lý bằng cách phát ra một event lỗi.
  Stream<AppUser?> get user;

  Either<AppUserFailure, AppUser> getCurrentUser();

  // Đăng nhập và kiểm tra username
  // THAY ĐỔI: Trả về Either<Failure, void>
  Future<Either<AppUserFailure, void>> signInWithGoogle();

  // Tạo username
  // THAY ĐỔI: Trả về Either<Failure, void>
  Future<Either<AppUserFailure, void>> createUsername(String username);

  // Đăng xuất
  // THAY ĐỔI: Trả về Either<Failure, void>
  Future<Either<AppUserFailure, void>> signOut();


}
