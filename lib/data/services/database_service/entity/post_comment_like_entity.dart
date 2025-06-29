import 'package:dishlocal/core/json_converter/date_time_converter.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'post_comment_like_entity.freezed.dart';
part 'post_comment_like_entity.g.dart';

/// Đại diện cho một bản ghi trong bảng `post_comment_likes`.
/// Thể hiện một lượt thích của người dùng trên một bình luận gốc.
@freezed
abstract class PostCommentLikeEntity with _$PostCommentLikeEntity {
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory PostCommentLikeEntity({
    /// PK, FK: Tham chiếu đến `post_comments.id`.
    required String commentId,

    /// PK, FK: Tham chiếu đến `profiles.id` của người dùng đã thích.
    required String userId,

    /// Thời điểm lượt thích được tạo.
    @DateTimeConverter() required DateTime createdAt,
  }) = _PostCommentLikeEntity;

  factory PostCommentLikeEntity.fromJson(Map<String, dynamic> json) => _$PostCommentLikeEntityFromJson(json);
}
