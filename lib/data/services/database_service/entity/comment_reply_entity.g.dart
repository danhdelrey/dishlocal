// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'comment_reply_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_CommentReplyEntity _$CommentReplyEntityFromJson(Map<String, dynamic> json) =>
    _CommentReplyEntity(
      id: json['id'] as String,
      parentCommentId: json['parent_comment_id'] as String,
      authorId: json['author_id'] as String,
      replyToUserId: json['reply_to_user_id'] as String,
      content: json['content'] as String,
      likeCount: (json['like_count'] as num?)?.toInt() ?? 0,
      createdAt: DateTime.parse(json['created_at'] as String),
    );

Map<String, dynamic> _$CommentReplyEntityToJson(_CommentReplyEntity instance) =>
    <String, dynamic>{
      'id': instance.id,
      'parent_comment_id': instance.parentCommentId,
      'author_id': instance.authorId,
      'reply_to_user_id': instance.replyToUserId,
      'content': instance.content,
      'like_count': instance.likeCount,
      'created_at': instance.createdAt.toIso8601String(),
    };
