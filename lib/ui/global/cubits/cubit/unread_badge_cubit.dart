import 'dart:async';

import 'package:dishlocal/data/categories/chat/model/conversation.dart';
import 'package:dishlocal/data/global/chat_event_bus.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:dishlocal/data/categories/chat/repository/interface/chat_repository.dart';
import 'package:logging/logging.dart';
part 'unread_badge_cubit.freezed.dart';
part 'unread_badge_state.dart';

@lazySingleton
class UnreadBadgeCubit extends Cubit<UnreadBadgeState> {
  final _log = Logger('UnreadBadgeCubit');
  final ChatRepository _chatRepository;
  final ChatEventBus _chatEventBus;
  StreamSubscription? _eventBusSubscription;

  // Trạng thái ban đầu
  UnreadBadgeCubit(this._chatRepository, this._chatEventBus) : super(const UnreadBadgeState());

  void startListening() {
    _log.info('UnreadBadgeCubit is now starting to listen for events.');
    updateConversations();

    _eventBusSubscription?.cancel();
    _eventBusSubscription = _chatEventBus.stream.listen((_) {
      updateConversations();
    });
  }

  void stopListening() {
    _log.info('UnreadBadgeCubit is stopping listening.');
    _eventBusSubscription?.cancel();
    _eventBusSubscription = null;
    emit(const UnreadBadgeState()); // Reset về trạng thái ban đầu
  }

  Future<void> updateConversations() async {
    // Chỉ emit loading nếu đây là lần đầu
    if (state.conversations.isEmpty) {
      emit(state.copyWith(isLoading: true));
    }

    final result = await _chatRepository.getMyConversations();
    result.fold(
      (failure) {
        _log.warning('Could not update conversations: ${failure.message}');
        emit(state.copyWith(isLoading: false));
      },
      (conversations) {
        final totalUnread = conversations.fold(0, (prev, convo) => prev + convo.unreadCount);
        _log.info('Conversations updated. Total unread: $totalUnread');
        emit(UnreadBadgeState(
          totalUnreadCount: totalUnread,
          conversations: conversations,
          isLoading: false,
        ));
      },
    );
  }

  @override
  Future<void> close() {
    _eventBusSubscription?.cancel();
    return super.close();
  }
}
