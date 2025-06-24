// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'profile_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ProfileEntity {
  /// PK: Primary Key, cũng là Foreign Key tham chiếu đến `auth.users.id`.
  String get id;

  /// Tên người dùng duy nhất, không thể thay đổi, dùng cho @mentions.
  String get username;

  /// Tên hiển thị, có thể thay đổi.
  String? get displayName;

  /// URL ảnh đại diện.
  String? get photoUrl;

  /// Giới thiệu ngắn về người dùng.
  String? get bio;

  /// (Denormalized) Số lượng người theo dõi, được cập nhật bằng triggers.
  int get followerCount;

  /// (Denormalized) Số lượng người đang theo dõi, được cập nhật bằng triggers.
  int get followingCount;

  /// Thời điểm hồ sơ được cập nhật lần cuối.
  DateTime get updatedAt;
  bool get isSetupCompleted;

  /// Create a copy of ProfileEntity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $ProfileEntityCopyWith<ProfileEntity> get copyWith =>
      _$ProfileEntityCopyWithImpl<ProfileEntity>(
          this as ProfileEntity, _$identity);

  /// Serializes this ProfileEntity to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is ProfileEntity &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.username, username) ||
                other.username == username) &&
            (identical(other.displayName, displayName) ||
                other.displayName == displayName) &&
            (identical(other.photoUrl, photoUrl) ||
                other.photoUrl == photoUrl) &&
            (identical(other.bio, bio) || other.bio == bio) &&
            (identical(other.followerCount, followerCount) ||
                other.followerCount == followerCount) &&
            (identical(other.followingCount, followingCount) ||
                other.followingCount == followingCount) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt) &&
            (identical(other.isSetupCompleted, isSetupCompleted) ||
                other.isSetupCompleted == isSetupCompleted));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      username,
      displayName,
      photoUrl,
      bio,
      followerCount,
      followingCount,
      updatedAt,
      isSetupCompleted);

  @override
  String toString() {
    return 'ProfileEntity(id: $id, username: $username, displayName: $displayName, photoUrl: $photoUrl, bio: $bio, followerCount: $followerCount, followingCount: $followingCount, updatedAt: $updatedAt, isSetupCompleted: $isSetupCompleted)';
  }
}

/// @nodoc
abstract mixin class $ProfileEntityCopyWith<$Res> {
  factory $ProfileEntityCopyWith(
          ProfileEntity value, $Res Function(ProfileEntity) _then) =
      _$ProfileEntityCopyWithImpl;
  @useResult
  $Res call(
      {String id,
      String username,
      String? displayName,
      String? photoUrl,
      String? bio,
      int followerCount,
      int followingCount,
      DateTime updatedAt,
      bool isSetupCompleted});
}

/// @nodoc
class _$ProfileEntityCopyWithImpl<$Res>
    implements $ProfileEntityCopyWith<$Res> {
  _$ProfileEntityCopyWithImpl(this._self, this._then);

  final ProfileEntity _self;
  final $Res Function(ProfileEntity) _then;

  /// Create a copy of ProfileEntity
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? username = null,
    Object? displayName = freezed,
    Object? photoUrl = freezed,
    Object? bio = freezed,
    Object? followerCount = null,
    Object? followingCount = null,
    Object? updatedAt = null,
    Object? isSetupCompleted = null,
  }) {
    return _then(_self.copyWith(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      username: null == username
          ? _self.username
          : username // ignore: cast_nullable_to_non_nullable
              as String,
      displayName: freezed == displayName
          ? _self.displayName
          : displayName // ignore: cast_nullable_to_non_nullable
              as String?,
      photoUrl: freezed == photoUrl
          ? _self.photoUrl
          : photoUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      bio: freezed == bio
          ? _self.bio
          : bio // ignore: cast_nullable_to_non_nullable
              as String?,
      followerCount: null == followerCount
          ? _self.followerCount
          : followerCount // ignore: cast_nullable_to_non_nullable
              as int,
      followingCount: null == followingCount
          ? _self.followingCount
          : followingCount // ignore: cast_nullable_to_non_nullable
              as int,
      updatedAt: null == updatedAt
          ? _self.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      isSetupCompleted: null == isSetupCompleted
          ? _self.isSetupCompleted
          : isSetupCompleted // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

@JsonSerializable(fieldRename: FieldRename.snake)
class _ProfileEntity implements ProfileEntity {
  const _ProfileEntity(
      {required this.id,
      required this.username,
      this.displayName,
      this.photoUrl,
      this.bio,
      this.followerCount = 0,
      this.followingCount = 0,
      required this.updatedAt,
      this.isSetupCompleted = false});
  factory _ProfileEntity.fromJson(Map<String, dynamic> json) =>
      _$ProfileEntityFromJson(json);

  /// PK: Primary Key, cũng là Foreign Key tham chiếu đến `auth.users.id`.
  @override
  final String id;

  /// Tên người dùng duy nhất, không thể thay đổi, dùng cho @mentions.
  @override
  final String username;

  /// Tên hiển thị, có thể thay đổi.
  @override
  final String? displayName;

  /// URL ảnh đại diện.
  @override
  final String? photoUrl;

  /// Giới thiệu ngắn về người dùng.
  @override
  final String? bio;

  /// (Denormalized) Số lượng người theo dõi, được cập nhật bằng triggers.
  @override
  @JsonKey()
  final int followerCount;

  /// (Denormalized) Số lượng người đang theo dõi, được cập nhật bằng triggers.
  @override
  @JsonKey()
  final int followingCount;

  /// Thời điểm hồ sơ được cập nhật lần cuối.
  @override
  final DateTime updatedAt;
  @override
  @JsonKey()
  final bool isSetupCompleted;

  /// Create a copy of ProfileEntity
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$ProfileEntityCopyWith<_ProfileEntity> get copyWith =>
      __$ProfileEntityCopyWithImpl<_ProfileEntity>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$ProfileEntityToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _ProfileEntity &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.username, username) ||
                other.username == username) &&
            (identical(other.displayName, displayName) ||
                other.displayName == displayName) &&
            (identical(other.photoUrl, photoUrl) ||
                other.photoUrl == photoUrl) &&
            (identical(other.bio, bio) || other.bio == bio) &&
            (identical(other.followerCount, followerCount) ||
                other.followerCount == followerCount) &&
            (identical(other.followingCount, followingCount) ||
                other.followingCount == followingCount) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt) &&
            (identical(other.isSetupCompleted, isSetupCompleted) ||
                other.isSetupCompleted == isSetupCompleted));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      username,
      displayName,
      photoUrl,
      bio,
      followerCount,
      followingCount,
      updatedAt,
      isSetupCompleted);

  @override
  String toString() {
    return 'ProfileEntity(id: $id, username: $username, displayName: $displayName, photoUrl: $photoUrl, bio: $bio, followerCount: $followerCount, followingCount: $followingCount, updatedAt: $updatedAt, isSetupCompleted: $isSetupCompleted)';
  }
}

/// @nodoc
abstract mixin class _$ProfileEntityCopyWith<$Res>
    implements $ProfileEntityCopyWith<$Res> {
  factory _$ProfileEntityCopyWith(
          _ProfileEntity value, $Res Function(_ProfileEntity) _then) =
      __$ProfileEntityCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String id,
      String username,
      String? displayName,
      String? photoUrl,
      String? bio,
      int followerCount,
      int followingCount,
      DateTime updatedAt,
      bool isSetupCompleted});
}

/// @nodoc
class __$ProfileEntityCopyWithImpl<$Res>
    implements _$ProfileEntityCopyWith<$Res> {
  __$ProfileEntityCopyWithImpl(this._self, this._then);

  final _ProfileEntity _self;
  final $Res Function(_ProfileEntity) _then;

  /// Create a copy of ProfileEntity
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = null,
    Object? username = null,
    Object? displayName = freezed,
    Object? photoUrl = freezed,
    Object? bio = freezed,
    Object? followerCount = null,
    Object? followingCount = null,
    Object? updatedAt = null,
    Object? isSetupCompleted = null,
  }) {
    return _then(_ProfileEntity(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      username: null == username
          ? _self.username
          : username // ignore: cast_nullable_to_non_nullable
              as String,
      displayName: freezed == displayName
          ? _self.displayName
          : displayName // ignore: cast_nullable_to_non_nullable
              as String?,
      photoUrl: freezed == photoUrl
          ? _self.photoUrl
          : photoUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      bio: freezed == bio
          ? _self.bio
          : bio // ignore: cast_nullable_to_non_nullable
              as String?,
      followerCount: null == followerCount
          ? _self.followerCount
          : followerCount // ignore: cast_nullable_to_non_nullable
              as int,
      followingCount: null == followingCount
          ? _self.followingCount
          : followingCount // ignore: cast_nullable_to_non_nullable
              as int,
      updatedAt: null == updatedAt
          ? _self.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      isSetupCompleted: null == isSetupCompleted
          ? _self.isSetupCompleted
          : isSetupCompleted // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

// dart format on
