import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:dishlocal/data/categories/chat/model/conversation.dart';
import 'package:dishlocal/data/categories/chat/model/message.dart';
import 'package:dishlocal/data/categories/chat/repository/failure/chat_failure.dart';
import 'package:dishlocal/data/categories/chat/repository/interface/chat_repository.dart';
import 'package:dishlocal/data/categories/post/model/post.dart';
import 'package:injectable/injectable.dart';
import 'package:logging/logging.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

@LazySingleton(as: ChatRepository)
class ChatRepositoryImpl implements ChatRepository {
  final _log = Logger('ChatRepositoryImpl');
  final _supabase = Supabase.instance.client;

  @override
  Future<Either<ChatFailure, List<Conversation>>> getMyConversations() async {
    try {
      _log.info('RPC: get_my_conversations');
      final result = await _supabase.rpc('get_my_conversations');
      _log.finer('RPC response: $result');

      final conversations = (result as List<dynamic>).map((data) => Conversation.fromJson(data as Map<String, dynamic>)).toList();

      return Right(conversations);
    } on PostgrestException catch (e) {
      _log.severe('RPC get_my_conversations failed', e);
      return Left(ChatOperationFailure(e.message));
    } catch (e) {
      _log.severe('An unexpected error occurred in getMyConversations', e);
      return Left(ChatOperationFailure('Đã xảy ra lỗi không mong muốn: ${e.toString()}'));
    }
  }

  @override
  Future<Either<ChatFailure, List<Message>>> getMessages({
    required String conversationId,
    required int page,
    int limit = 20,
  }) async {
    try {
      final from = (page - 1) * limit;
      final to = from + limit - 1;

      _log.info('Query: messages for conversation $conversationId, page: $page, limit: $limit (range: $from-$to)');

      // THAY ĐỔI: Chỉ định rõ mối quan hệ `posts_author_id_fkey`
      final result = await _supabase.from('messages').select('*, shared_post:posts(*, author:profiles!posts_author_id_fkey(*))').eq('conversation_id', conversationId).order('created_at', ascending: false).range(from, to);

      _log.finer('Query response: $result');

      final messages = (result as List<dynamic>).map((data) {
        final entityData = data as Map<String, dynamic>;

        if (entityData['shared_post'] != null) {
          // Giả sử model Post của bạn có thể parse từ json này
          entityData['sharedPost'] = Post.fromJson(entityData['shared_post']);
        }

        return Message.fromJson(entityData);
      }).toList();

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
  Future<Either<ChatFailure, Message>> sendMessage({
    required String conversationId,
    String? content,
    String? sharedPostId,
  }) async {
    try {
      _log.info('RPC: send_message to conversation $conversationId');

      // THAY ĐỔI: Chỉ gọi RPC và không cần .select() nữa
      final result = await _supabase.rpc(
        'send_message',
        params: {
          'p_conversation_id': conversationId,
          'p_content': content,
          'p_shared_post_id': sharedPostId,
        },
      );

      _log.finer('RPC response: $result');

      // Kết quả trả về trực tiếp là JSON chúng ta đã xây dựng
      final entityData = result as Map<String, dynamic>;

      // logic parse JSON lồng nhau cho 'sharedPost'
      if (entityData['shared_post'] != null) {
        // Đổi tên key để khớp với model 'Message'
        entityData['sharedPost'] = entityData['shared_post'];
      }

      final message = Message.fromJson(entityData);

      return Right(message);
    } on PostgrestException catch (e) {
      _log.severe('RPC send_message failed', e);
      if (e.code == 'P0001') {
        return const Left(ChatPermissionDenied());
      }
      return Left(ChatOperationFailure(e.message));
    } catch (e) {
      _log.severe('An unexpected error occurred in sendMessage', e);
      // In lỗi gốc để debug
      _log.severe(e.toString());
      return const Left(ChatOperationFailure('Đã xảy ra lỗi không mong muốn.'));
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
  Stream<Either<ChatFailure, Message>> subscribeToMessages({
    required String conversationId,
  }) {
    _log.info('Subscribing to realtime messages for conversation $conversationId');
    final streamController = StreamController<Either<ChatFailure, Message>>();

    // THAY ĐỔI: Tạo channel riêng biệt trước
    final channel = _supabase.channel('public:messages:conversation_id=eq.$conversationId');

    channel
        .onPostgresChanges(
      event: PostgresChangeEvent.insert,
      schema: 'public',
      table: 'messages',
      // Bộ lọc này đã được áp dụng khi tạo channel ở trên,
      // nhưng thêm vào đây sẽ đảm bảo tính chính xác.
      filter: PostgresChangeFilter(
        type: PostgresChangeFilterType.eq,
        column: 'conversation_id',
        value: conversationId,
      ),
      callback: (payload) async {
        try {
          _log.finer('Received realtime payload: ${payload.newRecord}');
          final newMessageData = payload.newRecord;

          // Dữ liệu từ realtime không có join, ta cần fetch lại để có đầy đủ thông tin
          final messageId = newMessageData['id'];

          final result = await _supabase.from('messages').select('*, shared_post:posts(*, author:profiles!posts_author_id_fkey(*))').eq('id', messageId).single();

          final entityData = result;
          if (entityData['shared_post'] != null) {
            entityData['sharedPost'] = Post.fromJson(entityData['shared_post']);
          }
          final message = Message.fromJson(entityData);

          streamController.add(Right(message));
        } catch (e) {
          _log.severe('Error processing realtime message', e);
          streamController.add(Left(ChatOperationFailure('Lỗi xử lý tin nhắn real-time: ${e.toString()}')));
        }
      },
    )
        .subscribe((status, [error]) {
      if (status == 'CHANNEL_ERROR' || status == 'CLOSED') {
        _log.severe('Realtime channel error for messages: $error');
        streamController.add(Left(ChatOperationFailure('Kết nối real-time bị lỗi: ${error.toString()}')));
      } else if (status == 'SUBSCRIBED') {
        _log.info('Successfully subscribed to messages for conversation $conversationId');
      }
    });

    streamController.onCancel = () {
      _log.info('Unsubscribing from messages channel for $conversationId');
      _supabase.removeChannel(channel);
    };

    return streamController.stream;
  }

  @override
  Stream<void> subscribeToConversationListChanges() {
    _log.info('Subscribing to realtime changes for the conversation list.');
    final streamController = StreamController<void>.broadcast();

    // Tạo một channel duy nhất để lắng nghe.
    final channel = _supabase.channel('public:conversations');

    // Đăng ký lắng nghe sự kiện trên kênh.
    // Đây là cú pháp đúng với phiên bản mới của supabase_flutter.
    channel
        .onPostgresChanges(
      event: PostgresChangeEvent.all, // Lắng nghe TẤT CẢ các thay đổi: INSERT, UPDATE, DELETE
      schema: 'public',
      table: 'conversations',
      // RLS policy đã thiết lập sẽ tự động lọc và chỉ gửi các thay đổi
      // trên những cuộc trò chuyện mà người dùng hiện tại có quyền truy cập.
      callback: (payload) {
        _log.finer('Realtime event on "conversations" table received. Payload: ${payload.newRecord}');
        // Khi có bất kỳ thay đổi nào, chỉ cần thông báo cho BLoC để tải lại.
        streamController.add(null);
      },
    )
        .subscribe((status, [error]) {
      // Callback này dùng để theo dõi trạng thái của việc đăng ký kênh.
      if (status == RealtimeSubscribeStatus.subscribed) {
        _log.info('Successfully subscribed to conversations channel.');
      }
      if (status == RealtimeSubscribeStatus.channelError || status == RealtimeSubscribeStatus.closed) {
        _log.severe('Conversations channel error or closed: $error');
      }
    });

    // Khi stream bị hủy (ví dụ: BLoC bị đóng), hãy hủy đăng ký kênh để tránh rò rỉ bộ nhớ.
    streamController.onCancel = () {
      _log.info('Unsubscribing from conversations channel.');
      _supabase.removeChannel(channel); // Hủy đăng ký kênh khi không cần nữa.
    };

    return streamController.stream;
  }
}
