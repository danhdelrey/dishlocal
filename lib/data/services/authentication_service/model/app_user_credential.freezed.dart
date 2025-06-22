// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'app_user_credential.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$AppUserCredential {
  /// ID định danh duy nhất của người dùng. Luôn có giá trị.
  String get uid;

  /// Email của người dùng. Có thể null (ví dụ: đăng nhập bằng SĐT, ẩn danh).
  String? get email;

  /// Tên hiển thị của người dùng.
  String? get displayName;

  /// URL ảnh đại diện của người dùng.
  String? get photoUrl;

  /// Số điện thoại của người dùng.
  String? get phoneNumber;

  /// Trạng thái xác thực email của người dùng.
  bool get isEmailVerified;

  /// Cho biết tài khoản có phải là tài khoản ẩn danh hay không.
  bool get isAnonymous;

  /// ID của nhà cung cấp dịch vụ xác thực (ví dụ: 'google', 'email', 'apple').
  String? get providerId;

  /// Thời điểm tài khoản được tạo.
  DateTime? get creationTime;

  /// Thời điểm người dùng đăng nhập lần cuối.
  DateTime? get lastSignInTime;

  /// Create a copy of AppUserCredential
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $AppUserCredentialCopyWith<AppUserCredential> get copyWith =>
      _$AppUserCredentialCopyWithImpl<AppUserCredential>(
          this as AppUserCredential, _$identity);

  /// Serializes this AppUserCredential to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is AppUserCredential &&
            (identical(other.uid, uid) || other.uid == uid) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.displayName, displayName) ||
                other.displayName == displayName) &&
            (identical(other.photoUrl, photoUrl) ||
                other.photoUrl == photoUrl) &&
            (identical(other.phoneNumber, phoneNumber) ||
                other.phoneNumber == phoneNumber) &&
            (identical(other.isEmailVerified, isEmailVerified) ||
                other.isEmailVerified == isEmailVerified) &&
            (identical(other.isAnonymous, isAnonymous) ||
                other.isAnonymous == isAnonymous) &&
            (identical(other.providerId, providerId) ||
                other.providerId == providerId) &&
            (identical(other.creationTime, creationTime) ||
                other.creationTime == creationTime) &&
            (identical(other.lastSignInTime, lastSignInTime) ||
                other.lastSignInTime == lastSignInTime));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      uid,
      email,
      displayName,
      photoUrl,
      phoneNumber,
      isEmailVerified,
      isAnonymous,
      providerId,
      creationTime,
      lastSignInTime);

  @override
  String toString() {
    return 'AppUserCredential(uid: $uid, email: $email, displayName: $displayName, photoUrl: $photoUrl, phoneNumber: $phoneNumber, isEmailVerified: $isEmailVerified, isAnonymous: $isAnonymous, providerId: $providerId, creationTime: $creationTime, lastSignInTime: $lastSignInTime)';
  }
}

/// @nodoc
abstract mixin class $AppUserCredentialCopyWith<$Res> {
  factory $AppUserCredentialCopyWith(
          AppUserCredential value, $Res Function(AppUserCredential) _then) =
      _$AppUserCredentialCopyWithImpl;
  @useResult
  $Res call(
      {String uid,
      String? email,
      String? displayName,
      String? photoUrl,
      String? phoneNumber,
      bool isEmailVerified,
      bool isAnonymous,
      String? providerId,
      DateTime? creationTime,
      DateTime? lastSignInTime});
}

/// @nodoc
class _$AppUserCredentialCopyWithImpl<$Res>
    implements $AppUserCredentialCopyWith<$Res> {
  _$AppUserCredentialCopyWithImpl(this._self, this._then);

  final AppUserCredential _self;
  final $Res Function(AppUserCredential) _then;

  /// Create a copy of AppUserCredential
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? uid = null,
    Object? email = freezed,
    Object? displayName = freezed,
    Object? photoUrl = freezed,
    Object? phoneNumber = freezed,
    Object? isEmailVerified = null,
    Object? isAnonymous = null,
    Object? providerId = freezed,
    Object? creationTime = freezed,
    Object? lastSignInTime = freezed,
  }) {
    return _then(_self.copyWith(
      uid: null == uid
          ? _self.uid
          : uid // ignore: cast_nullable_to_non_nullable
              as String,
      email: freezed == email
          ? _self.email
          : email // ignore: cast_nullable_to_non_nullable
              as String?,
      displayName: freezed == displayName
          ? _self.displayName
          : displayName // ignore: cast_nullable_to_non_nullable
              as String?,
      photoUrl: freezed == photoUrl
          ? _self.photoUrl
          : photoUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      phoneNumber: freezed == phoneNumber
          ? _self.phoneNumber
          : phoneNumber // ignore: cast_nullable_to_non_nullable
              as String?,
      isEmailVerified: null == isEmailVerified
          ? _self.isEmailVerified
          : isEmailVerified // ignore: cast_nullable_to_non_nullable
              as bool,
      isAnonymous: null == isAnonymous
          ? _self.isAnonymous
          : isAnonymous // ignore: cast_nullable_to_non_nullable
              as bool,
      providerId: freezed == providerId
          ? _self.providerId
          : providerId // ignore: cast_nullable_to_non_nullable
              as String?,
      creationTime: freezed == creationTime
          ? _self.creationTime
          : creationTime // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      lastSignInTime: freezed == lastSignInTime
          ? _self.lastSignInTime
          : lastSignInTime // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _AppUserCredential implements AppUserCredential {
  const _AppUserCredential(
      {required this.uid,
      this.email,
      this.displayName,
      this.photoUrl,
      this.phoneNumber,
      required this.isEmailVerified,
      required this.isAnonymous,
      this.providerId,
      this.creationTime,
      this.lastSignInTime});
  factory _AppUserCredential.fromJson(Map<String, dynamic> json) =>
      _$AppUserCredentialFromJson(json);

  /// ID định danh duy nhất của người dùng. Luôn có giá trị.
  @override
  final String uid;

  /// Email của người dùng. Có thể null (ví dụ: đăng nhập bằng SĐT, ẩn danh).
  @override
  final String? email;

  /// Tên hiển thị của người dùng.
  @override
  final String? displayName;

  /// URL ảnh đại diện của người dùng.
  @override
  final String? photoUrl;

  /// Số điện thoại của người dùng.
  @override
  final String? phoneNumber;

  /// Trạng thái xác thực email của người dùng.
  @override
  final bool isEmailVerified;

  /// Cho biết tài khoản có phải là tài khoản ẩn danh hay không.
  @override
  final bool isAnonymous;

  /// ID của nhà cung cấp dịch vụ xác thực (ví dụ: 'google', 'email', 'apple').
  @override
  final String? providerId;

  /// Thời điểm tài khoản được tạo.
  @override
  final DateTime? creationTime;

  /// Thời điểm người dùng đăng nhập lần cuối.
  @override
  final DateTime? lastSignInTime;

  /// Create a copy of AppUserCredential
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$AppUserCredentialCopyWith<_AppUserCredential> get copyWith =>
      __$AppUserCredentialCopyWithImpl<_AppUserCredential>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$AppUserCredentialToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _AppUserCredential &&
            (identical(other.uid, uid) || other.uid == uid) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.displayName, displayName) ||
                other.displayName == displayName) &&
            (identical(other.photoUrl, photoUrl) ||
                other.photoUrl == photoUrl) &&
            (identical(other.phoneNumber, phoneNumber) ||
                other.phoneNumber == phoneNumber) &&
            (identical(other.isEmailVerified, isEmailVerified) ||
                other.isEmailVerified == isEmailVerified) &&
            (identical(other.isAnonymous, isAnonymous) ||
                other.isAnonymous == isAnonymous) &&
            (identical(other.providerId, providerId) ||
                other.providerId == providerId) &&
            (identical(other.creationTime, creationTime) ||
                other.creationTime == creationTime) &&
            (identical(other.lastSignInTime, lastSignInTime) ||
                other.lastSignInTime == lastSignInTime));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      uid,
      email,
      displayName,
      photoUrl,
      phoneNumber,
      isEmailVerified,
      isAnonymous,
      providerId,
      creationTime,
      lastSignInTime);

  @override
  String toString() {
    return 'AppUserCredential(uid: $uid, email: $email, displayName: $displayName, photoUrl: $photoUrl, phoneNumber: $phoneNumber, isEmailVerified: $isEmailVerified, isAnonymous: $isAnonymous, providerId: $providerId, creationTime: $creationTime, lastSignInTime: $lastSignInTime)';
  }
}

/// @nodoc
abstract mixin class _$AppUserCredentialCopyWith<$Res>
    implements $AppUserCredentialCopyWith<$Res> {
  factory _$AppUserCredentialCopyWith(
          _AppUserCredential value, $Res Function(_AppUserCredential) _then) =
      __$AppUserCredentialCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String uid,
      String? email,
      String? displayName,
      String? photoUrl,
      String? phoneNumber,
      bool isEmailVerified,
      bool isAnonymous,
      String? providerId,
      DateTime? creationTime,
      DateTime? lastSignInTime});
}

/// @nodoc
class __$AppUserCredentialCopyWithImpl<$Res>
    implements _$AppUserCredentialCopyWith<$Res> {
  __$AppUserCredentialCopyWithImpl(this._self, this._then);

  final _AppUserCredential _self;
  final $Res Function(_AppUserCredential) _then;

  /// Create a copy of AppUserCredential
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? uid = null,
    Object? email = freezed,
    Object? displayName = freezed,
    Object? photoUrl = freezed,
    Object? phoneNumber = freezed,
    Object? isEmailVerified = null,
    Object? isAnonymous = null,
    Object? providerId = freezed,
    Object? creationTime = freezed,
    Object? lastSignInTime = freezed,
  }) {
    return _then(_AppUserCredential(
      uid: null == uid
          ? _self.uid
          : uid // ignore: cast_nullable_to_non_nullable
              as String,
      email: freezed == email
          ? _self.email
          : email // ignore: cast_nullable_to_non_nullable
              as String?,
      displayName: freezed == displayName
          ? _self.displayName
          : displayName // ignore: cast_nullable_to_non_nullable
              as String?,
      photoUrl: freezed == photoUrl
          ? _self.photoUrl
          : photoUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      phoneNumber: freezed == phoneNumber
          ? _self.phoneNumber
          : phoneNumber // ignore: cast_nullable_to_non_nullable
              as String?,
      isEmailVerified: null == isEmailVerified
          ? _self.isEmailVerified
          : isEmailVerified // ignore: cast_nullable_to_non_nullable
              as bool,
      isAnonymous: null == isAnonymous
          ? _self.isAnonymous
          : isAnonymous // ignore: cast_nullable_to_non_nullable
              as bool,
      providerId: freezed == providerId
          ? _self.providerId
          : providerId // ignore: cast_nullable_to_non_nullable
              as String?,
      creationTime: freezed == creationTime
          ? _self.creationTime
          : creationTime // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      lastSignInTime: freezed == lastSignInTime
          ? _self.lastSignInTime
          : lastSignInTime // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

// dart format on
