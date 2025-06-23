import 'package:dartz/dartz.dart';
import 'package:dishlocal/data/categories/app_user/model/app_user.dart';
import 'package:dishlocal/data/categories/app_user/repository/failure/app_user_failure.dart';
import 'package:dishlocal/data/services/authentication_service/model/app_user_credential.dart';

// Dùng sealed class để có thể chứa dữ liệu
abstract class SignInResult {}

// Trường hợp thành công, người dùng đã có hồ sơ đầy đủ
class SignInSuccess extends SignInResult {
  final AppUser user;
  SignInSuccess(this.user);
}

// Trường hợp thành công, nhưng là người dùng mới và cần thiết lập hồ sơ
class SignInRequiresProfileSetup extends SignInResult {
  final AppUserCredential credential;
  SignInRequiresProfileSetup(this.credential);
}

abstract class AppUserRepository {
  // Stream để lắng nghe trạng thái đăng nhập và thông tin user
  // Lỗi trong stream sẽ được xử lý bằng cách phát ra một event lỗi.
  Stream<AppUser?> get user;

  Future<Either<AppUserFailure, AppUser>> getCurrentUser();
  Future<Either<AppUserFailure, AppUser>> getUserWithId({
    required String userId,
    String? currentUserId,
  });
  String? getCurrentUserId();

  // Đăng nhập và kiểm tra username
  // THAY ĐỔI: Trả về Either<Failure, void>
  Future<Either<AppUserFailure, SignInResult>> signInWithGoogle();

  Future<Either<AppUserFailure, void>> updateUsername(String username);
  Future<Either<AppUserFailure, void>> updateBio(String? bio);
  Future<Either<AppUserFailure, void>> updateDisplayName(String displayName);

  Future<Either<AppUserFailure, void>> followUser({
    required String targetUserId,
    required bool isFollowing,
  });

  // Đăng xuất
  // THAY ĐỔI: Trả về Either<Failure, void>
  Future<Either<AppUserFailure, void>> signOut();

  Future<Either<AppUserFailure, void>> updateProfileAfterSetup({
    required String userId,
    required String username,
    String? displayName,
    String? photoUrl,
  });
}
