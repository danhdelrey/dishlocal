import 'package:dishlocal/app/theme/app_icons.dart';
import 'package:dishlocal/app/theme/custom_colors.dart';
import 'package:dishlocal/app/theme/theme.dart';
import 'package:dishlocal/core/dependencies_injection/service_locator.dart';
import 'package:dishlocal/data/categories/post/model/filter_sort_model/filter_sort_params.dart';
import 'package:dishlocal/data/categories/post/model/post.dart';
import 'package:dishlocal/data/categories/post/repository/interface/post_repository.dart';
import 'package:dishlocal/ui/features/filter_sort/view/sorting_bottom_sheet.dart';
import 'package:dishlocal/ui/features/post/bloc/post_bloc.dart';
import 'package:dishlocal/ui/features/post/view/post_grid_tab_view.dart';
import 'package:dishlocal/ui/features/post/view/shimmering_small_post.dart';
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


