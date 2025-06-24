// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'app_user_failure.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$AppUserFailure {
  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is AppUserFailure);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'AppUserFailure()';
  }
}

/// @nodoc
class $AppUserFailureCopyWith<$Res> {
  $AppUserFailureCopyWith(AppUserFailure _, $Res Function(AppUserFailure) __);
}

/// @nodoc

class SignInCancelledFailure implements AppUserFailure {
  const SignInCancelledFailure();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is SignInCancelledFailure);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'AppUserFailure.signInCancelled()';
  }
}

/// @nodoc

class SignInServiceFailure implements AppUserFailure {
  const SignInServiceFailure(this.message);

  final String message;

  /// Create a copy of AppUserFailure
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $SignInServiceFailureCopyWith<SignInServiceFailure> get copyWith =>
      _$SignInServiceFailureCopyWithImpl<SignInServiceFailure>(
          this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is SignInServiceFailure &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message);

  @override
  String toString() {
    return 'AppUserFailure.signInServiceFailure(message: $message)';
  }
}

/// @nodoc
abstract mixin class $SignInServiceFailureCopyWith<$Res>
    implements $AppUserFailureCopyWith<$Res> {
  factory $SignInServiceFailureCopyWith(SignInServiceFailure value,
          $Res Function(SignInServiceFailure) _then) =
      _$SignInServiceFailureCopyWithImpl;
  @useResult
  $Res call({String message});
}

/// @nodoc
class _$SignInServiceFailureCopyWithImpl<$Res>
    implements $SignInServiceFailureCopyWith<$Res> {
  _$SignInServiceFailureCopyWithImpl(this._self, this._then);

  final SignInServiceFailure _self;
  final $Res Function(SignInServiceFailure) _then;

  /// Create a copy of AppUserFailure
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? message = null,
  }) {
    return _then(SignInServiceFailure(
      null == message
          ? _self.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class SignOutFailure implements AppUserFailure {
  const SignOutFailure(this.message);

  final String message;

  /// Create a copy of AppUserFailure
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $SignOutFailureCopyWith<SignOutFailure> get copyWith =>
      _$SignOutFailureCopyWithImpl<SignOutFailure>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is SignOutFailure &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message);

  @override
  String toString() {
    return 'AppUserFailure.signOutFailure(message: $message)';
  }
}

/// @nodoc
abstract mixin class $SignOutFailureCopyWith<$Res>
    implements $AppUserFailureCopyWith<$Res> {
  factory $SignOutFailureCopyWith(
          SignOutFailure value, $Res Function(SignOutFailure) _then) =
      _$SignOutFailureCopyWithImpl;
  @useResult
  $Res call({String message});
}

/// @nodoc
class _$SignOutFailureCopyWithImpl<$Res>
    implements $SignOutFailureCopyWith<$Res> {
  _$SignOutFailureCopyWithImpl(this._self, this._then);

  final SignOutFailure _self;
  final $Res Function(SignOutFailure) _then;

  /// Create a copy of AppUserFailure
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? message = null,
  }) {
    return _then(SignOutFailure(
      null == message
          ? _self.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class UserNotFoundFailure implements AppUserFailure {
  const UserNotFoundFailure();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is UserNotFoundFailure);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'AppUserFailure.userNotFound()';
  }
}

/// @nodoc

class UpdatePermissionDeniedFailure implements AppUserFailure {
  const UpdatePermissionDeniedFailure();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is UpdatePermissionDeniedFailure);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'AppUserFailure.updatePermissionDenied()';
  }
}

/// @nodoc

class DatabaseFailure implements AppUserFailure {
  const DatabaseFailure(this.message);

  final String message;

  /// Create a copy of AppUserFailure
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $DatabaseFailureCopyWith<DatabaseFailure> get copyWith =>
      _$DatabaseFailureCopyWithImpl<DatabaseFailure>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is DatabaseFailure &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message);

  @override
  String toString() {
    return 'AppUserFailure.databaseFailure(message: $message)';
  }
}

/// @nodoc
abstract mixin class $DatabaseFailureCopyWith<$Res>
    implements $AppUserFailureCopyWith<$Res> {
  factory $DatabaseFailureCopyWith(
          DatabaseFailure value, $Res Function(DatabaseFailure) _then) =
      _$DatabaseFailureCopyWithImpl;
  @useResult
  $Res call({String message});
}

/// @nodoc
class _$DatabaseFailureCopyWithImpl<$Res>
    implements $DatabaseFailureCopyWith<$Res> {
  _$DatabaseFailureCopyWithImpl(this._self, this._then);

  final DatabaseFailure _self;
  final $Res Function(DatabaseFailure) _then;

  /// Create a copy of AppUserFailure
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? message = null,
  }) {
    return _then(DatabaseFailure(
      null == message
          ? _self.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class UnknownFailure implements AppUserFailure {
  const UnknownFailure();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is UnknownFailure);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'AppUserFailure.unknown()';
  }
}

/// @nodoc

class NotAuthenticatedFailure implements AppUserFailure {
  const NotAuthenticatedFailure();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is NotAuthenticatedFailure);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'AppUserFailure.notAuthenticated()';
  }
}

// dart format on
