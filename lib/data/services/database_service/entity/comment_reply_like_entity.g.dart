// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'comment_reply_like_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_CommentReplyLikeEntity _$CommentReplyLikeEntityFromJson(
        Map<String, dynamic> json) =>
    _CommentReplyLikeEntity(
      replyId: json['reply_id'] as String,
      userId: json['user_id'] as String,
      createdAt:
          const DateTimeConverter().fromJson(json['created_at'] as String),
    );

Map<String, dynamic> _$CommentReplyLikeEntityToJson(
        _CommentReplyLikeEntity instance) =>
    <String, dynamic>{
      'reply_id': instance.replyId,
      'user_id': instance.userId,
      'created_at': const DateTimeConverter().toJson(instance.createdAt),
    };
