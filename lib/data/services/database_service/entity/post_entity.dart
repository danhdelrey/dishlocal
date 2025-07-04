// file: lib/data/entities/post_entity.dart

import 'package:dishlocal/core/json_converter/date_time_converter.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'post_entity.freezed.dart';
part 'post_entity.g.dart';

/// Đại diện cho một bản ghi trong bảng `posts`.
@freezed
abstract class PostEntity with _$PostEntity {
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory PostEntity({
    /// PK: Primary Key, định danh duy nhất của bài post.
    required String id,

    /// FK: Foreign Key, tham chiếu đến `profiles.id` của tác giả.
    required String authorId,

    /// URL của hình ảnh chính.
    String? imageUrl,

    /// Chuỗi blurhash để hiển thị placeholder khi tải ảnh.
    String? blurHash,

    /// Tên món ăn.
    String? dishName,

    /// Tên gợi ý của địa điểm (ví dụ: "Bún bò Huế O Cương Chú Điền").
    String? locationName,

    /// Địa chỉ chi tiết, đầy đủ của địa điểm.
    String? locationAddress,

    /// Vĩ độ.
    double? latitude,

    /// Kinh độ.
    double? longitude,

    /// Giá tiền (nếu có).
    int? price,

    /// Nội dung/đánh giá chi tiết của người dùng về món ăn.
    String? insight,

    /// (Denormalized) Số lượt thích, được cập nhật bằng triggers.
    @Default(0) int likeCount,

    /// (Denormalized) Số lượt lưu, được cập nhật bằng triggers.
    @Default(0) int saveCount,

    @Default(0) int commentCount,

    /// Thời điểm bài post được tạo.
    @DateTimeConverter() required DateTime createdAt,
  }) = _PostEntity;

  factory PostEntity.fromJson(Map<String, dynamic> json) => _$PostEntityFromJson(json);
}
