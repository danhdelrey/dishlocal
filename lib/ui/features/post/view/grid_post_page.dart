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
  // MỚI: Tạo một ScrollController cục bộ. Đơn giản và hiệu quả.
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    // Gắn listener để phát hiện khi cuộn xuống cuối trang
    _scrollController.addListener(_onScroll);

    // Tải trang đầu tiên nếu cần
    final bloc = context.read<PostBloc>();
    if (bloc.state.status == PostStatus.initial) {
      bloc.add(const PostEvent.fetchNextPageRequested());
    }
  }

  @override
  void dispose() {
    // Quan trọng: Gỡ listener và hủy controller để tránh memory leak.
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
    // Trigger load more sớm hơn để trải nghiệm người dùng mượt mà hơn
    return currentScroll >= (maxScroll - 500.0);
  }

  // MỚI: Hàm xử lý refresh, tái sử dụng được
  Future<void> _onRefresh() async {
    final bloc = context.read<PostBloc>();
    bloc.add(const PostEvent.refreshRequested());
    // Đợi đến khi BLoC không còn ở trạng thái loading nữa
    await bloc.stream.firstWhere((s) => s.status != PostStatus.loading);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PostBloc, PostState>(
      builder: (context, state) {
        // ---- CÁC TRƯỜNG HỢP BAN ĐẦU (LOADING, FAILURE, EMPTY) ----

        // 1. Đang tải lần đầu tiên
        if (state.status == PostStatus.loading && state.posts.isEmpty) {
          return const _ShimmeringGrid();
        }

        // 2. Lỗi khi tải lần đầu
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
                  onPressed: _onRefresh, // Dùng hàm _onRefresh
                  icon: const Icon(Icons.refresh_rounded),
                  label: const Text('Thử lại'),
                ),
              ],
            ),
          );
        }

        // ---- CÁC TRƯỜNG HỢP HIỂN THỊ DANH SÁCH ----

        return Column(
          children: [
            // Luôn hiển thị FilterButton ở trên đầu
            const Padding(
              padding: EdgeInsets.only(top: 15, bottom: 5),
              child: FilterButton(),
            ),
            Expanded(
              child: RefreshIndicator(
                onRefresh: _onRefresh,
                child: _buildContent(context, state), // Gọi hàm xây dựng nội dung chính
              ),
            ),
          ],
        );
      },
    );
  }

  // MỚI: Tách hàm build nội dung để code sạch sẽ hơn
  Widget _buildContent(BuildContext context, PostState state) {
    // 3. Thành công nhưng không có bài viết nào
    if (state.posts.isEmpty) {
      // Dùng ListView để cho phép RefreshIndicator hoạt động ngay cả khi list rỗng
      return LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: constraints.maxHeight),
              child: Center(
                child: Text(widget.noItemsFoundMessage),
              ),
            ),
          );
        },
      );
    }

    // 4. Hiển thị GridView với danh sách bài viết
    return GridView.builder(
      key: PageStorageKey<String>(state.filterSortParams.toString()), // Giữ vị trí cuộn khi filter
      controller: _scrollController,
      physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
      padding: const EdgeInsets.fromLTRB(10, 0, 10, kBottomNavigationBarHeight + 40),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
        childAspectRatio: 0.75,
      ),
      // Nếu có trang tiếp theo, thêm 1 item cho loading indicator
      itemCount: state.hasNextPage ? state.posts.length + 1 : state.posts.length,
      itemBuilder: (context, index) {
        // Nếu là item cuối cùng và còn trang, hiển thị ShimmeringSmallPost
        if (index >= state.posts.length) {
          // Chỉ hiển thị Shimmering khi đang thực sự tải
          return state.status == PostStatus.loading ? const ShimmeringSmallPost() : const SizedBox.shrink();
        }

        // Ngược lại, hiển thị bài viết
        final post = state.posts[index];
        return SmallPost(
          post: post,
          onDeletePostPopBack: () {
            context.read<PostBloc>().add(const PostEvent.refreshRequested());
          },
        );
      },
    );
  }
}

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
