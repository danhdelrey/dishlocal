// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'comment_reply.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_CommentReply _$CommentReplyFromJson(Map<String, dynamic> json) =>
    _CommentReply(
      replyId: json['replyId'] as String,
      authorUserId: json['authorUserId'] as String,
      authorUsername: json['authorUsername'] as String,
      authorAvatarUrl: json['authorAvatarUrl'] as String?,
      replyToUserId: json['replyToUserId'] as String,
      replyToUsername: json['replyToUsername'] as String,
      content: json['content'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      likeCount: (json['likeCount'] as num).toInt(),
      isLiked: json['isLiked'] as bool,
    );

Map<String, dynamic> _$CommentReplyToJson(_CommentReply instance) =>
    <String, dynamic>{
      'replyId': instance.replyId,
      'authorUserId': instance.authorUserId,
      'authorUsername': instance.authorUsername,
      'authorAvatarUrl': instance.authorAvatarUrl,
      'replyToUserId': instance.replyToUserId,
      'replyToUsername': instance.replyToUsername,
      'content': instance.content,
      'createdAt': instance.createdAt.toIso8601String(),
      'likeCount': instance.likeCount,
      'isLiked': instance.isLiked,
    };
