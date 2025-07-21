// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'conversation_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ConversationEntity _$ConversationEntityFromJson(Map<String, dynamic> json) =>
    _ConversationEntity(
      id: json['id'] as String,
      createdAt: DateTime.parse(json['created_at'] as String),
      lastMessageAt:
          const DateTimeConverter().fromJson(json['last_message_at']),
    );

Map<String, dynamic> _$ConversationEntityToJson(_ConversationEntity instance) =>
    <String, dynamic>{
      'id': instance.id,
      'created_at': instance.createdAt.toIso8601String(),
      'last_message_at':
          const DateTimeConverter().toJson(instance.lastMessageAt),
    };
