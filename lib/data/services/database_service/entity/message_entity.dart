import 'package:dishlocal/core/json_converter/date_time_converter.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'message_entity.freezed.dart';
part 'message_entity.g.dart';

/// Đại diện cho một bản ghi trong bảng `messages`.
/// Một tin nhắn có thể là văn bản hoặc một bài post được chia sẻ.
/// Database có một CHECK constraint để đảm bảo `content` hoặc `sharedPostId` không được null cùng lúc.
@freezed
abstract class MessageEntity with _$MessageEntity {
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory MessageEntity({
    /// PK: Primary Key, định danh duy nhất của tin nhắn.
    required String id,

    /// FK: Tham chiếu đến `conversations.id` mà tin nhắn này thuộc về.
    required String conversationId,

    /// FK: Tham chiếu đến `profiles.id` của người gửi.
    required String senderId,

    /// Nội dung văn bản của tin nhắn. Có thể là null nếu đây là tin nhắn chia sẻ bài post.
    String? content,

    /// FK: Tham chiếu đến `posts.id` của bài post được chia sẻ.
    /// Có thể là null nếu đây là tin nhắn văn bản.
    String? sharedPostId,

    @Default('text') String messageType,

    /// Thời điểm tin nhắn được tạo.
    @DateTimeConverter() required DateTime createdAt,
  }) = _MessageEntity;

  factory MessageEntity.fromJson(Map<String, dynamic> json) => _$MessageEntityFromJson(json);
}
