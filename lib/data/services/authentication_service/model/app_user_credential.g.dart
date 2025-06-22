// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_user_credential.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_AppUserCredential _$AppUserCredentialFromJson(Map<String, dynamic> json) =>
    _AppUserCredential(
      uid: json['uid'] as String,
      email: json['email'] as String?,
      displayName: json['displayName'] as String?,
      photoUrl: json['photoUrl'] as String?,
      phoneNumber: json['phoneNumber'] as String?,
      isEmailVerified: json['isEmailVerified'] as bool,
      isAnonymous: json['isAnonymous'] as bool,
      providerId: json['providerId'] as String?,
      creationTime: json['creationTime'] == null
          ? null
          : DateTime.parse(json['creationTime'] as String),
      lastSignInTime: json['lastSignInTime'] == null
          ? null
          : DateTime.parse(json['lastSignInTime'] as String),
    );

Map<String, dynamic> _$AppUserCredentialToJson(_AppUserCredential instance) =>
    <String, dynamic>{
      'uid': instance.uid,
      'email': instance.email,
      'displayName': instance.displayName,
      'photoUrl': instance.photoUrl,
      'phoneNumber': instance.phoneNumber,
      'isEmailVerified': instance.isEmailVerified,
      'isAnonymous': instance.isAnonymous,
      'providerId': instance.providerId,
      'creationTime': instance.creationTime?.toIso8601String(),
      'lastSignInTime': instance.lastSignInTime?.toIso8601String(),
    };
