import 'package:dishlocal/app/theme/custom_colors.dart';
import 'package:dishlocal/app/theme/theme.dart';
import 'package:dishlocal/core/dependencies_injection/service_locator.dart';
import 'package:dishlocal/data/categories/post/model/post.dart';
import 'package:dishlocal/data/categories/post/repository/interface/post_repository.dart';
import 'package:dishlocal/ui/features/post/bloc/post_bloc.dart';
import 'package:dishlocal/ui/features/post/view/grid_post_page.dart';
import 'package:dishlocal/ui/widgets/element_widgets/glass_sliver_app_bar.dart';
import 'package:dishlocal/ui/widgets/guard_widgets/connectivity_and_location_guard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

/// BƯỚC 1: HomePage giờ trở thành một "Container" đơn giản, có thể là StatelessWidget.
/// Nhiệm vụ duy nhất của nó là gọi Guard.
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    // Khi Guard xác nhận điều kiện OK, nó sẽ tạo ra _HomePageContent.
    // Chỉ khi đó, initState của _HomePageContent mới được gọi.
    return ConnectivityAndLocationGuard(
      builder: (context) => const _HomePageContent(),
    );
  }
}

/// BƯỚC 2: Tạo một StatefulWidget riêng để chứa toàn bộ logic và giao diện của trang.
class _HomePageContent extends StatefulWidget {
  const _HomePageContent();

  @override
  State<_HomePageContent> createState() => _HomePageContentState();
}

class _HomePageContentState extends State<_HomePageContent> with SingleTickerProviderStateMixin {
  late final TabController _tabController;
  final ScrollController _mainScrollController = ScrollController();
  late final List<PostBloc> _postBlocs;

  final Set<int> _initializedTabs = {};

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);

    final postRepository = getIt<PostRepository>();

    _postBlocs = [
      PostBloc(postRepository.getPosts),
      PostBloc(postRepository.getFollowingPosts),
    ];

    if (_postBlocs.isNotEmpty) {
      _postBlocs[0].add(const PostEvent.fetchNextPostPageRequested());
      _initializedTabs.add(0);
    }

    _tabController.addListener(_handleTabSelection);
  }

  void _handleTabSelection() {
    final index = _tabController.index;
    if (!_initializedTabs.contains(index)) {
      _postBlocs[index].add(const PostEvent.fetchNextPostPageRequested());
      _initializedTabs.add(index);
    }
  }

  void _scrollToTopAndRefresh(int index) {
    // Logic này không thay đổi
    if (_mainScrollController.hasClients) {
      _mainScrollController.animateTo(0.0, duration: const Duration(milliseconds: 300), curve: Curves.easeOut);
    }
    // Sử dụng PrimaryScrollController.of(context) có thể không đáng tin cậy trong NestedScrollView.
    // Thay vào đó, chúng ta có thể dựa vào việc GridPostPage có scroll controller riêng
    // hoặc đơn giản là để RefreshIndicator xử lý.
    _postBlocs[index].add(const PostEvent.refreshRequested());
  }

  @override
  void dispose() {
    _tabController.removeListener(_handleTabSelection);
    _tabController.dispose();
    _mainScrollController.dispose();
    for (var bloc in _postBlocs) {
      bloc.close();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: NestedScrollView(
        controller: _mainScrollController,
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          // Phần headerSliverBuilder không thay đổi
          return <Widget>[
            GlassSliverAppBar(
              centerTitle: true,
              hasBorder: false,
              title: ShaderMask(
                shaderCallback: (bounds) => primaryGradient.createShader(Rect.fromLTWH(0, 0, bounds.width, bounds.height)),
                child: Text(
                  'DishLocal',
                  style: appTextTheme(context).titleLarge?.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                ),
              ),
              bottom: TabBar(
                dividerColor: Colors.white.withValues(alpha: 0.1),
                controller: _tabController,
                onTap: (index) {
                  if (!_tabController.indexIsChanging) {
                    _scrollToTopAndRefresh(index);
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
        // THAY ĐỔI LỚN BẮT ĐẦU TỪ ĐÂY
        body: TabBarView(
          controller: _tabController,
          children: [
            // Tab 1: "Dành cho bạn"
            _buildPostTab(
              bloc: _postBlocs[0],
              pageKey: 'homeForYouTab',
              noItemsMessage: 'Chưa có bài viết nào để hiển thị.',
            ),
            // Tab 2: "Đang theo dõi"
            _buildPostTab(
              bloc: _postBlocs[1],
              pageKey: 'homeFollowingTab',
              noItemsMessage: 'Bạn chưa theo dõi ai, hoặc họ chưa đăng bài mới.',
            ),
          ],
        ),
        // KẾT THÚC THAY ĐỔI
      ),
    );
  }

  /// Widget helper để tạo một tab hiển thị bài viết, tránh lặp code.
  Widget _buildPostTab({
    required PostBloc bloc,
    required String pageKey,
    required String noItemsMessage,
  }) {
    return BlocProvider.value(
      value: bloc,
      // Sử dụng BlocBuilder để rebuild khi state của BLoC thay đổi
      child: BlocBuilder<PostBloc, PagingState<DateTime?, Post>>(
        builder: (context, state) {
          // Truyền state và các callback vào GridPostPage
          return GridPostPage(
            key: PageStorageKey<String>(pageKey),
            pagingState: state,
            onFetchNextPage: () {
              // Khi GridPostPage yêu cầu trang mới, chúng ta bảo BLoC tương ứng fetch
              bloc.add(const PostEvent.fetchNextPostPageRequested());
            },
            onRefresh: () async {
              // Khi người dùng kéo để refresh, chúng ta gửi event refresh
              bloc.add(const PostEvent.refreshRequested());
              // Đợi BLoC xử lý xong để RefreshIndicator biết khi nào nên dừng
              await bloc.stream.firstWhere((s) => !s.isLoading);
            },
            noItemsFoundMessage: noItemsMessage,
          );
        },
      ),
    );
  }
}
