// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post_comment_like_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_PostCommentLikeEntity _$PostCommentLikeEntityFromJson(
        Map<String, dynamic> json) =>
    _PostCommentLikeEntity(
      commentId: json['comment_id'] as String,
      userId: json['user_id'] as String,
      createdAt: DateTime.parse(json['created_at'] as String),
    );

Map<String, dynamic> _$PostCommentLikeEntityToJson(
        _PostCommentLikeEntity instance) =>
    <String, dynamic>{
      'comment_id': instance.commentId,
      'user_id': instance.userId,
      'created_at': instance.createdAt.toIso8601String(),
    };
