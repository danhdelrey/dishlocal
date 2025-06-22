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
  String get uid;
  String? get email;
  String? get displayName;
  String? get photoUrl;

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
                other.photoUrl == photoUrl));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, uid, email, displayName, photoUrl);

  @override
  String toString() {
    return 'AppUserCredential(uid: $uid, email: $email, displayName: $displayName, photoUrl: $photoUrl)';
  }
}

/// @nodoc
abstract mixin class $AppUserCredentialCopyWith<$Res> {
  factory $AppUserCredentialCopyWith(
          AppUserCredential value, $Res Function(AppUserCredential) _then) =
      _$AppUserCredentialCopyWithImpl;
  @useResult
  $Res call({String uid, String? email, String? displayName, String? photoUrl});
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
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _AppUserCredential implements AppUserCredential {
  const _AppUserCredential(
      {required this.uid, this.email, this.displayName, this.photoUrl});
  factory _AppUserCredential.fromJson(Map<String, dynamic> json) =>
      _$AppUserCredentialFromJson(json);

  @override
  final String uid;
  @override
  final String? email;
  @override
  final String? displayName;
  @override
  final String? photoUrl;

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
                other.photoUrl == photoUrl));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, uid, email, displayName, photoUrl);

  @override
  String toString() {
    return 'AppUserCredential(uid: $uid, email: $email, displayName: $displayName, photoUrl: $photoUrl)';
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
  $Res call({String uid, String? email, String? displayName, String? photoUrl});
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
    ));
  }
}

// dart format on
