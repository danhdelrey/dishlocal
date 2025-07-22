// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'conversation.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Conversation _$ConversationFromJson(Map<String, dynamic> json) =>
    _Conversation(
      conversationId: json['conversation_id'] as String,
      otherParticipant:
          AppUser.fromJson(json['other_participant'] as Map<String, dynamic>),
      lastMessageContent: json['last_message_content'] as String?,
      lastMessageCreatedAt:
          const DateTimeConverter().fromJson(json['last_message_created_at']),
      lastMessageSenderId: json['last_message_sender_id'] as String?,
      lastMessageSharedPostId: json['last_message_shared_post_id'] as String?,
      unreadCount: (json['unread_count'] as num?)?.toInt() ?? 0,
      lastMessageType: json['last_message_type'] as String?,
    );

Map<String, dynamic> _$ConversationToJson(_Conversation instance) =>
    <String, dynamic>{
      'conversation_id': instance.conversationId,
      'other_participant': instance.otherParticipant,
      'last_message_content': instance.lastMessageContent,
      'last_message_created_at':
          const DateTimeConverter().toJson(instance.lastMessageCreatedAt),
      'last_message_sender_id': instance.lastMessageSenderId,
      'last_message_shared_post_id': instance.lastMessageSharedPostId,
      'unread_count': instance.unreadCount,
      'last_message_type': instance.lastMessageType,
    };
