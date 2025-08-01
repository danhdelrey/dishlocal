// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_MessageEntity _$MessageEntityFromJson(Map<String, dynamic> json) =>
    _MessageEntity(
      id: json['id'] as String,
      conversationId: json['conversation_id'] as String,
      senderId: json['sender_id'] as String,
      content: json['content'] as String?,
      sharedPostId: json['shared_post_id'] as String?,
      messageType: json['message_type'] as String? ?? 'text',
      createdAt: DateTime.parse(json['created_at'] as String),
    );

Map<String, dynamic> _$MessageEntityToJson(_MessageEntity instance) =>
    <String, dynamic>{
      'id': instance.id,
      'conversation_id': instance.conversationId,
      'sender_id': instance.senderId,
      'content': instance.content,
      'shared_post_id': instance.sharedPostId,
      'message_type': instance.messageType,
      'created_at': instance.createdAt.toIso8601String(),
    };
