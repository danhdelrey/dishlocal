import 'package:dishlocal/core/utils/time_formatter.dart';
import 'package:dishlocal/data/categories/chat/model/conversation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ConversationTile extends StatelessWidget {
  final Conversation conversation;
  final String _currentUserId = "user_123"; // Lấy ID người dùng thật

  const ConversationTile({super.key, required this.conversation});

  String _buildPreviewText() {
    final lastMessage = conversation.lastMessageContent;
    if (lastMessage == null || lastMessage.isEmpty) {
      if (conversation.lastMessageSharedPostId != null) {
        return "Đã chia sẻ một bài viết";
      }
      return "Chưa có tin nhắn.";
    }

    if (conversation.lastMessageSenderId == _currentUserId) {
      return 'Bạn: $lastMessage';
    }

    return lastMessage;
  }

  @override
  Widget build(BuildContext context) {
    final hasUnread = conversation.unreadCount > 0;

    return ListTile(
      leading: CircleAvatar(
        radius: 28,
        backgroundImage: conversation.otherParticipantPhotoUrl != null ? NetworkImage(conversation.otherParticipantPhotoUrl!) : null,
        child: conversation.otherParticipantPhotoUrl == null ? Text(conversation.otherParticipantDisplayName?[0] ?? '?') : null,
      ),
      title: Text(
        conversation.otherParticipantDisplayName ?? 'Người dùng',
        style: TextStyle(fontWeight: hasUnread ? FontWeight.bold : FontWeight.normal),
      ),
      subtitle: Text(
        _buildPreviewText(),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
          color: hasUnread ? Theme.of(context).textTheme.bodyLarge?.color : Colors.grey,
          fontWeight: hasUnread ? FontWeight.bold : FontWeight.normal,
        ),
      ),
      trailing: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          if (conversation.lastMessageCreatedAt != null)
            Text(
              TimeFormatter.formatTimeAgo(conversation.lastMessageCreatedAt!),
              style: TextStyle(
                color: hasUnread ? Theme.of(context).primaryColor : Colors.grey,
                fontSize: 12,
              ),
            ),
          const SizedBox(height: 4),
          if (hasUnread)
            CircleAvatar(
              radius: 10,
              backgroundColor: Theme.of(context).primaryColor,
              child: Text(
                conversation.unreadCount.toString(),
                style: const TextStyle(color: Colors.white, fontSize: 12),
              ),
            )
          else
            const SizedBox(height: 20), // Giữ khoảng trống để căn chỉnh
        ],
      ),
      onTap: () {
        context.push(
          '/chat',
          extra: {
            'conversationId': conversation.conversationId,
            'otherUserName': conversation.otherParticipantDisplayName,
          },
        );
      },
    );
  }
}
