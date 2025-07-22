import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:dishlocal/data/categories/app_user/model/app_user.dart';
import 'package:dishlocal/data/categories/app_user/repository/interface/app_user_repository.dart';
import 'package:dishlocal/data/categories/chat/model/message.dart';
import 'package:dishlocal/data/categories/chat/repository/failure/chat_failure.dart';
import 'package:dishlocal/data/categories/chat/repository/interface/chat_repository.dart';
import 'package:dishlocal/data/categories/post/model/post.dart';
import 'package:dishlocal/data/categories/post/repository/interface/post_repository.dart';
import 'package:dishlocal/data/services/database_service/entity/message_entity.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:logging/logging.dart';
import 'package:uuid/uuid.dart';

part 'chat_event.dart';
part 'chat_state.dart';
part 'chat_bloc.freezed.dart';

@injectable
class ChatBloc extends Bloc<ChatEvent, ChatState> {
  final _log = Logger('ChatBloc');
  final ChatRepository _chatRepository;
  final PostRepository _postRepository;
  final AppUserRepository _appUserRepository;
  StreamSubscription<Either<ChatFailure, MessageEntity>>? _messageSubscription;
  final int _messagesPerPage = 30;

  bool _isScreenActive = false;

  ChatBloc(this._chatRepository, this._appUserRepository, this._postRepository) : super(const ChatState.initial()) {
    on<_Started>(_onStarted);
    on<_MoreMessagesLoaded>(_onMoreMessagesLoaded);
    on<_MessageSent>(_onMessageSent);
    on<_PostShared>(_onPostShared);
    on<_MessageReceived>(_onMessageReceived);
    // === THAY ĐỔI: Thêm handler cho sự kiện active/inactive ===
    on<_ScreenStatusChanged>(_onScreenStatusChanged);
  }

  Future<List<Message>> _enrichMessages(List<MessageEntity> entities) async {
    final List<Message> enrichedMessages = [];
    for (final entity in entities) {
      Post? post;
      if (entity.sharedPostId != null) {
        final postResult = await _postRepository.getPostWithId(entity.sharedPostId!);
        if (postResult.isLeft()) {
          _log.warning('Failed to fetch post with ID ${entity.sharedPostId}');
        } else {
          post = (postResult as Right).value;
        }
      }
      enrichedMessages.add(
        Message.fromEntity(entity, sharedPost: post), // Cần tạo một factory constructor mới
      );
    }
    return enrichedMessages;
  }

  @override
  Future<void> close() {
    _log.info('Closing ChatBloc and message subscription.');
    _messageSubscription?.cancel();
    _isScreenActive = false; // Đảm bảo trạng thái được reset
    return super.close();
  }

  Future<void> _onStarted(_Started event, Emitter<ChatState> emit) async {
    // 1. Emit loading (đã đúng)
    emit(const ChatState.loading());

    _isScreenActive = true;
    _chatRepository.markConversationAsRead(conversationId: event.conversationId);

    _messageSubscription?.cancel();
    _messageSubscription = _chatRepository.subscribeToMessages(conversationId: event.conversationId).listen((result) {
      result.fold(
        (failure) => _log.severe('Realtime subscription error: ${failure.message}'),
        (entity) {
          if (entity.senderId != _appUserRepository.getCurrentUserId()) {
            add(ChatEvent.messageReceived(entity));
          }
        },
      );
    });

    // 2. Tải dữ liệu entity
    final result = await _chatRepository.getMessages(
      conversationId: event.conversationId,
      page: 1,
      limit: _messagesPerPage,
    );

    // 3. Xử lý kết quả
    // === SỬA LỖI Ở ĐÂY: Sử dụng await và fold trên result ===
    await result.fold(
      (failure) async {
        // Nếu có lỗi, emit trạng thái Error
        emit(ChatState.error(message: failure.message));
      },
      (entities) async {
        // 4. Nếu thành công, làm giàu dữ liệu
        final messages = await _enrichMessages(entities);

        // 5. SAU KHI làm giàu xong, emit trạng thái Loaded
        emit(ChatState.loaded(
          conversationId: event.conversationId,
          otherUser: event.otherUser,
          messages: messages,
          hasReachedMax: entities.length < _messagesPerPage,
          currentPage: 1,
        ));
      },
    );
  }

  Future<void> _onMoreMessagesLoaded(_MoreMessagesLoaded event, Emitter<ChatState> emit) async {
    // Lấy trạng thái hiện tại, đảm bảo nó là _Loaded
    final currentState = state;
    if (currentState is! ChatLoaded) return;

    // Ngăn việc tải nhiều lần cùng lúc hoặc khi đã hết dữ liệu
    if (currentState.isLoadingMore || currentState.hasReachedMax) return;

    // 1. Phát ra trạng thái đang tải thêm
    emit(currentState.copyWith(isLoadingMore: true));

    final nextPage = currentState.currentPage + 1;
    final result = await _chatRepository.getMessages(
      conversationId: currentState.conversationId,
      page: nextPage,
      limit: _messagesPerPage,
    );

    // 2. Xử lý kết quả trả về
    result.fold(
      (failure) => emit(currentState.copyWith(isLoadingMore: false)),
      (newEntities) async {
        // Làm giàu dữ liệu cho các tin nhắn mới
        final newMessages = await _enrichMessages(newEntities);
        final updatedMessages = List<Message>.from(currentState.messages)..addAll(newMessages);

        // PHÁT RA TRẠNG THÁI CUỐI CÙNG
        emit(currentState.copyWith(
          messages: updatedMessages,
          isLoadingMore: false, // Tắt loading indicator
          // Cập nhật lại cờ hasReachedMax
          hasReachedMax: newMessages.length < _messagesPerPage,
          currentPage: nextPage, // Tăng số trang hiện tại
        ));
      },
    );
  }

  Future<void> _onMessageSent(_MessageSent event, Emitter<ChatState> emit) async {
    if (state is! ChatLoaded) return;
    final currentState = state as ChatLoaded;

    // Bước 1: Optimistic UI (Không đổi)
    // Tạo tin nhắn tạm thời và hiển thị ngay lập tức với trạng thái "sending".
    final tempMessage = Message(
      id: const Uuid().v4(),
      conversationId: currentState.conversationId,
      senderId: _appUserRepository.getCurrentUserId()!,
      content: event.content,
      createdAt: DateTime.now(),
      status: MessageStatus.sending,
    );
    emit(currentState.copyWith(messages: [tempMessage, ...currentState.messages]));

    // Bước 2: Gửi tin nhắn thực tế (Không đổi)
    // Repository sẽ trả về một MessageEntity.
    final result = await _chatRepository.sendMessage(
      conversationId: currentState.conversationId,
      content: event.content,
    );

    // Bước 3: Cập nhật UI sau khi có kết quả từ server (THAY ĐỔI Ở ĐÂY)
    // Đảm bảo state không bị thay đổi trong lúc chờ đợi
    if (state is! ChatLoaded) return;
    final latestState = state as ChatLoaded;

    final newMessages = List<Message>.from(latestState.messages);
    final messageIndex = newMessages.indexWhere((m) => m.id == tempMessage.id);

    if (messageIndex != -1) {
      await result.fold(
        (failure) async {
          // Nếu gửi thất bại, cập nhật tin nhắn tạm thành "failed".
          newMessages[messageIndex] = tempMessage.copyWith(status: MessageStatus.failed);
        },
        (sentMessageEntity) async {
          // Nếu gửi thành công, chúng ta nhận về một MessageEntity.
          // Ta cần làm giàu nó thành một Message đầy đủ (dù trong trường hợp này nó không có post).
          final enrichedMessages = await _enrichMessages([sentMessageEntity]);
          if (enrichedMessages.isNotEmpty) {
            // Thay thế tin nhắn tạm bằng tin nhắn thật đã được làm giàu.
            newMessages[messageIndex] = enrichedMessages.first;
          } else {
            // Trường hợp hiếm gặp, làm giàu thất bại, đánh dấu là lỗi.
            newMessages[messageIndex] = tempMessage.copyWith(status: MessageStatus.failed);
            _log.severe('Failed to enrich sent message entity: ${sentMessageEntity.id}');
          }
        },
      );
      // Emit state cuối cùng với danh sách tin nhắn đã được cập nhật.
      emit(latestState.copyWith(messages: newMessages));
    }
  }

  Future<void> _onPostShared(_PostShared event, Emitter<ChatState> emit) async {
    // Logic tương tự _onMessageSent nhưng với `sharedPostId`
    // Có thể gộp 2 hàm này lại nếu muốn
  }

  void _onMessageReceived(_MessageReceived event, Emitter<ChatState> emit) async {
    if (state is! ChatLoaded) return;
    final currentState = state as ChatLoaded;

    // Làm giàu dữ liệu cho tin nhắn realtime
    final enrichedMessages = await _enrichMessages([event.message]);

    emit(currentState.copyWith(messages: [enrichedMessages.first, ...currentState.messages]));

    // === THAY ĐỔI QUAN TRỌNG ===
    // Nếu màn hình đang active, ngay lập tức gọi lại mark as read
    // để cập nhật last_read_at trên database.
    if (_isScreenActive) {
      _log.info('New message received while screen is active. Marking as read again.');
      _chatRepository.markConversationAsRead(conversationId: currentState.conversationId);
    }
  }

  // === THAY ĐỔI: Handler mới để xử lý trạng thái màn hình ===
  void _onScreenStatusChanged(_ScreenStatusChanged event, Emitter<ChatState> emit) {
    _isScreenActive = event.isActive;
  }
}
