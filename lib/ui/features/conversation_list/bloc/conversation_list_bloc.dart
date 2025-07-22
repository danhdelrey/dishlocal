import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dishlocal/data/categories/chat/model/conversation.dart';
import 'package:dishlocal/data/categories/chat/repository/interface/chat_repository.dart';
import 'package:dishlocal/data/global/chat_event_bus.dart';
import 'package:dishlocal/ui/global/cubits/cubit/unread_badge_cubit.dart';
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
  final UnreadBadgeCubit _unreadBadgeCubit;
  StreamSubscription? _unreadBadgeSubscription;

  // Constructor được cập nhật
  ConversationListBloc(this._chatRepository, this._chatEventBus, this._unreadBadgeCubit) : super(const ConversationListState.initial()) {
    on<_Started>(_onStarted);
    on<_Refreshed>(_onRefreshed);
  }

  @override
  Future<void> close() {
    _unreadBadgeSubscription?.cancel();
    return super.close();
  }

  Future<void> _onStarted(_Started event, Emitter<ConversationListState> emit) async {
    emit(const ConversationListState.loading());

    // === THAY ĐỔI: Lắng nghe UnreadBadgeCubit ===
    // Mỗi khi badge thay đổi (có nghĩa là dữ liệu chat đã thay đổi),
    // chúng ta sẽ tải lại danh sách.
    _unreadBadgeSubscription?.cancel();
    _unreadBadgeSubscription = _unreadBadgeCubit.stream.listen((_) {
      // Gọi hàm fetch trực tiếp, không cần event nội bộ
      _fetchConversations(emit);
    });

    // Vẫn fetch lần đầu tiên để hiển thị dữ liệu ban đầu
    await _fetchConversations(emit);
  }

  Future<void> _onRefreshed(_Refreshed event, Emitter<ConversationListState> emit) async {
    // Khi người dùng tự refresh, chúng ta cũng nên cập nhật lại badge
    await _unreadBadgeCubit.updateTotalUnreadCount();
    // Logic fetch của _onStarted sẽ được tự động kích hoạt bởi stream listener ở trên.
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
