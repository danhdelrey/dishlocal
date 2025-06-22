// file: lib/data/entities/follower_entity.dart

import 'package:dishlocal/core/json_converter/date_time_converter.dart';
import 'package:dishlocal/core/json_converter/timestamp_converter.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'follower_entity.freezed.dart';
part 'follower_entity.g.dart';

/// Đại diện cho một bản ghi trong bảng `followers`.
/// Bảng này thể hiện mối quan hệ "theo dõi".
@freezed
abstract class FollowerEntity with _$FollowerEntity {
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory FollowerEntity({
    /// FK: Người được theo dõi.
    required String userId,

    /// FK: Người đi theo dõi.
    required String followerId,

    /// Thời điểm mối quan hệ được tạo.
    @DateTimeConverter() required DateTime createdAt,
  }) = _FollowerEntity;

  factory FollowerEntity.fromJson(Map<String, dynamic> json) => _$FollowerEntityFromJson(json);
}
