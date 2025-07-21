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
    /// ID của tin nhắn.
    required String messageId,

    /// ID của cuộc trò chuyện mà tin nhắn này thuộc về.
    required String conversationId,

    /// ID của người gửi. UI sẽ so sánh với ID người dùng hiện tại
    /// để xác định tin nhắn gửi đi hay nhận được.
    required String senderId,

    /// Nội dung văn bản của tin nhắn.
    String? content,

    /// Object Post được chia sẻ.
    /// Repository sẽ có trách nhiệm lấy thông tin Post từ `sharedPostId`
    /// để điền vào đây.
    Post? sharedPost,

    /// Thời điểm tin nhắn được tạo.
    @DateTimeConverter() required DateTime createdAt,

    /// Trạng thái của tin nhắn trên UI.
    /// Trường này không có trong database, chỉ tồn tại ở client.
    /// `includeToJson: false` để không gửi trường này lên server.
    @JsonKey(includeToJson: false, includeFromJson: false)
    @Default(MessageStatus.sent) MessageStatus status,

  }) = _Message;

  // Lưu ý: Chúng ta thường không cần fromJson cho model này vì nó
  // được tạo ra trong Repository, không phải trực tiếp từ một API response duy nhất.
  // Tuy nhiên, việc có nó cũng không gây hại và có thể hữu ích cho việc cache.
  factory Message.fromJson(Map<String, dynamic> json) => _$MessageFromJson(json);
}