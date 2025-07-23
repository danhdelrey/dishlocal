// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ProfileEntity _$ProfileEntityFromJson(Map<String, dynamic> json) =>
    _ProfileEntity(
      id: json['id'] as String,
      username: json['username'] as String,
      displayName: json['display_name'] as String?,
      photoUrl: json['photo_url'] as String?,
      bio: json['bio'] as String?,
      followerCount: (json['follower_count'] as num?)?.toInt() ?? 0,
      followingCount: (json['following_count'] as num?)?.toInt() ?? 0,
      updatedAt: DateTime.parse(json['updated_at'] as String),
      fcmTokens: (json['fcm_tokens'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      isSetupCompleted: json['is_setup_completed'] as bool? ?? false,
    );

Map<String, dynamic> _$ProfileEntityToJson(_ProfileEntity instance) =>
    <String, dynamic>{
      'id': instance.id,
      'username': instance.username,
      'display_name': instance.displayName,
      'photo_url': instance.photoUrl,
      'bio': instance.bio,
      'follower_count': instance.followerCount,
      'following_count': instance.followingCount,
      'updated_at': instance.updatedAt.toIso8601String(),
      'fcm_tokens': instance.fcmTokens,
      'is_setup_completed': instance.isSetupCompleted,
    };
