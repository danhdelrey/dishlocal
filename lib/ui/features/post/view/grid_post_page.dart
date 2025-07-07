import 'package:dishlocal/app/theme/theme.dart';
import 'package:dishlocal/data/categories/post/model/post.dart';
import 'package:dishlocal/ui/features/filter_sort/view/filter_button.dart';
import 'package:dishlocal/ui/features/post/view/small_post.dart';
import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

// THAY ĐỔI 1: GridPostPage giờ là một widget trình bày thuần túy.
class GridPostPage extends StatelessWidget {
  // THAY ĐỔI 2: Nó nhận vào state và các hàm callback.
  final PagingState<dynamic, Post> pagingState;
  final VoidCallback onFetchNextPage;
  final Future<void> Function() onRefresh;
  final String noItemsFoundMessage;

  const GridPostPage({
    super.key,
    required this.pagingState,
    required this.onFetchNextPage,
    required this.onRefresh,
    this.noItemsFoundMessage = "Không có bài viết nào.",
  });

  @override
  Widget build(BuildContext context) {
    bool hasActiveFilters = true; // Giả sử bạn có một biến để kiểm tra bộ lọc
    return RefreshIndicator(
      onRefresh: onRefresh, // Gọi callback onRefresh
      child: Padding(
        padding: const EdgeInsets.only(left: 10, right: 10, top: 15),
        child: CustomScrollView(
          physics: const AlwaysScrollableScrollPhysics().applyTo(const BouncingScrollPhysics()),
          slivers: [
            SliverToBoxAdapter(
              child: FilterButton(hasActiveFilters: hasActiveFilters),
            ),
            PagedSliverMasonryGrid<dynamic, Post>(
              // Dùng state và callback được truyền vào
              state: pagingState,
              fetchNextPage: onFetchNextPage,
              builderDelegate: PagedChildBuilderDelegate<Post>(
                itemBuilder: (context, post, index) => SmallPost(
                  post: post,
                  onDeletePostPopBack: () async {
                    // Khi một bài viết bị xóa, chúng ta chỉ cần gọi onRefresh.
                    await onRefresh();
                  },
                ),
                // Các builder khác giữ nguyên
                firstPageProgressIndicatorBuilder: (_) => Column(
                  children: List.generate(
                    2,
                    (_) => const Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(child: ShimmeringSmallPost()),
                        Expanded(child: ShimmeringSmallPost()),
                      ],
                    ),
                  ),
                ),
                noItemsFoundIndicatorBuilder: (_) => Center(child: Text(noItemsFoundMessage)),
                newPageProgressIndicatorBuilder: (context) => const ShimmeringSmallPost(),
              ),
              gridDelegateBuilder: (int childCount) => const SliverSimpleGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
              ),
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
            ),
            const SliverToBoxAdapter(
              child: SizedBox(height: kBottomNavigationBarHeight + 15),
            ),
          ],
        ),
      ),
    );
  }
}

class ShimmeringSmallPost extends StatefulWidget {
  const ShimmeringSmallPost({super.key});

  @override
  State<ShimmeringSmallPost> createState() => _ShimmeringSmallPostState();
}

// Thêm "with SingleTickerProviderStateMixin" để cung cấp Ticker cho AnimationController
class _ShimmeringSmallPostState extends State<ShimmeringSmallPost> with SingleTickerProviderStateMixin {
  // 1. Khai báo AnimationController
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

  // Tách phần nội dung placeholder ra cho dễ đọc
  Widget _buildPlaceholderContent() {
    // Màu nền cho các thành phần placeholder
    final placeholderColor = appColorScheme(context).outlineVariant;

    return Column(
      children: [
        Container(
          height: 10,
          decoration: BoxDecoration(
            color: placeholderColor,
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
              color: placeholderColor,
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
                color: placeholderColor,
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
                  color: placeholderColor,
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
                color: placeholderColor,
                borderRadius: BorderRadius.circular(20),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
