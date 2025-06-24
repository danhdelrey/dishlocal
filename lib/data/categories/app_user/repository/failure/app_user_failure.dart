import 'package:freezed_annotation/freezed_annotation.dart';
part 'app_user_failure.freezed.dart';

@freezed
sealed class AppUserFailure with _$AppUserFailure {
  const factory AppUserFailure.signInCancelled() = SignInCancelledFailure;
  const factory AppUserFailure.signInServiceFailure(String message) = SignInServiceFailure;
  const factory AppUserFailure.signOutFailure(String message) = SignOutFailure;
  const factory AppUserFailure.userNotFound() = UserNotFoundFailure;
  const factory AppUserFailure.updatePermissionDenied() = UpdatePermissionDeniedFailure;
  const factory AppUserFailure.databaseFailure(String message) = DatabaseFailure;
  const factory AppUserFailure.unknown() = UnknownFailure;
  const factory AppUserFailure.notAuthenticated() = NotAuthenticatedFailure;
}
