// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'conversation_participant_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ConversationParticipantEntity _$ConversationParticipantEntityFromJson(
        Map<String, dynamic> json) =>
    _ConversationParticipantEntity(
      conversationId: json['conversation_id'] as String,
      userId: json['user_id'] as String,
      lastReadAt: const DateTimeConverter().fromJson(json['last_read_at']),
    );

Map<String, dynamic> _$ConversationParticipantEntityToJson(
        _ConversationParticipantEntity instance) =>
    <String, dynamic>{
      'conversation_id': instance.conversationId,
      'user_id': instance.userId,
      'last_read_at': const DateTimeConverter().toJson(instance.lastReadAt),
    };
