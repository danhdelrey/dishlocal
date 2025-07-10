import 'package:dishlocal/app/theme/app_icons.dart';
import 'package:dishlocal/app/theme/custom_colors.dart';
import 'package:dishlocal/app/theme/theme.dart';
import 'package:dishlocal/core/dependencies_injection/service_locator.dart';
import 'package:dishlocal/data/categories/post/model/filter_sort_model/filter_sort_params.dart';
import 'package:dishlocal/data/categories/post/model/post.dart';
import 'package:dishlocal/data/categories/post/repository/interface/post_repository.dart';
import 'package:dishlocal/ui/features/filter_sort/view/sorting_bottom_sheet.dart';
import 'package:dishlocal/ui/features/post/bloc/post_bloc.dart';
import 'package:dishlocal/ui/features/post/view/grid_post_page.dart';
import 'package:dishlocal/ui/features/post/view/small_post.dart';
import 'package:dishlocal/ui/widgets/element_widgets/glass_sliver_app_bar.dart';
import 'package:dishlocal/ui/widgets/guard_widgets/connectivity_and_location_guard.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const _HomePageContent();
  }
}

class _HomePageContent extends StatefulWidget {
  const _HomePageContent();

  @override
  State<_HomePageContent> createState() => _HomePageContentState();
}

class _HomePageContentState extends State<_HomePageContent> with TickerProviderStateMixin {
  late final TabController _tabController;
  late final List<PostBloc> _postBlocs;

  late final ScrollController forYouTabScrollController = ScrollController();
  late final ScrollController followingTabScrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    final postRepository = getIt<PostRepository>();

    _postBlocs = [
      PostBloc(({required params}) => postRepository.getPosts(params: params)),
      PostBloc(({required params}) => postRepository.getFollowingPosts(params: params)),
    ];
  }

  @override
  void dispose() {
    forYouTabScrollController.dispose();
    followingTabScrollController.dispose();
    _tabController.dispose();
    for (var bloc in _postBlocs) {
      bloc.close();
    }
    super.dispose();
  }

  void _onTabTapped(int index) {
    if (_tabController.index == index) {
      // Scroll to top if tapping on current tab
      final scrollController = index == 0 ? forYouTabScrollController : followingTabScrollController;
      if (scrollController.hasClients) {
        final currentOffset = scrollController.offset;
        final duration = Duration(milliseconds: (currentOffset / 2).clamp(300, 1000).round());

        scrollController.animateTo(
          0,
          duration: duration,
          curve: Curves.easeOut,
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.push("/camera"),
        shape: const CircleBorder(),
        backgroundColor: appColorScheme(context).primary,
        child: const Icon(CupertinoIcons.add),
      ),
      appBar: AppBar(
        centerTitle: true,
        title: ShaderMask(
          shaderCallback: (bounds) => primaryGradient.createShader(Rect.fromLTWH(0, 0, bounds.width, bounds.height)),
          child: Text(
            'DishLocal',
            style: appTextTheme(context).titleLarge?.copyWith(fontWeight: FontWeight.w700),
          ),
        ),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
      ),
      body: Column(
        children: [
          Material(
            color: Theme.of(context).scaffoldBackgroundColor,
            child: TabBar(
              controller: _tabController,
              onTap: _onTabTapped,
              tabs: const [
                Tab(text: 'Dành cho bạn'),
                Tab(text: 'Đang theo dõi'),
              ],
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                BlocProvider.value(
                  value: _postBlocs[0],
                  child: PostGridTabView(
                    scrollController: forYouTabScrollController,
                    key: const PageStorageKey<String>('homeForYouTab'),
                    noItemsFoundMessage: 'Chưa có bài viết nào để hiển thị.',
                  ),
                ),
                BlocProvider.value(
                  value: _postBlocs[1],
                  child: PostGridTabView(
                    scrollController: followingTabScrollController,
                    key: const PageStorageKey<String>('homeFollowingTab'),
                    noItemsFoundMessage: 'Bạn chưa theo dõi ai, hoặc họ chưa đăng bài mới.',
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class PostGridTabView extends StatefulWidget {
  final String noItemsFoundMessage;
  final ScrollController scrollController;

  const PostGridTabView({
    super.key,
    required this.noItemsFoundMessage,
    required this.scrollController,
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
    widget.scrollController.addListener(_onScroll);

    if (_bloc.state.status == PostStatus.initial) {
      _bloc.add(const PostEvent.fetchNextPageRequested());
    }
  }

  void _onScroll() {
    if (_isBottom) {
      _bloc.add(const PostEvent.fetchNextPageRequested());
    }
  }

  bool get _isBottom {
    if (!widget.scrollController.hasClients) return false;
    final maxScroll = widget.scrollController.position.maxScrollExtent;
    final currentScroll = widget.scrollController.offset;
    return currentScroll >= (maxScroll - 500.0);
  }

  Future<void> _onRefresh() async {
    _bloc.add(const PostEvent.refreshRequested());
    await _bloc.stream.firstWhere((s) => s.status != PostStatus.loading);
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: _onRefresh,
      child: BlocBuilder<PostBloc, PostState>(
        builder: (context, state) {
          if (state.status == PostStatus.loading && state.posts.isEmpty) {
            return GridView.builder(
              controller: widget.scrollController,
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
                          onPressed: _onRefresh,
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

          if (state.posts.isEmpty) {
            return ListView(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.4,
                  child: Center(child: Text(widget.noItemsFoundMessage)),
                ),
              ],
            );
          }

          return GridView.builder(
            controller: widget.scrollController,
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
