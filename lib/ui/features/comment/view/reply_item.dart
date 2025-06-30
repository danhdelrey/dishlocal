import 'package:dishlocal/app/theme/app_icons.dart';
import 'package:dishlocal/app/theme/theme.dart';
import 'package:dishlocal/core/utils/time_formatter.dart';
import 'package:dishlocal/data/categories/comment/model/comment_reply.dart';
import 'package:dishlocal/ui/features/comment/bloc/comment_bloc.dart';
import 'package:dishlocal/ui/features/post_reaction_bar/view/animated_icon_counter_button.dart';
import 'package:dishlocal/ui/widgets/element_widgets/custom_icon_with_label.dart';
import 'package:dishlocal/ui/widgets/image_widgets/cached_circle_avatar.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:timeago/timeago.dart' as timeago;

class ReplyItem extends StatelessWidget {
  final CommentReply reply;
  final String parentCommentId;
  final String postAuthorId;

  const ReplyItem({super.key, required this.reply, required this.parentCommentId, required this.postAuthorId});

  @override
  Widget build(BuildContext context) {
    final isAuthor = reply.authorUserId == postAuthorId;
    return Padding(
      padding: const EdgeInsets.only(top: 15),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
              onTap: () {
                context.push('/post_detail/profile', extra: {'userId': reply.authorUserId});
              },
              child: CachedCircleAvatar(imageUrl: reply.authorAvatarUrl ?? '', circleRadius: 12)),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RichText(
                  text: TextSpan(
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        context.push('/post_detail/profile', extra: {'userId': reply.authorUserId});
                      },
                    text: reply.authorUsername,
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
                RichText(
                  text: TextSpan(
                    style: Theme.of(context).textTheme.bodyMedium,
                    children: [
                      TextSpan(
                        text: '@${reply.replyToUsername} ',
                        style: TextStyle(color: Theme.of(context).colorScheme.primary, fontWeight: FontWeight.bold),
                      ),
                      TextSpan(text: reply.content),
                    ],
                  ),
                ),
                const SizedBox(height: 5),
                Row(
                  children: [
                    Text(
                      TimeFormatter.formatTimeAgo(reply.createdAt),
                      style: Theme.of(context).textTheme.labelMedium!.copyWith(color: Theme.of(context).colorScheme.outline),
                    ),
                    const SizedBox(width: 15),
                    GestureDetector(
                      onTap: () {
                        context.read<CommentBloc>().add(CommentEvent.replyTargetSet(
                              target: ReplyTarget(
                                parentCommentId: parentCommentId,
                                replyToUserId: reply.authorUserId,
                                replyToUsername: reply.authorUsername,
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
                      inactiveColor: appColorScheme(context).outline,
                      activeColor: Colors.pink,
                      isActive: reply.isLiked,
                      count: reply.likeCount,
                      onTap: () => context.read<CommentBloc>().add(CommentEvent.replyLiked(replyId: reply.replyId, parentCommentId: parentCommentId, isLiked: !reply.isLiked)),
                      iconBuilder: (isActive, color) {
                        final iconAsset = isActive ? AppIcons.heart : AppIcons.heart1;
                        return iconAsset.toSvg(width: 16, color: color);
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
