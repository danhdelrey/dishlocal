import 'package:dartz/dartz.dart';
import 'package:dishlocal/data/categories/chat/model/conversation.dart';
import 'package:dishlocal/data/categories/chat/model/message.dart';
import 'package:dishlocal/data/categories/chat/repository/failure/chat_failure.dart';
import 'package:dishlocal/data/services/database_service/entity/message_entity.dart';

abstract class ChatRepository {
  /// Lấy danh sách các cuộc trò chuyện của người dùng hiện tại.
  /// Được sắp xếp theo tin nhắn gần nhất.
  Future<Either<ChatFailure, List<Conversation>>> getMyConversations();

  /// Lấy tin nhắn trong một cuộc trò chuyện cụ thể, có hỗ trợ phân trang.
  /// - [conversationId]: ID của cuộc trò chuyện.
  /// - [page]: Số trang để lấy (bắt đầu từ 1).
  /// - [limit]: Số lượng tin nhắn mỗi trang.
  Future<Either<ChatFailure, List<MessageEntity>>> getMessages({
    required String conversationId,
    required int page,
    int limit = 20, // Số lượng tin nhắn mặc định cho mỗi lần tải
  });

  /// Bắt đầu một cuộc trò chuyện 1-1 mới với một người dùng khác,
  /// hoặc lấy ID của cuộc trò chuyện đã tồn tại.
  /// Trả về [String] là ID của cuộc trò chuyện.
  Future<Either<ChatFailure, String>> getOrCreateConversation({
    required String otherUserId,
  });

  /// Gửi một tin nhắn mới.
  /// Tin nhắn có thể là văn bản (`content`) hoặc một bài post được chia sẻ (`sharedPostId`).
  /// Trả về object [MessageEntity] vừa được tạo để cập nhật ngay lên UI.
  Future<Either<ChatFailure, MessageEntity>> sendMessage({
    required String conversationId,
    String? content,
    String? sharedPostId,
  });

  Future<Either<ChatFailure, void>> markConversationAsReadAndTouch({required String conversationId});

  /// Lắng nghe các tin nhắn mới trong một cuộc trò chuyện theo thời gian thực.
  /// Trả về một Stream chứa [MessageEntity] mới.
  Stream<Either<ChatFailure, MessageEntity>> subscribeToMessages({
    required String conversationId,
  });

  void initializeConversationListSubscription({
    required String userId,
  });

  void disposeConversationListSubscription();

  Future<Either<ChatFailure, void>> deleteConversation({required String conversationId});

  /// Lấy trạng thái đã đọc ban đầu cho tất cả người tham gia.
  Future<Either<ChatFailure, List<Map<String, dynamic>>>> getReadStatuses({required String conversationId});
}
