import 'package:dishlocal/core/json_converter/date_time_converter.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'comment_reply_like_entity.freezed.dart';
part 'comment_reply_like_entity.g.dart';

/// Đại diện cho một bản ghi trong bảng `comment_reply_likes`.
/// Thể hiện một lượt thích của người dùng trên một trả lời.
@freezed
abstract class CommentReplyLikeEntity with _$CommentReplyLikeEntity {
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory CommentReplyLikeEntity({
    /// PK, FK: Tham chiếu đến `comment_replies.id`.
    required String replyId,

    /// PK, FK: Tham chiếu đến `profiles.id` của người dùng đã thích.
    required String userId,

    /// Thời điểm lượt thích được tạo.
    @DateTimeConverter() required DateTime createdAt,
  }) = _CommentReplyLikeEntity;

  factory CommentReplyLikeEntity.fromJson(Map<String, dynamic> json) => _$CommentReplyLikeEntityFromJson(json);
}
