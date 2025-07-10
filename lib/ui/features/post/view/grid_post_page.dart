import 'package:dishlocal/app/theme/theme.dart';
import 'package:dishlocal/ui/features/filter_sort/view/filter_button.dart';
import 'package:dishlocal/ui/features/post/bloc/post_bloc.dart';
import 'package:dishlocal/ui/features/post/view/small_post.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GridPostPage extends StatefulWidget {
  final String noItemsFoundMessage;

  const GridPostPage({
    super.key,
    this.noItemsFoundMessage = "Không có bài viết nào.",
  });

  @override
  State<GridPostPage> createState() => _GridPostPageState();
}

class _GridPostPageState extends State<GridPostPage> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);

    final bloc = context.read<PostBloc>();
    if (bloc.state.status == PostStatus.initial) {
      bloc.add(const PostEvent.fetchNextPageRequested());
    }
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_isBottom) {
      if (mounted) {
        context.read<PostBloc>().add(const PostEvent.fetchNextPageRequested());
      }
    }
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll - 500.0);
  }

  Future<void> _onRefresh() async {
    final bloc = context.read<PostBloc>();
    bloc.add(const PostEvent.refreshRequested());
    await bloc.stream.firstWhere((s) => s.status != PostStatus.loading);
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<PostBloc, PostState>(
      listener: (context, state) {
        if (state.status == PostStatus.success && state.posts.isNotEmpty) {
          // Scroll về đầu khi có filters mới
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (_scrollController.hasClients) {
              _scrollController.animateTo(
                0,
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeOut,
              );
            }
          });
        }
      },
      child: BlocBuilder<PostBloc, PostState>(
        builder: (context, state) {
          if (state.status == PostStatus.loading && state.posts.isEmpty) {
            return const _ShimmeringSliverGrid();
          }

          if (state.status == PostStatus.failure && state.posts.isEmpty) {
            return Center(
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
            );
          }

          return RefreshIndicator(
            onRefresh: _onRefresh,
            child: CustomScrollView(
              controller: _scrollController,
              physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
              slivers: [
                if (state.posts.isEmpty)
                  SliverFillRemaining(
                    hasScrollBody: false,
                    child: Center(
                      child: Text(widget.noItemsFoundMessage),
                    ),
                  )
                else
                  SliverPadding(
                    padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                    sliver: SliverGrid(
                      delegate: SliverChildBuilderDelegate(
                        (context, index) {
                          if (index >= state.posts.length) {
                            return state.status == PostStatus.loading ? const ShimmeringSmallPost() : const SizedBox.shrink();
                          }
                          final post = state.posts[index];
                          return SmallPost(
                            post: post,
                            onDeletePostPopBack: () {
                              context.read<PostBloc>().add(const PostEvent.refreshRequested());
                            },
                          );
                        },
                        childCount: state.hasNextPage ? state.posts.length + 1 : state.posts.length,
                      ),
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 10,
                        crossAxisSpacing: 10,
                        childAspectRatio: 0.75,
                      ),
                    ),
                  ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _ShimmeringSliverGrid extends StatelessWidget {
  const _ShimmeringSliverGrid();

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      physics: const NeverScrollableScrollPhysics(),
      slivers: [
        SliverPadding(
          padding: const EdgeInsets.all(10),
          sliver: SliverGrid(
            delegate: SliverChildBuilderDelegate(
              (context, index) => const ShimmeringSmallPost(),
              childCount: 6,
            ),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
              childAspectRatio: 0.75,
            ),
          ),
        ),
      ],
    );
  }
}

class ShimmeringSmallPost extends StatefulWidget {
  const ShimmeringSmallPost({super.key});
  @override
  State<ShimmeringSmallPost> createState() => _ShimmeringSmallPostState();
}

class _ShimmeringSmallPostState extends State<ShimmeringSmallPost> with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _opacityAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    )..repeat(reverse: true);
    _opacityAnimation = Tween<double>(begin: 0.3, end: 0.8).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: FadeTransition(
        opacity: _opacityAnimation,
        child: _buildPlaceholderContent(),
      ),
    );
  }

  Widget _buildPlaceholderContent() {
    final placeholderColor = appColorScheme(context).outlineVariant;
    return Column(
      children: [
        Container(
          height: 10,
          decoration: BoxDecoration(color: placeholderColor, borderRadius: BorderRadius.circular(1000)),
        ),
        const SizedBox(height: 5),
        AspectRatio(
          aspectRatio: 1,
          child: Container(
            decoration: BoxDecoration(color: placeholderColor, borderRadius: BorderRadius.circular(12)),
          ),
        ),
        const SizedBox(height: 5),
        Row(
          children: [
            Container(
              width: 16,
              height: 16,
              decoration: BoxDecoration(color: placeholderColor, borderRadius: BorderRadius.circular(1000)),
            ),
            const SizedBox(width: 5),
            Expanded(
              child: Container(
                height: 10,
                decoration: BoxDecoration(color: placeholderColor, borderRadius: BorderRadius.circular(20)),
              ),
            ),
            const SizedBox(width: 20),
            Container(
              width: 30,
              height: 10,
              decoration: BoxDecoration(color: placeholderColor, borderRadius: BorderRadius.circular(20)),
            ),
          ],
        ),
      ],
    );
  }
}
