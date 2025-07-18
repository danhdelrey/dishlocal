import 'dart:async';

import 'package:dishlocal/app/config/main_shell.dart';
import 'package:dishlocal/app/theme/theme.dart';
import 'package:dishlocal/core/dependencies_injection/service_locator.dart';
import 'package:dishlocal/data/categories/post/model/filter_sort_model/filter_sort_params.dart';
import 'package:dishlocal/data/categories/post/repository/interface/post_repository.dart';
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

  late final StreamSubscription<int> _refreshSubscription;

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

    _refreshSubscription = refreshManager.refreshStream.listen((tabIndex) {
      if (tabIndex == myTabIndex) {
        _triggerRefreshAndScroll();
      }
    });

    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _refreshSubscription.cancel();
    _scrollController.dispose();
    _bloc.close();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.offset >= _scrollController.position.maxScrollExtent - 500.0) {
      if (_bloc.state.status != PostStatus.loading && _bloc.state.hasNextPage) {
        _bloc.add(const PostEvent.fetchNextPageRequested());
      }
    }
  }

  Future<void> _onRefresh() async {
    _bloc.add(const PostEvent.refreshRequested());
    await _bloc.stream.firstWhere((s) => s.status != PostStatus.loading);
  }

  void _scrollToTop() {
    if (_scrollController.hasClients) {
      _scrollController.animateTo(
        0.0,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeOut,
      );
    }
  }

  void _triggerRefreshAndScroll() {
    _scrollToTop();
    _onRefresh();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _bloc,
      child: Scaffold(
        appBar: AppBar(
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
            
          ],
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            BlocBuilder<PostBloc, PostState>(
              builder: (context, state) {
                return FiltersWrap(
                  filterParams: state.filterSortParams,
                  postBloc: context.read<PostBloc>(),
                );
              },
            ),
            Expanded(
              child: BlocBuilder<PostBloc, PostState>(
                builder: (context, state) {
                  if (state.status == PostStatus.loading && state.posts.isEmpty) {
                    return const _ShimmeringGrid();
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

                  if (state.status == PostStatus.success && state.posts.isEmpty) {
                    return const Center(
                      child: Text('Chưa có bài viết nào để hiển thị.'),
                    );
                  }

                  return Padding(
                    padding: const EdgeInsets.all(10),
                    child: GridView.builder(
                      controller: _scrollController,
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
                          onDeletePostPopBack: () {
                            _bloc.add(const PostEvent.refreshRequested());
                          },
                        );
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ShimmeringGrid extends StatelessWidget {
  const _ShimmeringGrid();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
          childAspectRatio: 0.75,
        ),
        itemCount: 6,
        itemBuilder: (context, index) => const ShimmeringSmallPost(),
      ),
    );
  }
}
