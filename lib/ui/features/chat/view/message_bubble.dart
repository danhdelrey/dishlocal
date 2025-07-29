import 'package:dishlocal/app/theme/custom_colors.dart';
import 'package:dishlocal/app/theme/theme.dart';
import 'package:dishlocal/data/categories/app_user/model/app_user.dart';
import 'package:dishlocal/data/categories/chat/model/message.dart';
import 'package:dishlocal/ui/features/post/view/small_post.dart';
import 'package:dishlocal/ui/widgets/containers_widgets/glass_container.dart';
import 'package:dishlocal/ui/widgets/image_widgets/cached_circle_avatar.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class MessageBubble extends StatelessWidget {
  final Message message;
  final bool isMe;
  final AppUser otherUser;
  final DateTime? otherUserLastReadAt;

  // Cờ điều khiển hiển thị, được tính toán từ ChatScreen
  final bool shouldShowAvatar;
  final bool shouldShowStatus;

  const MessageBubble({
    super.key,
    required this.message,
    required this.isMe,
    required this.otherUser,
    this.otherUserLastReadAt,
    this.shouldShowAvatar = false,
    this.shouldShowStatus = false,
  });

  @override
  Widget build(BuildContext context) {
    // === CẤU TRÚC MỚI: Bọc mọi thứ trong một Row lớn ===
    return Padding(
      padding: EdgeInsets.only(bottom: shouldShowAvatar ? 10.0 : 4.0),
      child: Row(
        mainAxisAlignment: isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          // 1. Avatar (hoặc khoảng trống) cho tin nhắn của người kia
          if (!isMe) _buildAvatarSpace(context),

          // 2. Cột chứa Bubble và Status Text
          Flexible(
            child: Column(
              crossAxisAlignment: isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
              children: [
                _buildBubbleContent(context),
                if (shouldShowStatus) _buildStatusText(context), // <--- WIDGET STATUS MỚI
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// Xây dựng nội dung chính của bubble (text và/hoặc post)
  Widget _buildBubbleContent(BuildContext context) {
    final theme = Theme.of(context);

    final contentColumn = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (message.messageType == 'shared_post') _buildSharedPost(context, theme),
        if (message.content != null && message.content!.isNotEmpty) _buildTextContent(theme),
      ],
    );

    return ConstrainedBox(
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
        blur: 0,
        child: contentColumn,
      ),
    );
  }

  /// Widget hiển thị bài viết được chia sẻ, placeholder loading, hoặc thông báo đã xóa
  Widget _buildSharedPost(BuildContext context, ThemeData theme) {
    if (message.messageType != 'shared_post') {
      return const SizedBox.shrink();
    }

    Widget sharedPostContent;
    if (message.sharedPost != null) {
      // Trường hợp 1: Có object Post -> Hiển thị SmallPost
      sharedPostContent = SmallPost(post: message.sharedPost!, onDeletePostPopBack: () {});
    } else if (message.sharedPostId != null) {
      // Trường hợp 2: Có post ID nhưng chưa có object Post -> ĐANG TẢI
      sharedPostContent = SizedBox(
        height: 150,
        child: Center(
          child: SizedBox(
            width: 24,
            height: 24,
            child: CircularProgressIndicator(strokeWidth: 2, color: appColorScheme(context).primary),
          ),
        ),
      );
    } else {
      // Trường hợp 3: Không có cả hai -> Đã bị xóa
      sharedPostContent = Padding(
        padding: const EdgeInsets.all(12.0),
        child: Text(
          'Bài viết này không còn tồn tại',
          style: theme.textTheme.bodyMedium?.copyWith(
            color: isMe ? theme.colorScheme.onPrimary.withOpacity(0.8) : theme.colorScheme.onSurface.withOpacity(0.7),
            fontStyle: FontStyle.italic,
          ),
        ),
      );
    }

    return SizedBox(
      width: 200, // Đặt chiều rộng cố định cho các tin nhắn chia sẻ
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: sharedPostContent,
      ),
    );
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

  /// Xây dựng avatar hoặc một khoảng trống có cùng chiều rộng để căn lề
  Widget _buildAvatarSpace(BuildContext context) {
    // Tin nhắn của mình không có avatar bên trái
    if (isMe) return const SizedBox.shrink();

    // Chiều rộng cố định để các bubble phía trên thẳng hàng
    return SizedBox(
      width: 38, // Bán kính (15) * 2 + padding (4) * 2
      child: shouldShowAvatar
          ? Align(
              alignment: Alignment.bottomLeft,
              child: GestureDetector(
                onTap: () => context.push('/post_detail/profile', extra: {'userId': otherUser.userId}),
                child: CachedCircleAvatar(
                  imageUrl: otherUser.photoUrl ?? '',
                  circleRadius: 15,
                ),
              ),
            )
          : null, // Để trống khi không cần hiển thị avatar
    );
  }

  Widget _buildStatusText(BuildContext context) {
    // Chỉ hiển thị status cho tin nhắn của mình
    if (!isMe) return const SizedBox.shrink();

    Widget statusWidget;
    final theme = Theme.of(context);
    final style = theme.textTheme.bodySmall?.copyWith(color: theme.colorScheme.onSurfaceVariant);

    // Ưu tiên 1: Trạng thái "Đã xem"
    if (otherUserLastReadAt != null && message.createdAt.toUtc().isBefore(otherUserLastReadAt!.toUtc())) {
      statusWidget = Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          CachedCircleAvatar(
            imageUrl: otherUser.photoUrl ?? '',
            circleRadius: 7,
          ),
          const SizedBox(width: 4),
          Text('Đã xem', style: style),
        ],
      );
    }
    // Ưu tiên 2: Các trạng thái khác
    else {
      switch (message.status) {
        case MessageStatus.sending:
          statusWidget = Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.access_time, size: 14, color: style?.color),
              const SizedBox(width: 4),
              Text('Đang gửi...', style: style),
            ],
          );
          break;
        case MessageStatus.failed:
          statusWidget = Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.error, size: 14, color: theme.colorScheme.error),
              const SizedBox(width: 4),
              Text('Gửi lỗi', style: style?.copyWith(color: theme.colorScheme.error)),
            ],
          );
          break;
        case MessageStatus.sent:
          statusWidget = Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.done, size: 14, color: style?.color),
              const SizedBox(width: 4),
              Text('Đã gửi', style: style),
            ],
          );
          break;
        default:
          statusWidget = const SizedBox.shrink();
      }
    }

    return Padding(
      padding: const EdgeInsets.only(top: 4.0, right: 8.0),
      child: statusWidget,
    );
  }
}
