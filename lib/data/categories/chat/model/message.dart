import 'package:dishlocal/core/json_converter/date_time_converter.dart';
import 'package:dishlocal/data/categories/post/model/post.dart';
import 'package:dishlocal/data/services/database_service/entity/message_entity.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'message.freezed.dart';
part 'message.g.dart';

enum MessageStatus {
  /// Đang gửi đi, UI có thể hiển thị icon đồng hồ.
  sending,

  /// Đã gửi thành công đến server.
  sent,

  /// Đã được người nhận đọc (yêu cầu logic bổ sung để theo dõi).
  read,

  /// Gửi thất bại.
  failed,
}



@freezed
abstract class Message with _$Message {
  @JsonSerializable(explicitToJson: true, fieldRename: FieldRename.snake)
  const factory Message({
    required String id,
    required String conversationId,
    required String senderId,
    String? content,
    Post? sharedPost,
    String? sharedPostId,
    @DateTimeConverter() required DateTime createdAt,
    @JsonKey(includeToJson: false, includeFromJson: false) @Default(MessageStatus.sent) MessageStatus status,
  }) = _Message;

  factory Message.fromEntity(MessageEntity entity, {Post? sharedPost}) {
    return Message(
      id: entity.id,
      conversationId: entity.conversationId,
      senderId: entity.senderId,
      content: entity.content,
      createdAt: entity.createdAt,
      sharedPost: sharedPost,
      sharedPostId: entity.sharedPostId,
    );
  }

  factory Message.fromJson(Map<String, dynamic> json) => _$MessageFromJson(json);
}
