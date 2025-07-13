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

// Sử dụng lại delegate này để làm cho TabBar có thể "ghim" lại.
// Có thể chuyển class này ra một file tiện ích chung.
class _SliverPersistentHeaderDelegate extends SliverPersistentHeaderDelegate {
  _SliverPersistentHeaderDelegate(this._tabBar);

  final TabBar _tabBar;

  @override
  double get minExtent => _tabBar.preferredSize.height;
  @override
  double get maxExtent => _tabBar.preferredSize.height;

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: Theme.of(context).scaffoldBackgroundColor,
      child: _tabBar,
    );
  }

  @override
  bool shouldRebuild(_SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return ConnectivityAndLocationGuard(builder: (context) {
      return const _HomePageContent();
    });
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

  // THAY ĐỔI: Chỉ cần một ScrollController cho toàn bộ trang.
  late final ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _tabController = TabController(length: 2, vsync: this);
    final postRepository = getIt<PostRepository>();

    _postBlocs = [
      PostBloc(({required params}) => postRepository.getPosts(params: params)),
      PostBloc(({required params}) => postRepository.getFollowingPosts(params: params)),
    ];
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _tabController.dispose();
    for (var bloc in _postBlocs) {
      bloc.close();
    }
    super.dispose();
  }

  // THAY ĐỔI: Hàm để cuộn toàn bộ trang lên đầu.
  void _scrollToTop() {
    if (_scrollController.hasClients) {
      _scrollController.animateTo(
        0.0,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeOut,
      );
    }
  }

  // THAY ĐỔI: Hàm refresh chung cho cả trang.
  Future<void> _onRefresh() async {
    final activeBloc = _postBlocs[_tabController.index];
    activeBloc.add(const PostEvent.refreshRequested());
    await activeBloc.stream.firstWhere((s) => s.status != PostStatus.loading);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // THAY ĐỔI: Bỏ cấu trúc AppBar và Column.
      // Thay bằng RefreshIndicator và NestedScrollView.
      body: RefreshIndicator(
        onRefresh: _onRefresh,
        child: NestedScrollView(
          controller: _scrollController,
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              // THAY ĐỔI: Sử dụng SliverAppBar thay cho AppBar.
              SliverAppBar(
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
                // Các thuộc tính quan trọng để AppBar hoạt động đúng trong NestedScrollView
                snap: true,
                floating: true,
                forceElevated: innerBoxIsScrolled, // Hiện bóng đổ khi cuộn
              ),
              // THAY ĐỔI: Sử dụng SliverPersistentHeader để ghim TabBar.
              SliverPersistentHeader(
                delegate: _SliverPersistentHeaderDelegate(
                  TabBar(
                    controller: _tabController,
                    onTap: (index) {
                      // Nếu người dùng nhấn vào tab đang được chọn, cuộn lên đầu.
                      if (index == _tabController.index) {
                        _scrollToTop();
                      }
                    },
                    tabs: const [
                      Tab(text: 'Dành cho bạn'),
                      Tab(text: 'Đang theo dõi'),
                    ],
                  ),
                ),
                pinned: true, // Đây là thuộc tính làm cho nó "dính" lại.
              ),
            ];
          },
          // THAY ĐỔI: Body là TabBarView, không cần bọc trong Expanded.
          body: TabBarView(
            controller: _tabController,
            children: [
              BlocProvider.value(
                value: _postBlocs[0],
                // PostGridTabView giờ đây hoạt động hoàn hảo trong cấu trúc này.
                child: const PostGridTabView(
                  key: PageStorageKey<String>('homeForYouTab'),
                  noItemsFoundMessage: 'Chưa có bài viết nào để hiển thị.',
                ),
              ),
              BlocProvider.value(
                value: _postBlocs[1],
                child: const PostGridTabView(
                  key: PageStorageKey<String>('homeFollowingTab'),
                  noItemsFoundMessage: 'Bạn chưa theo dõi ai, hoặc họ chưa đăng bài mới.',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
