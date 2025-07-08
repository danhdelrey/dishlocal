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
import 'package:dishlocal/ui/widgets/element_widgets/glass_sliver_app_bar.dart';
import 'package:dishlocal/ui/widgets/guard_widgets/connectivity_and_location_guard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return ConnectivityAndLocationGuard(
      builder: (context) => const _HomePageContent(),
    );
  }
}

class _HomePageContent extends StatefulWidget {
  const _HomePageContent();

  @override
  State<_HomePageContent> createState() => _HomePageContentState();
}

class _HomePageContentState extends State<_HomePageContent> with SingleTickerProviderStateMixin {
  late final TabController _tabController;
  late final List<PostBloc> _postBlocs;
  // ScrollController này chỉ dùng cho AppBar, không dùng cho phân trang.
  final ScrollController _mainScrollController = ScrollController();

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
    _tabController.dispose();
    _mainScrollController.dispose();
    for (var bloc in _postBlocs) {
      bloc.close();
    }
    super.dispose();
  }

  void _scrollToTopAndRefreshCurrentTab() {
    // Logic cuộn lên đầu vẫn giữ nguyên
    if (_mainScrollController.hasClients) {
      _mainScrollController.animateTo(0.0, duration: const Duration(milliseconds: 2000), curve: Curves.easeOut);
    }
    // Gửi event refresh tới BLoC của tab hiện tại
    //_postBlocs[_tabController.index].add(const PostEvent.refreshRequested());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: NestedScrollView(
        controller: _mainScrollController,
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            GlassSliverAppBar(
              centerTitle: true,
              hasBorder: false,
              title: ShaderMask(
                shaderCallback: (bounds) => primaryGradient.createShader(Rect.fromLTWH(0, 0, bounds.width, bounds.height)),
                child: Text(
                  'DishLocal',
                  style: appTextTheme(context).titleLarge?.copyWith(fontWeight: FontWeight.w700),
                ),
              ),
              actions: [
                IconButton(
                  icon: AppIcons.search.toSvg(color: appColorScheme(context).onSurfaceVariant),
                  onPressed: () => context.push('/search_input'),
                ),
              ],
              bottom: TabBar(
                dividerColor: Colors.white.withAlpha(25), // Alpha 0.1
                controller: _tabController,
                onTap: (index) {
                  if (!_tabController.indexIsChanging) {
                    _scrollToTopAndRefreshCurrentTab();
                  }
                },
                tabs: const [
                  Tab(text: 'Dành cho bạn'),
                  Tab(text: 'Đang theo dõi'),
                ],
              ),
              floating: true,
              snap: true,
              pinned: true,
            ),
          ];
        },
        body: TabBarView(
          controller: _tabController,
          children: [
            // Cung cấp BLoC cho mỗi GridPostPage tương ứng
            BlocProvider.value(
              value: _postBlocs[0],
              child: const GridPostPage(
                key: PageStorageKey<String>('homeForYouTab'), // Giữ state khi chuyển tab
                noItemsFoundMessage: 'Chưa có bài viết nào để hiển thị.',
              ),
            ),
            BlocProvider.value(
              value: _postBlocs[1],
              child: const GridPostPage(
                key: PageStorageKey<String>('homeFollowingTab'),
                noItemsFoundMessage: 'Bạn chưa theo dõi ai, hoặc họ chưa đăng bài mới.',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
