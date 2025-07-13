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

  const PostGridTabView({
    super.key,
    required this.noItemsFoundMessage,
    // THAY ĐỔI: Không cần truyền ScrollController vào đây nữa.
  });

  @override
  State<PostGridTabView> createState() => _PostGridTabViewState();
}

class _PostGridTabViewState extends State<PostGridTabView> {
  late PostBloc _bloc;
  ScrollController? _scrollController;

  @override
  void initState() {
    super.initState();
    _bloc = context.read<PostBloc>();

    // THAY ĐỔI: Lắng nghe PrimaryScrollController mà NestedScrollView cung cấp.
    // Việc này phải được thực hiện sau khi frame đầu tiên được build.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        _scrollController = PrimaryScrollController.of(context);
        _scrollController?.addListener(_onScroll);
      }
    });

    if (_bloc.state.status == PostStatus.initial) {
      _bloc.add(const PostEvent.fetchNextPageRequested());
    }
  }

  @override
  void dispose() {
    // THAY ĐỔI: Hủy listener khi widget bị dispose.
    _scrollController?.removeListener(_onScroll);
    super.dispose();
  }

  void _onScroll() {
    if (_isBottom) {
      _bloc.add(const PostEvent.fetchNextPageRequested());
    }
  }

  bool get _isBottom {
    if (_scrollController == null || !_scrollController!.hasClients) return false;
    final maxScroll = _scrollController!.position.maxScrollExtent;
    final currentScroll = _scrollController!.offset;
    return currentScroll >= (maxScroll - 500.0);
  }

  // THAY ĐỔI: Hàm refresh được chuyển lên widget cha, nhưng chúng ta vẫn cần
  // một cách để refresh từ nút "Thử lại".
  Future<void> _retryFetch() async {
    _bloc.add(const PostEvent.refreshRequested());
  }

  @override
  Widget build(BuildContext context) {
    // THAY ĐỔI: Xóa RefreshIndicator ở đây. Nó sẽ được quản lý ở cấp cao hơn.
    return BlocBuilder<PostBloc, PostState>(
      builder: (context, state) {
        if (state.status == PostStatus.loading && state.posts.isEmpty) {
          return GridView.builder(
            // THAY ĐỔI: Không cần controller, padding nên được đặt ở đây để có khoảng trống
            key: const PageStorageKey<String>('shimmer_grid'),
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
                  onPressed: _retryFetch,
                  icon: const Icon(Icons.refresh_rounded),
                  label: const Text('Thử lại'),
                ),
              ],
            ),
          );
        }

        if (state.posts.isEmpty) {
          return Center(child: Text(widget.noItemsFoundMessage));
        }

        // THAY ĐỔI: Quan trọng nhất - GridView không có thuộc tính `controller`.
        // Nó sẽ tự động sử dụng PrimaryScrollController từ NestedScrollView.
        return GridView.builder(
          key: PageStorageKey<String>(widget.noItemsFoundMessage), // Key để giữ vị trí cuộn khi chuyển tab
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
    );
  }
}
