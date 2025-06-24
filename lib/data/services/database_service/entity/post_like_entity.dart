// file: lib/data/entities/post_like_entity.dart

import 'package:dishlocal/core/json_converter/date_time_converter.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'post_like_entity.freezed.dart';
part 'post_like_entity.g.dart';

/// Đại diện cho một lượt thích trên một bài post.
@freezed
abstract class PostLikeEntity with _$PostLikeEntity {
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory PostLikeEntity({
    /// FK: Bài post được thích.
    required String postId,

    /// FK: Người dùng đã thích bài post.
    required String userId,

    /// Thời điểm lượt thích được tạo.
    @DateTimeConverter() required DateTime createdAt,
  }) = _PostLikeEntity;

  factory PostLikeEntity.fromJson(Map<String, dynamic> json) => _$PostLikeEntityFromJson(json);
}
