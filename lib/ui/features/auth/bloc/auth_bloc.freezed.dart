// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'auth_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$AuthEvent {
  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is AuthEvent);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'AuthEvent()';
  }
}

/// @nodoc
class $AuthEventCopyWith<$Res> {
  $AuthEventCopyWith(AuthEvent _, $Res Function(AuthEvent) __);
}

/// Adds pattern-matching-related methods to [AuthEvent].
extension AuthEventPatterns on AuthEvent {
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
    TResult Function(AuthCheckRequested value)? authCheckRequested,
    TResult Function(SignInWithGoogleRequested value)?
        signInWithGoogleRequested,
    TResult Function(SignedOut value)? signedOut,
    TResult Function(_UserChanged value)? userChanged,
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case AuthCheckRequested() when authCheckRequested != null:
        return authCheckRequested(_that);
      case SignInWithGoogleRequested() when signInWithGoogleRequested != null:
        return signInWithGoogleRequested(_that);
      case SignedOut() when signedOut != null:
        return signedOut(_that);
      case _UserChanged() when userChanged != null:
        return userChanged(_that);
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
    required TResult Function(AuthCheckRequested value) authCheckRequested,
    required TResult Function(SignInWithGoogleRequested value)
        signInWithGoogleRequested,
    required TResult Function(SignedOut value) signedOut,
    required TResult Function(_UserChanged value) userChanged,
  }) {
    final _that = this;
    switch (_that) {
      case AuthCheckRequested():
        return authCheckRequested(_that);
      case SignInWithGoogleRequested():
        return signInWithGoogleRequested(_that);
      case SignedOut():
        return signedOut(_that);
      case _UserChanged():
        return userChanged(_that);
      case _:
        throw StateError('Unexpected subclass');
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
    TResult? Function(AuthCheckRequested value)? authCheckRequested,
    TResult? Function(SignInWithGoogleRequested value)?
        signInWithGoogleRequested,
    TResult? Function(SignedOut value)? signedOut,
    TResult? Function(_UserChanged value)? userChanged,
  }) {
    final _that = this;
    switch (_that) {
      case AuthCheckRequested() when authCheckRequested != null:
        return authCheckRequested(_that);
      case SignInWithGoogleRequested() when signInWithGoogleRequested != null:
        return signInWithGoogleRequested(_that);
      case SignedOut() when signedOut != null:
        return signedOut(_that);
      case _UserChanged() when userChanged != null:
        return userChanged(_that);
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
    TResult Function()? authCheckRequested,
    TResult Function()? signInWithGoogleRequested,
    TResult Function()? signedOut,
    TResult Function(AppUser? user)? userChanged,
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case AuthCheckRequested() when authCheckRequested != null:
        return authCheckRequested();
      case SignInWithGoogleRequested() when signInWithGoogleRequested != null:
        return signInWithGoogleRequested();
      case SignedOut() when signedOut != null:
        return signedOut();
      case _UserChanged() when userChanged != null:
        return userChanged(_that.user);
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
    required TResult Function() authCheckRequested,
    required TResult Function() signInWithGoogleRequested,
    required TResult Function() signedOut,
    required TResult Function(AppUser? user) userChanged,
  }) {
    final _that = this;
    switch (_that) {
      case AuthCheckRequested():
        return authCheckRequested();
      case SignInWithGoogleRequested():
        return signInWithGoogleRequested();
      case SignedOut():
        return signedOut();
      case _UserChanged():
        return userChanged(_that.user);
      case _:
        throw StateError('Unexpected subclass');
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
    TResult? Function()? authCheckRequested,
    TResult? Function()? signInWithGoogleRequested,
    TResult? Function()? signedOut,
    TResult? Function(AppUser? user)? userChanged,
  }) {
    final _that = this;
    switch (_that) {
      case AuthCheckRequested() when authCheckRequested != null:
        return authCheckRequested();
      case SignInWithGoogleRequested() when signInWithGoogleRequested != null:
        return signInWithGoogleRequested();
      case SignedOut() when signedOut != null:
        return signedOut();
      case _UserChanged() when userChanged != null:
        return userChanged(_that.user);
      case _:
        return null;
    }
  }
}

/// @nodoc

class AuthCheckRequested implements AuthEvent {
  const AuthCheckRequested();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is AuthCheckRequested);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'AuthEvent.authCheckRequested()';
  }
}

/// @nodoc

class SignInWithGoogleRequested implements AuthEvent {
  const SignInWithGoogleRequested();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is SignInWithGoogleRequested);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'AuthEvent.signInWithGoogleRequested()';
  }
}

/// @nodoc

class SignedOut implements AuthEvent {
  const SignedOut();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is SignedOut);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'AuthEvent.signedOut()';
  }
}

/// @nodoc

class _UserChanged implements AuthEvent {
  const _UserChanged(this.user);

  final AppUser? user;

  /// Create a copy of AuthEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$UserChangedCopyWith<_UserChanged> get copyWith =>
      __$UserChangedCopyWithImpl<_UserChanged>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _UserChanged &&
            (identical(other.user, user) || other.user == user));
  }

  @override
  int get hashCode => Object.hash(runtimeType, user);

  @override
  String toString() {
    return 'AuthEvent.userChanged(user: $user)';
  }
}

/// @nodoc
abstract mixin class _$UserChangedCopyWith<$Res>
    implements $AuthEventCopyWith<$Res> {
  factory _$UserChangedCopyWith(
          _UserChanged value, $Res Function(_UserChanged) _then) =
      __$UserChangedCopyWithImpl;
  @useResult
  $Res call({AppUser? user});

  $AppUserCopyWith<$Res>? get user;
}

/// @nodoc
class __$UserChangedCopyWithImpl<$Res> implements _$UserChangedCopyWith<$Res> {
  __$UserChangedCopyWithImpl(this._self, this._then);

  final _UserChanged _self;
  final $Res Function(_UserChanged) _then;

  /// Create a copy of AuthEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? user = freezed,
  }) {
    return _then(_UserChanged(
      freezed == user
          ? _self.user
          : user // ignore: cast_nullable_to_non_nullable
              as AppUser?,
    ));
  }

  /// Create a copy of AuthEvent
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $AppUserCopyWith<$Res>? get user {
    if (_self.user == null) {
      return null;
    }

    return $AppUserCopyWith<$Res>(_self.user!, (value) {
      return _then(_self.copyWith(user: value));
    });
  }
}

/// @nodoc
mixin _$AuthState {
  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is AuthState);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'AuthState()';
  }
}

/// @nodoc
class $AuthStateCopyWith<$Res> {
  $AuthStateCopyWith(AuthState _, $Res Function(AuthState) __);
}

/// Adds pattern-matching-related methods to [AuthState].
extension AuthStatePatterns on AuthState {
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
    TResult Function(Initial value)? initial,
    TResult Function(InProgress value)? inProgress,
    TResult Function(Authenticated value)? authenticated,
    TResult Function(Unauthenticated value)? unauthenticated,
    TResult Function(NewUser value)? newUser,
    TResult Function(Failure value)? failure,
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case Initial() when initial != null:
        return initial(_that);
      case InProgress() when inProgress != null:
        return inProgress(_that);
      case Authenticated() when authenticated != null:
        return authenticated(_that);
      case Unauthenticated() when unauthenticated != null:
        return unauthenticated(_that);
      case NewUser() when newUser != null:
        return newUser(_that);
      case Failure() when failure != null:
        return failure(_that);
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
    required TResult Function(Initial value) initial,
    required TResult Function(InProgress value) inProgress,
    required TResult Function(Authenticated value) authenticated,
    required TResult Function(Unauthenticated value) unauthenticated,
    required TResult Function(NewUser value) newUser,
    required TResult Function(Failure value) failure,
  }) {
    final _that = this;
    switch (_that) {
      case Initial():
        return initial(_that);
      case InProgress():
        return inProgress(_that);
      case Authenticated():
        return authenticated(_that);
      case Unauthenticated():
        return unauthenticated(_that);
      case NewUser():
        return newUser(_that);
      case Failure():
        return failure(_that);
      case _:
        throw StateError('Unexpected subclass');
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
    TResult? Function(Initial value)? initial,
    TResult? Function(InProgress value)? inProgress,
    TResult? Function(Authenticated value)? authenticated,
    TResult? Function(Unauthenticated value)? unauthenticated,
    TResult? Function(NewUser value)? newUser,
    TResult? Function(Failure value)? failure,
  }) {
    final _that = this;
    switch (_that) {
      case Initial() when initial != null:
        return initial(_that);
      case InProgress() when inProgress != null:
        return inProgress(_that);
      case Authenticated() when authenticated != null:
        return authenticated(_that);
      case Unauthenticated() when unauthenticated != null:
        return unauthenticated(_that);
      case NewUser() when newUser != null:
        return newUser(_that);
      case Failure() when failure != null:
        return failure(_that);
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
    TResult Function()? initial,
    TResult Function()? inProgress,
    TResult Function(AppUser user)? authenticated,
    TResult Function()? unauthenticated,
    TResult Function(AppUser user)? newUser,
    TResult Function(AppUserFailure failure)? failure,
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case Initial() when initial != null:
        return initial();
      case InProgress() when inProgress != null:
        return inProgress();
      case Authenticated() when authenticated != null:
        return authenticated(_that.user);
      case Unauthenticated() when unauthenticated != null:
        return unauthenticated();
      case NewUser() when newUser != null:
        return newUser(_that.user);
      case Failure() when failure != null:
        return failure(_that.failure);
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
    required TResult Function() initial,
    required TResult Function() inProgress,
    required TResult Function(AppUser user) authenticated,
    required TResult Function() unauthenticated,
    required TResult Function(AppUser user) newUser,
    required TResult Function(AppUserFailure failure) failure,
  }) {
    final _that = this;
    switch (_that) {
      case Initial():
        return initial();
      case InProgress():
        return inProgress();
      case Authenticated():
        return authenticated(_that.user);
      case Unauthenticated():
        return unauthenticated();
      case NewUser():
        return newUser(_that.user);
      case Failure():
        return failure(_that.failure);
      case _:
        throw StateError('Unexpected subclass');
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
    TResult? Function()? initial,
    TResult? Function()? inProgress,
    TResult? Function(AppUser user)? authenticated,
    TResult? Function()? unauthenticated,
    TResult? Function(AppUser user)? newUser,
    TResult? Function(AppUserFailure failure)? failure,
  }) {
    final _that = this;
    switch (_that) {
      case Initial() when initial != null:
        return initial();
      case InProgress() when inProgress != null:
        return inProgress();
      case Authenticated() when authenticated != null:
        return authenticated(_that.user);
      case Unauthenticated() when unauthenticated != null:
        return unauthenticated();
      case NewUser() when newUser != null:
        return newUser(_that.user);
      case Failure() when failure != null:
        return failure(_that.failure);
      case _:
        return null;
    }
  }
}

/// @nodoc

class Initial implements AuthState {
  const Initial();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is Initial);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'AuthState.initial()';
  }
}

/// @nodoc

class InProgress implements AuthState {
  const InProgress();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is InProgress);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'AuthState.inProgress()';
  }
}

/// @nodoc

class Authenticated implements AuthState {
  const Authenticated(this.user);

  final AppUser user;

  /// Create a copy of AuthState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $AuthenticatedCopyWith<Authenticated> get copyWith =>
      _$AuthenticatedCopyWithImpl<Authenticated>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is Authenticated &&
            (identical(other.user, user) || other.user == user));
  }

  @override
  int get hashCode => Object.hash(runtimeType, user);

  @override
  String toString() {
    return 'AuthState.authenticated(user: $user)';
  }
}

/// @nodoc
abstract mixin class $AuthenticatedCopyWith<$Res>
    implements $AuthStateCopyWith<$Res> {
  factory $AuthenticatedCopyWith(
          Authenticated value, $Res Function(Authenticated) _then) =
      _$AuthenticatedCopyWithImpl;
  @useResult
  $Res call({AppUser user});

  $AppUserCopyWith<$Res> get user;
}

/// @nodoc
class _$AuthenticatedCopyWithImpl<$Res>
    implements $AuthenticatedCopyWith<$Res> {
  _$AuthenticatedCopyWithImpl(this._self, this._then);

  final Authenticated _self;
  final $Res Function(Authenticated) _then;

  /// Create a copy of AuthState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? user = null,
  }) {
    return _then(Authenticated(
      null == user
          ? _self.user
          : user // ignore: cast_nullable_to_non_nullable
              as AppUser,
    ));
  }

  /// Create a copy of AuthState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $AppUserCopyWith<$Res> get user {
    return $AppUserCopyWith<$Res>(_self.user, (value) {
      return _then(_self.copyWith(user: value));
    });
  }
}

/// @nodoc

class Unauthenticated implements AuthState {
  const Unauthenticated();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is Unauthenticated);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'AuthState.unauthenticated()';
  }
}

/// @nodoc

class NewUser implements AuthState {
  const NewUser(this.user);

  final AppUser user;

  /// Create a copy of AuthState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $NewUserCopyWith<NewUser> get copyWith =>
      _$NewUserCopyWithImpl<NewUser>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is NewUser &&
            (identical(other.user, user) || other.user == user));
  }

  @override
  int get hashCode => Object.hash(runtimeType, user);

  @override
  String toString() {
    return 'AuthState.newUser(user: $user)';
  }
}

/// @nodoc
abstract mixin class $NewUserCopyWith<$Res>
    implements $AuthStateCopyWith<$Res> {
  factory $NewUserCopyWith(NewUser value, $Res Function(NewUser) _then) =
      _$NewUserCopyWithImpl;
  @useResult
  $Res call({AppUser user});

  $AppUserCopyWith<$Res> get user;
}

/// @nodoc
class _$NewUserCopyWithImpl<$Res> implements $NewUserCopyWith<$Res> {
  _$NewUserCopyWithImpl(this._self, this._then);

  final NewUser _self;
  final $Res Function(NewUser) _then;

  /// Create a copy of AuthState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? user = null,
  }) {
    return _then(NewUser(
      null == user
          ? _self.user
          : user // ignore: cast_nullable_to_non_nullable
              as AppUser,
    ));
  }

  /// Create a copy of AuthState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $AppUserCopyWith<$Res> get user {
    return $AppUserCopyWith<$Res>(_self.user, (value) {
      return _then(_self.copyWith(user: value));
    });
  }
}

/// @nodoc

class Failure implements AuthState {
  const Failure(this.failure);

  final AppUserFailure failure;

  /// Create a copy of AuthState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $FailureCopyWith<Failure> get copyWith =>
      _$FailureCopyWithImpl<Failure>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is Failure &&
            (identical(other.failure, failure) || other.failure == failure));
  }

  @override
  int get hashCode => Object.hash(runtimeType, failure);

  @override
  String toString() {
    return 'AuthState.failure(failure: $failure)';
  }
}

/// @nodoc
abstract mixin class $FailureCopyWith<$Res>
    implements $AuthStateCopyWith<$Res> {
  factory $FailureCopyWith(Failure value, $Res Function(Failure) _then) =
      _$FailureCopyWithImpl;
  @useResult
  $Res call({AppUserFailure failure});

  $AppUserFailureCopyWith<$Res> get failure;
}

/// @nodoc
class _$FailureCopyWithImpl<$Res> implements $FailureCopyWith<$Res> {
  _$FailureCopyWithImpl(this._self, this._then);

  final Failure _self;
  final $Res Function(Failure) _then;

  /// Create a copy of AuthState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? failure = null,
  }) {
    return _then(Failure(
      null == failure
          ? _self.failure
          : failure // ignore: cast_nullable_to_non_nullable
              as AppUserFailure,
    ));
  }

  /// Create a copy of AuthState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $AppUserFailureCopyWith<$Res> get failure {
    return $AppUserFailureCopyWith<$Res>(_self.failure, (value) {
      return _then(_self.copyWith(failure: value));
    });
  }
}

// dart format on
