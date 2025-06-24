import 'package:dartz/dartz.dart';
import 'package:dishlocal/data/categories/app_user/model/app_user.dart';
import 'package:dishlocal/data/categories/app_user/repository/failure/app_user_failure.dart';
import 'package:dishlocal/data/services/authentication_service/model/app_user_credential.dart';

enum SignInResult {
  /// Đăng nhập thành công và user đã có profile đầy đủ.
  success,

  /// Đăng nhập thành công nhưng đây là user mới, cần qua màn hình setup profile.
  newUser,
}

abstract class AppUserRepository {
  /// Stream theo dõi sự thay đổi của người dùng hiện tại (đăng nhập/đăng xuất/cập nhật profile).
  /// Trả về `null` nếu không có ai đăng nhập.
  Stream<AppUser?> get onCurrentUserChanged;

  /// Lấy người dùng hiện tại một lần.
  /// Trả về [UserNotFoundFailure] nếu người dùng đã đăng nhập nhưng không tìm thấy profile.
  Future<Either<AppUserFailure, AppUser>> getCurrentUser();

  /// Lấy giá trị người dùng hiện tại từ cache của repository một cách đồng bộ.
  /// Trả về `null` nếu không có ai đăng nhập hoặc chưa có dữ liệu.
  AppUser? get latestUser;

  /// Lấy ID của người dùng hiện tại, trả về null nếu chưa đăng nhập.
  String? getCurrentUserId();

  /// Lấy thông tin của một người dùng bất kỳ bằng ID.
  Future<Either<AppUserFailure, AppUser>> getUserById(String userId);

  /// Đăng nhập bằng Google.
  Future<Either<AppUserFailure, SignInResult>> signInWithGoogle();

  /// Đăng xuất.
  Future<Either<AppUserFailure, void>> signOut();

  /// Cập nhật profile sau khi người dùng mới hoàn thành màn hình setup.
  Future<Either<AppUserFailure, void>> completeProfileSetup({
    required String username,
    String? displayName,
  });

  /// Cập nhật một trường duy nhất trong profile của người dùng hiện tại.
  Future<Either<AppUserFailure, void>> updateProfileField({required String field, required dynamic value});

  /// Thực hiện hành động follow/unfollow một người dùng.
  Future<Either<AppUserFailure, void>> followUser({required String targetUserId, required bool isFollowing});
}
