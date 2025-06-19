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
    return BlocProvider(
      create: (context) => getIt<PostBloc>(),
      child: BlocBuilder<PostBloc, PagingState<DateTime?, Post>>(
        builder: (context, state) => PagedMasonryGridView<DateTime?, Post>.count(
          crossAxisCount: 2,
          state: state,
          fetchNextPage: () => context.read<PostBloc>().add(const PostEvent.fetchNextPostPageRequested()),
          builderDelegate: PagedChildBuilderDelegate<Post>(
            itemBuilder: (_, item, index) => SmallPost(post: item),
          ),
        ),
      ),
    );
  }
}
