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

    // THAY ĐỔI: Xóa tất cả logic liên quan đến ScrollController.
    // Không cần addPostFrameCallback, không cần listener.

    if (_bloc.state.status == PostStatus.initial) {
      _bloc.add(const PostEvent.fetchNextPageRequested());
    }
  }

  Future<void> _retryFetch() async {
    _bloc.add(const PostEvent.refreshRequested());
  }

  @override
  Widget build(BuildContext context) {
    // THAY ĐỔI: Bọc toàn bộ widget bằng NotificationListener.
    return NotificationListener<ScrollNotification>(
      onNotification: (notification) {
        // Kiểm tra xem có phải là một sự kiện cập nhật cuộn không
        // và đã cuộn gần đến cuối chưa.
        if (notification is ScrollUpdateNotification && notification.metrics.pixels >= notification.metrics.maxScrollExtent - 500.0) {
          // Rất quan trọng: Chỉ gọi fetch khi không đang loading và còn trang để fetch.
          // Điều này ngăn chặn việc gọi fetch liên tục.
          if (_bloc.state.status != PostStatus.loading && _bloc.state.hasNextPage) {
            _bloc.add(const PostEvent.fetchNextPageRequested());
          }
        }
        // Trả về false để cho phép notification tiếp tục được xử lý bởi các widget cha (nếu có).
        return false;
      },
      child: BlocBuilder<PostBloc, PostState>(
        builder: (context, state) {
          // ==========================================================
          // Toàn bộ logic bên trong BlocBuilder giữ nguyên, không đổi.
          // ==========================================================
          if (state.status == PostStatus.loading && state.posts.isEmpty) {
            return GridView.builder(
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
            // Dùng ListView để có thể cuộn và kích hoạt RefreshIndicator nếu cần
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
                          onPressed: _retryFetch,
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

          if (state.status == PostStatus.success && state.posts.isEmpty) {
            // Dùng ListView để có thể cuộn và kích hoạt RefreshIndicator
            return ListView(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.4,
                  child: Center(child: Text(widget.noItemsFoundMessage)),
                ),
              ],
            );
          }

          // GridView này sẽ tự động sử dụng PrimaryScrollController do NestedScrollView cung cấp
          // để đồng bộ cuộn với header.
          return GridView.builder(
            key: PageStorageKey<String>(widget.noItemsFoundMessage),
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
