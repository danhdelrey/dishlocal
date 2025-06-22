// file: lib/data/entities/profile_entity.dart

import 'package:freezed_annotation/freezed_annotation.dart';

part 'profile_entity.freezed.dart';
part 'profile_entity.g.dart';

/// Đại diện cho một bản ghi trong bảng `profiles`.
/// Lưu trữ thông tin công khai của người dùng.
@freezed
abstract class ProfileEntity with _$ProfileEntity {
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory ProfileEntity({
    /// PK: Primary Key, cũng là Foreign Key tham chiếu đến `auth.users.id`.
    required String id,

    /// Tên người dùng duy nhất, không thể thay đổi, dùng cho @mentions.
    required String username,

    /// Tên hiển thị, có thể thay đổi.
    String? displayName,

    /// URL ảnh đại diện.
    String? photoUrl,

    /// Giới thiệu ngắn về người dùng.
    String? bio,

    /// (Denormalized) Số lượng người theo dõi, được cập nhật bằng triggers.
    @Default(0) int followerCount,

    /// (Denormalized) Số lượng người đang theo dõi, được cập nhật bằng triggers.
    @Default(0) int followingCount,

    /// Thời điểm hồ sơ được cập nhật lần cuối.
    required DateTime updatedAt,
  }) = _ProfileEntity;

  factory ProfileEntity.fromJson(Map<String, dynamic> json) => _$ProfileEntityFromJson(json);
}
