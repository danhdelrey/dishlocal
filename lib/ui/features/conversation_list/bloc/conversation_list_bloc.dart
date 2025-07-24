import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dishlocal/data/categories/chat/model/conversation.dart';
import 'package:dishlocal/data/categories/chat/repository/interface/chat_repository.dart';
import 'package:dishlocal/data/global/chat_event_bus.dart';
import 'package:dishlocal/data/singleton/notification_service.dart';
import 'package:dishlocal/ui/global/cubits/cubit/unread_badge_cubit.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:logging/logging.dart';

part 'conversation_list_event.dart';
part 'conversation_list_state.dart';
part 'conversation_list_bloc.freezed.dart';

@injectable
class ConversationListBloc extends Cubit<ConversationListState> {
  final UnreadBadgeCubit _unreadBadgeCubit;
  final NotificationService _notificationService;
  StreamSubscription? _badgeSubscription;

  ConversationListBloc(this._unreadBadgeCubit, this._notificationService) : super(const ConversationListState.loading()) {
    _initialize();
  }

  Future<void> _initialize() async {
    // Lắng nghe state từ UnreadBadgeCubit
    _badgeSubscription = _unreadBadgeCubit.stream.listen((badgeState) {
      if (!badgeState.isLoading) {
        emit(ConversationListState.loaded(badgeState.conversations));
      }
    });

    // Xử lý trạng thái ban đầu
    final initialBadgeState = _unreadBadgeCubit.state;
    if (!initialBadgeState.isLoading) {
      emit(ConversationListState.loaded(initialBadgeState.conversations));
    }

  }

  // Khi người dùng pull-to-refresh
  Future<void> refresh() async {
    await _unreadBadgeCubit.updateConversations();
  }

  @override
  Future<void> close() {
    _badgeSubscription?.cancel();
    return super.close();
  }
}
