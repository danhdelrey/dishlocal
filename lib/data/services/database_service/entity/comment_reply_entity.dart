import 'package:dishlocal/core/json_converter/date_time_converter.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'comment_reply_entity.freezed.dart';
part 'comment_reply_entity.g.dart';

/// Đại diện cho một bản ghi trong bảng `comment_replies`.
/// Đây là một trả lời cho một bình luận gốc.
@freezed
abstract class CommentReplyEntity with _$CommentReplyEntity {
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory CommentReplyEntity({
    /// PK: Primary Key, định danh duy nhất của trả lời.
    required String id,

    /// FK: Foreign Key, tham chiếu đến `post_comments.id` (bình luận gốc).
    required String parentCommentId,

    /// FK: Foreign Key, tham chiếu đến `profiles.id` của tác giả trả lời.
    required String authorId,

    /// FK: Foreign Key, tham chiếu đến `profiles.id` của người được trả lời.
    /// Dùng để hiển thị tag вида "@username".
    required String replyToUserId,

    /// Nội dung của trả lời.
    required String content,

    /// (Denormalized) Số lượt thích trên trả lời này.
    @Default(0) int likeCount,

    /// Thời điểm trả lời được tạo.
    @DateTimeConverter() required DateTime createdAt,
  }) = _CommentReplyEntity;

  factory CommentReplyEntity.fromJson(Map<String, dynamic> json) => _$CommentReplyEntityFromJson(json);
}
