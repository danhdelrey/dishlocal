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
import 'package:rxdart/rxdart.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

@LazySingleton(as: AppUserRepository)
class SqlAppUserRepositoryImpl implements AppUserRepository {
  final _log = Logger('UserRepositorySqlImpl');
  final AuthenticationService _authService;
  final SqlDatabaseService _dbService;
  // Dùng cho các thao tác chuyên biệt không có trong service chung (stream, rpc, etc.)
  final _supabase = Supabase.instance.client;

  static const String _profilesTable = 'profiles';
  static const String _followersTable = 'followers';

  SqlAppUserRepositoryImpl(this._authService, this._dbService) {
    _log.info('✅ Khởi tạo UserRepositorySqlImpl.');
  }

  /// Helper để bắt và "dịch" các lỗi từ tầng service sang tầng repository.
  /// Giữ cho các phương thức khác sạch sẽ và chỉ tập trung vào logic thành công.
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
        // Ví dụ cụ thể về việc "dịch" lỗi
        UniqueConstraintViolationException() => const DatabaseFailure('Tên người dùng hoặc thông tin này đã tồn tại.'),
        _ => DatabaseFailure(e.message),
      });
    } catch (e, st) {
      _log.severe('❌ Lỗi không xác định trong Repository', e, st);
      return const Left(UnknownFailure());
    }
  }

  // Phương thức helper private để tránh lặp code khi cập nhật profile
  Future<Either<AppUserFailure, void>> _updateProfileField(String fieldName, dynamic value) {
    return _handleErrors(() async {
      final userId = _authService.getCurrentUserId();
      if (userId == null) {
        throw SupabaseSignInException('Có lỗi xảy ra khi thực hiện đăng nhập');
      }
      // Không cần kết quả trả về, chỉ cần biết nó có thành công hay không.
      // Do đó, ta không cần fromJson.
      await _dbService.update(
        tableName: _profilesTable,
        id: userId,
        data: {fieldName: value},
        fromJson: (json) => null, // Không dùng kết quả
      );
    });
  }

  @override
  Stream<AppUser?> get user {
    // Bắt đầu với luồng thay đổi trạng thái xác thực từ service
    return _authService.authStateChanges
        // Sử dụng switchMap từ RxDart để chuyển đổi luồng
        .switchMap((credential) {
      // TRƯỜNG HỢP 1: Người dùng đã đăng xuất (credential là null)
      if (credential == null) {
        _log.info('Auth stream: Người dùng đã đăng xuất. Phát ra giá trị null.');
        // Trả về một luồng chỉ phát ra giá trị null một lần rồi kết thúc.
        return Stream.value(null);
      }

      // TRƯỜNG HỢP 2: Người dùng đã đăng nhập (có credential)
      _log.info('Auth stream: Người dùng ${credential.uid} đã đăng nhập. Bắt đầu lắng nghe hồ sơ...');
      // Trả về một luồng mới: luồng lắng nghe sự thay đổi của bảng 'profiles'
      return _supabase
          .from(_profilesTable)
          .stream(primaryKey: ['id']) // Lắng nghe thay đổi trên bảng dựa vào PK
          .eq('id', credential.uid) // Chỉ cho user có ID này
          // Dùng .map() bình thường để biến đổi kết quả của luồng profile
          .map((profilesData) {
            // profilesData là một List<Map<String, dynamic>>
            if (profilesData.isEmpty) {
              _log.warning('Stream: Không tìm thấy hồ sơ cho ${credential.uid}. Có thể đang trong quá trình tạo. Phát ra null tạm thời.');
              // Đây là trường hợp quan trọng, ví dụ user vừa đăng ký và hồ sơ chưa kịp tạo.
              return null;
            }

            // Nếu có dữ liệu, chuyển nó thành đối tượng ProfileEntity
            final profile = ProfileEntity.fromJson(profilesData.first);

            // Kết hợp dữ liệu từ xác thực và hồ sơ để tạo AppUser hoàn chỉnh.
            return AppUser(
              userId: profile.id,
              username: profile.username,
              originalDisplayname: credential.displayName ?? '', // Lấy từ credential
              email: credential.email ?? '', // Lấy từ credential
              displayName: profile.displayName,
              photoUrl: profile.photoUrl,
              bio: profile.bio,
              followerCount: profile.followerCount,
              followingCount: profile.followingCount,
              // Khi đang xem chính mình, isFollowing không áp dụng.
              isFollowing: false,
            );
          });
    }).handleError((error, stackTrace) {
      // Bắt lỗi trên toàn bộ luồng kết hợp để tránh làm sập stream
      _log.severe('Lỗi trong luồng dữ liệu người dùng (user stream)', error, stackTrace);
      // Bạn có thể phát ra một AppUser đặc biệt cho trạng thái lỗi nếu muốn
      // Hoặc để yên để StreamBuilder/Bloc có thể bắt `snapshot.hasError`
    });
  }

  @override
// Kiểu trả về vẫn giữ nguyên
  Future<Either<AppUserFailure, SignInResult>> signInWithGoogle() {
    return _handleErrors(() async {
      // 1. Thực hiện xác thực như cũ
      final credential = await _authService.signInWithGoogle();

      // 2. Luôn lấy hồ sơ người dùng.
      // Trigger đã đảm bảo nó tồn tại, nếu không có lỗi ở đây nghĩa là CSDL có vấn đề.
      final profile = await _dbService.readSingleById(
        tableName: _profilesTable,
        id: credential!.uid,
        fromJson: ProfileEntity.fromJson,
      );

      _log.info('Kiểm tra hồ sơ cho người dùng ${credential.uid}. Username hiện tại: ${profile.username}');

      // 3. ĐÂY LÀ LOGIC QUAN TRỌNG:
      // Kiểm tra xem username có phải là username mặc định do trigger tạo ra không.
      if (profile.username.startsWith('user')) {
        // Giả định username mặc định bắt đầu bằng 'user'
        _log.info('Username là mặc định. Yêu cầu thiết lập hồ sơ.');
        // Trả về thông tin xác thực để màn hình setup có thể sử dụng
        return SignInRequiresProfileSetup(credential);
      } else {
        _log.info('Người dùng đã có hồ sơ hoàn chỉnh. Đăng nhập thành công.');
        // Nếu username đã được tuỳ chỉnh, tạo AppUser và trả về thành công
        final appUser = AppUser(
          userId: profile.id,
          username: profile.username,
          originalDisplayname: credential.displayName ?? '',
          email: credential.email ?? '',
          displayName: profile.displayName,
          photoUrl: profile.photoUrl,
          bio: profile.bio,
          followerCount: profile.followerCount,
          followingCount: profile.followingCount,
        );
        return SignInSuccess(appUser);
      }
    });
  }

  @override
  Future<Either<AppUserFailure, void>> signOut() {
    return _handleErrors(() => _authService.signOut());
  }

  @override
  String? getCurrentUserId() {
    return _authService.getCurrentUserId();
  }

  @override
  Future<Either<AppUserFailure, AppUser>> getCurrentUser() {
    return _handleErrors(() async {
      final credential = _authService.getCurrentUser();
      if (credential == null) {
        throw SupabaseSignInException('Có lỗi xảy ra khi thực hiện đăng nhập');
      }

      final profile = await _dbService.readSingleById(tableName: _profilesTable, id: credential.uid, fromJson: ProfileEntity.fromJson);

      return AppUser(
        userId: profile.id,
        username: profile.username,
        originalDisplayname: credential.displayName ?? '',
        email: credential.email ?? '',
        displayName: profile.displayName,
        photoUrl: profile.photoUrl,
        bio: profile.bio,
        followerCount: profile.followerCount,
        followingCount: profile.followingCount,
        isFollowing: false,
      );
    });
  }

  @override
  Future<Either<AppUserFailure, AppUser>> getUserWithId({required String userId, String? currentUserId}) {
    return _handleErrors(() async {
      // 1. Lấy thông tin hồ sơ của người dùng mục tiêu
      final profile = await _dbService.readSingleById(tableName: _profilesTable, id: userId, fromJson: ProfileEntity.fromJson);

      // 2. Kiểm tra trạng thái follow nếu có người dùng đang xem
      bool isFollowing = false;
      if (currentUserId != null && currentUserId.isNotEmpty && currentUserId != userId) {
        final result = await _supabase
            .from(_followersTable)
            .select('user_id')
            .eq('user_id', userId) // Người được theo dõi
            .eq('follower_id', currentUserId) // Người đi theo dõi
            .limit(1);

        isFollowing = result.isNotEmpty;
      }
      _log.info('Người dùng $currentUserId đang xem $userId. Trạng thái follow: $isFollowing');

      // 3. Tạo đối tượng AppUser hoàn chỉnh
      return AppUser(
        userId: profile.id,
        username: profile.username,
        // Thông tin email và originalDisplayname không công khai cho người khác xem
        originalDisplayname: profile.displayName ?? profile.username,
        email: '', // Không lộ email người khác
        displayName: profile.displayName,
        photoUrl: profile.photoUrl,
        bio: profile.bio,
        followerCount: profile.followerCount,
        followingCount: profile.followingCount,
        isFollowing: isFollowing,
      );
    });
  }

  @override
  Future<Either<AppUserFailure, void>> followUser({required String targetUserId, required bool isFollowing}) {
    return _handleErrors(() async {
      final currentUserId = _authService.getCurrentUserId();
      if (currentUserId == null) {
        throw SupabaseSignInException('Có lỗi xảy ra khi thực hiện đăng nhập');
      }
      if (currentUserId == targetUserId) {
        throw Exception('User cannot follow themselves.');
      }

      if (isFollowing) {
        // THEO DÕI: Thêm một bản ghi vào bảng 'followers'
        _log.info('User $currentUserId is following $targetUserId.');
        await _supabase.from(_followersTable).insert({
          'user_id': targetUserId, // người được theo dõi
          'follower_id': currentUserId // người đi theo dõi
        });
      } else {
        // BỎ THEO DÕI: Xóa bản ghi tương ứng
        _log.info('User $currentUserId is unfollowing $targetUserId.');
        await _supabase.from(_followersTable).delete().eq('user_id', targetUserId).eq('follower_id', currentUserId);
      }
      // Các trigger trong CSDL sẽ tự động cập nhật follower_count và following_count.
    });
  }

  @override
  Future<Either<AppUserFailure, void>> updateUsername(String username) {
    return _updateProfileField('username', username);
  }

  @override
  Future<Either<AppUserFailure, void>> updateDisplayName(String displayName) {
    return _updateProfileField('display_name', displayName);
  }

  @override
  Future<Either<AppUserFailure, void>> updateBio(String? bio) {
    return _updateProfileField('bio', bio);
  }

  @override
// Đổi tên và logic cho đúng với nghiệp vụ: không phải "tạo" mà là "cập nhật"
  Future<Either<AppUserFailure, void>> updateProfileAfterSetup({
    required String userId,
    required String username,
    String? displayName,
    // Giả sử bạn cũng cho phép cập nhật ảnh đại diện ở màn hình này
    String? photoUrl,
  }) {
    return _handleErrors(() async {
      _log.info('Cập nhật hồ sơ cho người dùng $userId với username: $username');

      // Tạo một map chứa các dữ liệu cần cập nhật
      final dataToUpdate = {
        'username': username,
        'display_name': displayName,
        'photo_url': photoUrl,
      };

      // Loại bỏ các giá trị null để không ghi đè dữ liệu hiện có bằng null một cách vô tình
      dataToUpdate.removeWhere((key, value) => value == null);

      // Dùng service để CẬP NHẬT (UPDATE) bản ghi đã tồn tại
      await _dbService.update(
        tableName: _profilesTable,
        id: userId,
        data: dataToUpdate,
        fromJson: (json) => null, // Không cần kết quả trả về
      );

      _log.info('Cập nhật hồ sơ cho $userId thành công.');
    });
  }
}
