import 'package:dishlocal/core/dependencies_injection/service_locator.dart';
import 'package:dishlocal/data/categories/chat/repository/interface/chat_repository.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class MessageButton extends StatefulWidget {
  final String otherUserId;
  final String otherUserName;
  final Widget? child;
  final ButtonStyle? style;

  const MessageButton({
    super.key,
    required this.otherUserId,
    required this.otherUserName,
    this.child,
    this.style,
  });

  @override
  State<MessageButton> createState() => _MessageButtonState();
}

class _MessageButtonState extends State<MessageButton> {
  bool _isLoading = false;

  /// Xử lý logic khi nút được nhấn.
  Future<void> _handleOnPressed() async {
    // Ngăn người dùng nhấn nhiều lần khi đang xử lý
    if (_isLoading) return;

    setState(() {
      _isLoading = true;
    });

    try {
      // Lấy repository từ DI
      final chatRepository = getIt<ChatRepository>();

      // Gọi repository để lấy hoặc tạo cuộc trò chuyện
      final result = await chatRepository.getOrCreateConversation(
        otherUserId: widget.otherUserId,
      );

      // Xử lý kết quả và điều hướng
      // Kiểm tra `mounted` để đảm bảo widget vẫn còn trên cây widget trước khi dùng BuildContext
      if (!mounted) return;

      result.fold(
        (failure) {
          // Hiển thị lỗi cho người dùng
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Không thể bắt đầu cuộc trò chuyện: ${failure.message}')),
          );
        },
        (conversationId) {
          context.push('/chat', extra: {
            'conversationId': conversationId,
            'otherUserName': widget.otherUserName,
          });
        },
      );
    } finally {
      // Luôn đảm bảo tắt trạng thái loading, dù thành công hay thất bại
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      style: widget.style,
      // Vô hiệu hóa nút khi đang loading
      onPressed: _isLoading ? null : _handleOnPressed,
      icon: _isLoading
          // Hiển thị vòng quay tải khi đang loading
          ? Container(
              width: 20,
              height: 20,
              padding: const EdgeInsets.all(2.0),
              child: const CircularProgressIndicator(
                color: Colors.white,
                strokeWidth: 2,
              ),
            )
          : const Icon(Icons.message_rounded),
      // Sử dụng child được truyền vào, hoặc mặc định là "Nhắn tin"
      label: widget.child ?? const Text('Nhắn tin'),
    );
  }
}
