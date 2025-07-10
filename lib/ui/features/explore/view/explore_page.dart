import 'package:dishlocal/app/theme/theme.dart';
import 'package:dishlocal/core/dependencies_injection/service_locator.dart';
import 'package:dishlocal/data/categories/post/repository/interface/post_repository.dart';
import 'package:dishlocal/ui/features/filter_sort/view/filter_button.dart';
import 'package:dishlocal/ui/features/post/bloc/post_bloc.dart';
import 'package:dishlocal/ui/features/post/view/grid_post_page.dart';
import 'package:dishlocal/ui/features/post/view/small_post.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class ExplorePage extends StatefulWidget {
  const ExplorePage({super.key});

  @override
  State<ExplorePage> createState() => _ExplorePageState();
}

class _ExplorePageState extends State<ExplorePage> {
  late final PostBloc _bloc;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    final postRepository = getIt<PostRepository>();
    _bloc = PostBloc(({required params}) => postRepository.getPosts(params: params));

    // Bắt đầu fetch dữ liệu ngay khi bloc được khởi tạo
    if (_bloc.state.status == PostStatus.initial) {
      _bloc.add(const PostEvent.fetchNextPageRequested());
    }

    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController
      ..removeListener(_onScroll)
      ..dispose();
    _bloc.close();
    super.dispose();
  }

  // Logic kiểm tra cuộn xuống cuối trang để tải thêm
  void _onScroll() {
    if (_isBottom) {
      _bloc.add(const PostEvent.fetchNextPageRequested());
    }
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    // Tải thêm khi còn 500px nữa là đến cuối
    return currentScroll >= (maxScroll - 500.0);
  }

  // Logic cho việc kéo để làm mới (pull-to-refresh)
  Future<void> _onRefresh() async {
    _bloc.add(const PostEvent.refreshRequested());
    // Chờ cho đến khi state không còn là loading nữa
    await _bloc.stream.firstWhere((s) => s.status != PostStatus.loading);
  }

  @override
  Widget build(BuildContext context) {
    // Cung cấp bloc cho toàn bộ cây widget con
    return BlocProvider.value(
      value: _bloc,
      child: Scaffold(
        body: SafeArea(
          child: RefreshIndicator(
            onRefresh: _onRefresh,
            child: CustomScrollView(
              controller: _scrollController,
              physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
              slivers: [
                // AppBar chính của trang
                SliverAppBar(
                  centerTitle: true,
                  backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                  surfaceTintColor: Colors.transparent,
                  elevation: 0,
                  title: Text(
                    'Khám phá',
                    style: appTextTheme(context).titleLarge,
                  ),
                  actions: [
                    IconButton(
                      icon: const Icon(CupertinoIcons.search),
                      onPressed: () => context.push('/search_input'),
                    ),
                    const FilterButton(),
                  ],
                  pinned: false,
                  floating: true,
                  snap: true,
                ),

                // Sử dụng BlocBuilder để render nội dung chính (lưới bài viết)
                // tùy theo trạng thái của PostBloc
                BlocBuilder<PostBloc, PostState>(
                  builder: (context, state) {
                    // --- TRẠNG THÁI LOADING LẦN ĐẦU ---
                    if (state.status == PostStatus.loading && state.posts.isEmpty) {
                      return const _ShimmeringSliverGrid();
                    }

                    // --- TRẠNG THÁI LỖI KHI CHƯA CÓ DỮ LIỆU ---
                    if (state.status == PostStatus.failure && state.posts.isEmpty) {
                      return SliverFillRemaining(
                        hasScrollBody: false,
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
                      );
                    }

                    // --- TRẠNG THÁI KHÔNG CÓ BÀI VIẾT NÀO ---
                    if (state.posts.isEmpty) {
                      return const SliverFillRemaining(
                        hasScrollBody: false,
                        child: Center(
                          child: Text('Chưa có bài viết nào để hiển thị.'),
                        ),
                      );
                    }

                    // --- TRẠNG THÁI THÀNH CÔNG, HIỂN THỊ LƯỚI BÀI VIẾT ---
                    return SliverPadding(
                      padding: const EdgeInsets.all(10),
                      sliver: SliverGrid(
                        delegate: SliverChildBuilderDelegate(
                          (context, index) {
                            // Hiển thị Shimmer loading ở cuối danh sách khi tải thêm trang
                            if (index >= state.posts.length) {
                              return const ShimmeringSmallPost();
                            }
                            final post = state.posts[index];
                            return SmallPost(
                              post: post,
                              onDeletePostPopBack: () {
                                _bloc.add(const PostEvent.refreshRequested());
                              },
                            );
                          },
                          // Thêm 1 item vào childCount nếu còn trang tiếp theo để hiển thị loading
                          childCount: state.hasNextPage ? state.posts.length + 2 : state.posts.length,
                        ),
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 10,
                          crossAxisSpacing: 10,
                          childAspectRatio: 0.75, // Điều chỉnh tỷ lệ này nếu cần
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// Widget Shimmer cho Grid - ĐÃ SỬA LẠI
// Nó chỉ trả về các sliver, không còn chứa CustomScrollView nữa
class _ShimmeringSliverGrid extends StatelessWidget {
  const _ShimmeringSliverGrid();

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: const EdgeInsets.all(10),
      sliver: SliverGrid(
        delegate: SliverChildBuilderDelegate(
          (context, index) => const ShimmeringSmallPost(),
          childCount: 6, // Hiển thị 6 item shimmer
        ),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
          childAspectRatio: 0.75,
        ),
      ),
    );
  }
}
