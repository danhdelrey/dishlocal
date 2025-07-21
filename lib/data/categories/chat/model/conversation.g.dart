// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'conversation.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Conversation _$ConversationFromJson(Map<String, dynamic> json) =>
    _Conversation(
      conversationId: json['conversationId'] as String,
      otherParticipantId: json['otherParticipantId'] as String,
      otherParticipantUsername: json['otherParticipantUsername'] as String,
      otherParticipantDisplayName:
          json['otherParticipantDisplayName'] as String?,
      otherParticipantPhotoUrl: json['otherParticipantPhotoUrl'] as String?,
      lastMessageContent: json['lastMessageContent'] as String?,
      lastMessageCreatedAt: _$JsonConverterFromJson<String, DateTime>(
          json['lastMessageCreatedAt'], const DateTimeConverter().fromJson),
      lastMessageSenderId: json['lastMessageSenderId'] as String?,
      lastMessageSharedPostId: json['lastMessageSharedPostId'] as String?,
      unreadCount: (json['unreadCount'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$ConversationToJson(_Conversation instance) =>
    <String, dynamic>{
      'conversationId': instance.conversationId,
      'otherParticipantId': instance.otherParticipantId,
      'otherParticipantUsername': instance.otherParticipantUsername,
      'otherParticipantDisplayName': instance.otherParticipantDisplayName,
      'otherParticipantPhotoUrl': instance.otherParticipantPhotoUrl,
      'lastMessageContent': instance.lastMessageContent,
      'lastMessageCreatedAt': _$JsonConverterToJson<String, DateTime>(
          instance.lastMessageCreatedAt, const DateTimeConverter().toJson),
      'lastMessageSenderId': instance.lastMessageSenderId,
      'lastMessageSharedPostId': instance.lastMessageSharedPostId,
      'unreadCount': instance.unreadCount,
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
