// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AppUser _$AppUserFromJson(Map<String, dynamic> json) => AppUser(
      userId: json['userId'] as String,
      email: json['email'] as String?,
      username: json['username'] as String?,
      displayName: json['displayName'] as String?,
      photoUrl: json['photoUrl'] as String?,
    );

Map<String, dynamic> _$AppUserToJson(AppUser instance) => <String, dynamic>{
      'userId': instance.userId,
      'email': instance.email,
      'username': instance.username,
      'displayName': instance.displayName,
      'photoUrl': instance.photoUrl,
    };
