import 'package:dishlocal/app/theme/app_icons.dart';
import 'package:dishlocal/app/theme/theme.dart';
import 'package:dishlocal/ui/features/post_reaction_bar/view/animated_icon_counter_button.dart';
import 'package:flutter/material.dart';

class ReactionBar extends StatelessWidget {
  final int likeCount;
  final bool isLiked;
  final VoidCallback onLikeTap;
  final Color likeColor;

  final int commentCount;
  final VoidCallback onCommentTap;

  final int saveCount;
  final bool isSaved;
  final VoidCallback onSaveTap;
  final Color saveColor;

  const ReactionBar({
    super.key,
    required this.likeCount,
    required this.isLiked,
    required this.onLikeTap,
    required this.saveCount,
    required this.isSaved,
    required this.onSaveTap,
    required this.likeColor,
    required this.saveColor,
    required this.commentCount,
    required this.onCommentTap,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // Nút Like
        AnimatedIconCounterButton(
          activeColor: likeColor,
          isActive: isLiked,
          count: likeCount,
          onTap: onLikeTap,
          iconBuilder: (isActive, color) {
            final iconAsset = isActive ? AppIcons.heart : AppIcons.heart1;
            return iconAsset.toSvg(width: 16, color: color);
          },
        ),
        const SizedBox(width: 20),
        AnimatedIconCounterButton(
          activeColor: appColorScheme(context).onSurface,
          isActive: true,
          count: commentCount,
          onTap: onCommentTap,
          iconBuilder: (isActive, color) {
            final iconAsset = isActive ? AppIcons.comment2 : AppIcons.comment2;
            return iconAsset.toSvg(width: 16, color: color);
          },
        ),
        const SizedBox(width: 20),
        // Nút Save/Bookmark
        AnimatedIconCounterButton(
          activeColor: saveColor,
          isActive: isSaved,
          count: saveCount,
          onTap: onSaveTap,
          iconBuilder: (isActive, color) {
            // Giả sử bạn có icon bookmark
            final iconAsset = isActive ? AppIcons.bookmark : AppIcons.bookmark1;
            return iconAsset.toSvg(width: 16, color: color);
          },
        ),
      ],
    );
  }
}
