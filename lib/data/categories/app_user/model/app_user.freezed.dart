// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'app_user.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$AppUser {
  /// Sửa lỗi: Sử dụng @JsonKey để khớp với cột 'id' trả về từ RPC.
  @JsonKey(name: 'id')
  String get userId;

  /// Sửa lỗi: `email` không có trong RPC, nó được thêm vào sau.
  /// Do đó, nó phải là tùy chọn trong `fromJson`.
  String? get email;

  /// `username` có thể null nếu chưa hoàn tất setup.
  String? get username;

  /// `displayName` có thể null.
  String? get displayName;

  /// Sửa lỗi: Đây là trường chỉ dùng trong UI, không nên là `required`.
  /// Nó sẽ được khởi tạo từ `displayName`.
  String? get originalDisplayname;
  String? get photoUrl;
  String? get bio;
  int get postCount;
  int get likeCount;
  int get followerCount;
  int get followingCount;
  bool? get isFollowing;
  List<String>? get fcmTokens;
  bool get isSetupCompleted;

  /// Create a copy of AppUser
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $AppUserCopyWith<AppUser> get copyWith =>
      _$AppUserCopyWithImpl<AppUser>(this as AppUser, _$identity);

  /// Serializes this AppUser to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is AppUser &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.username, username) ||
                other.username == username) &&
            (identical(other.displayName, displayName) ||
                other.displayName == displayName) &&
            (identical(other.originalDisplayname, originalDisplayname) ||
                other.originalDisplayname == originalDisplayname) &&
            (identical(other.photoUrl, photoUrl) ||
                other.photoUrl == photoUrl) &&
            (identical(other.bio, bio) || other.bio == bio) &&
            (identical(other.postCount, postCount) ||
                other.postCount == postCount) &&
            (identical(other.likeCount, likeCount) ||
                other.likeCount == likeCount) &&
            (identical(other.followerCount, followerCount) ||
                other.followerCount == followerCount) &&
            (identical(other.followingCount, followingCount) ||
                other.followingCount == followingCount) &&
            (identical(other.isFollowing, isFollowing) ||
                other.isFollowing == isFollowing) &&
            const DeepCollectionEquality().equals(other.fcmTokens, fcmTokens) &&
            (identical(other.isSetupCompleted, isSetupCompleted) ||
                other.isSetupCompleted == isSetupCompleted));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      userId,
      email,
      username,
      displayName,
      originalDisplayname,
      photoUrl,
      bio,
      postCount,
      likeCount,
      followerCount,
      followingCount,
      isFollowing,
      const DeepCollectionEquality().hash(fcmTokens),
      isSetupCompleted);

  @override
  String toString() {
    return 'AppUser(userId: $userId, email: $email, username: $username, displayName: $displayName, originalDisplayname: $originalDisplayname, photoUrl: $photoUrl, bio: $bio, postCount: $postCount, likeCount: $likeCount, followerCount: $followerCount, followingCount: $followingCount, isFollowing: $isFollowing, fcmTokens: $fcmTokens, isSetupCompleted: $isSetupCompleted)';
  }
}

/// @nodoc
abstract mixin class $AppUserCopyWith<$Res> {
  factory $AppUserCopyWith(AppUser value, $Res Function(AppUser) _then) =
      _$AppUserCopyWithImpl;
  @useResult
  $Res call(
      {@JsonKey(name: 'id') String userId,
      String? email,
      String? username,
      String? displayName,
      String? originalDisplayname,
      String? photoUrl,
      String? bio,
      int postCount,
      int likeCount,
      int followerCount,
      int followingCount,
      bool? isFollowing,
      List<String>? fcmTokens,
      bool isSetupCompleted});
}

/// @nodoc
class _$AppUserCopyWithImpl<$Res> implements $AppUserCopyWith<$Res> {
  _$AppUserCopyWithImpl(this._self, this._then);

  final AppUser _self;
  final $Res Function(AppUser) _then;

  /// Create a copy of AppUser
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userId = null,
    Object? email = freezed,
    Object? username = freezed,
    Object? displayName = freezed,
    Object? originalDisplayname = freezed,
    Object? photoUrl = freezed,
    Object? bio = freezed,
    Object? postCount = null,
    Object? likeCount = null,
    Object? followerCount = null,
    Object? followingCount = null,
    Object? isFollowing = freezed,
    Object? fcmTokens = freezed,
    Object? isSetupCompleted = null,
  }) {
    return _then(_self.copyWith(
      userId: null == userId
          ? _self.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      email: freezed == email
          ? _self.email
          : email // ignore: cast_nullable_to_non_nullable
              as String?,
      username: freezed == username
          ? _self.username
          : username // ignore: cast_nullable_to_non_nullable
              as String?,
      displayName: freezed == displayName
          ? _self.displayName
          : displayName // ignore: cast_nullable_to_non_nullable
              as String?,
      originalDisplayname: freezed == originalDisplayname
          ? _self.originalDisplayname
          : originalDisplayname // ignore: cast_nullable_to_non_nullable
              as String?,
      photoUrl: freezed == photoUrl
          ? _self.photoUrl
          : photoUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      bio: freezed == bio
          ? _self.bio
          : bio // ignore: cast_nullable_to_non_nullable
              as String?,
      postCount: null == postCount
          ? _self.postCount
          : postCount // ignore: cast_nullable_to_non_nullable
              as int,
      likeCount: null == likeCount
          ? _self.likeCount
          : likeCount // ignore: cast_nullable_to_non_nullable
              as int,
      followerCount: null == followerCount
          ? _self.followerCount
          : followerCount // ignore: cast_nullable_to_non_nullable
              as int,
      followingCount: null == followingCount
          ? _self.followingCount
          : followingCount // ignore: cast_nullable_to_non_nullable
              as int,
      isFollowing: freezed == isFollowing
          ? _self.isFollowing
          : isFollowing // ignore: cast_nullable_to_non_nullable
              as bool?,
      fcmTokens: freezed == fcmTokens
          ? _self.fcmTokens
          : fcmTokens // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      isSetupCompleted: null == isSetupCompleted
          ? _self.isSetupCompleted
          : isSetupCompleted // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// Adds pattern-matching-related methods to [AppUser].
extension AppUserPatterns on AppUser {
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
  TResult maybeMap<TResult extends Object?>(
    TResult Function(_AppUser value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _AppUser() when $default != null:
        return $default(_that);
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
  TResult map<TResult extends Object?>(
    TResult Function(_AppUser value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _AppUser():
        return $default(_that);
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
  TResult? mapOrNull<TResult extends Object?>(
    TResult? Function(_AppUser value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _AppUser() when $default != null:
        return $default(_that);
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
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(
            @JsonKey(name: 'id') String userId,
            String? email,
            String? username,
            String? displayName,
            String? originalDisplayname,
            String? photoUrl,
            String? bio,
            int postCount,
            int likeCount,
            int followerCount,
            int followingCount,
            bool? isFollowing,
            List<String>? fcmTokens,
            bool isSetupCompleted)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _AppUser() when $default != null:
        return $default(
            _that.userId,
            _that.email,
            _that.username,
            _that.displayName,
            _that.originalDisplayname,
            _that.photoUrl,
            _that.bio,
            _that.postCount,
            _that.likeCount,
            _that.followerCount,
            _that.followingCount,
            _that.isFollowing,
            _that.fcmTokens,
            _that.isSetupCompleted);
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
  TResult when<TResult extends Object?>(
    TResult Function(
            @JsonKey(name: 'id') String userId,
            String? email,
            String? username,
            String? displayName,
            String? originalDisplayname,
            String? photoUrl,
            String? bio,
            int postCount,
            int likeCount,
            int followerCount,
            int followingCount,
            bool? isFollowing,
            List<String>? fcmTokens,
            bool isSetupCompleted)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _AppUser():
        return $default(
            _that.userId,
            _that.email,
            _that.username,
            _that.displayName,
            _that.originalDisplayname,
            _that.photoUrl,
            _that.bio,
            _that.postCount,
            _that.likeCount,
            _that.followerCount,
            _that.followingCount,
            _that.isFollowing,
            _that.fcmTokens,
            _that.isSetupCompleted);
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
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function(
            @JsonKey(name: 'id') String userId,
            String? email,
            String? username,
            String? displayName,
            String? originalDisplayname,
            String? photoUrl,
            String? bio,
            int postCount,
            int likeCount,
            int followerCount,
            int followingCount,
            bool? isFollowing,
            List<String>? fcmTokens,
            bool isSetupCompleted)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _AppUser() when $default != null:
        return $default(
            _that.userId,
            _that.email,
            _that.username,
            _that.displayName,
            _that.originalDisplayname,
            _that.photoUrl,
            _that.bio,
            _that.postCount,
            _that.likeCount,
            _that.followerCount,
            _that.followingCount,
            _that.isFollowing,
            _that.fcmTokens,
            _that.isSetupCompleted);
      case _:
        return null;
    }
  }
}

/// @nodoc

@JsonSerializable(fieldRename: FieldRename.snake)
class _AppUser implements AppUser {
  const _AppUser(
      {@JsonKey(name: 'id') required this.userId,
      this.email,
      this.username,
      this.displayName,
      this.originalDisplayname,
      this.photoUrl,
      this.bio,
      this.postCount = 0,
      this.likeCount = 0,
      this.followerCount = 0,
      this.followingCount = 0,
      this.isFollowing,
      final List<String>? fcmTokens,
      this.isSetupCompleted = false})
      : _fcmTokens = fcmTokens;
  factory _AppUser.fromJson(Map<String, dynamic> json) =>
      _$AppUserFromJson(json);

  /// Sửa lỗi: Sử dụng @JsonKey để khớp với cột 'id' trả về từ RPC.
  @override
  @JsonKey(name: 'id')
  final String userId;

  /// Sửa lỗi: `email` không có trong RPC, nó được thêm vào sau.
  /// Do đó, nó phải là tùy chọn trong `fromJson`.
  @override
  final String? email;

  /// `username` có thể null nếu chưa hoàn tất setup.
  @override
  final String? username;

  /// `displayName` có thể null.
  @override
  final String? displayName;

  /// Sửa lỗi: Đây là trường chỉ dùng trong UI, không nên là `required`.
  /// Nó sẽ được khởi tạo từ `displayName`.
  @override
  final String? originalDisplayname;
  @override
  final String? photoUrl;
  @override
  final String? bio;
  @override
  @JsonKey()
  final int postCount;
  @override
  @JsonKey()
  final int likeCount;
  @override
  @JsonKey()
  final int followerCount;
  @override
  @JsonKey()
  final int followingCount;
  @override
  final bool? isFollowing;
  final List<String>? _fcmTokens;
  @override
  List<String>? get fcmTokens {
    final value = _fcmTokens;
    if (value == null) return null;
    if (_fcmTokens is EqualUnmodifiableListView) return _fcmTokens;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  @JsonKey()
  final bool isSetupCompleted;

  /// Create a copy of AppUser
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$AppUserCopyWith<_AppUser> get copyWith =>
      __$AppUserCopyWithImpl<_AppUser>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$AppUserToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _AppUser &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.username, username) ||
                other.username == username) &&
            (identical(other.displayName, displayName) ||
                other.displayName == displayName) &&
            (identical(other.originalDisplayname, originalDisplayname) ||
                other.originalDisplayname == originalDisplayname) &&
            (identical(other.photoUrl, photoUrl) ||
                other.photoUrl == photoUrl) &&
            (identical(other.bio, bio) || other.bio == bio) &&
            (identical(other.postCount, postCount) ||
                other.postCount == postCount) &&
            (identical(other.likeCount, likeCount) ||
                other.likeCount == likeCount) &&
            (identical(other.followerCount, followerCount) ||
                other.followerCount == followerCount) &&
            (identical(other.followingCount, followingCount) ||
                other.followingCount == followingCount) &&
            (identical(other.isFollowing, isFollowing) ||
                other.isFollowing == isFollowing) &&
            const DeepCollectionEquality()
                .equals(other._fcmTokens, _fcmTokens) &&
            (identical(other.isSetupCompleted, isSetupCompleted) ||
                other.isSetupCompleted == isSetupCompleted));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      userId,
      email,
      username,
      displayName,
      originalDisplayname,
      photoUrl,
      bio,
      postCount,
      likeCount,
      followerCount,
      followingCount,
      isFollowing,
      const DeepCollectionEquality().hash(_fcmTokens),
      isSetupCompleted);

  @override
  String toString() {
    return 'AppUser(userId: $userId, email: $email, username: $username, displayName: $displayName, originalDisplayname: $originalDisplayname, photoUrl: $photoUrl, bio: $bio, postCount: $postCount, likeCount: $likeCount, followerCount: $followerCount, followingCount: $followingCount, isFollowing: $isFollowing, fcmTokens: $fcmTokens, isSetupCompleted: $isSetupCompleted)';
  }
}

/// @nodoc
abstract mixin class _$AppUserCopyWith<$Res> implements $AppUserCopyWith<$Res> {
  factory _$AppUserCopyWith(_AppUser value, $Res Function(_AppUser) _then) =
      __$AppUserCopyWithImpl;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'id') String userId,
      String? email,
      String? username,
      String? displayName,
      String? originalDisplayname,
      String? photoUrl,
      String? bio,
      int postCount,
      int likeCount,
      int followerCount,
      int followingCount,
      bool? isFollowing,
      List<String>? fcmTokens,
      bool isSetupCompleted});
}

/// @nodoc
class __$AppUserCopyWithImpl<$Res> implements _$AppUserCopyWith<$Res> {
  __$AppUserCopyWithImpl(this._self, this._then);

  final _AppUser _self;
  final $Res Function(_AppUser) _then;

  /// Create a copy of AppUser
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? userId = null,
    Object? email = freezed,
    Object? username = freezed,
    Object? displayName = freezed,
    Object? originalDisplayname = freezed,
    Object? photoUrl = freezed,
    Object? bio = freezed,
    Object? postCount = null,
    Object? likeCount = null,
    Object? followerCount = null,
    Object? followingCount = null,
    Object? isFollowing = freezed,
    Object? fcmTokens = freezed,
    Object? isSetupCompleted = null,
  }) {
    return _then(_AppUser(
      userId: null == userId
          ? _self.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      email: freezed == email
          ? _self.email
          : email // ignore: cast_nullable_to_non_nullable
              as String?,
      username: freezed == username
          ? _self.username
          : username // ignore: cast_nullable_to_non_nullable
              as String?,
      displayName: freezed == displayName
          ? _self.displayName
          : displayName // ignore: cast_nullable_to_non_nullable
              as String?,
      originalDisplayname: freezed == originalDisplayname
          ? _self.originalDisplayname
          : originalDisplayname // ignore: cast_nullable_to_non_nullable
              as String?,
      photoUrl: freezed == photoUrl
          ? _self.photoUrl
          : photoUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      bio: freezed == bio
          ? _self.bio
          : bio // ignore: cast_nullable_to_non_nullable
              as String?,
      postCount: null == postCount
          ? _self.postCount
          : postCount // ignore: cast_nullable_to_non_nullable
              as int,
      likeCount: null == likeCount
          ? _self.likeCount
          : likeCount // ignore: cast_nullable_to_non_nullable
              as int,
      followerCount: null == followerCount
          ? _self.followerCount
          : followerCount // ignore: cast_nullable_to_non_nullable
              as int,
      followingCount: null == followingCount
          ? _self.followingCount
          : followingCount // ignore: cast_nullable_to_non_nullable
              as int,
      isFollowing: freezed == isFollowing
          ? _self.isFollowing
          : isFollowing // ignore: cast_nullable_to_non_nullable
              as bool?,
      fcmTokens: freezed == fcmTokens
          ? _self._fcmTokens
          : fcmTokens // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      isSetupCompleted: null == isSetupCompleted
          ? _self.isSetupCompleted
          : isSetupCompleted // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

// dart format on
