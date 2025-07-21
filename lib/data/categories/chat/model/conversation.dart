import 'package:dishlocal/core/json_converter/date_time_converter.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'conversation.freezed.dart';
part 'conversation.g.dart';

@freezed
abstract class Conversation with _$Conversation {
  @JsonSerializable(explicitToJson: true)
  const factory Conversation({
    required String conversationId,
    required String otherParticipantId,

    // Username không thể null vì profile phải có username
    required String otherParticipantUsername,

    // Các trường này có thể null trong profile
    String? otherParticipantDisplayName,
    String? otherParticipantPhotoUrl,

    // === THAY ĐỔI QUAN TRỌNG NHẤT ===
    // Các trường này SẼ LÀ NULL nếu chưa có tin nhắn nào
    String? lastMessageContent,
    @DateTimeConverter() DateTime? lastMessageCreatedAt,
    String? lastMessageSenderId,
    String? lastMessageSharedPostId,
    @Default(0) int unreadCount,
  }) = _Conversation;

  factory Conversation.fromJson(Map<String, dynamic> json) => _$ConversationFromJson(json);
}
