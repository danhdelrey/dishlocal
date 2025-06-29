import 'package:dishlocal/core/json_converter/date_time_converter.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'comment.freezed.dart';
part 'comment.g.dart';

/// Model đại diện cho một bình luận gốc (root-level) đã được làm giàu thông tin
/// để hiển thị trên giao diện người dùng (UI).
/// Dữ liệu này là kết quả từ hàm RPC `get_post_comments`.
@freezed
abstract class Comment with _$Comment {
  @JsonSerializable(explicitToJson: true)
  const factory Comment({
    /// ID duy nhất của bình luận.
    required String commentId,

    /// ID của người dùng đã viết bình luận.
    required String authorUserId,

    /// Tên người dùng của tác giả (từ `profiles.username`).
    required String authorUsername,

    /// URL ảnh đại diện của tác giả (từ `profiles.photo_url`).
    String? authorAvatarUrl,

    /// Nội dung văn bản của bình luận.
    required String content,

    /// Thời điểm bình luận được tạo.
    @DateTimeConverter() required DateTime createdAt,

    /// Số lượt thích của bình luận.
    required int likeCount,

    /// Số lượt trả lời của bình luận.
    required int replyCount,

    /// Cờ cho biết người dùng hiện tại có thích bình luận này hay không.
    /// Giá trị này được tính toán trong hàm RPC.
    required bool isLiked,
  }) = _Comment;

  factory Comment.fromJson(Map<String, dynamic> json) => _$CommentFromJson(json);
}
