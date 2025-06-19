import 'package:dishlocal/core/dependencies_injection/service_locator.dart';
import 'package:dishlocal/data/categories/post/model/post.dart';
import 'package:dishlocal/ui/features/post/bloc/post_bloc.dart';
import 'package:dishlocal/ui/features/post/view/small_post.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

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
                    itemBuilder: (context, post, index) => SmallPost(post: post),
                    firstPageProgressIndicatorBuilder: (_) => const Center(
                      child: CircularProgressIndicator(),
                    ),
                    noItemsFoundIndicatorBuilder: (_) => const Center(
                      child: Text("Không có bài viết nào."),
                    ),
                    noMoreItemsIndicatorBuilder: (context) => const Text('no more'),
                    newPageProgressIndicatorBuilder: (context) => const Text('loading'),
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
}
