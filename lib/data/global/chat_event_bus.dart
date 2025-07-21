import 'dart:async';

import 'package:injectable/injectable.dart';

/// Một event bus đơn giản để thông báo các thay đổi liên quan đến chat
/// trên toàn bộ ứng dụng.
@lazySingleton
class ChatEventBus {
  final _controller = StreamController<void>.broadcast();

  /// Stream mà các BLoC/Cubit khác sẽ lắng nghe.
  Stream<void> get stream => _controller.stream;

  /// Gọi hàm này để phát đi một sự kiện "cần làm mới dữ liệu chat".
  void fireChatDataChanged() {
    _controller.add(null);
  }

  void dispose() {
    _controller.close();
  }
}
