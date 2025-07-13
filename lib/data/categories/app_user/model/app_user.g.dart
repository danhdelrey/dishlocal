// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_AppUser _$AppUserFromJson(Map<String, dynamic> json) => _AppUser(
      userId: json['id'] as String,
      email: json['email'] as String?,
      username: json['username'] as String?,
      displayName: json['display_name'] as String?,
      originalDisplayname: json['original_displayname'] as String?,
      photoUrl: json['photo_url'] as String?,
      bio: json['bio'] as String?,
      postCount: (json['post_count'] as num?)?.toInt() ?? 0,
      likeCount: (json['like_count'] as num?)?.toInt() ?? 0,
      followerCount: (json['follower_count'] as num?)?.toInt() ?? 0,
      followingCount: (json['following_count'] as num?)?.toInt() ?? 0,
      isFollowing: json['is_following'] as bool?,
      isSetupCompleted: json['is_setup_completed'] as bool? ?? false,
    );

Map<String, dynamic> _$AppUserToJson(_AppUser instance) => <String, dynamic>{
      'id': instance.userId,
      'email': instance.email,
      'username': instance.username,
      'display_name': instance.displayName,
      'original_displayname': instance.originalDisplayname,
      'photo_url': instance.photoUrl,
      'bio': instance.bio,
      'post_count': instance.postCount,
      'like_count': instance.likeCount,
      'follower_count': instance.followerCount,
      'following_count': instance.followingCount,
      'is_following': instance.isFollowing,
      'is_setup_completed': instance.isSetupCompleted,
    };
