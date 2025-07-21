import 'package:dishlocal/core/json_converter/date_time_converter.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'conversation_entity.freezed.dart';
part 'conversation_entity.g.dart';

/// Đại diện cho một bản ghi trong bảng `conversations`.
/// Mỗi bản ghi là một cuộc trò chuyện duy nhất.
@freezed
abstract class ConversationEntity with _$ConversationEntity {
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory ConversationEntity({
    /// PK: Primary Key, định danh duy nhất của cuộc trò chuyện.
    required String id,

    /// Thời điểm cuộc trò chuyện được tạo.
    @DateTimeConverter() required DateTime createdAt,

    /// (Denormalized) Thời điểm của tin nhắn cuối cùng trong cuộc trò chuyện.
    /// Dùng để sắp xếp danh sách chat một cách hiệu quả.
    @DateTimeConverter() DateTime? lastMessageAt,
  }) = _ConversationEntity;

  factory ConversationEntity.fromJson(Map<String, dynamic> json) => _$ConversationEntityFromJson(json);
}
