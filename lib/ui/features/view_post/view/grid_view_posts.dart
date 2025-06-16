import 'package:dishlocal/ui/features/view_post/view/small_post.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class GridViewPosts extends StatelessWidget {
  const GridViewPosts({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      physics: const AlwaysScrollableScrollPhysics().applyTo(const BouncingScrollPhysics()),
      slivers: [
        // Lưới dạng Masonry
        SliverPadding(
          padding: const EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 150),
          sliver: SliverMasonryGrid.count(
            crossAxisCount: 2,
            mainAxisSpacing: 10,
            crossAxisSpacing: 10,
            childCount: 10,
            itemBuilder: (context, index) => SmallPost(
              postId: index,
            ),
          ),
        ),
      ],
    );
  }
}
