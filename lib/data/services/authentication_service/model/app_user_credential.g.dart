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
    );

Map<String, dynamic> _$AppUserCredentialToJson(_AppUserCredential instance) =>
    <String, dynamic>{
      'uid': instance.uid,
      'email': instance.email,
      'displayName': instance.displayName,
      'photoUrl': instance.photoUrl,
    };
