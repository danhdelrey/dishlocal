import 'dart:async';

import 'package:dishlocal/app/config/main_shell.dart';
import 'package:dishlocal/app/theme/theme.dart';
import 'package:dishlocal/core/dependencies_injection/service_locator.dart';
import 'package:dishlocal/data/categories/post/model/filter_sort_model/filter_sort_params.dart';
import 'package:dishlocal/data/categories/post/repository/interface/post_repository.dart';
import 'package:dishlocal/ui/features/filter_sort/view/filter_button.dart';
import 'package:dishlocal/ui/features/filter_sort/view/filters_wrap.dart';
import 'package:dishlocal/ui/features/post/bloc/post_bloc.dart';
import 'package:dishlocal/ui/features/post/view/shimmering_small_post.dart';
import 'package:dishlocal/ui/features/post/view/small_post.dart';
import 'package:dishlocal/ui/widgets/guard_widgets/connectivity_and_location_guard.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class ExplorePage extends StatelessWidget {
  const ExplorePage({super.key, this.initialFilterSortParams});
  final FilterSortParams? initialFilterSortParams;

  @override
  Widget build(BuildContext context) {
    return ConnectivityAndLocationGuard(builder: (context) {
      return _ExplorePageContent(
        initialFilterSortParams: initialFilterSortParams,
      );
    });
  }
}

class _ExplorePageContent extends StatefulWidget {
  const _ExplorePageContent({required this.initialFilterSortParams});
  final FilterSortParams? initialFilterSortParams;

  @override
  State<_ExplorePageContent> createState() => _ExplorePageContentState();
}

class _ExplorePageContentState extends State<_ExplorePageContent> {
  late final PostBloc _bloc;
  final ScrollController _scrollController = ScrollController();

  // THAY ĐỔI: Thêm StreamSubscription
  late final StreamSubscription<int> _refreshSubscription;

  // THAY ĐỔI: Đặt chỉ số cho tab này
  // Dựa vào MainShell: Home (0), Rocket (1), Profile (2).
  // Trang Khám phá (Rocket) là tab thứ hai.
  static const int myTabIndex = 1;

  @override
  void initState() {
    super.initState();
    final postRepository = getIt<PostRepository>();
    _bloc = PostBloc(
      ({filterSortParams, page, required pageSize}) {
        return postRepository.getPosts(params: filterSortParams!);
      },
    );

    if (_bloc.state.status == PostStatus.initial) {
      if (widget.initialFilterSortParams != null) {
        _bloc.add(PostEvent.filtersChanged(newFilters: widget.initialFilterSortParams!));
      } else {
        _bloc.add(const PostEvent.fetchNextPageRequested());
      }
    }

    // THAY ĐỔI: Lắng nghe sự kiện refresh
    _refreshSubscription = refreshManager.refreshStream.listen((tabIndex) {
      if (tabIndex == myTabIndex) {
        _triggerRefreshAndScroll();
      }
    });

    // THAY ĐỔI: Xóa listener cho _onScroll. Chúng ta sẽ dùng NotificationListener.
    // _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    // THAY ĐỔI: Hủy subscription
    _refreshSubscription.cancel();
    _scrollController.dispose();
    _bloc.close();
    super.dispose();
  }

  // THAY ĐỔI: Xóa _onScroll và _isBottom.

  Future<void> _onRefresh() async {
    _bloc.add(const PostEvent.refreshRequested());
    await _bloc.stream.firstWhere((s) => s.status != PostStatus.loading);
  }

  // THAY ĐỔI: Hàm cuộn lên đầu
  void _scrollToTop() {
    if (_scrollController.hasClients) {
      _scrollController.animateTo(
        0.0,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeOut,
      );
    }
  }

  // THAY ĐỔI: Hàm thực hiện cả hai hành động
  void _triggerRefreshAndScroll() {
    _scrollToTop();
    _onRefresh();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _bloc,
      child: Scaffold(
        body: SafeArea(
          child: NotificationListener<ScrollNotification>(
            onNotification: (notification) {
              if (notification is ScrollUpdateNotification && notification.metrics.pixels >= notification.metrics.maxScrollExtent - 500.0) {
                if (_bloc.state.status != PostStatus.loading && _bloc.state.hasNextPage) {
                  _bloc.add(const PostEvent.fetchNextPageRequested());
                }
              }
              return false;
            },
            child: CustomScrollView(
              controller: _scrollController,
              slivers: [
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
                    FilterButton(
                      showWrap: false,
                      postBloc: _bloc,
                    ),
                  ],
                  pinned: false,
                  floating: true,
                  snap: true,
                ),
                BlocBuilder<PostBloc, PostState>(
                  builder: (context, state) {
                    return SliverToBoxAdapter(
                      child: FiltersWrap(
                        filterParams: state.filterSortParams,
                        openFilterSortSheet: (context) {},
                      ),
                    );
                  },
                ),
                BlocBuilder<PostBloc, PostState>(
                  builder: (context, state) {
                    // --- Toàn bộ logic bên trong builder này giữ nguyên ---
                    if (state.status == PostStatus.loading && state.posts.isEmpty) {
                      return const _ShimmeringSliverGrid();
                    }

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

                    if (state.status == PostStatus.success && state.posts.isEmpty) {
                      return const SliverFillRemaining(
                        hasScrollBody: false,
                        child: Center(
                          child: Text('Chưa có bài viết nào để hiển thị.'),
                        ),
                      );
                    }

                    return SliverPadding(
                      padding: const EdgeInsets.all(10),
                      sliver: SliverGrid(
                        delegate: SliverChildBuilderDelegate(
                          (context, index) {
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
                          childCount: state.hasNextPage ? state.posts.length + 2 : state.posts.length,
                        ),
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 10,
                          crossAxisSpacing: 10,
                          childAspectRatio: 0.75,
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
