import 'package:dishlocal/core/json_converter/date_time_converter.dart';
import 'package:dishlocal/data/categories/post/model/post.dart';
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
  @JsonSerializable(explicitToJson: true)
  const factory Message({
    required String messageId,
    required String conversationId,
    required String senderId,

    // Đã là nullable, đúng
    String? content,

    // Đã là nullable, đúng
    Post? sharedPost,
    required DateTime createdAt,
    @JsonKey(includeToJson: false, includeFromJson: false) @Default(MessageStatus.sent) MessageStatus status,

    // Thêm trường này để dễ dàng parse từ JSON của RPC
    // Nó sẽ không được sử dụng trực tiếp trên UI
    @JsonKey(includeFromJson: false, includeToJson: false) String? sharedPostId,
  }) = _Message;

  factory Message.fromJson(Map<String, dynamic> json) => _$MessageFromJson(json);
}
