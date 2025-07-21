import 'package:dishlocal/core/json_converter/date_time_converter.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'conversation.freezed.dart';
part 'conversation.g.dart';

/// Đại diện cho một cuộc trò chuyện trong danh sách chat của người dùng.
/// Model này được thiết kế cho lớp UI/Domain, tổng hợp thông tin cần thiết
/// để hiển thị một dòng trong danh sách.
@freezed
abstract class Conversation with _$Conversation {
  @JsonSerializable(explicitToJson: true)
  const factory Conversation({
    /// ID của cuộc trò chuyện, lấy từ `conversations.id`.
    required String conversationId,

    /// ID của người đối thoại.
    required String otherParticipantId,

    /// Tên đăng nhập của người đối thoại, lấy từ `profiles.username`.
    required String otherParticipantUsername,

    /// Tên hiển thị của người đối thoại, lấy từ `profiles.display_name`.
    String? otherParticipantDisplayName,

    /// URL ảnh đại diện của người đối thoại, lấy từ `profiles.photo_url`.
    String? otherParticipantPhotoUrl,

    /// Nội dung của tin nhắn cuối cùng để hiển thị preview.
    String? lastMessageContent,

    /// Thời gian của tin nhắn cuối cùng, dùng để sắp xếp và hiển thị.
    @DateTimeConverter() DateTime? lastMessageCreatedAt,

    /// ID của người gửi tin nhắn cuối cùng. Dùng để hiển thị "Bạn: ..."
    String? lastMessageSenderId,

    /// ID của bài post được chia sẻ trong tin nhắn cuối cùng (nếu có).
    /// Dùng để hiển thị icon [Bài viết] hoặc tương tự.
    String? lastMessageSharedPostId,

    /// Số lượng tin nhắn chưa đọc trong cuộc trò chuyện này.
    /// Dùng để hiển thị huy hiệu (badge).
    @Default(0) int unreadCount,
  }) = _Conversation;

  factory Conversation.fromJson(Map<String, dynamic> json) => _$ConversationFromJson(json);
}
