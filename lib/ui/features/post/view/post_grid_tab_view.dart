import 'package:dishlocal/app/theme/theme.dart';
import 'package:dishlocal/ui/features/home/view/home_page.dart';
import 'package:dishlocal/ui/features/post/bloc/post_bloc.dart';
import 'package:dishlocal/ui/features/post/view/shimmering_small_post.dart';
import 'package:dishlocal/ui/features/post/view/small_post.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PostGridTabView extends StatefulWidget {
  final String noItemsFoundMessage;
  final ScrollController scrollController;

  const PostGridTabView({
    super.key,
    required this.noItemsFoundMessage,
    required this.scrollController,
  });

  @override
  State<PostGridTabView> createState() => _PostGridTabViewState();
}

class _PostGridTabViewState extends State<PostGridTabView> {
  late PostBloc _bloc;

  @override
  void initState() {
    super.initState();
    _bloc = context.read<PostBloc>();
    widget.scrollController.addListener(_onScroll);

    if (_bloc.state.status == PostStatus.initial) {
      _bloc.add(const PostEvent.fetchNextPageRequested());
    }
  }

  void _onScroll() {
    if (_isBottom) {
      _bloc.add(const PostEvent.fetchNextPageRequested());
    }
  }

  bool get _isBottom {
    if (!widget.scrollController.hasClients) return false;
    final maxScroll = widget.scrollController.position.maxScrollExtent;
    final currentScroll = widget.scrollController.offset;
    return currentScroll >= (maxScroll - 500.0);
  }

  Future<void> _onRefresh() async {
    _bloc.add(const PostEvent.refreshRequested());
    await _bloc.stream.firstWhere((s) => s.status != PostStatus.loading);
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: _onRefresh,
      child: BlocBuilder<PostBloc, PostState>(
        builder: (context, state) {
          if (state.status == PostStatus.loading && state.posts.isEmpty) {
            return GridView.builder(
              controller: widget.scrollController,
              padding: const EdgeInsets.all(10.0),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
                childAspectRatio: 0.75,
              ),
              itemCount: 8,
              itemBuilder: (context, index) => const ShimmeringSmallPost(),
            );
          }

          if (state.status == PostStatus.failure && state.posts.isEmpty) {
            return ListView(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.4,
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.error_outline_rounded, size: 64, color: appColorScheme(context).error),
                        const SizedBox(height: 16),
                        Text('Có lỗi xảy ra', style: appTextTheme(context).titleMedium),
                        const SizedBox(height: 8),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 30),
                          child: Text(state.failure?.message ?? "Không xác định", textAlign: TextAlign.center),
                        ),
                        const SizedBox(height: 24),
                        ElevatedButton.icon(
                          onPressed: _onRefresh,
                          icon: const Icon(Icons.refresh_rounded),
                          label: const Text('Thử lại'),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          }

          if (state.posts.isEmpty) {
            return ListView(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.4,
                  child: Center(child: Text(widget.noItemsFoundMessage)),
                ),
              ],
            );
          }

          return GridView.builder(
            controller: widget.scrollController,
            padding: const EdgeInsets.all(10.0),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
              childAspectRatio: 0.75,
            ),
            itemCount: state.hasNextPage ? state.posts.length + 2 : state.posts.length,
            itemBuilder: (context, index) {
              if (index >= state.posts.length) {
                return const ShimmeringSmallPost();
              }
              final post = state.posts[index];
              return SmallPost(
                post: post,
                onDeletePostPopBack: () => _bloc.add(const PostEvent.refreshRequested()),
              );
            },
          );
        },
      ),
    );
  }
}
