
// import 'package:dartz/dartz.dart';
// import 'package:dishlocal/data/categories/app_user/model/app_user.dart';
// import 'package:dishlocal/data/categories/app_user/repository/failure/app_user_failure.dart';
// import 'package:dishlocal/data/categories/app_user/repository/interface/app_user_repository.dart';
// import 'package:dishlocal/data/services/authentication_service/exception/authentication_service_exception.dart';
// import 'package:dishlocal/data/services/authentication_service/interface/authentication_service.dart';
// import 'package:dishlocal/data/services/database_service/exception/no_sql_database_service_exception.dart' as db_exception;
// import 'package:dishlocal/data/services/database_service/interface/no_sql_database_service.dart';
// import 'package:dishlocal/data/services/database_service/model/batch_operation.dart';
// import 'package:dishlocal/data/services/database_service/model/server_timestamp.dart';
// import 'package:injectable/injectable.dart';
// import 'package:logging/logging.dart';

// class NoSqlAppUserRepositoryImpl implements AppUserRepository {
//   final _log = Logger('UserRepositoryImpl');
//   final AuthenticationService _authService;
//   final NoSqlDatabaseService _databaseService;
//   static const String _usersCollection = 'users';

//   NoSqlAppUserRepositoryImpl(
//     this._authService,
//     this._databaseService,
//   ) {
//     _log.info('Khởi tạo UserRepositoryImpl.');
//   }

//   @override
//   Stream<AppUser?> get user {
//     _log.info('Bắt đầu lắng nghe luồng (stream) thay đổi của người dùng.');
//     return _authService.authStateChanges.asyncMap((userCredential) async {
//       final userId = userCredential?.uid;
//       _log.fine('Luồng authStateChanges phát ra một sự kiện mới. UID: ${userId ?? "null"}.');

//       if (userCredential == null) {
//         _log.info('Người dùng đã đăng xuất (userCredential là null). Phát ra giá trị null trong luồng người dùng.');
//         return null;
//       }

//       try {
//         _log.fine('Đang lấy dữ liệu người dùng từ Firestore cho UID: $userId');
//         final userData = await _databaseService.getDocument(collection: _usersCollection, docId: userCredential.uid);

//         if (userData != null) {
//           _log.info('Tìm thấy dữ liệu người dùng trong Firestore cho UID: $userId. Đang tạo đối tượng AppUser từ dữ liệu.');
//           return AppUser.fromJson(userData);
//         } else {
//           _log.warning('Không tìm thấy dữ liệu trong Firestore cho UID: $userId. Đây có thể là người dùng mới. Đang tạo đối tượng AppUser tạm thời từ dữ liệu xác thực.');
//           return AppUser(
//             userId: userCredential.uid,
//             originalDisplayname: userCredential.displayName!,
//             email: userCredential.email!,
//             photoUrl: userCredential.photoUrl,
//             displayName: userCredential.displayName,
//             followerCount: 0,
//             followingCount: 0,
//           );
//         }
//       } catch (e, stackTrace) {
//         _log.severe('Lỗi khi xử lý sự kiện thay đổi người dùng cho UID: $userId', e, stackTrace);
//         // THAY ĐỔI: Thay vì rethrow, chúng ta ném ra một lỗi mà stream có thể bắt được.
//         // BLoC lắng nghe stream này sẽ cần có .handleError hoặc .listen(onError: ...).
//         // Đối với BLoC, một cách hay là biến stream lỗi thành stream State lỗi.
//         throw DatabaseFailure('Không thể tải dữ liệu người dùng: ${e.toString()}');
//       }
//     });
//   }

//   // @override
//   // Future<Either<AppUserFailure, void>> signInWithGoogle() async {
//   //   _log.info('Bắt đầu quy trình đăng nhập với Google ở tầng Repository.');
//   //   try {
//   //     _log.fine('Đang gọi _authService.signInWithGoogle()...');
//   //     final userCredential = await _authService.signInWithGoogle();
//   //     if (userCredential == null) {
//   //       return const Left(UnknownFailure());
//   //     }

//   //     final userId = userCredential.uid;
//   //     _log.info('Đăng nhập xác thực thành công. UID: $userId. Đang kiểm tra dữ liệu trong Firestore.');

//   //     final userData = await _databaseService.getDocument(collection: _usersCollection, docId: userId);

//   //     if (userData == null) {
//   //       _log.info('Người dùng với UID $userId chưa tồn tại trong Firestore. Đang tiến hành tạo mới.');
//   //       final newUser = AppUser(
//   //         userId: userId,
//   //         originalDisplayname: userCredential.displayName!,
//   //         email: userCredential.email!,
//   //         photoUrl: userCredential.photoUrl,
//   //         displayName: userCredential.displayName,
//   //         followerCount: 0,
//   //         followingCount: 0,
//   //       );
//   //       _log.fine('Đang lưu thông tin người dùng mới vào Firestore...');
//   //       await _databaseService.setDocument(
//   //         collection: _usersCollection,
//   //         docId: newUser.userId,
//   //         data: newUser.toJson(),
//   //       );
//   //       _log.info('Tạo người dùng mới trong Firestore thành công cho UID: $userId.');
//   //     } else {
//   //       _log.info('Người dùng với UID $userId đã tồn tại trong Firestore. Bỏ qua bước tạo mới.');
//   //     }
//   //     return const Right(null); // Thành công
//   //   }
//   //   // THAY ĐỔI: Bắt các ServiceException và "dịch" sang Failure
//   //   on GoogleSignInCancelledException catch (e) {
//   //     _log.warning('Bắt được GoogleSignInCancelledException: ${e.message}');
//   //     return const Left(SignInCancelledFailure());
//   //   } on GoogleSignInException catch (e) {
//   //     _log.severe('Bắt được GoogleSignInException: ${e.message}');
//   //     return Left(SignInServiceFailure(e.message));
//   //   } on FirebaseSignInException catch (e) {
//   //     _log.severe('Bắt được FirebaseSignInException: ${e.message}');
//   //     return Left(SignInServiceFailure(e.message));
//   //   } on db_exception.NoSqlDatabaseServiceException catch (e) {
//   //     _log.severe('Bắt được DatabaseServiceException trong lúc đăng nhập: ${e.message}');
//   //     return Left(DatabaseFailure('Lỗi cơ sở dữ liệu khi thiết lập người dùng: ${e.message}'));
//   //   } catch (e, stackTrace) {
//   //     _log.severe('Lỗi không xác định xảy ra trong quá trình signInWithGoogle tại Repository.', e, stackTrace);
//   //     return const Left(UnknownFailure());
//   //   }
//   // }

//   @override
//   Future<Either<AppUserFailure, void>> updateUsername(String username) async {
//     return _updateUserField('username', username);
//   }

//   @override
//   Future<Either<AppUserFailure, void>> updateBio(String? bio) async {
//     return _updateUserField('bio', bio);
//   }

//   @override
//   Future<Either<AppUserFailure, void>> updateDisplayName(String displayName) async {
//     return _updateUserField('displayName', displayName);
//   }

//   @override
//   Future<Either<AppUserFailure, void>> signOut() async {
//     _log.info('Bắt đầu quy trình đăng xuất.');
//     try {
//       await _authService.signOut();
//       _log.info('Đăng xuất thành công.');
//       return const Right(null); // Thành công
//     }
//     // THAY ĐỔI: Bắt ServiceException và "dịch" sang Failure
//     on SignOutException catch (e) {
//       _log.severe('Bắt được SignOutException: ${e.message}');
//       return Left(SignOutFailure(e.message));
//     } catch (e, stackTrace) {
//       _log.severe('Lỗi không xác định xảy ra trong quá trình đăng xuất.', e, stackTrace);
//       return const Left(UnknownFailure(message: 'Lỗi không xác định khi đăng xuất.'));
//     }
//   }

//   @override
//   Future<Either<AppUserFailure, AppUser>> getCurrentUser() async {
//     try {
//       final firebaseUser = _authService.getCurrentUser();
//       if (firebaseUser == null) {
//         return const Left(NotAuthenticatedFailure());
//       }
//       final userData = await _databaseService.getDocument(collection: _usersCollection, docId: firebaseUser.uid);
//       final appUser = AppUser.fromJson(userData!);

//       _log.info('Người dùng hiện tại là userId: ${appUser.userId}, displayName: ${appUser.displayName}, photoUrl: ${appUser.photoUrl}, email: ${appUser.email}, username: ${appUser.username}, bio: ${appUser.bio}');
//       return Right(appUser);
//     } catch (e) {
//       return const Left(UnknownFailure());
//     }
//   }

//   @override
//   String? getCurrentUserId() {
//     return _authService.getCurrentUserId();
//   }

//   Future<Either<AppUserFailure, void>> _updateUserField(
//     String fieldName,
//     Object? value,
//   ) async {
//     _log.info("Bắt đầu cập nhật trường '$fieldName' cho người dùng hiện tại.");
//     try {
//       _log.fine('Đang lấy người dùng hiện tại từ _authService...');
//       final firebaseUser = _authService.getCurrentUser();
//       if (firebaseUser == null) {
//         _log.warning('Không có người dùng nào đang đăng nhập để cập nhật $fieldName.');
//         return const Left(NotAuthenticatedFailure());
//       }

//       final userId = firebaseUser.uid;
//       _log.fine('Người dùng $userId đã xác thực. Đang cập nhật $fieldName thành "$value"...');

//       await _databaseService.updateDocument(
//         collection: _usersCollection,
//         docId: userId,
//         // Đây là điểm mấu chốt: tạo một map với key và value động
//         data: {fieldName: value},
//       );

//       _log.info('Cập nhật $fieldName thành công cho người dùng $userId.');
//       return const Right(null); // Thành công
//     } on db_exception.PermissionDeniedException catch (e) {
//       _log.severe("Lỗi quyền khi cập nhật $fieldName: ${e.message}");
//       return const Left(UpdatePermissionDeniedFailure());
//     } on db_exception.NoSqlDatabaseServiceException catch (e) {
//       _log.severe("Lỗi database khi cập nhật $fieldName: ${e.message}");
//       return Left(DatabaseFailure('Lỗi cơ sở dữ liệu khi cập nhật $fieldName: ${e.message}'));
//     } catch (e, stackTrace) {
//       _log.severe('Lỗi không xác định khi đang cập nhật $fieldName.', e, stackTrace);
//       return const Left(UnknownFailure());
//     }
//   }

//   @override
//   Future<Either<AppUserFailure, AppUser>> getUserWithId({
//     required String userId,
//     String? currentUserId, // <-- Nhận tham số mới
//   }) async {
//     _log.info('📥 Bắt đầu lấy dữ liệu cho người dùng: $userId. Người xem: ${currentUserId ?? "khách"}');
//     try {
//       // Luôn lấy dữ liệu chính của người dùng
//       final userData = await _databaseService.getDocument(
//         collection: _usersCollection,
//         docId: userId,
//       );

//       if (userData == null) {
//         _log.warning('⚠️ Không tìm thấy người dùng với ID: $userId');
//         return const Left(UnknownFailure(message: 'User not found'));
//       }

//       final appUser = AppUser.fromJson(userData);

//       // Nếu không có người dùng hiện tại hoặc người dùng đang xem chính mình,
//       // thì không cần kiểm tra trạng thái follow.
//       if (currentUserId == null || currentUserId.isEmpty || currentUserId == userId) {
//         _log.fine('Không cần kiểm tra trạng thái follow. Trả về dữ liệu gốc.');
//         // Trả về dữ liệu người dùng mà không cần làm giàu thêm
//         return Right(appUser.copyWith(isFollowing: false));
//       }

//       // Nếu có người dùng hiện tại, tiến hành kiểm tra trạng thái follow
//       _log.fine('🔄 Đang kiểm tra trạng thái follow từ $currentUserId đến $userId...');
//       final followCheckDoc = await _databaseService.getDocument(
//         collection: '$_usersCollection/$currentUserId/following',
//         docId: userId,
//       );

//       // isFollowing sẽ là true nếu tài liệu tồn tại (khác null)
//       final bool isFollowing = followCheckDoc != null;
//       _log.info('✅ Kiểm tra follow hoàn tất. isFollowing: $isFollowing');

//       // Tạo một bản sao của appUser với thông tin isFollowing đã được làm giàu
//       final enrichedUser = appUser.copyWith(isFollowing: isFollowing);

//       return Right(enrichedUser);
//     } on db_exception.NoSqlDatabaseServiceException catch (e, stackTrace) {
//       _log.severe('❌ Lỗi Database Service khi lấy người dùng $userId.', e, stackTrace);
//       return Left(DatabaseFailure(e.message));
//     } catch (e, stackTrace) {
//       _log.severe('❌ Lỗi không xác định khi lấy người dùng $userId.', e, stackTrace);
//       return const Left(UnknownFailure());
//     }
//   }

//   @override
//   Future<Either<AppUserFailure, void>> followUser({
//     required String targetUserId,
//     required bool isFollowing,
//   }) async {
//     final action = isFollowing ? "theo dõi" : "bỏ theo dõi";
//     _log.info('▶️ Bắt đầu quá trình $action người dùng: $targetUserId.');

//     try {
//       // BƯỚC 1: Lấy ID của người dùng hiện tại và kiểm tra các điều kiện cơ bản
//       final currentUserId = _authService.getCurrentUserId();
//       if (currentUserId == null) {
//         _log.warning('Người dùng chưa đăng nhập. Không thể thực hiện hành động $action.');
//         return const Left(NotAuthenticatedFailure());
//       }

//       if (currentUserId == targetUserId) {
//         _log.warning('Người dùng không thể tự $action chính mình.');
//         return const Left(UnknownFailure(message: 'Bạn không thể tự theo dõi chính mình.'));
//       }

//       // BƯỚC 2: Định nghĩa các đường dẫn tài liệu cần thao tác
//       final currentUserDocPath = '$_usersCollection/$currentUserId';
//       final targetUserDocPath = '$_usersCollection/$targetUserId';

//       // Đường dẫn để lưu danh sách "đang theo dõi" của người dùng hiện tại
//       final followingPath = '$currentUserDocPath/following/$targetUserId';
//       // Đường dẫn để lưu danh sách "người theo dõi" của người dùng mục tiêu
//       final followerPath = '$targetUserDocPath/followers/$currentUserId';

//       // BƯỚC 3: Chuẩn bị danh sách các thao tác cho batch write
//       final List<BatchOperation> operations = [];
//       final incrementValue = isFollowing ? 1 : -1;

//       // Thao tác 1: Cập nhật `followingCount` cho người dùng hiện tại
//       operations.add(BatchOperation.update(
//         path: currentUserDocPath,
//         data: {'followingCount': FieldIncrement(incrementValue)},
//       ));

//       // Thao tác 2: Cập nhật `followerCount` cho người dùng mục tiêu
//       operations.add(BatchOperation.update(
//         path: targetUserDocPath,
//         data: {'followerCount': FieldIncrement(incrementValue)},
//       ));

//       if (isFollowing) {
//         // Thao tác 3 & 4 (khi theo dõi): Tạo các bản ghi quan hệ
//         // Ghi lại rằng `currentUser` đang theo dõi `targetUser`
//         operations.add(BatchOperation.set(
//           path: followingPath,
//           data: {'followedAt': const ServerTimestamp()},
//         ));
//         // Ghi lại rằng `targetUser` có một người theo dõi mới là `currentUser`
//         operations.add(BatchOperation.set(
//           path: followerPath,
//           data: {'followedAt': const ServerTimestamp()},
//         ));
//       } else {
//         // Thao tác 3 & 4 (khi bỏ theo dõi): Xóa các bản ghi quan hệ
//         operations.add(BatchOperation.delete(path: followingPath));
//         operations.add(BatchOperation.delete(path: followerPath));
//       }

//       // BƯỚC 4: Thực thi tất cả các thao tác một cách nguyên tử
//       _log.fine('🔄 Chuẩn bị thực thi batch write cho hành động $action...');
//       await _databaseService.executeBatch(operations);

//       _log.info('✅ Hoàn thành $action người dùng $targetUserId thành công.');
//       return right(null);
//     } on db_exception.NoSqlDatabaseServiceException catch (e, stackTrace) {
//       _log.severe('❌ Lỗi Database Service khi $action người dùng $targetUserId.', e, stackTrace);
//       return Left(DatabaseFailure('Lỗi cơ sở dữ liệu khi $action: ${e.message}'));
//     } catch (e, stackTrace) {
//       _log.severe('❌ Lỗi không xác định khi $action người dùng $targetUserId.', e, stackTrace);
//       return const Left(UnknownFailure());
//     }
//   }

//   @override
//   Future<Either<AppUserFailure, void>> updateProfileAfterSetup({
//     required String userId,
//     required String username,
//     String? displayName,
//     String? photoUrl,
//     String? bio,
//   }) {
//     // TODO: implement completeProfileSetup
//     throw UnimplementedError();
//   }

//   @override
//   Future<Either<AppUserFailure, SignInResult>> signInWithGoogle() {
//     // TODO: implement signInWithGoogle
//     throw UnimplementedError();
//   }
// }
