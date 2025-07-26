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

part 'conversation_list_state.dart';
part 'conversation_list_bloc.freezed.dart';

@injectable
class ConversationListBloc extends Cubit<ConversationListState> {
  final _log = Logger("ConversationListBloc");
  final UnreadBadgeCubit _unreadBadgeCubit;
  final NotificationService _notificationService;
  final ChatRepository _chatRepository;
  StreamSubscription? _badgeSubscription;

  ConversationListBloc(this._unreadBadgeCubit, this._notificationService, this._chatRepository) : super(const ConversationListState.loading()) {
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

  Future<void> deleteConversation(String conversationId) async {
    // Không cần emit loading ở đây để UI mượt hơn
    final result = await _chatRepository.deleteConversation(conversationId: conversationId);

    result.fold((failure) {
      // TODO: Hiển thị lỗi cho người dùng (ví dụ: qua một stream lỗi riêng)
      _log.severe("Failed to delete conversation: ${failure.message}");
      // Vì xóa thất bại, chúng ta trigger một lần refresh để đảm bảo UI đúng
      refresh();
    }, (_) {
      // Xóa thành công.
      // `ChatEventBus` sẽ tự động được kích hoạt bởi trigger `DELETE` trên Supabase,
      // làm cho `UnreadBadgeCubit` và BLoC này tự cập nhật.
      // Chúng ta không cần làm gì ở đây cả!
      _log.info("Conversation deleted. Realtime will handle the UI update.");
    });
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
