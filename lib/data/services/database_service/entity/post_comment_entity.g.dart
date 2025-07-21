// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post_comment_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_PostCommentEntity _$PostCommentEntityFromJson(Map<String, dynamic> json) =>
    _PostCommentEntity(
      id: json['id'] as String,
      postId: json['post_id'] as String,
      authorId: json['author_id'] as String,
      content: json['content'] as String,
      likeCount: (json['like_count'] as num?)?.toInt() ?? 0,
      replyCount: (json['reply_count'] as num?)?.toInt() ?? 0,
      createdAt: DateTime.parse(json['created_at'] as String),
    );

Map<String, dynamic> _$PostCommentEntityToJson(_PostCommentEntity instance) =>
    <String, dynamic>{
      'id': instance.id,
      'post_id': instance.postId,
      'author_id': instance.authorId,
      'content': instance.content,
      'like_count': instance.likeCount,
      'reply_count': instance.replyCount,
      'created_at': instance.createdAt.toIso8601String(),
    };
