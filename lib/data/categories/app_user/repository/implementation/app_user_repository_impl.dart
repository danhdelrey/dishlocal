// file: lib/data/categories/app_user/repository/implementation/user_repository_impl.dart

import 'package:dartz/dartz.dart';
import 'package:dishlocal/data/categories/app_user/model/app_user.dart';
import 'package:dishlocal/data/categories/app_user/repository/failure/app_user_failure.dart';
import 'package:dishlocal/data/categories/app_user/repository/interface/app_user_repository.dart';
import 'package:dishlocal/data/services/authentication_service/exception/authentication_service_exception.dart';
import 'package:dishlocal/data/services/authentication_service/interface/authentication_service.dart';
import 'package:dishlocal/data/services/database_service/exception/database_service_exception.dart' as db_exception;
import 'package:dishlocal/data/services/database_service/interface/database_service.dart';
import 'package:injectable/injectable.dart';
import 'package:logging/logging.dart';

@LazySingleton(as: AppUserRepository)
class UserRepositoryImpl implements AppUserRepository {
  final _log = Logger('UserRepositoryImpl');
  final AuthenticationService _authService;
  final DatabaseService _databaseService;
  static const String _usersCollection = 'users';

  UserRepositoryImpl(
    this._authService,
    this._databaseService,
  ) {
    _log.info('Khởi tạo UserRepositoryImpl.');
  }

  @override
  Stream<AppUser?> get user {
    _log.info('Bắt đầu lắng nghe luồng (stream) thay đổi của người dùng.');
    return _authService.authStateChanges.asyncMap((firebaseUser) async {
      final userId = firebaseUser?.uid;
      _log.fine('Luồng authStateChanges phát ra một sự kiện mới. UID: ${userId ?? "null"}.');

      if (firebaseUser == null) {
        _log.info('Người dùng đã đăng xuất (firebaseUser là null). Phát ra giá trị null trong luồng người dùng.');
        return null;
      }

      try {
        _log.fine('Đang lấy dữ liệu người dùng từ Firestore cho UID: $userId');
        final userData = await _databaseService.getDocument(collection: _usersCollection, docId: firebaseUser.uid);

        if (userData != null) {
          _log.info('Tìm thấy dữ liệu người dùng trong Firestore cho UID: $userId. Đang tạo đối tượng AppUser từ dữ liệu.');
          return AppUser.fromJson(userData);
        } else {
          _log.warning('Không tìm thấy dữ liệu trong Firestore cho UID: $userId. Đây có thể là người dùng mới. Đang tạo đối tượng AppUser tạm thời từ dữ liệu xác thực.');
          return AppUser(
            userId: firebaseUser.uid,
            email: firebaseUser.email,
            photoUrl: firebaseUser.photoURL,
            displayName: firebaseUser.displayName,
          );
        }
      } catch (e, stackTrace) {
        _log.severe('Lỗi khi xử lý sự kiện thay đổi người dùng cho UID: $userId', e, stackTrace);
        // THAY ĐỔI: Thay vì rethrow, chúng ta ném ra một lỗi mà stream có thể bắt được.
        // BLoC lắng nghe stream này sẽ cần có .handleError hoặc .listen(onError: ...).
        // Đối với BLoC, một cách hay là biến stream lỗi thành stream State lỗi.
        throw DatabaseFailure('Không thể tải dữ liệu người dùng: ${e.toString()}');
      }
    });
  }

  @override
  Future<Either<AppUserFailure, void>> signInWithGoogle() async {
    _log.info('Bắt đầu quy trình đăng nhập với Google ở tầng Repository.');
    try {
      _log.fine('Đang gọi _authService.signInWithGoogle()...');
      final userCredential = await _authService.signInWithGoogle();
      final firebaseUser = userCredential.user;

      if (firebaseUser == null) {
        // Trường hợp này rất hiếm, nhưng nên xử lý
        _log.severe('signInWithGoogle từ authService trả về credential nhưng không có user object.');
        return const Left(UnknownFailure(message: 'Không nhận được thông tin người dùng sau khi đăng nhập.'));
      }

      final userId = firebaseUser.uid;
      _log.info('Đăng nhập xác thực thành công. UID: $userId. Đang kiểm tra dữ liệu trong Firestore.');

      final userData = await _databaseService.getDocument(collection: _usersCollection, docId: userId);

      if (userData == null) {
        _log.info('Người dùng với UID $userId chưa tồn tại trong Firestore. Đang tiến hành tạo mới.');
        final newUser = AppUser(
          userId: userId,
          email: firebaseUser.email,
          photoUrl: firebaseUser.photoURL,
          displayName: firebaseUser.displayName,
        );
        _log.fine('Đang lưu thông tin người dùng mới vào Firestore...');
        await _databaseService.setDocument(
          collection: _usersCollection,
          docId: newUser.userId,
          data: newUser.toJson(),
        );
        _log.info('Tạo người dùng mới trong Firestore thành công cho UID: $userId.');
      } else {
        _log.info('Người dùng với UID $userId đã tồn tại trong Firestore. Bỏ qua bước tạo mới.');
      }
      return const Right(null); // Thành công
    }
    // THAY ĐỔI: Bắt các ServiceException và "dịch" sang Failure
    on GoogleSignInCancelledException catch (e) {
      _log.warning('Bắt được GoogleSignInCancelledException: ${e.message}');
      return const Left(SignInCancelledFailure());
    } on GoogleSignInException catch (e) {
      _log.severe('Bắt được GoogleSignInException: ${e.message}');
      return Left(SignInServiceFailure(e.message));
    } on FirebaseSignInException catch (e) {
      _log.severe('Bắt được FirebaseSignInException: ${e.message}');
      return Left(SignInServiceFailure(e.message));
    } on db_exception.DatabaseServiceException catch (e) {
      _log.severe('Bắt được DatabaseServiceException trong lúc đăng nhập: ${e.message}');
      return Left(DatabaseFailure('Lỗi cơ sở dữ liệu khi thiết lập người dùng: ${e.message}'));
    } catch (e, stackTrace) {
      _log.severe('Lỗi không xác định xảy ra trong quá trình signInWithGoogle tại Repository.', e, stackTrace);
      return const Left(UnknownFailure());
    }
  }

  @override
  Future<Either<AppUserFailure, void>> createUsername(String username) async {
    _log.info("Bắt đầu cập nhật username cho người dùng hiện tại.");
    try {
      _log.fine('Đang lấy người dùng hiện tại từ _authService...');
      final firebaseUser = _authService.getCurrentUser();
      if (firebaseUser == null) {
        _log.warning('Không có người dùng nào đang đăng nhập để cập nhật username.');
        // THAY ĐỔI: Trả về Failure thay vì throw Exception
        return const Left(NotAuthenticatedFailure());
      }

      final userId = firebaseUser.uid;
      _log.fine('Người dùng $userId đã xác thực. Đang cập nhật username thành "$username"...');
      await _databaseService.updateDocument(
        collection: _usersCollection,
        docId: userId,
        data: {'username': username},
      );
      _log.info('Cập nhật username thành công cho người dùng $userId.');
      return const Right(null); // Thành công
    }
    // THAY ĐỔI: Bắt các ServiceException và "dịch" sang Failure
    on db_exception.PermissionDeniedException catch (e) {
      _log.severe('Lỗi quyền khi cập nhật username: ${e.message}');
      return const Left(UpdatePermissionDeniedFailure());
    } on db_exception.DatabaseServiceException catch (e) {
      _log.severe('Lỗi database khi cập nhật username: ${e.message}');
      return Left(DatabaseFailure('Lỗi cơ sở dữ liệu khi cập nhật username: ${e.message}'));
    } catch (e, stackTrace) {
      _log.severe('Lỗi không xác định khi đang cập nhật username.', e, stackTrace);
      return const Left(UnknownFailure());
    }
  }

  @override
  Future<Either<AppUserFailure, void>> signOut() async {
    _log.info('Bắt đầu quy trình đăng xuất.');
    try {
      await _authService.signOut();
      _log.info('Đăng xuất thành công.');
      return const Right(null); // Thành công
    }
    // THAY ĐỔI: Bắt ServiceException và "dịch" sang Failure
    on SignOutException catch (e) {
      _log.severe('Bắt được SignOutException: ${e.message}');
      return Left(SignOutFailure(e.message));
    } catch (e, stackTrace) {
      _log.severe('Lỗi không xác định xảy ra trong quá trình đăng xuất.', e, stackTrace);
      return const Left(UnknownFailure(message: 'Lỗi không xác định khi đăng xuất.'));
    }
  }

  @override
  Either<AppUserFailure, AppUser> getCurrentUser() {
    try {
      final firebaseUser = _authService.getCurrentUser();
      if (firebaseUser == null) {
        return const Left(NotAuthenticatedFailure());
      }
      _log.info('Người dùng hiện tại là userId: ${firebaseUser.uid}, displayName: ${firebaseUser.displayName}, photoUrl: ${firebaseUser.photoURL}, email: ${firebaseUser.email}');
      //TODO: chưa truyền vào userID
      return Right(
        AppUser(
          userId: firebaseUser.uid,
          displayName: firebaseUser.displayName,
          photoUrl: firebaseUser.photoURL,
          email: firebaseUser.email,
        ),
      );
    } catch (e) {
      return const Left(UnknownFailure());
    }
  }
}
