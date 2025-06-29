// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'comment.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Comment _$CommentFromJson(Map<String, dynamic> json) => _Comment(
      commentId: json['commentId'] as String,
      authorUserId: json['authorUserId'] as String,
      authorUsername: json['authorUsername'] as String,
      authorAvatarUrl: json['authorAvatarUrl'] as String?,
      content: json['content'] as String,
      createdAt:
          const DateTimeConverter().fromJson(json['createdAt'] as String),
      likeCount: (json['likeCount'] as num).toInt(),
      replyCount: (json['replyCount'] as num).toInt(),
      isLiked: json['isLiked'] as bool,
    );

Map<String, dynamic> _$CommentToJson(_Comment instance) => <String, dynamic>{
      'commentId': instance.commentId,
      'authorUserId': instance.authorUserId,
      'authorUsername': instance.authorUsername,
      'authorAvatarUrl': instance.authorAvatarUrl,
      'content': instance.content,
      'createdAt': const DateTimeConverter().toJson(instance.createdAt),
      'likeCount': instance.likeCount,
      'replyCount': instance.replyCount,
      'isLiked': instance.isLiked,
    };
