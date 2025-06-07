import 'package:dishlocal/app/theme/app_icons.dart';
import 'package:dishlocal/ui/features/comment/view/comment.dart';
import 'package:dishlocal/ui/widgets/custom_icon_with_label.dart';
import 'package:flutter/material.dart';

class CommentSection extends StatelessWidget {
  const CommentSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
      ),
      child: Column(
        children: [
          Row(
            children: [
              Text(
                'Tất cả bình luận',
                style: Theme.of(context).textTheme.labelLarge,
              ),
              Icon(
                Icons.keyboard_arrow_down_rounded,
                color: Theme.of(context).colorScheme.onSurface,
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          const Comment(),
          const Comment(),
          const Comment(
            subComment: Comment(
              avatarSize: 24,
            ),
          ),
          const Comment(),
          const Comment(),
          const SizedBox(
            height: 50,
          ),
          const SizedBox(
            width: 20,
            height: 20,
            child: CircularProgressIndicator(
              strokeWidth: 2,
            ),
          ),
        ],
      ),
    );
  }
}
