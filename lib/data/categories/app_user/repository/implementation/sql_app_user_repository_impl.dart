import 'package:dartz/dartz.dart';
import 'package:dishlocal/data/categories/app_user/model/app_user.dart';
import 'package:dishlocal/data/categories/app_user/repository/failure/app_user_failure.dart';
import 'package:dishlocal/data/categories/app_user/repository/interface/app_user_repository.dart';
import 'package:dishlocal/data/services/authentication_service/exception/authentication_service_exception.dart';
import 'package:dishlocal/data/services/authentication_service/interface/authentication_service.dart';
import 'package:dishlocal/data/services/database_service/entity/profile_entity.dart';
import 'package:dishlocal/data/services/database_service/exception/sql_database_service_exception.dart';
import 'package:dishlocal/data/services/database_service/interface/sql_database_service.dart';
import 'package:injectable/injectable.dart';
import 'package:logging/logging.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

@LazySingleton(as: AppUserRepository)
class SqlAppUserRepositoryImpl implements AppUserRepository {
  final _log = Logger('UserRepositorySqlImpl');
  final AuthenticationService _authService;
  final SqlDatabaseService _dbService;
  final  _supabase = Supabase.instance.client; // Dùng cho các thao tác không có trong service chung

  static const String _profilesTable = 'profiles';
  static const String _followersTable = 'followers';

  SqlAppUserRepositoryImpl(this._authService, this._dbService) {
    _log.info('✅ Khởi tạo UserRepositorySqlImpl.');
  }

  // Helper để bắt và dịch lỗi
  Future<Either<AppUserFailure, T>> _handleErrors<T>(Future<T> Function() future) async {
    try {
      return Right(await future());
    } on AuthenticationServiceException catch (e) {
      _log.severe('❌ Lỗi từ AuthenticationService', e);
      return Left(switch (e) {
        GoogleSignInCancelledException() => const SignInCancelledFailure(),
        GoogleSignInException() || SupabaseSignInException() => SignInServiceFailure(e.message),
        SignOutException() => SignOutFailure(e.message),
        _ => const UnknownFailure(),
      });
    } on SqlDatabaseServiceException catch (e) {
      _log.severe('❌ Lỗi từ SqlDatabaseService', e);
      return Left(switch (e) {
        RecordNotFoundException() => const UserNotFoundFailure(),
        PermissionDeniedException() => const UpdatePermissionDeniedFailure(),
        UniqueConstraintViolationException() => const DatabaseFailure('Tên người dùng này đã tồn tại.'),
        _ => DatabaseFailure(e.message),
      });
    } catch (e, st) {
      _log.severe('❌ Lỗi không xác định trong Repository', e, st);
      return const Left(UnknownFailure());
    }
  }

  @override
  Stream<AppUser?> get user {
    _log.info('🎧 Bắt đầu lắng nghe luồng (stream) thay đổi của người dùng.');
    return _authService.authStateChanges.asyncMap((credential) async {
      final userId = credential?.uid;
      _log.fine('📬 Luồng authStateChanges phát ra sự kiện mới. UID: ${userId ?? "null"}.');

      if (credential == null) {
        _log.info('🚪 Người dùng đã đăng xuất. Phát ra null.');
        return null;
      }

      try {
        _log.fine('🗃️ Đang lấy dữ liệu hồ sơ từ bảng "profiles" cho UID: $userId');

        // Sử dụng RPC để lấy profile cùng với trạng thái isFollowing (nếu cần)
        // Thay vì tự JOIN, ta sẽ tạo một hàm RPC đơn giản cho việc này.
        // Hoặc cách đơn giản hơn là JOIN trực tiếp.
        final profileData = await _supabase.from(_profilesTable).select().eq('id', userId!).single();

        // Chuyển đổi từ ProfileEntity (DB model) sang AppUser (UI model)
        return AppUser(
          userId: profileData['id'],
          email: credential.email!,
          originalDisplayname: profileData['display_name'] ?? credential.displayName ?? '',
          displayName: profileData['display_name'],
          username: profileData['username'],
          photoUrl: profileData['photo_url'],
          bio: profileData['bio'],
          followerCount: profileData['follower_count'],
          followingCount: profileData['following_count'],
          isFollowing: false, // Mặc định là false khi xem chính mình
        );
      } catch (e, st) {
        _log.severe('🔥 Lỗi khi lấy dữ liệu profile cho UID: $userId', e, st);
        // Trong stream, chúng ta ném lỗi để tầng trên (BLoC) xử lý
        throw DatabaseFailure('Không thể tải dữ liệu người dùng: ${e.toString()}');
      }
    });
  }

  @override
  Future<Either<AppUserFailure, void>> signInWithGoogle() {
    return _handleErrors(() async {
      _log.info('▶️ Bắt đầu quy trình đăng nhập Google...');
      await _authService.signInWithGoogle();
      // Logic kiểm tra và tạo user mới đã được chuyển về backend
      // thông qua trigger `handle_new_user`. Repository không cần làm gì ở đây nữa.
      _log.info('✅ Đăng nhập Google thành công. Trigger sẽ tự động tạo profile nếu cần.');
    });
  }

  // Helper chung cho việc cập nhật một trường duy nhất trong profile
  Future<Either<AppUserFailure, void>> _updateProfileField(String fieldName, dynamic value) {
    return _handleErrors(() async {
      final userId = _authService.getCurrentUserId();
      if (userId == null) throw const NotAuthenticatedFailure();

      _log.info("🔄 Đang cập nhật trường '$fieldName' cho người dùng $userId...");
      await _dbService.update(
        tableName: _profilesTable,
        id: userId,
        data: {fieldName: value},
        fromJson: ProfileEntity.fromJson, // Dummy
      );
      _log.info("✅ Cập nhật '$fieldName' thành công.");
    });
  }

  @override
  Future<Either<AppUserFailure, void>> updateUsername(String username) {
    return _updateProfileField('username', username);
  }

  @override
  Future<Either<AppUserFailure, void>> updateBio(String? bio) {
    return _updateProfileField('bio', bio);
  }

  @override
  Future<Either<AppUserFailure, void>> updateDisplayName(String displayName) {
    return _updateProfileField('display_name', displayName);
  }

  @override
  Future<Either<AppUserFailure, void>> signOut() {
    return _handleErrors(() async {
      _log.info('🚪 Bắt đầu đăng xuất...');
      await _authService.signOut();
      _log.info('✅ Đăng xuất thành công.');
    });
  }

  @override
  Future<Either<AppUserFailure, AppUser>> getCurrentUser() {
    return _handleErrors(() async {
      final credential = _authService.getCurrentUser();
      if (credential == null) throw const NotAuthenticatedFailure();

      _log.info('👤 Đang lấy dữ liệu người dùng hiện tại: ${credential.uid}');
      final profileEntity = await _dbService.readSingleById<ProfileEntity>(
        tableName: _profilesTable,
        id: credential.uid,
        fromJson: ProfileEntity.fromJson,
      );

      return AppUser(
        userId: profileEntity.id,
        email: credential.email!,
        originalDisplayname: profileEntity.displayName ?? credential.displayName ?? '',
        username: profileEntity.username,
        displayName: profileEntity.displayName,
        photoUrl: profileEntity.photoUrl,
        bio: profileEntity.bio,
        followerCount: profileEntity.followerCount,
        followingCount: profileEntity.followingCount,
        isFollowing: false,
      );
    });
  }

  @override
  String? getCurrentUserId() {
    return _authService.getCurrentUserId();
  }

  @override
  Future<Either<AppUserFailure, AppUser>> getUserWithId({required String userId, String? currentUserId}) {
    return _handleErrors(() async {
      _log.info('📥 Bắt đầu lấy dữ liệu cho người dùng: $userId. Người xem: ${currentUserId ?? "khách"}');

      // Lấy dữ liệu profile của người dùng mục tiêu
      final profileEntity = await _dbService.readSingleById<ProfileEntity>(tableName: _profilesTable, id: userId, fromJson: ProfileEntity.fromJson);

      bool isFollowing = false;
      if (currentUserId != null && currentUserId != userId) {
        // Kiểm tra mối quan hệ follow
        _log.fine('🔄 Đang kiểm tra trạng thái follow từ $currentUserId đến $userId...');
        final followRecord = await _supabase.from(_followersTable).select().match({'user_id': userId, 'follower_id': currentUserId}).maybeSingle(); // Dùng maybeSingle để không lỗi nếu không tìm thấy

        isFollowing = followRecord != null;
        _log.info('✅ Kiểm tra follow hoàn tất. isFollowing: $isFollowing');
      }

      // Lấy email từ auth.users (ít khi cần nhưng có thể hữu ích)
      // final adminUser = await _supabase.auth.admin.getUserById(userId);

      return AppUser(
        userId: profileEntity.id,
        email: '...', // Không dễ để lấy email của người khác, thường là không cần
        originalDisplayname: profileEntity.displayName ?? '',
        username: profileEntity.username,
        displayName: profileEntity.displayName,
        photoUrl: profileEntity.photoUrl,
        bio: profileEntity.bio,
        followerCount: profileEntity.followerCount,
        followingCount: profileEntity.followingCount,
        isFollowing: isFollowing,
      );
    });
  }

  @override
  Future<Either<AppUserFailure, void>> followUser({required String targetUserId, required bool isFollowing}) {
    return _handleErrors(() async {
      final action = isFollowing ? "theo dõi" : "bỏ theo dõi";
      _log.info('▶️ Bắt đầu quá trình $action người dùng: $targetUserId.');

      final currentUserId = _authService.getCurrentUserId();
      if (currentUserId == null) throw const NotAuthenticatedFailure();
      if (currentUserId == targetUserId) throw const UnknownFailure(message: 'Không thể tự theo dõi chính mình.');

      if (isFollowing) {
        // Chèn vào bảng followers. Trigger sẽ tự cập nhật các bộ đếm.
        await _dbService.create(
          tableName: _followersTable,
          data: {'user_id': targetUserId, 'follower_id': currentUserId},
          fromJson: (json) => {}, // Dummy
        );
      } else {
        // Xóa khỏi bảng followers. Trigger sẽ tự cập nhật các bộ đếm.
        await _supabase.from(_followersTable).delete().match({'user_id': targetUserId, 'follower_id': currentUserId});
      }
      _log.info('✅ Hoàn thành $action người dùng $targetUserId thành công.');
    });
  }
}
