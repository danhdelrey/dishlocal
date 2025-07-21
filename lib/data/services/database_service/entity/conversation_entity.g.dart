// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'conversation_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ConversationEntity _$ConversationEntityFromJson(Map<String, dynamic> json) =>
    _ConversationEntity(
      id: json['id'] as String,
      createdAt:
          const DateTimeConverter().fromJson(json['created_at'] as String),
      lastMessageAt: _$JsonConverterFromJson<String, DateTime>(
          json['last_message_at'], const DateTimeConverter().fromJson),
    );

Map<String, dynamic> _$ConversationEntityToJson(_ConversationEntity instance) =>
    <String, dynamic>{
      'id': instance.id,
      'created_at': const DateTimeConverter().toJson(instance.createdAt),
      'last_message_at': _$JsonConverterToJson<String, DateTime>(
          instance.lastMessageAt, const DateTimeConverter().toJson),
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
