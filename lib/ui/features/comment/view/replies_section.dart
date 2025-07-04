import 'package:dishlocal/ui/features/comment/bloc/comment_bloc.dart';
import 'package:dishlocal/ui/features/comment/view/comment_bottom_sheet.dart';
import 'package:dishlocal/ui/features/comment/view/comment_list_view.dart';
import 'package:dishlocal/ui/features/comment/view/reply_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RepliesSection extends StatelessWidget {
  final String parentCommentId;
  final int totalReplyCount;
  final String postAuthorId;

  const RepliesSection({super.key, required this.parentCommentId, required this.totalReplyCount, required this.postAuthorId});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CommentBloc, CommentState>(
      buildWhen: (p, c) => p.replies[parentCommentId] != c.replies[parentCommentId] || p.replyLoadStatus[parentCommentId] != c.replyLoadStatus[parentCommentId],
      builder: (context, state) {
        final replies = state.replies[parentCommentId] ?? [];
        final hasMore = state.hasMoreReplies[parentCommentId] ?? true;
        final status = state.replyLoadStatus[parentCommentId] ?? CommentStatus.initial;
        final remainingCount = totalReplyCount - replies.length;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 7.5,
            ),
            ...replies.map(
              (reply) => ReplyItem(
                currentUserId: state.currentUser!.userId,
                reply: reply,
                parentCommentId: parentCommentId,
                postAuthorId: postAuthorId,
              ),
            ),
            if (status == CommentStatus.loading)
              const ShimmeringComment(
                isReply: true,
              ),
            if (hasMore && status != CommentStatus.loading && remainingCount > 0)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: Row(
                  children: [
                    TextButton.icon(
                      icon: const Icon(
                        Icons.keyboard_arrow_down_rounded,
                      ),
                      onPressed: () => context.read<CommentBloc>().add(CommentEvent.repliesRequested(parentCommentId: parentCommentId)),
                      label: Text(
                        'Xem $remainingCount trả lời...',
                      ),
                      style: TextButton.styleFrom(
                        foregroundColor: Theme.of(context).colorScheme.onSurface,
                        textStyle: Theme.of(context).textTheme.labelMedium,
                        padding: EdgeInsets.zero,

                        tapTargetSize: MaterialTapTargetSize.shrinkWrap, // 👈 Loại bỏ padding mặc định cho hit test
                        minimumSize: const Size(0, 0), // 👈 Tránh chiều cao tối thiểu mặc định
                      ),
                    ),
                  ],
                ),
              )
          ],
        );
      },
    );
  }
}
