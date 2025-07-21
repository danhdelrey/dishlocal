// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Message _$MessageFromJson(Map<String, dynamic> json) => _Message(
      messageId: json['messageId'] as String,
      conversationId: json['conversationId'] as String,
      senderId: json['senderId'] as String,
      content: json['content'] as String?,
      sharedPost: json['sharedPost'] == null
          ? null
          : Post.fromJson(json['sharedPost'] as Map<String, dynamic>),
      createdAt:
          const DateTimeConverter().fromJson(json['createdAt'] as String),
    );

Map<String, dynamic> _$MessageToJson(_Message instance) => <String, dynamic>{
      'messageId': instance.messageId,
      'conversationId': instance.conversationId,
      'senderId': instance.senderId,
      'content': instance.content,
      'sharedPost': instance.sharedPost?.toJson(),
      'createdAt': const DateTimeConverter().toJson(instance.createdAt),
    };
