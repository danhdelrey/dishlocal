import 'package:dishlocal/ui/features/comment/view/comment.dart';
import 'package:dishlocal/ui/features/view_post/view/post_detail_page.dart';
import 'package:flutter/material.dart';

class CommentSection extends StatelessWidget {
  const CommentSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 10,
      ),
      child: Column(
        children: [
          Comment(),
          Comment(),
          Comment(
            subComment: Comment(
              avatarSize: 24,
            ),
          ),
          Comment(),
          Comment(),
          SizedBox(
            height: 20,
          ),
          SizedBox(
            width: 20,
            height: 20,
            child: CircularProgressIndicator(
              strokeWidth: 2,
            ),
          ),
          SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }
}
