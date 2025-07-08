import 'package:dishlocal/app/theme/app_icons.dart';
import 'package:dishlocal/app/theme/theme.dart';
import 'package:dishlocal/core/dependencies_injection/service_locator.dart';
import 'package:dishlocal/data/categories/app_user/repository/interface/app_user_repository.dart';
import 'package:dishlocal/data/categories/post/model/post.dart';
import 'package:dishlocal/data/categories/post/repository/interface/post_repository.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:dishlocal/ui/features/auth/view/logout_button.dart';
import 'package:dishlocal/ui/features/post/bloc/post_bloc.dart';
import 'package:dishlocal/ui/features/post/view/grid_post_page.dart';
import 'package:dishlocal/ui/features/user_info/bloc/user_info_bloc.dart';
import 'package:dishlocal/ui/features/user_info/view/profile_info.dart';
import 'package:dishlocal/ui/widgets/containers_widgets/glass_container.dart';
import 'package:dishlocal/ui/widgets/element_widgets/glass_sliver_app_bar.dart';
import 'package:dishlocal/ui/widgets/guard_widgets/connectivity_and_location_guard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

/// Container đơn giản, truyền userId xuống.
class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key, this.userId});
  final String? userId;

  @override
  Widget build(BuildContext context) {
    return ConnectivityAndLocationGuard(
      builder: (context) => _ProfilePageContent(userId: userId),
    );
  }
}

/// Widget nội dung chính, chứa toàn bộ logic và giao diện.
class _ProfilePageContent extends StatefulWidget {
  const _ProfilePageContent({this.userId});
  final String? userId;

  @override
  State<_ProfilePageContent> createState() => _ProfilePageContentState();
}

/// State logic được chuyển hết vào đây.
class _ProfilePageContentState extends State<_ProfilePageContent> with SingleTickerProviderStateMixin {
  late final TabController _tabController;
  final ScrollController _mainScrollController = ScrollController();
  late final List<PostBloc> _postBlocs;
  late final UserInfoBloc _userInfoBloc;

  bool _isMyProfile = false;

  @override
  void initState() {
    super.initState();

    final appUserRepo = getIt<AppUserRepository>();
    final postRepository = getIt<PostRepository>();
    final currentUserId = appUserRepo.getCurrentUserId();

    // Xác định xem đây có phải trang cá nhân của người dùng hiện tại không
    // Nếu widget.userId là null, nghĩa là đang xem trang của mình.
    _isMyProfile = widget.userId == null || widget.userId == currentUserId;

    // Khởi tạo tab controller với số lượng tab phù hợp
    _tabController = TabController(length: _isMyProfile ? 2 : 1, vsync: this);

    // Khởi tạo UserInfoBloc để lấy thông tin profile
    _userInfoBloc = getIt<UserInfoBloc>()..add(UserInfoRequested(userId: widget.userId));

    // Khởi tạo các BLoC cho từng tab
    _postBlocs = [
      // BLoC cho tab "Bài viết đã đăng"
      PostBloc(
        ({required params}) => postRepository.getPostsByUserId(
          userId: widget.userId,
          params: params,
        ),
      ),
      // Chỉ thêm BLoC cho tab "Đã lưu" nếu là trang của mình
      if (_isMyProfile)
        PostBloc(
          ({required params}) => postRepository.getSavedPosts(
            // userId luôn là của người dùng hiện tại cho tab này
            userId: currentUserId,
            params: params,
          ),
        ),
    ];
  }

  @override
  void dispose() {
    _tabController.dispose();
    _mainScrollController.dispose();
    _userInfoBloc.close();
    for (var bloc in _postBlocs) {
      bloc.close();
    }
    super.dispose();
  }

  void _scrollToTopAndRefreshCurrentTab() {
    if (_mainScrollController.hasClients) {
      _mainScrollController.animateTo(0.0, duration: const Duration(milliseconds: 300), curve: Curves.easeOut);
    }
    _postBlocs[_tabController.index].add(const PostEvent.refreshRequested());
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(value: _userInfoBloc),
        // Cung cấp các PostBlocs cho cây widget
        // Chúng ta sẽ lấy BLoC cụ thể trong từng TabView
      ],
      child: Scaffold(
        body: NestedScrollView(
          controller: _mainScrollController,
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              GlassSliverAppBar(
                leading: widget.userId != null
                    ? IconButton(
                        onPressed: () => context.pop(),
                        icon: AppIcons.left.toSvg(color: appColorScheme(context).onSurface),
                      )
                    : null,
                pinned: true,
                floating: true,
                title: BlocBuilder<UserInfoBloc, UserInfoState>(
                  builder: (context, state) {
                    if (state is UserInfoSuccess) {
                      return Text(state.appUser.username ?? 'Profile');
                    }
                    return const SizedBox();
                  },
                ),
                centerTitle: true,
                actions: [
                  if (_isMyProfile) const LogoutButton(),
                ],
              ),
              const SliverToBoxAdapter(child: ProfileInfo()),
              SliverPersistentHeader(
                delegate: _SliverAppBarDelegate(
                  TabBar(
                    controller: _tabController,
                    onTap: (index) {
                      if (!_tabController.indexIsChanging) {
                        _scrollToTopAndRefreshCurrentTab();
                      }
                    },
                    dividerColor: Colors.white.withAlpha(25),
                    tabs: [
                      const Tab(icon: Icon(Icons.grid_view_rounded)),
                      if (_isMyProfile) const Tab(icon: Icon(Icons.bookmark_rounded)),
                    ],
                  ),
                ),
                pinned: true,
              ),
            ];
          },
          body: TabBarView(
            controller: _tabController,
            children: [
              // Tab 1: Bài viết đã đăng
              BlocProvider.value(
                value: _postBlocs[0],
                child: const GridPostPage(
                  key: PageStorageKey<String>('profilePosts'),
                  noItemsFoundMessage: 'Chưa có bài viết nào.',
                ),
              ),
              // Tab 2: Bài viết đã lưu (chỉ tồn tại nếu là trang của mình)
              if (_isMyProfile)
                BlocProvider.value(
                  value: _postBlocs[1],
                  child: const GridPostPage(
                    key: PageStorageKey<String>('profileSavedPosts'),
                    noItemsFoundMessage: 'Chưa có bài viết nào được lưu.',
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

// Lớp _SliverAppBarDelegate không đổi, chỉ cần copy và dán
class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  _SliverAppBarDelegate(this._tabBar);
  final TabBar _tabBar;

  @override
  double get minExtent => _tabBar.preferredSize.height;
  @override
  double get maxExtent => _tabBar.preferredSize.height;

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return GlassContainer(
      backgroundColor: Colors.transparent,
      borderRadius: 0,
      blur: 50,
      child: _tabBar,
    );
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) => false;
}
