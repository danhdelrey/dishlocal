import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:dishlocal/data/categories/app_user/repository/interface/app_user_repository.dart';
import 'package:dishlocal/data/categories/chat/model/message.dart';
import 'package:dishlocal/data/categories/chat/repository/failure/chat_failure.dart';
import 'package:dishlocal/data/categories/chat/repository/interface/chat_repository.dart';
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
  final AppUserRepository _appUserRepository;
  StreamSubscription<Either<ChatFailure, Message>>? _messageSubscription;
  final int _messagesPerPage = 30;

  bool _isScreenActive = false;

  ChatBloc(this._chatRepository, this._appUserRepository) : super(const ChatState.initial()) {
    on<_Started>(_onStarted);
    on<_MoreMessagesLoaded>(_onMoreMessagesLoaded);
    on<_MessageSent>(_onMessageSent);
    on<_PostShared>(_onPostShared);
    on<_MessageReceived>(_onMessageReceived);
    // === THAY ĐỔI: Thêm handler cho sự kiện active/inactive ===
    on<_ScreenStatusChanged>(_onScreenStatusChanged);
  }

  @override
  Future<void> close() {
    _log.info('Closing ChatBloc and message subscription.');
    _messageSubscription?.cancel();
    _isScreenActive = false; // Đảm bảo trạng thái được reset
    return super.close();
  }

  Future<void> _onStarted(_Started event, Emitter<ChatState> emit) async {
    // === THAY ĐỔI: Đặt cờ active là true khi bắt đầu ===
    _isScreenActive = true;

    emit(const ChatState.loading());

    // Đánh dấu đã đọc lần đầu (không đổi)
    _chatRepository.markConversationAsRead(conversationId: event.conversationId);

    _messageSubscription?.cancel();
    _messageSubscription = _chatRepository.subscribeToMessages(conversationId: event.conversationId).listen((result) {
      result.fold(
        (failure) => _log.severe('Realtime subscription error: ${failure.message}'),
        (message) {
          if (message.senderId != _appUserRepository.getCurrentUserId()) {
            add(ChatEvent.messageReceived(message));
          }
        },
      );
    });

    // Tải trang tin nhắn đầu tiên
    final result = await _chatRepository.getMessages(
      conversationId: event.conversationId,
      page: 1,
      limit: _messagesPerPage,
    );

    result.fold(
      (failure) => emit(ChatState.error(message: failure.message)),
      (messages) => emit(ChatState.loaded(
        conversationId: event.conversationId,
        otherUserName: event.otherUserName,
        messages: messages,
        hasReachedMax: messages.length < _messagesPerPage,
        currentPage: 1,
      )),
    );
  }

  Future<void> _onMoreMessagesLoaded(_MoreMessagesLoaded event, Emitter<ChatState> emit) async {
    if (state is! ChatLoaded) return;
    final currentState = state as ChatLoaded;
    if (currentState.isLoadingMore || currentState.hasReachedMax) return;

    emit(currentState.copyWith(isLoadingMore: true));

    final nextPage = currentState.currentPage + 1;
    final result = await _chatRepository.getMessages(
      conversationId: currentState.conversationId,
      page: nextPage,
      limit: _messagesPerPage,
    );

    result.fold(
      (failure) {
        _log.warning('Failed to load more messages: ${failure.message}');
        emit(currentState.copyWith(isLoadingMore: false)); // Tắt loading indicator
      },
      (newMessages) {
        emit(currentState.copyWith(
          messages: currentState.messages..addAll(newMessages),
          isLoadingMore: false,
          hasReachedMax: newMessages.length < _messagesPerPage,
          currentPage: nextPage,
        ));
      },
    );
  }

  Future<void> _onMessageSent(_MessageSent event, Emitter<ChatState> emit) async {
    if (state is! ChatLoaded) return;
    final currentState = state as ChatLoaded;

    // Optimistic UI: Tạo tin nhắn tạm thời và thêm vào state ngay lập tức
    final tempMessage = Message(
      id: const Uuid().v4(), // ID tạm thời
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
    final latestState = state as ChatLoaded;
    final newMessages = List<Message>.from(latestState.messages);
    final messageIndex = newMessages.indexWhere((m) => m.id == tempMessage.id);

    if (messageIndex != -1) {
      result.fold((failure) {
        newMessages[messageIndex] = tempMessage.copyWith(status: MessageStatus.failed);
      }, (sentMessage) {
        newMessages[messageIndex] = sentMessage; // Thay thế tin nhắn tạm bằng tin nhắn thật
      });
      emit(latestState.copyWith(messages: newMessages));
    }
  }

  Future<void> _onPostShared(_PostShared event, Emitter<ChatState> emit) async {
    // Logic tương tự _onMessageSent nhưng với `sharedPostId`
    // Có thể gộp 2 hàm này lại nếu muốn
  }

 void _onMessageReceived(_MessageReceived event, Emitter<ChatState> emit) {
    if (state is! ChatLoaded) return;
    final currentState = state as ChatLoaded;

    // Thêm tin nhắn mới vào đầu danh sách (không đổi)
    emit(currentState.copyWith(messages: [event.message, ...currentState.messages]));

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
