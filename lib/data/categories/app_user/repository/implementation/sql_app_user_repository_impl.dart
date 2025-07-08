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
import 'package:dishlocal/data/services/search_service/exception/search_service_exception.dart';
import 'package:dishlocal/data/services/search_service/interface/search_service.dart';
import 'package:injectable/injectable.dart';
import 'package:logging/logging.dart';
import 'package:rxdart/rxdart.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

@LazySingleton(as: AppUserRepository)
class SqlAppUserRepositoryImpl implements AppUserRepository {
  final _log = Logger('SqlAppUserRepositoryImpl');
  final AuthenticationService _authService;
  final SqlDatabaseService _dbService;
  final SearchService _searchService;
  final _supabase = Supabase.instance.client;

  // Sử dụng BehaviorSubject để lưu trữ và phát ra AppUser hiện tại
  // Nó sẽ giữ lại giá trị cuối cùng cho các subscriber mới.
  final BehaviorSubject<AppUser?> _currentUserController;

  SqlAppUserRepositoryImpl(this._authService, this._dbService, this._searchService) : _currentUserController = BehaviorSubject<AppUser?>() {
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
      try {
        final appUserResult = await _fetchAppUserFromCredential(credential);
        appUserResult.fold(
          (l) => _log.severe("Không thể fetch profile trong _onAuthChanged", l),
          (user) => _currentUserController.add(user),
        );
      } catch (e) {
        _log.severe("Lỗi trong _onAuthChanged", e);
        _currentUserController.add(null);
      }
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
      final appUser = AppUser(
        userId: credential.uid,
        email: credential.email ?? '',
        username: profile.username,
        displayName: profile.displayName,
        photoUrl: profile.photoUrl,
        bio: profile.bio,
        followerCount: profile.followerCount,
        followingCount: profile.followingCount,
        originalDisplayname: credential.displayName ?? '',
        isSetupCompleted: profile.isSetupCompleted,
      );
      _log.info('AppUser được trả về từ _onAuthChanged(AppUserCredential? credential) trong SqlAppUserRepositoryImpl là: ${appUser.toString()}');
      return appUser;
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
  Future<Either<AppUserFailure, AppUser>> getUserProfile([String? userId]) {
    return _handleErrors(() async {
      // ---- LOGIC ĐƯỢC TẬP TRUNG VÀO ĐÂY ----
      // 1. Xác định ID cần lấy
      final idToFetch = userId ?? _authService.getCurrentUserId();

      // 2. Kiểm tra xem có ID để lấy không
      if (idToFetch == null) {
        _log.warning('getUserProfile: ⚠️ Cố gắng lấy profile nhưng không có userId và cũng chưa đăng nhập.');
        throw const NotAuthenticatedFailure(); // Ném ra lỗi để _handleErrors bắt
      }

      _log.fine('getUserProfile: 🔄 Đang lấy profile cho user ID: $idToFetch');

      // 3. Lấy dữ liệu profile từ DB
      final profile = await _dbService.readSingleById<ProfileEntity>(
        tableName: 'profiles',
        id: idToFetch,
        fromJson: ProfileEntity.fromJson,
      );

      // 4. Kiểm tra trạng thái 'isFollowing' (nếu cần)
      bool isFollowing = false;
      final currentUserId = _authService.getCurrentUserId();
      if (currentUserId != null && currentUserId != idToFetch) {
        final result = await _dbService.readList(
          tableName: 'followers',
          fromJson: (json) => json,
          filters: {'user_id': idToFetch, 'follower_id': currentUserId},
        );
        isFollowing = result.isNotEmpty;
      }

      // 5. Tạo và trả về đối tượng AppUser hoàn chỉnh
      return AppUser(
        userId: profile.id,
        email: (idToFetch == currentUserId) ? (_authService.getCurrentUser()?.email ?? '') : '',
        username: profile.username,
        displayName: profile.displayName,
        photoUrl: profile.photoUrl,
        bio: profile.bio,
        followerCount: profile.followerCount,
        followingCount: profile.followingCount,
        isSetupCompleted: profile.isSetupCompleted,
        isFollowing: isFollowing,
        originalDisplayname: profile.displayName ?? '',
      );
    });
  }

  @override
  Future<Either<AppUserFailure, SignInResult>> signInWithGoogle() {
    return _handleErrors(() async {
      // 1. Đăng nhập với Google để lấy credential
      final credential = await _authService.signInWithGoogle();
      if (credential == null) {
        throw AuthenticationServiceUnknownException('signInWithGoogle: Credential trả về null sau khi đăng nhập.');
      }

      // 2. Chủ động tạo profile nếu nó chưa tồn tại
      _log.info('signInWithGoogle: Chủ động gọi RPC để đảm bảo profile tồn tại...');
      await _dbService.rpc(
        'create_profile_if_not_exists',
        params: {
          'user_id': credential.uid,
          'full_name': credential.displayName,
          'avatar_url': credential.photoUrl,
        },
      );
      _log.info('signInWithGoogle: RPC call hoàn tất.');

      // 3. Lấy profile đầy đủ sau khi đã đảm bảo nó tồn tại
      final appUserResult = await _fetchAppUserFromCredential(credential);

      // 4. 🔥 THAY ĐỔI QUAN TRỌNG:
      // Sau khi có kết quả, chúng ta sẽ đẩy AppUser vào stream VÀ trả về SignInResult.
      return appUserResult.fold(
        (failure) {
          // Nếu không thể lấy profile, coi như đăng nhập thất bại.
          _currentUserController.add(null);
          throw failure; // Ném lại lỗi để _handleErrors bắt và dịch
        },
        (appUser) {
          // Đẩy người dùng vào stream để toàn bộ app cập nhật
          _currentUserController.add(appUser);

          // Trả về kết quả cho màn hình Login
          if (appUser.isSetupCompleted) {
            return SignInResult.success;
          } else {
            return SignInResult.newUser;
          }
        },
      );
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
  Future<Either<AppUserFailure, AppUser>> completeProfileSetup({
    required String username,
    String? displayName,
    String? bio,
  }) {
    return _handleErrors(() async {
      final userId = getCurrentUserId();
      if (userId == null) throw const NotAuthenticatedFailure();

      final dataToUpdate = {
        'username': username,
        if (displayName != null && displayName.isNotEmpty) 'display_name': displayName,
        if (bio != null && bio.isNotEmpty) 'bio': bio,
        'is_setup_completed': true,
      };

      // 🔥 THAY ĐỔI QUAN TRỌNG:
      // 1. `_dbService.update` bây giờ sẽ trả về `ProfileEntity` đã được cập nhật.
      final updatedProfile = await _dbService.update<ProfileEntity>(
        tableName: 'profiles',
        id: userId,
        data: dataToUpdate,
        fromJson: ProfileEntity.fromJson, // Cung cấp hàm chuyển đổi
      );

      // 2. Không cần đọc lại. Lấy credential để có email, full_name...
      final credential = _authService.getCurrentUser()!;

      // 3. Tạo AppUser từ `updatedProfile` và `credential`
      final updatedAppUser = AppUser(
        userId: updatedProfile.id,
        email: credential.email ?? '',
        username: updatedProfile.username,
        displayName: updatedProfile.displayName,
        photoUrl: updatedProfile.photoUrl,
        bio: updatedProfile.bio,
        followerCount: updatedProfile.followerCount,
        followingCount: updatedProfile.followingCount,
        isSetupCompleted: updatedProfile.isSetupCompleted, // <-- Sẽ là true
        originalDisplayname: credential.displayName ?? '',
      );

      // 4. Cập nhật stream và trả về AppUser mới
      _currentUserController.add(updatedAppUser);
      return updatedAppUser;
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
        _log.info('UNFOLLOW: "$currentUserId" đang unfollow "$targetUserId"');
        await _dbService.deleteWhere(
          tableName: 'followers',
          filters: {
            'user_id': targetUserId, // Người được theo dõi
            'follower_id': currentUserId, // Người đi theo dõi
          },
        );
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

  @override
  Future<Either<AppUserFailure, List<AppUser>>> searchProfiles({
    required String query,
    int page = 0,
    int hitsPerPage = 20,
  }) async {
    _log.info('🔍 Bắt đầu tìm kiếm profile với query: "$query"');
    try {
      // 1. Lấy danh sách ID từ dịch vụ tìm kiếm
      final searchResult = await _searchService.search(
        query: query,
        searchType: SearchableItem.profiles,
        page: page,
        hitsPerPage: hitsPerPage,
      );
      _log.info('✅ Tìm kiếm thành công, nhận được ${searchResult.objectIds.length} ID profile.');

      if (searchResult.objectIds.isEmpty) {
        return const Right([]);
      }

      // 2. Lấy chi tiết của TẤT CẢ profile trong MỘT lần gọi RPC
      _log.info('📥 Bắt đầu lấy chi tiết cho ${searchResult.objectIds.length} profile trong một lần gọi...');
      final currentUserId = _authService.getCurrentUserId();

      // Gọi hàm RPC mới
      final List<dynamic> profilesData = await _supabase.rpc('get_profile_details_by_ids', params: {
        'p_user_ids': searchResult.objectIds, // <<< Mảng các ID
        'p_current_user_id': currentUserId, // <<< ID người dùng hiện tại
      });

      // Chuyển đổi kết quả JSON thành danh sách các đối tượng AppUser
      // Hàm RPC trả về các trường đã khớp sẵn với AppUser
      final List<AppUser> unsortedUsers = profilesData.map((json) {
        final data = json as Map<String, dynamic>;
        // Ánh xạ trực tiếp từ kết quả RPC sang AppUser
        return AppUser(
          userId: data['id'],
          email: '',
          username: data['username'],
          displayName: data['display_name'],
          photoUrl: data['photo_url'],
          bio: data['bio'],
          followerCount: data['follower_count'],
          followingCount: data['following_count'],
          isSetupCompleted: data['is_setup_completed'],
          isFollowing: data['is_following'], // <<< Lấy trực tiếp từ RPC
          originalDisplayname: data['display_name'] ?? '',
        );
      }).toList();

      // 3. SẮP XẾP LẠI KẾT QUẢ theo thứ tự từ dịch vụ tìm kiếm (quan trọng!)
      final usersById = {for (var user in unsortedUsers) user.userId: user};
      final List<AppUser> sortedUsers = searchResult.objectIds
          .map((id) => usersById[id])
          .whereType<AppUser>() // Lọc ra các user không tìm thấy (nếu có)
          .toList();

      _log.info('🔍 Tìm kiếm thành công, tìm thấy và sắp xếp ${sortedUsers.length} profile.');
      return Right(sortedUsers);
    } on SearchServiceException catch (e, st) {
      // 4. Bắt lỗi từ SearchService và ánh xạ sang AppUserFailure
      _log.severe('❌ Lỗi từ SearchService khi tìm kiếm profile', e, st);

      final failure = switch (e) {
        // Lỗi kết nối
        SearchConnectionException() => AppUserFailure.databaseFailure(e.message),
        // Lỗi API (hệ thống)
        SearchApiException() => const AppUserFailure.databaseFailure('Dịch vụ tìm kiếm đang gặp sự cố.'),
        // Các lỗi khác từ search service
        _ => const AppUserFailure.unknown(),
      };
      return Left(failure);
    } on Exception catch (e, st) {
      // 5. Bắt các lỗi không mong muốn khác
      _log.severe('❌ Lỗi không xác định trong quá trình tìm kiếm profile', e, st);
      return const Left(AppUserFailure.unknown());
    }
  }
}
