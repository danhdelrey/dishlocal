import 'package:dishlocal/app/theme/theme.dart';
import 'package:dishlocal/data/categories/post/model/post.dart';
import 'package:dishlocal/ui/features/filter_sort/view/filter_button.dart';
import 'package:dishlocal/ui/features/post/bloc/post_bloc.dart';
import 'package:dishlocal/ui/features/post/view/small_post.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

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
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    // Tải trang đầu tiên ngay khi widget được tạo
    // (nếu danh sách đang rỗng)
    final bloc = context.read<PostBloc>();
    if (bloc.state.status == PostStatus.initial) {
      bloc.add(const PostEvent.fetchNextPageRequested());
    }
  }

  @override
  void dispose() {
    _scrollController
      ..removeListener(_onScroll)
      ..dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_isBottom) {
      // Gọi BLoC để tải trang tiếp theo
      context.read<PostBloc>().add(const PostEvent.fetchNextPageRequested());
    }
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    // Trigger tải trang mới khi chỉ còn 300px nữa là đến cuối
    return currentScroll >= (maxScroll - 300);
  }

  @override
  Widget build(BuildContext context) {
    // Dùng BlocBuilder để lắng nghe và rebuild UI theo PostState
    return BlocBuilder<PostBloc, PostState>(
      builder: (context, state) {
        // Trường hợp 1: Đang tải lần đầu tiên (danh sách rỗng)
        if (state.status == PostStatus.loading && state.posts.isEmpty) {
          return const _ShimmeringGrid();
        }
        // Trường hợp 2: Lỗi khi tải lần đầu
        if (state.status == PostStatus.failure && state.posts.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Lỗi: ${state.failure?.toString() ?? "Không xác định"}'),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    context.read<PostBloc>().add(const PostEvent.refreshRequested());
                  },
                  child: const Text('Thử lại'),
                ),
              ],
            ),
          );
        }
        // Trường hợp 3: Thành công nhưng không có bài viết nào
        if (state.status == PostStatus.success && state.posts.isEmpty) {
          return Column(
            children: [
              const FilterButton(),
              const SizedBox(height: 24),
              Center(child: Text(widget.noItemsFoundMessage)),
            ],
          );
        }

        // Trường hợp 4: Hiển thị danh sách bài viết
        return _buildPostList(context, state);
      },
    );
  }

  Widget _buildPostList(BuildContext context, PostState state) {
    return RefreshIndicator(
      onRefresh: () async {
        final bloc = context.read<PostBloc>();
        bloc.add(const PostEvent.refreshRequested());
        // Đợi đến khi BLoC không còn ở trạng thái loading nữa
        await bloc.stream.firstWhere((s) => s.status != PostStatus.loading);
      },
      child: CustomScrollView(
        controller: _scrollController,
        physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
        slivers: [
          const SliverToBoxAdapter(
            child: FilterButton(),
          ),

          SliverPadding(
            padding: const EdgeInsets.all(10),
            sliver: SliverGrid(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
                childAspectRatio: 0.75, // Tỷ lệ chiều rộng/chiều cao của mỗi item
              ),
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  final post = state.posts[index];
                  return SmallPost(
                    post: post,
                    onDeletePostPopBack: () {
                      context.read<PostBloc>().add(const PostEvent.refreshRequested());
                    },
                  );
                },
                childCount: state.posts.length,
              ),
            ),
          ),
          // Hiển thị loading indicator ở cuối nếu còn trang để tải
          if (state.hasNextPage)
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 24),
                child: Center(
                  // Dùng ShimmeringSmallPost cho loading indicator ở cuối
                  child: state.status == PostStatus.loading ? const ShimmeringSmallPost() : const SizedBox.shrink(),
                ),
              ),
            ),
          // Thêm một khoảng trống ở cuối để không bị FAB che mất
          const SliverToBoxAdapter(
            child: SizedBox(height: kBottomNavigationBarHeight + 40),
          ),
        ],
      ),
    );
  }
}

// Widget Shimmer tiện ích cho lần tải đầu tiên
class _ShimmeringGrid extends StatelessWidget {
  const _ShimmeringGrid();

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.all(10),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
        childAspectRatio: 0.75,
      ),
      itemCount: 6, // Hiển thị 6 item shimmer
      itemBuilder: (context, index) => const ShimmeringSmallPost(),
    );
  }
}

// Giữ nguyên widget ShimmeringSmallPost của bạn
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
