import 'package:dishlocal/core/json_converter/date_time_converter.dart';
import 'package:dishlocal/data/categories/app_user/model/app_user.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'conversation.freezed.dart';
part 'conversation.g.dart';

@freezed
abstract class Conversation with _$Conversation {
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory Conversation({
    required String conversationId,
    required AppUser otherParticipant,
    String? lastMessageContent,
    @DateTimeConverter() DateTime? lastMessageCreatedAt,
    String? lastMessageSenderId,
    String? lastMessageSharedPostId,
    @Default(0) int unreadCount,
  }) = _Conversation;

  factory Conversation.fromJson(Map<String, dynamic> json) => _$ConversationFromJson(json);
}
