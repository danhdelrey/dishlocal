
import 'package:dishlocal/core/json_converter/date_time_converter.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'post_comment_entity.freezed.dart';
part 'post_comment_entity.g.dart';

/// Đại diện cho một bản ghi trong bảng `post_comments`.
/// Đây là một bình luận gốc (root-level) của một bài đăng.
@freezed
abstract class PostCommentEntity with _$PostCommentEntity {
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory PostCommentEntity({
    /// PK: Primary Key, định danh duy nhất của bình luận.
    required String id,

    /// FK: Foreign Key, tham chiếu đến `posts.id` mà bình luận này thuộc về.
    required String postId,

    /// FK: Foreign Key, tham chiếu đến `profiles.id` của tác giả bình luận.
    required String authorId,

    /// Nội dung của bình luận.
    required String content,

    /// (Denormalized) Số lượt thích trên bình luận này.
    @Default(0) int likeCount,

    /// (Denormalized) Số lượt trả lời cho bình luận này.
    @Default(0) int replyCount,

    /// Thời điểm bình luận được tạo.
    @DateTimeConverter() required DateTime createdAt,
  }) = _PostCommentEntity;

  factory PostCommentEntity.fromJson(Map<String, dynamic> json) => _$PostCommentEntityFromJson(json);
}
