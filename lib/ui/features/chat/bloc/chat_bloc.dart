import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:dishlocal/core/dependencies_injection/service_locator.dart';
import 'package:dishlocal/data/categories/app_user/model/app_user.dart';
import 'package:dishlocal/data/categories/app_user/repository/interface/app_user_repository.dart';
import 'package:dishlocal/data/categories/chat/model/message.dart';
import 'package:dishlocal/data/categories/chat/repository/failure/chat_failure.dart';
import 'package:dishlocal/data/categories/chat/repository/interface/chat_repository.dart';
import 'package:dishlocal/data/categories/post/model/post.dart';
import 'package:dishlocal/data/categories/post/repository/interface/post_repository.dart';
import 'package:dishlocal/data/global/chat_event_bus.dart';
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

  StreamSubscription? _eventBusSubscription;
  bool _isScreenActive = false;

  ChatBloc(this._chatRepository, this._appUserRepository, this._postRepository) : super(const ChatState.initial()) {
    on<_Started>(_onStarted);
    on<_MoreMessagesLoaded>(_onMoreMessagesLoaded);
    on<_MessageSent>(_onMessageSent);
    on<_PostShared>(_onPostShared);
    on<_MessageReceived>(_onMessageReceived);
    on<_EnrichmentStarted>(_onEnrichmentStarted);
    on<_MessageEnriched>(_onMessageEnriched);
    // === THAY ĐỔI: Thêm handler cho sự kiện active/inactive ===
    on<_ScreenStatusChanged>(_onScreenStatusChanged);
    on<_ReadStatusCheckRequested>(_onReadStatusCheckRequested);
  }


  @override
  Future<void> close() {
    _log.info('Closing ChatBloc and message subscription.');
    _messageSubscription?.cancel();
    _isScreenActive = false; // Đảm bảo trạng thái được reset
    _eventBusSubscription?.cancel();
    return super.close();
  }

  Future<void> _onStarted(_Started event, Emitter<ChatState> emit) async {
    // 1. Emit loading (đã đúng)
    emit(const ChatState.loading());

    _isScreenActive = true;
    _chatRepository.markConversationAsRead(conversationId: event.conversationId);

    // === THAY ĐỔI: Lắng nghe EventBus để cập nhật trạng thái đã đọc ===
    _eventBusSubscription?.cancel();
    _eventBusSubscription = getIt<ChatEventBus>().stream.listen((_) {
      // Khi có thay đổi, thêm event mới để xử lý
      add(ChatEvent.readStatusCheckRequested(event.conversationId));
    });

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

    final result = await _chatRepository.getMessages(
      conversationId: event.conversationId,
      page: 1,
      limit: _messagesPerPage,
    );

    await result.fold(
      (failure) async => emit(ChatState.error(message: failure.message)),
      (entities) async {
        // === THAY ĐỔI LỚN ===
        // 1. Chuyển đổi entities thành Messages "chưa hoàn chỉnh"
        final initialMessages = entities.map((e) => Message.fromEntity(e)).toList();

        // === THÊM MỚI: Lấy trạng thái đã đọc ban đầu ===
        final statusResult = await _chatRepository.getReadStatuses(conversationId: event.conversationId);
        DateTime? otherUserLastReadAt;
        statusResult.fold(
          (l) => _log.warning("Could not fetch initial read statuses."),
          (statuses) {
            final otherStatus = statuses.firstWhere(
              (s) => s['user_id'] == event.otherUser.userId,
              orElse: () => {},
            );
            if (otherStatus['last_read_at'] != null) {
              otherUserLastReadAt = DateTime.parse(otherStatus['last_read_at']);
            }
          }
        );

        // 2. Emit trạng thái Loaded NGAY LẬP TỨC
        emit(ChatState.loaded(
          conversationId: event.conversationId,
          otherUser: event.otherUser,
          messages: initialMessages,
          hasReachedMax: entities.length < _messagesPerPage,
          currentPage: 1,
          otherUserLastReadAt: otherUserLastReadAt,
        ));

        // 3. Kích hoạt quá trình làm giàu dữ liệu ở background
        add(ChatEvent.enrichmentStarted(initialMessages));
      },
    );
  }

  Future<void> _onReadStatusCheckRequested(_ReadStatusCheckRequested event, Emitter<ChatState> emit) async {
    if (state is! ChatLoaded) return;
    final currentState = state as ChatLoaded;
    
    _log.info("Read status check requested for conversation ${event.conversationId}");
    final statusResult = await _chatRepository.getReadStatuses(conversationId: event.conversationId);
    
    statusResult.fold(
      (l) => _log.warning("Could not fetch updated read statuses."),
      (statuses) {
        final otherStatus = statuses.firstWhere(
          (s) => s['user_id'] == currentState.otherUser.userId,
          orElse: () => {},
        );
        DateTime? newLastReadAt;
        if (otherStatus['last_read_at'] != null) {
          newLastReadAt = DateTime.parse(otherStatus['last_read_at']);
        }
        
        // Chỉ emit nếu có thay đổi
        if (currentState.otherUserLastReadAt != newLastReadAt) {
          emit(currentState.copyWith(otherUserLastReadAt: newLastReadAt));
        }
      }
    );
  }

  Future<void> _onMoreMessagesLoaded(_MoreMessagesLoaded event, Emitter<ChatState> emit) async {
    final currentState = state;
    if (currentState is! ChatLoaded) return;
    if (currentState.isLoadingMore || currentState.hasReachedMax) return;

    // 1. Phát ra trạng thái đang tải thêm
    emit(currentState.copyWith(isLoadingMore: true));

    final nextPage = currentState.currentPage + 1;
    final result = await _chatRepository.getMessages(
      conversationId: currentState.conversationId,
      page: nextPage,
      limit: _messagesPerPage,
    );

   await result.fold(
      (failure) async => emit(currentState.copyWith(isLoadingMore: false)),
      (newEntities) async {
        // === THAY ĐỔI LỚN ===
        // 1. Chuyển đổi entities mới thành Messages "chưa hoàn chỉnh"
        final newMessages = newEntities.map((e) => Message.fromEntity(e)).toList();
        final updatedMessages = List<Message>.from(currentState.messages)..addAll(newMessages);

        // 2. Emit trạng thái mới NGAY LẬP TỨC
        emit(currentState.copyWith(
          messages: updatedMessages,
          isLoadingMore: false,
          hasReachedMax: newEntities.length < _messagesPerPage,
          currentPage: nextPage,
        ));

        // 3. Kích hoạt quá trình làm giàu dữ liệu cho các tin nhắn mới
        add(ChatEvent.enrichmentStarted(newMessages));
      },
    );
  }

  Future<void> _onMessageSent(_MessageSent event, Emitter<ChatState> emit) async {
    if (state is! ChatLoaded) return;
    final currentState = state as ChatLoaded;

    // Optimistic UI (Không đổi)
    final tempMessage = Message(
      id: const Uuid().v4(),
      conversationId: currentState.conversationId,
      senderId: _appUserRepository.getCurrentUserId()!,
      content: event.content,
      createdAt: DateTime.now(),
      status: MessageStatus.sending,
    );
    emit(currentState.copyWith(messages: [tempMessage, ...currentState.messages]));

    // Gửi tin nhắn thực tế
    final result = await _chatRepository.sendMessage(
      conversationId: currentState.conversationId,
      content: event.content,
    );

    // Cập nhật state sau khi có kết quả từ server
    if (state is! ChatLoaded) return;
    final latestState = state as ChatLoaded;

    final newMessages = List<Message>.from(latestState.messages);
    final messageIndex = newMessages.indexWhere((m) => m.id == tempMessage.id);

    if (messageIndex != -1) {
      result.fold(
        (failure) {
          // Nếu gửi thất bại, cập nhật trạng thái
          newMessages[messageIndex] = tempMessage.copyWith(status: MessageStatus.failed);
          emit(latestState.copyWith(messages: newMessages));
        },
        (sentMessageEntity) {
          // === THAY ĐỔI LỚN ===
          // Nếu gửi thành công, chỉ cần tạo Message từ Entity (chưa có Post)
          // và cập nhật lại danh sách.
          // Việc làm giàu dữ liệu Post sẽ được xử lý bởi `_onMessageReceived`
          // khi tin nhắn này được Supabase Realtime đẩy về.
          final sentMessage = Message.fromEntity(sentMessageEntity);
          newMessages[messageIndex] = sentMessage;
          emit(latestState.copyWith(messages: newMessages));
        },
      );
    }
  }

  Future<void> _onPostShared(_PostShared event, Emitter<ChatState> emit) async {
    // Logic tương tự _onMessageSent nhưng với `sharedPostId`
    // Có thể gộp 2 hàm này lại nếu muốn
  }

  void _onEnrichmentStarted(_EnrichmentStarted event, Emitter<ChatState> emit) {
    // Lặp qua các tin nhắn cần làm giàu
    for (final message in event.messages) {
      // Chỉ xử lý những tin nhắn có sharedPostId và chưa có object Post
      if (message.sharedPostId != null && message.sharedPost == null) {
        // Chạy bất đồng bộ, không `await`
        _postRepository.getPostWithId(message.sharedPostId!).then((result) {
          result.fold(
            (l) => _log.warning('Failed to enrich post ${message.sharedPostId}'),
            (post) {
              // Tạo một message mới với dữ liệu post đã được làm giàu
              final updatedMessage = message.copyWith(sharedPost: post);
              // Thêm event để cập nhật state
              add(ChatEvent.messageEnriched(updatedMessage));
            },
          );
        });
      }
    }
  }

  // === HANDLER MỚI: Cập nhật state với tin nhắn đã được làm giàu ===
  void _onMessageEnriched(_MessageEnriched event, Emitter<ChatState> emit) {
    if (state is! ChatLoaded) return;
    final currentState = state as ChatLoaded;

    // Tìm và thay thế tin nhắn cũ bằng tin nhắn đã được cập nhật
    final messageIndex = currentState.messages.indexWhere((m) => m.id == event.updatedMessage.id);

    if (messageIndex != -1) {
      final updatedMessages = List<Message>.from(currentState.messages);
      updatedMessages[messageIndex] = event.updatedMessage;
      emit(currentState.copyWith(messages: updatedMessages));
    }
  }

  void _onMessageReceived(_MessageReceived event, Emitter<ChatState> emit) async {
    if (state is! ChatLoaded) return;
    final currentState = state as ChatLoaded;

    // Chuyển đổi và emit tin nhắn chưa hoàn chỉnh ngay lập tức
    final newMessage = Message.fromEntity(event.message);
    emit(currentState.copyWith(messages: [newMessage, ...currentState.messages]));

    // Kích hoạt làm giàu dữ liệu cho tin nhắn mới này
    add(ChatEvent.enrichmentStarted([newMessage]));

    if (_isScreenActive) {
      _chatRepository.markConversationAsRead(conversationId: currentState.conversationId);
    }
  }

  // === THAY ĐỔI: Handler mới để xử lý trạng thái màn hình ===
  void _onScreenStatusChanged(_ScreenStatusChanged event, Emitter<ChatState> emit) {
    _isScreenActive = event.isActive;
  }
}
