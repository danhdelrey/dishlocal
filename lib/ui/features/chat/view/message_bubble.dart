import 'package:dishlocal/app/theme/custom_colors.dart';
import 'package:dishlocal/app/theme/theme.dart';
import 'package:dishlocal/data/categories/app_user/model/app_user.dart';
import 'package:dishlocal/data/categories/chat/model/message.dart';
import 'package:dishlocal/ui/features/post/view/small_post.dart';
import 'package:dishlocal/ui/widgets/containers_widgets/glass_container.dart';
import 'package:dishlocal/ui/widgets/image_widgets/cached_circle_avatar.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:logging/logging.dart';

class MessageBubble extends StatelessWidget {
  final Message message;
  final bool isMe;
  final AppUser otherUser;
  final DateTime? otherUserLastReadAt;

  const MessageBubble({
    super.key,
    required this.message,
    required this.isMe,
    required this.otherUser, this.otherUserLastReadAt,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final log = Logger("MessageBubble");
    if (message.id == '93b804ed-a838-4af1-8c87-96a67daf40c7') {
      log.info('--- DEBUGGING MESSAGE BUBBLE ---');
      log.info('Message ID: ${message.id}');
      log.info('Message Type: ${message.messageType}');
      log.info('Shared Post ID: ${message.sharedPostId}');
      log.info('Shared Post Object is null: ${message.sharedPost == null}');
      log.info('---------------------------------');
    }

    // === TÁI CẤU TRÚC: Xây dựng nội dung trước ===
    final contentColumn = Column(
      crossAxisAlignment: isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
      children: [
        // === BẮT ĐẦU THAY ĐỔI LOGIC ===

        // Hiển thị phần chia sẻ post NẾU messageType là 'shared_post'
        if (message.messageType == 'shared_post') _buildSharedPost(context, theme, isMe),

        // Hiển thị phần nội dung text NẾU content có giá trị
        if (message.content != null && message.content!.isNotEmpty) _buildTextContent(theme),

        // === KẾT THÚC THAY ĐỔI LOGIC ===
      ],
    );

    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Align(
        alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            if (!isMe)
              Padding(
                padding: const EdgeInsets.only(right: 4.0),
                child: GestureDetector(
                  behavior: HitTestBehavior.translucent,
                  onTap: () {
                    context.push('/post_detail/profile', extra: {'userId': otherUser.userId});
                  },
                  child: CachedCircleAvatar(
                    imageUrl: otherUser.photoUrl ?? '',
                    circleRadius: 15,
                  ),
                ),
              ),
            Flexible(
              child: ConstrainedBox(
                constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.7),
                child: GlassContainer(
                  horizontalPadding: message.sharedPostId != null ? 0 : 10,
                  verticalPadding: message.sharedPostId != null ? 0 : 6,
                  backgroundColor: message.sharedPostId != null ? theme.colorScheme.outlineVariant : (isMe ? const Color(0xFFff9a44) : theme.colorScheme.outlineVariant),
                  backgroundAlpha: message.sharedPostId != null ? 0.1 : (isMe ? 0.9 : 0.1),
                  borderRadius: 20,
                  borderTop: true,
                  borderLeft: true,
                  borderRight: true,
                  borderBottom: true,
                  child: contentColumn, // Đưa nội dung đã xây dựng vào đây
                ),
              ),
            ),
            if (isMe) _buildStatusIcon(context),
          ],
        ),
      ),
    );
  }

  Widget _buildSharedPost(BuildContext context, ThemeData theme, bool isMe) {
    if (message.messageType != 'shared_post') {
      return const SizedBox.shrink();
    }

    // === THAY ĐỔI LOGIC HIỂN THỊ ===

    // 1. Nếu có object Post -> Hiển thị SmallPost
    if (message.sharedPost != null) {
      return SizedBox(
        width: 150,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: SmallPost(post: message.sharedPost!, onDeletePostPopBack: () {}),
        ),
      );
    }
    // 2. Nếu có post ID nhưng chưa có object Post -> ĐANG TẢI
    else if (message.sharedPostId != null && message.sharedPost == null) {
      return SizedBox(
        width: 150,
        height: 200, // Chiều cao tạm thời cho placeholder
        child: Center(
          child: SizedBox(
            width: 40,
            height: 40,
            child: CircularProgressIndicator(
              strokeWidth: 2,
              color: isMe ? Colors.white : appColorScheme(context).primary,
            ),
          ),
        ),
      );
    }
    // 3. Nếu không có cả hai -> Đã bị xóa
    else {
      return Container(
        width: 150,
        padding: const EdgeInsets.all(12.0),
        child: Text(
          'Bài viết này không còn tồn tại',
          style: theme.textTheme.bodyMedium?.copyWith(
            color: theme.colorScheme.onSurface.withOpacity(0.6),
            fontStyle: FontStyle.italic,
            fontWeight: FontWeight.bold,
          ),
        ),
      );
    }
  }

  /// Widget hiển thị nội dung văn bản
  Widget _buildTextContent(ThemeData theme) {
    if (message.content == null || message.content!.isEmpty) {
      return const SizedBox.shrink();
    }

    return Padding(
      // Thêm khoảng cách nếu phía trên có một bài viết được chia sẻ
      padding: EdgeInsets.only(top: message.messageType == 'shared_post' ? 8.0 : 0),
      child: Text(
        message.content!,
        style: theme.textTheme.bodyMedium?.copyWith(
          color: isMe ? theme.colorScheme.onPrimary : theme.colorScheme.onSurface,
        ),
      ),
    );
  }

  Widget _buildStatusIcon(BuildContext context) {
    if (!isMe) return const SizedBox.shrink();

    // === LOGIC "ĐÃ XEM" NẰM Ở ĐÂY ===
    if (otherUserLastReadAt != null && (message.createdAt.isBefore(otherUserLastReadAt!) || message.createdAt.isAtSameMomentAs(otherUserLastReadAt!))) {
      // Nếu tin nhắn đã được đọc -> Hiển thị avatar nhỏ của người kia
      return Padding(
        padding: const EdgeInsets.only(right: 8.0, bottom: 4.0),
        child: CachedCircleAvatar(
          imageUrl: otherUser.photoUrl ?? '',
          circleRadius: 8,
        ),
      );
    }

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
