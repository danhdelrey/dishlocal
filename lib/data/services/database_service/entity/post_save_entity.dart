// file: lib/data/entities/post_like_entity.dart

import 'package:dishlocal/core/json_converter/date_time_converter.dart';
import 'package:dishlocal/core/json_converter/timestamp_converter.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'post_save_entity.freezed.dart';
part 'post_save_entity.g.dart';

/// Đại diện cho một lượt thích trên một bài post.
@freezed
abstract class PostSaveEntity with _$PostSaveEntity {
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory PostSaveEntity({
    /// FK: Bài post được lưu.
    required String postId,

    /// FK: Người dùng đã lưu bài post.
    required String userId,

    /// Thời điểm lượt thích được tạo.
    @DateTimeConverter() required DateTime createdAt,
  }) = _PostSaveEntity;

  factory PostSaveEntity.fromJson(Map<String, dynamic> json) => _$PostSaveEntityFromJson(json);
}
