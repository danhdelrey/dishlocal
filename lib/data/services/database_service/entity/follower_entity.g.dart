// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'follower_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_FollowerEntity _$FollowerEntityFromJson(Map<String, dynamic> json) =>
    _FollowerEntity(
      userId: json['user_id'] as String,
      followerId: json['follower_id'] as String,
      createdAt:
          const DateTimeConverter().fromJson(json['created_at'] as String),
    );

Map<String, dynamic> _$FollowerEntityToJson(_FollowerEntity instance) =>
    <String, dynamic>{
      'user_id': instance.userId,
      'follower_id': instance.followerId,
      'created_at': const DateTimeConverter().toJson(instance.createdAt),
    };
