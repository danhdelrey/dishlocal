// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Message _$MessageFromJson(Map<String, dynamic> json) => _Message(
      id: json['id'] as String,
      conversationId: json['conversation_id'] as String,
      senderId: json['sender_id'] as String,
      content: json['content'] as String?,
      sharedPost: json['shared_post'] == null
          ? null
          : Post.fromJson(json['shared_post'] as Map<String, dynamic>),
      sharedPostId: json['shared_post_id'] as String?,
      createdAt: DateTime.parse(json['created_at'] as String),
    );

Map<String, dynamic> _$MessageToJson(_Message instance) => <String, dynamic>{
      'id': instance.id,
      'conversation_id': instance.conversationId,
      'sender_id': instance.senderId,
      'content': instance.content,
      'shared_post': instance.sharedPost?.toJson(),
      'shared_post_id': instance.sharedPostId,
      'created_at': instance.createdAt.toIso8601String(),
    };
