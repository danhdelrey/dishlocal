import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class AppRouteObserver {
  String? _currentConversationId;

  String? get currentConversationId => _currentConversationId;

  bool isInsideChatScreen(String conversationId) {
    return _currentConversationId == conversationId;
  }

  // === THAY ĐỔI: Các phương thức công khai để ChatScreen có thể gọi ===

  /// Được gọi từ `initState` của ChatScreen.
  void enterChatScreen(String conversationId) {
    _currentConversationId = conversationId;
  }

  /// Được gọi từ `dispose` của ChatScreen.
  void exitChatScreen() {
    _currentConversationId = null;
  }
}
