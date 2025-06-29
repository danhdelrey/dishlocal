import 'package:dishlocal/ui/features/comment/bloc/comment_bloc.dart';
import 'package:dishlocal/ui/features/comment/view/comment_bottom_sheet.dart';
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
            ...replies.map((reply) => ReplyItem(reply: reply, parentCommentId: parentCommentId, postAuthorId: postAuthorId)),
            if (status == CommentStatus.loading) const Padding(padding: EdgeInsets.symmetric(vertical: 8.0), child: SizedBox(width: 16, height: 16, child: CircularProgressIndicator(strokeWidth: 2))),
            if (hasMore && status != CommentStatus.loading && remainingCount > 0)
              GestureDetector(
                onTap: () => context.read<CommentBloc>().add(CommentEvent.repliesRequested(parentCommentId: parentCommentId)),
                child: Padding(
                  padding: const EdgeInsets.only(top: 15),
                  child: Text(
                    'Xem $remainingCount trả lời...',
                    style: Theme.of(context).textTheme.labelMedium!.copyWith(color: Theme.of(context).colorScheme.outline),
                  ),
                ),
              )
          ],
        );
      },
    );
  }
}
