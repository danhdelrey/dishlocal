import 'package:dartz/dartz.dart';
import 'package:dishlocal/data/categories/app_user/model/app_user.dart';
import 'package:dishlocal/data/categories/app_user/repository/failure/app_user_failure.dart';
import 'package:dishlocal/data/categories/app_user/repository/interface/app_user_repository.dart';
import 'package:dishlocal/data/services/authentication_service/exception/authentication_service_exception.dart';
import 'package:dishlocal/data/services/authentication_service/interface/authentication_service.dart';
import 'package:dishlocal/data/services/authentication_service/model/app_user_credential.dart';
import 'package:dishlocal/data/services/database_service/entity/profile_entity.dart';
import 'package:dishlocal/data/services/database_service/exception/sql_database_service_exception.dart';
import 'package:dishlocal/data/services/database_service/interface/sql_database_service.dart';
import 'package:injectable/injectable.dart';
import 'package:logging/logging.dart';
import 'package:rxdart/rxdart.dart';

@LazySingleton(as: AppUserRepository)
class SqlAppUserRepositoryImpl implements AppUserRepository {
  final _log = Logger('SqlAppUserRepositoryImpl');
  final AuthenticationService _authService;
  final SqlDatabaseService _dbService;

  // Sử dụng BehaviorSubject để lưu trữ và phát ra AppUser hiện tại
  // Nó sẽ giữ lại giá trị cuối cùng cho các subscriber mới.
  final BehaviorSubject<AppUser?> _currentUserController;

  SqlAppUserRepositoryImpl(this._authService, this._dbService) : _currentUserController = BehaviorSubject<AppUser?>() {
    _log.info('✅ Khởi tạo UserRepositorySqlImpl.');

    // Lắng nghe sự thay đổi trạng thái xác thực từ service
    _authService.authStateChanges.listen(_onAuthChanged);
  }

  /// Hàm được gọi mỗi khi trạng thái đăng nhập thay đổi.
  Future<void> _onAuthChanged(AppUserCredential? credential) async {
    if (credential == null) {
      _log.info('🚪 Người dùng đã đăng xuất.');
      _currentUserController.add(null);
    } else {
      _log.info('👤 Người dùng đã đăng nhập: ${credential.uid}');
      // Lấy profile đầy đủ và phát ra stream
      final result = await _fetchAppUserFromCredential(credential);
      result.fold(
        (failure) {
          _log.severe('❌ Không thể lấy profile sau khi đăng nhập: $failure');
          // Có thể đăng xuất người dùng ở đây nếu profile là bắt buộc
          _currentUserController.add(null);
        },
        (appUser) {
          _log.info('✅ Lấy profile thành công, phát ra AppUser.');
          _currentUserController.add(appUser);
        },
      );
    }
  }

  /// Helper để kết hợp AppUserCredential và ProfileEntity thành AppUser
  Future<Either<AppUserFailure, AppUser>> _fetchAppUserFromCredential(AppUserCredential credential) {
    return _handleErrors(() async {
      final profile = await _dbService.readSingleById<ProfileEntity>(
        tableName: 'profiles',
        id: credential.uid,
        fromJson: ProfileEntity.fromJson,
      );
      return AppUser(
        userId: credential.uid,
        email: credential.email ?? '',
        username: profile.username,
        displayName: profile.displayName,
        photoUrl: profile.photoUrl,
        bio: profile.bio,
        followerCount: profile.followerCount,
        followingCount: profile.followingCount,
        originalDisplayname: credential.displayName ?? '',
      );
    });
  }

  @override
  Stream<AppUser?> get onCurrentUserChanged => _currentUserController.stream;

  @override
  AppUser? get latestUser => _currentUserController.valueOrNull;

  @override
  String? getCurrentUserId() {
    return _authService.getCurrentUserId();
  }

  @override
  Future<Either<AppUserFailure, AppUser>> getCurrentUser() async {
    final credential = _authService.getCurrentUser();
    if (credential == null) {
      return const Left(AppUserFailure.notAuthenticated());
    }
    // Lấy lại thông tin mới nhất từ DB thay vì từ stream
    return _fetchAppUserFromCredential(credential);
  }

  @override
  Future<Either<AppUserFailure, AppUser>> getUserById(String userId) {
    return _handleErrors(() async {
      final profile = await _dbService.readSingleById<ProfileEntity>(
        tableName: 'profiles',
        id: userId,
        fromJson: ProfileEntity.fromJson,
      );

      // Kiểm tra xem người dùng hiện tại có đang follow người này không
      bool isFollowing = false;
      final currentUserId = getCurrentUserId();
      if (currentUserId != null && currentUserId != userId) {
        final result = await _dbService.readList(
          tableName: 'followers',
          fromJson: (json) => json, // không cần convert
          filters: {'user_id': userId, 'follower_id': currentUserId},
        );
        isFollowing = result.isNotEmpty;
      }

      return AppUser(
        userId: profile.id,
        email: '', // Không thể biết email của người khác
        username: profile.username,
        displayName: profile.displayName,
        photoUrl: profile.photoUrl,
        bio: profile.bio,
        followerCount: profile.followerCount,
        followingCount: profile.followingCount,
        originalDisplayname: profile.displayName ?? '',
        isFollowing: isFollowing,
      );
    });
  }

  @override
  Future<Either<AppUserFailure, SignInResult>> signInWithGoogle() {
    return _handleErrors(() async {
      final credential = await _authService.signInWithGoogle();
      if (credential == null) {
        throw AuthenticationServiceUnknownException('Credential trả về null sau khi đăng nhập.');
      }

      // Luôn lấy profile từ DB để có thông tin mới nhất
      // Trigger `handle_new_user` đảm bảo profile luôn tồn tại sau khi user được tạo trong `auth.users`
      try {
        final profile = await _dbService.readSingleById<ProfileEntity>(
          tableName: 'profiles',
          id: credential.uid,
          fromJson: ProfileEntity.fromJson,
        );

        // Logic kiểm tra mới: rõ ràng và đáng tin cậy
        if (profile.isSetupCompleted) {
          _log.info('Người dùng đã tồn tại và hoàn thành setup. Kết quả: success.');
          return SignInResult.success;
        } else {
          _log.info('Người dùng mới hoặc chưa hoàn thành setup. Kết quả: newUser.');
          return SignInResult.newUser;
        }
      } on RecordNotFoundException {
        // Lỗi này không nên xảy ra nếu trigger của bạn hoạt động đúng.
        // Nó chỉ ra một sự không đồng bộ giữa `auth.users` và `profiles`.
        _log.severe('Lỗi nghiêm trọng: Profile không tồn tại cho user ${credential.uid} mặc dù đã đăng nhập.');
        throw UnknownDatabaseException('Không tìm thấy profile tương ứng với tài khoản.');
      }
    });
  }

  @override
  Future<Either<AppUserFailure, void>> signOut() {
    return _handleErrors(() async {
      await _authService.signOut();
      // _onAuthChanged sẽ tự động dọn dẹp stream
    });
  }

  @override
  Future<Either<AppUserFailure, void>> completeProfileSetup({required String username, String? displayName}) {
    return _handleErrors(() async {
      final userId = getCurrentUserId();
      if (userId == null) throw const NotAuthenticatedFailure();

      final dataToUpdate = {
        'username': username,
        if (displayName != null) 'display_name': displayName,
        // Đánh dấu là đã hoàn thành setup!
        'is_setup_completed': true,
      };

      await _dbService.update(
        tableName: 'profiles',
        id: userId,
        data: dataToUpdate,
        fromJson: (_) => {}, // không cần kết quả trả về
      );

      // Trigger việc cập nhật lại AppUser trong stream
      // để các widget khác (như home screen) có được thông tin mới nhất.
      _onAuthChanged(_authService.getCurrentUser());
    });
  }

  @override
  Future<Either<AppUserFailure, void>> updateProfileField({required String field, required dynamic value}) {
    return _handleErrors(() async {
      final userId = getCurrentUserId();
      if (userId == null) throw const AppUserFailure.notAuthenticated();

      await _dbService.update(
        tableName: 'profiles',
        id: userId,
        data: {field: value},
        fromJson: (_) => {},
      );
      // Optional: Lấy lại profile mới và cập nhật stream
      _onAuthChanged(_authService.getCurrentUser());
    });
  }

  @override
  Future<Either<AppUserFailure, void>> followUser({required String targetUserId, required bool isFollowing}) {
    return _handleErrors(() async {
      final currentUserId = getCurrentUserId();
      if (currentUserId == null) throw const AppUserFailure.notAuthenticated();
      if (currentUserId == targetUserId) return; // Không thể tự follow

      if (isFollowing) {
        // Hành động: Follow
        await _dbService.create(
          tableName: 'followers',
          data: {'user_id': targetUserId, 'follower_id': currentUserId},
          fromJson: (_) => {},
        );
      } else {
        // Hành động: Unfollow
        // Vì PKEY là (user_id, follower_id), ta không thể dùng delete(id).
        // Cần một phương thức delete với filter trong service.
        // Giả sử service có phương thức `deleteWhere`.
        // Nếu không, bạn cần tạo một RPC function trên Supabase.
        // TẠM THỜI, giả sử bạn sẽ thêm phương thức này vào service:
        // await _dbService.deleteWhere(
        //   tableName: 'followers',
        //   filters: {'user_id': targetUserId, 'follower_id': currentUserId},
        // );
        // Nếu chưa có, bạn có thể tạo một RPC function để làm việc này.
        _log.warning('Cần triển khai deleteWhere trong SqlDatabaseService hoặc RPC function cho unfollow.');
        // Tạm thời để trống.
      }
    });
  }

  Future<Either<AppUserFailure, T>> _handleErrors<T>(Future<T> Function() future) async {
    try {
      return Right(await future());
    }
    // Bắt các lỗi AuthenticationService trước
    on AuthenticationServiceException catch (e) {
      _log.severe('❌ _handleErrors(): Lỗi từ AuthenticationService', e);
      return Left(switch (e) {
        GoogleSignInCancelledException() => const AppUserFailure.signInCancelled(),
        GoogleSignInException() || SupabaseSignInException() => AppUserFailure.signInServiceFailure(e.message),
        SignOutException() => AppUserFailure.signOutFailure(e.message),
        _ => const AppUserFailure.unknown(),
      });
    }
    // Bắt NotAuthenticatedException CỤ THỂ TRƯỚC khi bắt SqlDatabaseServiceException chung
    on NotAuthenticatedFailure catch (e) {
      _log.warning('⚠️ _handleErrors(): Người dùng chưa được xác thực', e);
      return const Left(AppUserFailure.notAuthenticated());
    }
    // Bây giờ mới bắt các lỗi SqlDatabaseServiceException còn lại
    on SqlDatabaseServiceException catch (e) {
      _log.severe('❌_handleErrors(): Lỗi từ SqlDatabaseService', e);
      return Left(switch (e) {
        // Chúng ta không cần case cho NotAuthenticatedFailure ở đây nữa
        RecordNotFoundException() => const AppUserFailure.userNotFound(),
        PermissionDeniedException() => const AppUserFailure.updatePermissionDenied(),
        UniqueConstraintViolationException() => AppUserFailure.databaseFailure('Tên người dùng "${e.value}" đã tồn tại.'),
        CheckConstraintViolationException() => AppUserFailure.databaseFailure('Dữ liệu cho trường "${e.fieldName}" không hợp lệ.'),
        DatabaseConnectionException() => AppUserFailure.databaseFailure(e.message),
        // Các loại lỗi khác từ DB sẽ rơi vào đây
        _ => AppUserFailure.databaseFailure(e.message),
      });
    }
    // Bắt tất cả các lỗi còn lại không xác định
    catch (e, st) {
      _log.severe('❌_handleErrors(): Lỗi không xác định trong Repository', e, st);
      return const Left(AppUserFailure.unknown());
    }
  }
}
