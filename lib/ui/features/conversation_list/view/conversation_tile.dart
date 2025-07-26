import 'dart:async';

import 'package:dishlocal/app/theme/theme.dart';
import 'package:dishlocal/core/dependencies_injection/service_locator.dart';
import 'package:dishlocal/core/utils/time_formatter.dart';
import 'package:dishlocal/data/categories/app_user/repository/interface/app_user_repository.dart';
import 'package:dishlocal/data/categories/chat/model/conversation.dart';
import 'package:dishlocal/ui/features/conversation_list/bloc/conversation_list_bloc.dart';
import 'package:dishlocal/ui/widgets/image_widgets/cached_circle_avatar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class ConversationTile extends StatefulWidget {
  final Conversation conversation;

  const ConversationTile({super.key, required this.conversation});

  @override
  State<ConversationTile> createState() => _ConversationTileState();
}

class _ConversationTileState extends State<ConversationTile> {
  Timer? _timer;
  late final String _currentUserId;

  @override
  void initState() {
    super.initState();
    _currentUserId = getIt<AppUserRepository>().getCurrentUserId()!;
    // Chỉ bắt đầu timer nếu có thời gian để hiển thị
    if (widget.conversation.lastMessageCreatedAt != null) {
      // Timer sẽ kích hoạt một lần build lại mỗi phút
      _timer = Timer.periodic(const Duration(minutes: 1), (timer) {
        // Gọi setState để buộc widget build lại
        if (mounted) {
          setState(() {});
        }
      });
    }
  }

  @override
  void dispose() {
    // Luôn hủy timer để tránh rò rỉ bộ nhớ
    _timer?.cancel();
    super.dispose();
  }

  String _buildPreviewText() {
    // Ưu tiên 1: Nếu tin nhắn cuối là loại 'shared_post'
    if (widget.conversation.lastMessageType == 'shared_post') {
      return widget.conversation.lastMessageSenderId == _currentUserId ? 'Bạn đã gửi một bài viết' : 'Đã gửi một bài viết';
    }

    // Ưu tiên 2: Nếu tin nhắn cuối có nội dung text
    final lastMessageText = widget.conversation.lastMessageContent?.replaceAll('\n', ' ');
    if (lastMessageText != null && lastMessageText.isNotEmpty) {
      return widget.conversation.lastMessageSenderId == _currentUserId ? 'Bạn: $lastMessageText' : lastMessageText;
    }

    // Trường hợp mặc định: Nếu không có tin nhắn nào
    return "Chưa có tin nhắn.";
  }

  Future<bool?> _showConfirmationDialog(BuildContext context) {
    return showDialog<bool>(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: const Text('Xác nhận xóa'),
          content: const Text('Bạn có chắc chắn muốn xóa cuộc trò chuyện này không? Hành động này không thể hoàn tác.'),
          actions: <Widget>[
            TextButton(
              child: const Text('Hủy'),
              onPressed: () => Navigator.of(dialogContext).pop(false),
            ),
            TextButton(
              child: const Text('Xóa', style: TextStyle(color: Colors.red)),
              onPressed: () => Navigator.of(dialogContext).pop(true),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final hasUnread = widget.conversation.unreadCount > 0;

    final tileContent = InkWell(
      onTap: () {
        // === THAY ĐỔI: Đơn giản hóa onTap ===
        // Không cần gọi .then() và refresh BLoC nữa.
        // Việc cập nhật trạng thái đã đọc sẽ trigger EventBus,
        // sau đó UnreadBadgeCubit và ConversationListBloc sẽ tự động cập nhật.
        context.push(
          '/chat',
          extra: {
            'conversationId': widget.conversation.conversationId,
            'otherUser': widget.conversation.otherParticipant,
          },
        );
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 15.0),
        child: Row(
          children: [
            CachedCircleAvatar(
              imageUrl: widget.conversation.otherParticipant.photoUrl ?? '',
              circleRadius: 25,
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.conversation.otherParticipant.displayName ?? 'Người dùng',
                    style: appTextTheme(context).labelLarge?.copyWith(
                          fontWeight: hasUnread ? FontWeight.bold : FontWeight.normal,
                          color: appColorScheme(context).onSurface,
                        ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    _buildPreviewText(),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: appTextTheme(context).bodyMedium?.copyWith(
                          color: hasUnread ? appColorScheme(context).onSurface : appColorScheme(context).outline,
                        ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 12),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                if (widget.conversation.lastMessageCreatedAt != null)
                  Text(
                    TimeFormatter.formatTimeAgo(widget.conversation.lastMessageCreatedAt!),
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
                      widget.conversation.unreadCount.toString(),
                      style: const TextStyle(color: Colors.white, fontSize: 12),
                    ),
                  )
                else
                  const SizedBox(height: 20),
              ],
            ),
          ],
        ),
      ),
    );

    return Dismissible(
      // Key là bắt buộc để Flutter xác định đúng widget cần xóa
      key: ValueKey(widget.conversation.conversationId),

      // Chỉ cho phép vuốt từ phải sang trái
      direction: DismissDirection.endToStart,

      // Nền sẽ hiển thị phía sau khi vuốt
      background: Container(
        color: Colors.red,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        alignment: Alignment.centerRight,
        child: const Icon(Icons.delete, color: Colors.white),
      ),

      // Hàm confirmDismiss sẽ được gọi TRƯỚC KHI widget bị xóa khỏi cây
      confirmDismiss: (direction) async {
        // Hiển thị dialog và chờ kết quả
        final bool? confirmed = await _showConfirmationDialog(context);
        // Trả về kết quả (true để cho phép xóa, false để hủy)
        return confirmed ?? false;
      },

      // Hàm onDismissed sẽ được gọi SAU KHI widget đã được xóa (nếu confirmDismiss trả về true)
      onDismissed: (direction) {
        // Gọi BLoC để thực hiện logic xóa trên server
        context.read<ConversationListBloc>().deleteConversation(widget.conversation.conversationId);

        // (Tùy chọn) Hiển thị SnackBar để có thể hoàn tác
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Đã xóa cuộc trò chuyện với ${widget.conversation.otherParticipant.displayName}'),
          ),
        );
      },

      // Widget con chính là tile của chúng ta
      child: tileContent,
    );
  }
}
