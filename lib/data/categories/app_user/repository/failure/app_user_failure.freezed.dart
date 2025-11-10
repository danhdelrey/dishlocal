// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
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

/// Adds pattern-matching-related methods to [AppUserFailure].
extension AppUserFailurePatterns on AppUserFailure {
  /// A variant of `map` that fallback to returning `orElse`.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case _:
  ///     return orElse();
  /// }
  /// ```

  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(SignInCancelledFailure value)? signInCancelled,
    TResult Function(SignInServiceFailure value)? signInServiceFailure,
    TResult Function(SignOutFailure value)? signOutFailure,
    TResult Function(UserNotFoundFailure value)? userNotFound,
    TResult Function(UpdatePermissionDeniedFailure value)?
        updatePermissionDenied,
    TResult Function(DatabaseFailure value)? databaseFailure,
    TResult Function(NotAuthenticatedFailure value)? notAuthenticated,
    TResult Function(UnknownFailure value)? unknown,
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case SignInCancelledFailure() when signInCancelled != null:
        return signInCancelled(_that);
      case SignInServiceFailure() when signInServiceFailure != null:
        return signInServiceFailure(_that);
      case SignOutFailure() when signOutFailure != null:
        return signOutFailure(_that);
      case UserNotFoundFailure() when userNotFound != null:
        return userNotFound(_that);
      case UpdatePermissionDeniedFailure() when updatePermissionDenied != null:
        return updatePermissionDenied(_that);
      case DatabaseFailure() when databaseFailure != null:
        return databaseFailure(_that);
      case NotAuthenticatedFailure() when notAuthenticated != null:
        return notAuthenticated(_that);
      case UnknownFailure() when unknown != null:
        return unknown(_that);
      case _:
        return orElse();
    }
  }

  /// A `switch`-like method, using callbacks.
  ///
  /// Callbacks receives the raw object, upcasted.
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case final Subclass2 value:
  ///     return ...;
  /// }
  /// ```

  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(SignInCancelledFailure value) signInCancelled,
    required TResult Function(SignInServiceFailure value) signInServiceFailure,
    required TResult Function(SignOutFailure value) signOutFailure,
    required TResult Function(UserNotFoundFailure value) userNotFound,
    required TResult Function(UpdatePermissionDeniedFailure value)
        updatePermissionDenied,
    required TResult Function(DatabaseFailure value) databaseFailure,
    required TResult Function(NotAuthenticatedFailure value) notAuthenticated,
    required TResult Function(UnknownFailure value) unknown,
  }) {
    final _that = this;
    switch (_that) {
      case SignInCancelledFailure():
        return signInCancelled(_that);
      case SignInServiceFailure():
        return signInServiceFailure(_that);
      case SignOutFailure():
        return signOutFailure(_that);
      case UserNotFoundFailure():
        return userNotFound(_that);
      case UpdatePermissionDeniedFailure():
        return updatePermissionDenied(_that);
      case DatabaseFailure():
        return databaseFailure(_that);
      case NotAuthenticatedFailure():
        return notAuthenticated(_that);
      case UnknownFailure():
        return unknown(_that);
    }
  }

  /// A variant of `map` that fallback to returning `null`.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case _:
  ///     return null;
  /// }
  /// ```

  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(SignInCancelledFailure value)? signInCancelled,
    TResult? Function(SignInServiceFailure value)? signInServiceFailure,
    TResult? Function(SignOutFailure value)? signOutFailure,
    TResult? Function(UserNotFoundFailure value)? userNotFound,
    TResult? Function(UpdatePermissionDeniedFailure value)?
        updatePermissionDenied,
    TResult? Function(DatabaseFailure value)? databaseFailure,
    TResult? Function(NotAuthenticatedFailure value)? notAuthenticated,
    TResult? Function(UnknownFailure value)? unknown,
  }) {
    final _that = this;
    switch (_that) {
      case SignInCancelledFailure() when signInCancelled != null:
        return signInCancelled(_that);
      case SignInServiceFailure() when signInServiceFailure != null:
        return signInServiceFailure(_that);
      case SignOutFailure() when signOutFailure != null:
        return signOutFailure(_that);
      case UserNotFoundFailure() when userNotFound != null:
        return userNotFound(_that);
      case UpdatePermissionDeniedFailure() when updatePermissionDenied != null:
        return updatePermissionDenied(_that);
      case DatabaseFailure() when databaseFailure != null:
        return databaseFailure(_that);
      case NotAuthenticatedFailure() when notAuthenticated != null:
        return notAuthenticated(_that);
      case UnknownFailure() when unknown != null:
        return unknown(_that);
      case _:
        return null;
    }
  }

  /// A variant of `when` that fallback to an `orElse` callback.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case _:
  ///     return orElse();
  /// }
  /// ```

  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? signInCancelled,
    TResult Function(String message)? signInServiceFailure,
    TResult Function(String message)? signOutFailure,
    TResult Function()? userNotFound,
    TResult Function()? updatePermissionDenied,
    TResult Function(String message)? databaseFailure,
    TResult Function()? notAuthenticated,
    TResult Function()? unknown,
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case SignInCancelledFailure() when signInCancelled != null:
        return signInCancelled();
      case SignInServiceFailure() when signInServiceFailure != null:
        return signInServiceFailure(_that.message);
      case SignOutFailure() when signOutFailure != null:
        return signOutFailure(_that.message);
      case UserNotFoundFailure() when userNotFound != null:
        return userNotFound();
      case UpdatePermissionDeniedFailure() when updatePermissionDenied != null:
        return updatePermissionDenied();
      case DatabaseFailure() when databaseFailure != null:
        return databaseFailure(_that.message);
      case NotAuthenticatedFailure() when notAuthenticated != null:
        return notAuthenticated();
      case UnknownFailure() when unknown != null:
        return unknown();
      case _:
        return orElse();
    }
  }

  /// A `switch`-like method, using callbacks.
  ///
  /// As opposed to `map`, this offers destructuring.
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case Subclass2(:final field2):
  ///     return ...;
  /// }
  /// ```

  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() signInCancelled,
    required TResult Function(String message) signInServiceFailure,
    required TResult Function(String message) signOutFailure,
    required TResult Function() userNotFound,
    required TResult Function() updatePermissionDenied,
    required TResult Function(String message) databaseFailure,
    required TResult Function() notAuthenticated,
    required TResult Function() unknown,
  }) {
    final _that = this;
    switch (_that) {
      case SignInCancelledFailure():
        return signInCancelled();
      case SignInServiceFailure():
        return signInServiceFailure(_that.message);
      case SignOutFailure():
        return signOutFailure(_that.message);
      case UserNotFoundFailure():
        return userNotFound();
      case UpdatePermissionDeniedFailure():
        return updatePermissionDenied();
      case DatabaseFailure():
        return databaseFailure(_that.message);
      case NotAuthenticatedFailure():
        return notAuthenticated();
      case UnknownFailure():
        return unknown();
    }
  }

  /// A variant of `when` that fallback to returning `null`
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case _:
  ///     return null;
  /// }
  /// ```

  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? signInCancelled,
    TResult? Function(String message)? signInServiceFailure,
    TResult? Function(String message)? signOutFailure,
    TResult? Function()? userNotFound,
    TResult? Function()? updatePermissionDenied,
    TResult? Function(String message)? databaseFailure,
    TResult? Function()? notAuthenticated,
    TResult? Function()? unknown,
  }) {
    final _that = this;
    switch (_that) {
      case SignInCancelledFailure() when signInCancelled != null:
        return signInCancelled();
      case SignInServiceFailure() when signInServiceFailure != null:
        return signInServiceFailure(_that.message);
      case SignOutFailure() when signOutFailure != null:
        return signOutFailure(_that.message);
      case UserNotFoundFailure() when userNotFound != null:
        return userNotFound();
      case UpdatePermissionDeniedFailure() when updatePermissionDenied != null:
        return updatePermissionDenied();
      case DatabaseFailure() when databaseFailure != null:
        return databaseFailure(_that.message);
      case NotAuthenticatedFailure() when notAuthenticated != null:
        return notAuthenticated();
      case UnknownFailure() when unknown != null:
        return unknown();
      case _:
        return null;
    }
  }
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

// dart format on
