import 'package:dishlocal/data/categories/chat/model/message.dart';
import 'package:flutter/material.dart';

class MessageBubble extends StatelessWidget {
  final Message message;
  final bool isMe;

  const MessageBubble({
    super.key,
    required this.message,
    required this.isMe,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        Container(
          constraints: BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width * 0.7,
          ),
          decoration: BoxDecoration(
            color: isMe ? Theme.of(context).primaryColor : Colors.grey[300],
            borderRadius: BorderRadius.circular(12),
          ),
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
          margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
          child: Column(
            crossAxisAlignment: isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
            children: [
              // Nếu có bài post được chia sẻ, hiển thị widget preview ở đây
              if (message.sharedPost != null) Text('Đã chia sẻ bài viết: ${message.sharedPost!.dishName}'),

              // Hiển thị nội dung text
              if (message.content != null)
                Text(
                  message.content!,
                  style: TextStyle(color: isMe ? Colors.white : Colors.black),
                ),

              const SizedBox(height: 4),
              _buildStatusIcon(),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildStatusIcon() {
    if (!isMe) return const SizedBox.shrink();

    IconData? icon;
    double size = 12;
    Color color = Colors.white70;

    switch (message.status) {
      case MessageStatus.sending:
        icon = Icons.access_time_filled_rounded;
        break;
      case MessageStatus.failed:
        icon = Icons.error;
        color = Colors.red;
        break;
      case MessageStatus.sent:
        // Có thể thêm logic cho trạng thái "delivered" và "read" sau
        icon = Icons.done;
        break;
      case MessageStatus.read:
        icon = Icons.done_all;
        color = Colors.lightBlueAccent;
        break;
    }

    if (icon == null) return const SizedBox.shrink();
    return Icon(icon, size: size, color: color);
  }
}
