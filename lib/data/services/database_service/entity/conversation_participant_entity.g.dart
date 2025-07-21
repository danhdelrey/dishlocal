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
      lastReadAt: _$JsonConverterFromJson<String, DateTime>(
          json['last_read_at'], const DateTimeConverter().fromJson),
    );

Map<String, dynamic> _$ConversationParticipantEntityToJson(
        _ConversationParticipantEntity instance) =>
    <String, dynamic>{
      'conversation_id': instance.conversationId,
      'user_id': instance.userId,
      'last_read_at': _$JsonConverterToJson<String, DateTime>(
          instance.lastReadAt, const DateTimeConverter().toJson),
    };

Value? _$JsonConverterFromJson<Json, Value>(
  Object? json,
  Value? Function(Json json) fromJson,
) =>
    json == null ? null : fromJson(json as Json);

Json? _$JsonConverterToJson<Json, Value>(
  Value? value,
  Json? Function(Value value) toJson,
) =>
    value == null ? null : toJson(value);
