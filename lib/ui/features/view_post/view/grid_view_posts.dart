import 'package:dishlocal/ui/features/view_post/view/post.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class GridViewPosts extends StatelessWidget {
  const GridViewPosts({super.key, this.header});

  final SliverToBoxAdapter? header;

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        if (header != null) header!,

        // Lưới dạng Masonry
        SliverPadding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          sliver: SliverMasonryGrid.count(
            crossAxisCount: 2,
            mainAxisSpacing: 10,
            crossAxisSpacing: 10,
            childCount: 10,
            itemBuilder: (context, index) => const Post(),
          ),
        ),

        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Container(
              width: double.infinity,
              alignment: Alignment.center,
              child: Text(
                'Đã xem hết bài đăng',
                style: Theme.of(context).textTheme.labelMedium!.copyWith(
                      color: Theme.of(context).colorScheme.outline,
                    ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
