import 'package:dishlocal/app/theme/theme.dart';
import 'package:dishlocal/core/dependencies_injection/service_locator.dart';
import 'package:dishlocal/data/categories/post/model/post.dart';
import 'package:dishlocal/ui/features/post/bloc/post_bloc.dart';
import 'package:dishlocal/ui/features/post/view/small_post.dart';
import 'package:dishlocal/ui/widgets/animated_widgets/fade_slide_up.dart';
import 'package:dishlocal/ui/widgets/element_widgets/custom_loading_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:shimmer/shimmer.dart';

class GridPostPage extends StatefulWidget {
  const GridPostPage({super.key});

  @override
  State<GridPostPage> createState() => _GridPostPageState();
}

class _GridPostPageState extends State<GridPostPage> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PostBloc, PagingState<DateTime?, Post>>(
      builder: (context, state) {
        return RefreshIndicator(
          onRefresh: () => Future.sync(
            () => context.read<PostBloc>().add(
                  const PostEvent.refreshRequested(),
                ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
            child: CustomScrollView(
              physics: const AlwaysScrollableScrollPhysics().applyTo(const BouncingScrollPhysics()),
              slivers: [
                // Grid dạng masonry
                PagedSliverMasonryGrid<DateTime?, Post>(
                  state: state,
                  fetchNextPage: () {
                    context.read<PostBloc>().add(
                          const PostEvent.fetchNextPostPageRequested(),
                        );
                  },
                  builderDelegate: PagedChildBuilderDelegate<Post>(
                    itemBuilder: (context, post, index) => FadeSlideUp(
                      delay: Duration(milliseconds: index * 100),
                      child: SmallPost(post: post),
                    ),
                    firstPageProgressIndicatorBuilder: (_) => Shimmer.fromColors(
                      baseColor: appColorScheme(context).surfaceContainerLow,
                      highlightColor: appColorScheme(context).outline,
                      child: Column(
                        children: List.generate(
                          5,
                          (_) => Expanded(
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                _buildShimmeringSmallPost(),
                                _buildShimmeringSmallPost(),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    noItemsFoundIndicatorBuilder: (_) => const Center(
                      child: Text("Không có bài viết nào."),
                    ),
                    newPageProgressIndicatorBuilder: (context) => const Center(child: CustomLoadingIndicator(indicatorSize: 30)),
                  ),
                  gridDelegateBuilder: (int childCount) => const SliverSimpleGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                  ),
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildShimmeringSmallPost() {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: Column(
          children: [
            Container(
              height: 10,
              decoration: BoxDecoration(
                color: Colors.amber,
                borderRadius: BorderRadius.circular(1000),
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            AspectRatio(
              aspectRatio: 1,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.amber,
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Row(
              children: [
                Container(
                  width: 16,
                  height: 16,
                  decoration: BoxDecoration(
                    color: Colors.amber,
                    borderRadius: BorderRadius.circular(1000),
                  ),
                ),
                const SizedBox(
                  width: 5,
                ),
                Expanded(
                  child: Container(
                    height: 10,
                    decoration: BoxDecoration(
                      color: Colors.amber,
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 20,
                ),
                Container(
                  width: 30,
                  height: 10,
                  decoration: BoxDecoration(
                    color: Colors.amber,
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
