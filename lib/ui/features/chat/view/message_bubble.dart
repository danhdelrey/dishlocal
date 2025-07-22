import 'package:dishlocal/app/theme/theme.dart';
import 'package:dishlocal/data/categories/app_user/model/app_user.dart';
import 'package:dishlocal/data/categories/chat/model/message.dart';
import 'package:dishlocal/ui/features/post/view/small_post.dart';
import 'package:dishlocal/ui/widgets/image_widgets/cached_circle_avatar.dart';
import 'package:flutter/material.dart';

class MessageBubble extends StatelessWidget {
  final Message message;
  final bool isMe;
  final AppUser otherUser;

  const MessageBubble({
    super.key,
    required this.message,
    required this.isMe,
    required this.otherUser,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Align(
      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          if (!isMe)
            Padding(
              padding: const EdgeInsets.only(right: 4.0, bottom: 10),
              child: CachedCircleAvatar(
                imageUrl: otherUser.photoUrl ?? '',
                circleRadius: 15,
              ),
            ),
          Flexible(
            child: ConstrainedBox(
              constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.8),
              child: Container(
                decoration: BoxDecoration(
                  gradient: isMe
                      ? const LinearGradient(
                          colors: [Colors.blue, Colors.lightBlueAccent],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        )
                      : null,
                  color: isMe ? null : theme.colorScheme.surfaceContainerLow,
                  borderRadius: BorderRadius.circular(20),
                ),
                padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 14),
                margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                child: Column(
                  crossAxisAlignment: isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                  children: [
                    if (message.sharedPost != null) SmallPost(post: message.sharedPost!, onDeletePostPopBack: () {}),
                    if (message.content != null)
                      Text(
                        message.content!,
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: isMe ? theme.colorScheme.onPrimary : theme.colorScheme.onSurface,
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ),
          if (isMe) _buildStatusIcon(context),
        ],
      ),
    );
  }

  Widget _buildStatusIcon(BuildContext context) {
    if (!isMe) return const SizedBox.shrink();

    IconData? icon;
    double size = 14;
    Color color = Colors.grey.shade600;

    switch (message.status) {
      case MessageStatus.sending:
        icon = Icons.access_time;
        break;
      case MessageStatus.failed:
        icon = Icons.error;
        color = Colors.red;
        break;
      case MessageStatus.sent:
        icon = Icons.done;
        break;
      case MessageStatus.read:
        // Thay vì dùng icon khác, ta có thể hiển thị avatar của người nhận
        // ở trạng thái "đã xem". Đây là một cách tiếp cận hiện đại.
        return Padding(
          padding: const EdgeInsets.only(right: 8.0, bottom: 4.0),
          child: CachedCircleAvatar(
            imageUrl: otherUser.photoUrl ?? '',
            circleRadius: 8,
          ),
        );
    }

    return Icon(icon, size: size, color: color);
  }
}
