import 'package:dishlocal/app/theme/app_icons.dart';
import 'package:dishlocal/data/categories/comment/model/comment.dart';
import 'package:dishlocal/ui/features/comment/bloc/comment_bloc.dart';
import 'package:dishlocal/ui/features/comment/view/comment_bottom_sheet.dart';
import 'package:dishlocal/ui/features/comment/view/replies_section.dart';
import 'package:dishlocal/ui/features/post_reaction_bar/view/animated_icon_counter_button.dart';
import 'package:dishlocal/ui/widgets/element_widgets/custom_icon_with_label.dart';
import 'package:dishlocal/ui/widgets/image_widgets/cached_circle_avatar.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:timeago/timeago.dart' as timeago;

class CommentItem extends StatelessWidget {
  final Comment comment;
  final String postAuthorId;

  const CommentItem({super.key, required this.comment, required this.postAuthorId});

  @override
  Widget build(BuildContext context) {
    final isAuthor = comment.authorUserId == postAuthorId;

    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: () {
              context.push('/post_detail/profile', extra: {'userId': comment.authorUserId});
            },
            child: CachedCircleAvatar(imageUrl: comment.authorAvatarUrl ?? '', circleRadius: 18),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RichText(
                  text: TextSpan(
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        context.push('/post_detail/profile', extra: {'userId': comment.authorUserId});
                      },
                    text: comment.authorUsername,
                    style: Theme.of(context).textTheme.labelLarge,
                    children: [
                      if (isAuthor)
                        TextSpan(
                          text: ' • Tác giả',
                          style: Theme.of(context).textTheme.labelMedium!.copyWith(color: Theme.of(context).colorScheme.secondary),
                        ),
                    ],
                  ),
                ),
                Text(
                  comment.content,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                const SizedBox(height: 5),
                Row(
                  children: [
                    Text(
                      timeago.format(comment.createdAt, locale: 'vi'),
                      style: Theme.of(context).textTheme.labelMedium!.copyWith(color: Theme.of(context).colorScheme.outline),
                    ),
                    const SizedBox(width: 15),
                    GestureDetector(
                      onTap: () {
                        context.read<CommentBloc>().add(CommentEvent.replyTargetSet(
                              target: ReplyTarget(
                                parentCommentId: comment.commentId,
                                replyToUserId: comment.authorUserId,
                                replyToUsername: comment.authorUsername,
                              ),
                            ));
                      },
                      child: Text(
                        'Trả lời',
                        style: Theme.of(context).textTheme.labelMedium!.copyWith(color: Theme.of(context).colorScheme.onSurface),
                      ),
                    ),
                    const Spacer(),
                    AnimatedIconCounterButton(
                      activeColor: Colors.pink,
                      isActive: comment.isLiked,
                      count: comment.likeCount,
                      onTap: () => context.read<CommentBloc>().add(CommentEvent.commentLiked(commentId: comment.commentId, isLiked: !comment.isLiked)),
                      iconBuilder: (isActive, color) {
                        final iconAsset = isActive ? AppIcons.heart : AppIcons.heart1;
                        return iconAsset.toSvg(width: 16, color: color);
                      },
                    ),
                  ],
                ),
                if (comment.replyCount > 0)
                  RepliesSection(
                    parentCommentId: comment.commentId,
                    totalReplyCount: comment.replyCount,
                    postAuthorId: postAuthorId,
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
