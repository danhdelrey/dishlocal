import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dishlocal/data/categories/chat/model/conversation.dart';
import 'package:dishlocal/data/categories/chat/repository/interface/chat_repository.dart';
import 'package:dishlocal/data/global/chat_event_bus.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:logging/logging.dart';

part 'conversation_list_event.dart';
part 'conversation_list_state.dart';
part 'conversation_list_bloc.freezed.dart';

@injectable
class ConversationListBloc extends Bloc<ConversationListEvent, ConversationListState> {
  final _log = Logger('ConversationListBloc');
  final ChatRepository _chatRepository;
  final ChatEventBus _chatEventBus;
  StreamSubscription? _eventBusSubscription;

  // Constructor được cập nhật
  ConversationListBloc(this._chatRepository, this._chatEventBus) : super(const ConversationListState.initial()) {
    on<_Started>(_onStarted);
    on<_Refreshed>(_onRefreshed);
    on<_ListChanged>(_onListChanged);
  }

  @override
  Future<void> close() {
    _eventBusSubscription?.cancel();
    return super.close();
  }

  Future<void> _onStarted(_Started event, Emitter<ConversationListState> emit) async {
    emit(const ConversationListState.loading());

    // === THAY ĐỔI: Lắng nghe từ EventBus ===
    _eventBusSubscription?.cancel();
    _eventBusSubscription = _chatEventBus.stream.listen((_) {
      add(const ConversationListEvent.listChanged());
    });

    await _fetchConversations(emit);
  }

  Future<void> _onRefreshed(_Refreshed event, Emitter<ConversationListState> emit) async {
    await _fetchConversations(emit);
  }

  // Handler mới
  Future<void> _onListChanged(_ListChanged event, Emitter<ConversationListState> emit) async {
    _log.info('Conversation list changed via realtime, refetching...');
    // Chỉ fetch lại, không emit loading để UI không bị giật
    await _fetchConversations(emit);
  }

  Future<void> _fetchConversations(Emitter<ConversationListState> emit) async {
    final result = await _chatRepository.getMyConversations();
    result.fold(
      (failure) {
        _log.severe('Failed to fetch conversations: ${failure.message}');
        // Chỉ emit lỗi nếu trạng thái hiện tại không phải là loaded,
        // để không ghi đè dữ liệu cũ bằng màn hình lỗi khi refresh thất bại
        if (state is! ConversationListLoaded) {
          emit(ConversationListState.error(message: failure.message));
        }
      },
      (conversations) {
        emit(ConversationListState.loaded(conversations: conversations));
      },
    );
  }
}
