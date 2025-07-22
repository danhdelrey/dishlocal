import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:dishlocal/data/categories/chat/model/conversation.dart';
import 'package:dishlocal/data/categories/chat/model/message.dart';
import 'package:dishlocal/data/categories/chat/repository/failure/chat_failure.dart';
import 'package:dishlocal/data/categories/chat/repository/interface/chat_repository.dart';
import 'package:dishlocal/data/categories/post/model/post.dart';
import 'package:dishlocal/data/global/chat_event_bus.dart';
import 'package:dishlocal/data/services/database_service/entity/message_entity.dart';
import 'package:injectable/injectable.dart';
import 'package:logging/logging.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

@LazySingleton(as: ChatRepository)
class ChatRepositoryImpl implements ChatRepository {
  final _log = Logger('ChatRepositoryImpl');
  final _supabase = Supabase.instance.client;
  final ChatEventBus _chatEventBus;

  // Giữ lại channel để có thể hủy khi cần
  RealtimeChannel? _conversationListChannel;

  // Constructor được cập nhật
  ChatRepositoryImpl(this._chatEventBus) {
    // Khởi tạo việc lắng nghe ngay khi repository được tạo
    //_initializeConversationListSubscription();
  }

  // Xóa phương thức `subscribeToConversationListChanges()` cũ.
  // Thay vào đó, chúng ta sẽ quản lý nó bên trong repository.
  @override
  void initializeConversationListSubscription({required String userId}) {
    // Tránh đăng ký nhiều lần
    if (_conversationListChannel != null) return;

    _log.info('Initializing conversation list subscription via EventBus.');
    _conversationListChannel = _supabase.channel('conversation-list-changes');

    _conversationListChannel!
        .onPostgresChanges(
          event: PostgresChangeEvent.all,
          schema: 'public',
          table: 'conversations',
          callback: (payload) {
            _log.finer('Realtime event on "conversations". Firing event bus.');
            _chatEventBus.fireChatDataChanged(); // Phát sự kiện
          },
        )
        .onPostgresChanges(
          event: PostgresChangeEvent.update,
          schema: 'public',
          table: 'conversation_participants',
          filter: PostgresChangeFilter(
            type: PostgresChangeFilterType.eq,
            column: 'user_id',
            value: userId,
          ),
          callback: (payload) {
            _log.finer('Realtime event on "conversation_participants". Firing event bus.');
            _chatEventBus.fireChatDataChanged(); // Phát sự kiện
          },
        )
        .subscribe();
  }

  @override
  Future<Either<ChatFailure, List<Conversation>>> getMyConversations() async {
    try {
      _log.info('RPC: get_my_conversations');
      final result = await _supabase.rpc('get_my_conversations');
      _log.finer('RPC response: $result');

      // Ép kiểu kết quả thành một List<dynamic>
      final List<dynamic> dataList = result as List<dynamic>;

      // Sử dụng vòng lặp for thay vì .map() để gỡ lỗi dễ hơn
      final List<Conversation> conversations = [];
      for (final data in dataList) {
        try {
          // Cố gắng parse từng object JSON
          final conversation = Conversation.fromJson(data as Map<String, dynamic>);
          conversations.add(conversation);
        } catch (e, stackTrace) {
          // NẾU CÓ LỖI, IN RA CHÍNH XÁC OBJECT GÂY LỖI
          _log.severe('!!! LỖI PARSE JSON !!!');
          _log.severe('Object gây lỗi: $data');
          _log.severe('Lỗi cụ thể: $e');
          _log.severe('Stack trace: $stackTrace');
          // Ném lại lỗi để BLoC có thể bắt được và hiển thị thông báo lỗi
          rethrow;
        }
      }

      return Right(conversations);
    } catch (e) {
      _log.severe('An unexpected error occurred in getMyConversations');
      _log.severe(e.toString()); // In lỗi ra log
      return Left(ChatOperationFailure('Đã xảy ra lỗi không mong muốn: ${e.toString()}'));
    }
  }

  @override
  Future<Either<ChatFailure, List<MessageEntity>>> getMessages({
    required String conversationId,
    required int page,
    int limit = 20,
  }) async {
    try {
      final from = (page - 1) * limit;
      final to = from + limit - 1;

      _log.info('Querying messages (basic) for conversation $conversationId, page: $page');

      // === THAY ĐỔI: Query rất đơn giản, không JOIN ===
      final result = await _supabase
          .from('messages')
          .select('*') // Lấy tất cả các cột của bảng messages
          .eq('conversation_id', conversationId)
          .order('created_at', ascending: false)
          .range(from, to);

      _log.finer('Query response: $result');

      // Bây giờ chúng ta sẽ parse thành MessageEntity thay vì Message
      final messages = (result as List<dynamic>).map((data) => MessageEntity.fromJson(data as Map<String, dynamic>)).toList();

      return Right(messages);
    } on PostgrestException catch (e) {
      _log.severe('Query messages failed', e);
      return Left(ChatOperationFailure(e.message));
    } catch (e) {
      _log.severe('An unexpected error occurred in getMessages', e);
      return Left(ChatOperationFailure('Đã xảy ra lỗi không mong muốn: ${e.toString()}'));
    }
  }

  @override
  Future<Either<ChatFailure, String>> getOrCreateConversation({
    required String otherUserId,
  }) async {
    try {
      _log.info('RPC: get_or_create_conversation with otherUserId: $otherUserId');
      final result = await _supabase.rpc(
        'get_or_create_conversation',
        params: {'other_user_id': otherUserId},
      );
      _log.finer('RPC response: $result');

      if (result == null) {
        return const Left(UserNotFoundFailure());
      }

      return Right(result as String);
    } on PostgrestException catch (e) {
      _log.severe('RPC get_or_create_conversation failed', e);
      return Left(ChatOperationFailure(e.message));
    } catch (e) {
      _log.severe('An unexpected error occurred in getOrCreateConversation', e);
      return Left(ChatOperationFailure('Đã xảy ra lỗi không mong muốn: ${e.toString()}'));
    }
  }

  @override
  Future<Either<ChatFailure, MessageEntity>> sendMessage({
    // Kiểu trả về là MessageEntity
    required String conversationId,
    String? content,
    String? sharedPostId,
  }) async {
    try {
      _log.info('RPC: send_message (optimized) to conversation $conversationId');

      // RPC bây giờ trả về một danh sách chứa một record
      final result = await _supabase.rpc(
        'send_message',
        params: {
          'p_conversation_id': conversationId,
          'p_content': content,
          'p_shared_post_id': sharedPostId,
        },
      ).single(); // Dùng .single() để lấy record duy nhất đó

      _log.finer('RPC response: $result');

      // Parse kết quả trực tiếp thành MessageEntity
      final messageEntity = MessageEntity.fromJson(result as Map<String, dynamic>);

      return Right(messageEntity);
    } on PostgrestException catch (e) {
      _log.severe('RPC send_message failed', e);
      if (e.code == 'P0001') {
        return const Left(ChatPermissionDenied());
      }
      return Left(ChatOperationFailure(e.message));
    } catch (e) {
      _log.severe('An unexpected error occurred in sendMessage', e);
      return Left(ChatOperationFailure('Đã xảy ra lỗi không mong muốn: ${e.toString()}'));
    }
  }

  @override
  Future<Either<ChatFailure, void>> markConversationAsRead({
    required String conversationId,
  }) async {
    try {
      _log.info('RPC: mark_conversation_as_read for conversation $conversationId');
      await _supabase.rpc(
        'mark_conversation_as_read',
        params: {'p_conversation_id': conversationId},
      );
      _log.finer('RPC call successful');

      return const Right(null);
    } on PostgrestException catch (e) {
      _log.severe('RPC mark_conversation_as_read failed', e);
      return Left(ChatOperationFailure(e.message));
    } catch (e) {
      _log.severe('An unexpected error occurred in markConversationAsRead', e);
      return Left(ChatOperationFailure('Đã xảy ra lỗi không mong muốn: ${e.toString()}'));
    }
  }

  @override
  Stream<Either<ChatFailure, MessageEntity>> subscribeToMessages({
    required String conversationId,
  }) {
    _log.info('Subscribing to realtime messages for conversation $conversationId');
    final streamController = StreamController<Either<ChatFailure, MessageEntity>>();

    final channel = _supabase.channel('public:messages:conversation_id=eq.$conversationId');

    channel
        .onPostgresChanges(
      event: PostgresChangeEvent.insert,
      schema: 'public',
      table: 'messages',
      filter: PostgresChangeFilter(
        type: PostgresChangeFilterType.eq,
        column: 'conversation_id',
        value: conversationId,
      ),
      callback: (payload) async {
        try {
          _log.finer('Received realtime payload: ${payload.newRecord}');
          // === THAY ĐỔI: Chỉ cần parse thành MessageEntity ===
          final messageEntity = MessageEntity.fromJson(payload.newRecord);

          // Chúng ta sẽ không trả về Message đầy đủ ở đây nữa
          // BLoC sẽ chịu trách nhiệm làm giàu dữ liệu
          streamController.add(Right(messageEntity));
        } catch (e) {
          _log.severe('Error processing realtime message', e);
          streamController.add(Left(ChatOperationFailure('Lỗi xử lý tin nhắn real-time: ${e.toString()}')));
        }
      },
    )
        .subscribe((status, [error]) {
      if (status == RealtimeSubscribeStatus.channelError || status == RealtimeSubscribeStatus.closed) {
        _log.severe('Realtime channel error for messages: $error');
        streamController.add(Left(ChatOperationFailure('Kết nối real-time bị lỗi: ${error.toString()}')));
      } else if (status == RealtimeSubscribeStatus.subscribed) {
        _log.info('Successfully subscribed to messages for conversation $conversationId');
      }
    });

     streamController.onCancel = () {
      _log.info('Unsubscribing from messages channel for $conversationId');
      _supabase.removeChannel(channel);
    };

    return streamController.stream;
  }
}
