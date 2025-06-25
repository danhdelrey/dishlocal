import 'package:dishlocal/app/theme/theme.dart';
import 'package:dishlocal/data/categories/post/model/post.dart';
import 'package:dishlocal/ui/features/post/bloc/post_bloc.dart';
import 'package:dishlocal/ui/features/post/view/small_post.dart';
import 'package:dishlocal/ui/widgets/animated_widgets/fade_slide_up.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class GridPostPage extends StatelessWidget {
  // Chuyển thành StatelessWidget vì không còn state nội bộ
  final String noItemsFoundMessage;

  const GridPostPage({
    super.key,
    this.noItemsFoundMessage = "Không có bài viết nào.",
  });

  @override
  Widget build(BuildContext context) {
    // Widget này sẽ tìm BLoC được cung cấp ở cây widget cha của nó
    final postBloc = context.watch<PostBloc>(); // Dùng watch để rebuild khi state thay đổi
    final state = postBloc.state;

    return RefreshIndicator(
      onRefresh: () async {
        postBloc.add(const PostEvent.refreshRequested());
        // Có thể thêm một completer hoặc đợi một chút để UI mượt hơn
        await postBloc.stream.firstWhere((s) => !s.isLoading);
      },
      child: Padding(
        padding: const EdgeInsets.only(left: 10, right: 10, top: 15),
        child: CustomScrollView(
          physics: const AlwaysScrollableScrollPhysics().applyTo(const BouncingScrollPhysics()),
          slivers: [
            PagedSliverMasonryGrid<DateTime?, Post>(
              state: state, // Lấy state từ BLoC
              fetchNextPage: () {
                // Bảo BLoC của nó fetch trang tiếp theo
                postBloc.add(const PostEvent.fetchNextPostPageRequested());
              },
              builderDelegate: PagedChildBuilderDelegate<Post>(
                itemBuilder: (context, post, index) => FadeSlideUp(
                  delay: Duration(milliseconds: index * 100),
                  child: SmallPost(
                    post: post,
                    onDeletePostPopBack: () async {
                      postBloc.add(const PostEvent.refreshRequested());
                      await postBloc.stream.firstWhere((s) => !s.isLoading);
                    },
                  ),
                ),
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
                // Sử dụng tham số đã truyền vào
                noItemsFoundIndicatorBuilder: (_) => Center(
                  child: Text(noItemsFoundMessage),
                ),
                newPageProgressIndicatorBuilder: (context) => const ShimmeringSmallPost(),
              ),
              gridDelegateBuilder: (int childCount) => const SliverSimpleGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
              ),
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
            ),
            const SliverToBoxAdapter(
              child: SizedBox(
                height: kBottomNavigationBarHeight + 15,
              ),
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
