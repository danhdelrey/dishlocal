import 'dart:async';

import 'package:dishlocal/data/global/chat_event_bus.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:dishlocal/data/categories/chat/repository/interface/chat_repository.dart';
import 'package:logging/logging.dart';

@injectable
class UnreadBadgeCubit extends Cubit<int> {
  final _log = Logger('UnreadBadgeCubit');
  final ChatRepository _chatRepository;
 final ChatEventBus _chatEventBus;
  StreamSubscription? _eventBusSubscription;

  // Constructor được cập nhật
  UnreadBadgeCubit(this._chatRepository, this._chatEventBus) : super(0) {
    _initialize();
  }

  void _initialize() {
    _log.info('Initializing UnreadBadgeCubit.');
    updateTotalUnreadCount();

    // === THAY ĐỔI: Lắng nghe từ EventBus ===
    _eventBusSubscription?.cancel();
    _eventBusSubscription = _chatEventBus.stream.listen((_) {
      _log.info('Received event from bus, updating total unread count...');
      updateTotalUnreadCount();
    });
  }

  /// Lấy danh sách cuộc trò chuyện và tính tổng số tin nhắn chưa đọc.
  Future<void> updateTotalUnreadCount() async {
    final result = await _chatRepository.getMyConversations();
    result.fold(
      (failure) {
        _log.warning('Could not update total unread count: ${failure.message}');
        // Trong trường hợp lỗi, giữ nguyên giá trị cũ để tránh làm người dùng khó chịu
        emit(state);
      },
      (conversations) {
        // === THAY ĐỔI: Tính tổng `unreadCount` từ tất cả các cuộc trò chuyện ===
        int totalUnread = conversations.fold(0, (previousValue, conversation) => previousValue + conversation.unreadCount);

        // Chỉ emit trạng thái mới nếu nó khác trạng thái hiện tại
        if (state != totalUnread) {
          _log.info('Total unread count changed to: $totalUnread');
          emit(totalUnread);
        }
      },
    );
  }

  @override
  Future<void> close() {
    _eventBusSubscription?.cancel();
    return super.close();
  }
}
