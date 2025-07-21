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
          setState(() {
            // Không cần làm gì ở đây, chỉ cần gọi setState là đủ
          });
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
    final lastMessage = widget.conversation.lastMessageContent;
    if (lastMessage == null || lastMessage.isEmpty) {
      if (widget.conversation.lastMessageSharedPostId != null) {
        return "Đã chia sẻ một bài viết";
      }
      return "Chưa có tin nhắn.";
    }

    if (widget.conversation.lastMessageSenderId == _currentUserId) {
      return 'Bạn: $lastMessage';
    }

    return lastMessage;
  }

  @override
  Widget build(BuildContext context) {
    final hasUnread = widget.conversation.unreadCount > 0;

    return InkWell(
      onTap: () {
        context.push(
          '/chat',
          extra: {
            'conversationId': widget.conversation.conversationId,
            'otherUser': widget.conversation.otherParticipant,
          },
        ).then((_) {
          context.read<ConversationListBloc>().add(const ConversationListEvent.refreshed());
        });
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
  }
}
