import 'package:dishlocal/core/json_converter/date_time_converter.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'conversation_participant_entity.freezed.dart';
part 'conversation_participant_entity.g.dart';

/// Đại diện cho một bản ghi trong bảng `conversation_participants`.
/// Liên kết một người dùng vào một cuộc trò chuyện.
@freezed
abstract class ConversationParticipantEntity with _$ConversationParticipantEntity {
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory ConversationParticipantEntity({
    /// PK, FK: Tham chiếu đến `conversations.id`.
    required String conversationId,

    /// PK, FK: Tham chiếu đến `profiles.id` của người tham gia.
    required String userId,

    /// Thời điểm cuối cùng người dùng đọc tin nhắn trong cuộc trò chuyện này.
    /// Giá trị này dùng để xác định tin nhắn chưa đọc và trạng thái "Đã xem".
    @DateTimeConverter() DateTime? lastReadAt,
  }) = _ConversationParticipantEntity;

  factory ConversationParticipantEntity.fromJson(Map<String, dynamic> json) => _$ConversationParticipantEntityFromJson(json);
}
