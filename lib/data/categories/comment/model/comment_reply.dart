import 'package:dishlocal/core/json_converter/date_time_converter.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'comment_reply.freezed.dart';
part 'comment_reply.g.dart';

/// Model đại diện cho một bình luận trả lời (reply) đã được làm giàu thông tin
/// để hiển thị trên giao diện người dùng (UI).
/// Dữ liệu này là kết quả từ hàm RPC `get_comment_replies`.
@freezed
abstract class CommentReply with _$CommentReply {
  @JsonSerializable(explicitToJson: true)
  const factory CommentReply({
    /// ID duy nhất của trả lời.
    required String replyId,

    /// ID của người dùng đã viết trả lời.
    required String authorUserId,

    /// Tên người dùng của tác giả trả lời.
    required String authorUsername,

    /// URL ảnh đại diện của tác giả trả lời.
    String? authorAvatarUrl,

    /// ID của người dùng được trả lời.
    required String replyToUserId,

    /// Tên người dùng của người được trả lời (để hiển thị "@username").
    required String replyToUsername,

    /// Nội dung văn bản của trả lời.
    required String content,

    /// Thời điểm trả lời được tạo.
    @DateTimeConverter() required DateTime createdAt,

    /// Số lượt thích của trả lời.
    required int likeCount,

    /// Cờ cho biết người dùng hiện tại có thích trả lời này hay không.
    /// Giá trị này được tính toán trong hàm RPC.
    required bool isLiked,
  }) = _CommentReply;

  factory CommentReply.fromJson(Map<String, dynamic> json) => _$CommentReplyFromJson(json);
}
