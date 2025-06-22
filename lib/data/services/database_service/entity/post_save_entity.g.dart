// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post_save_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_PostSaveEntity _$PostSaveEntityFromJson(Map<String, dynamic> json) =>
    _PostSaveEntity(
      postId: json['post_id'] as String,
      userId: json['user_id'] as String,
      createdAt:
          const DateTimeConverter().fromJson(json['created_at'] as String),
    );

Map<String, dynamic> _$PostSaveEntityToJson(_PostSaveEntity instance) =>
    <String, dynamic>{
      'post_id': instance.postId,
      'user_id': instance.userId,
      'created_at': const DateTimeConverter().toJson(instance.createdAt),
    };
