import 'dart:async';

import 'package:dishlocal/app/config/main_shell.dart';
import 'package:dishlocal/app/theme/app_icons.dart';
import 'package:dishlocal/app/theme/theme.dart';
import 'package:dishlocal/core/dependencies_injection/service_locator.dart';
import 'package:dishlocal/data/categories/app_user/repository/interface/app_user_repository.dart';
import 'package:dishlocal/data/categories/post/model/filter_sort_model/filter_sort_params.dart';
import 'package:dishlocal/data/categories/post/model/post.dart';
import 'package:dishlocal/data/categories/post/repository/interface/post_repository.dart';
import 'package:dishlocal/ui/features/auth/view/logout_button.dart';
import 'package:dishlocal/ui/features/home/view/home_page.dart';
import 'package:dishlocal/ui/features/post/bloc/post_bloc.dart';
import 'package:dishlocal/ui/features/post/view/post_grid_tab_view.dart';
import 'package:dishlocal/ui/features/post/view/small_post.dart';
import 'package:dishlocal/ui/features/user_info/bloc/user_info_bloc.dart';
import 'package:dishlocal/ui/features/user_info/view/profile_info.dart';
import 'package:dishlocal/ui/widgets/guard_widgets/connectivity_and_location_guard.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

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

class _ProfilePageContent extends StatefulWidget {
  const _ProfilePageContent({this.userId});
  final String? userId;

  @override
  State<_ProfilePageContent> createState() => _ProfilePageContentState();
}

class _ProfilePageContentState extends State<_ProfilePageContent> with TickerProviderStateMixin {
  late final TabController _tabController;
  late final List<PostBloc> _postBlocs;
  late final UserInfoBloc _userInfoBloc;
  bool _isMyProfile = false;

  // THAY ĐỔI: Một ScrollController duy nhất để quản lý toàn bộ trang.
  late final ScrollController _outerScrollController;

  late final StreamSubscription<int> _refreshSubscription;
  static const int myTabIndex = 2;

  @override
  void initState() {
    super.initState();

    _outerScrollController = ScrollController();

    final appUserRepo = getIt<AppUserRepository>();
    final postRepository = getIt<PostRepository>();
    final currentUserId = appUserRepo.getCurrentUserId();

    _isMyProfile = widget.userId == null || widget.userId == currentUserId;
    _tabController = TabController(length: _isMyProfile ? 2 : 1, vsync: this);
    _userInfoBloc = getIt<UserInfoBloc>()..add(UserInfoRequested(userId: widget.userId));
    _postBlocs = [
      PostBloc(
        ({required params}) => postRepository.getPostsByUserId(
          userId: widget.userId,
          params: params,
        ),
      ),
      if (_isMyProfile)
        PostBloc(
          ({required params}) => postRepository.getSavedPosts(
            userId: currentUserId,
            params: params,
          ),
        ),
    ];

    _refreshSubscription = refreshManager.refreshStream.listen((tabIndex) {
      if (tabIndex == myTabIndex) {
        _triggerRefreshAndScroll();
      }
    });
  }

  @override
  void dispose() {
    _refreshSubscription.cancel();
    _outerScrollController.dispose();

    _tabController.dispose();
    _userInfoBloc.close();
    for (var bloc in _postBlocs) {
      bloc.close();
    }
    super.dispose();
  }

  // THAY ĐỔI: Hàm cuộn lên đầu trang, được gọi khi nhấn vào tab đang active.
  void _scrollToTop() {
    if (_outerScrollController.hasClients) {
      _outerScrollController.animateTo(
        0.0,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeOut,
      );
    }
  }

  // THAY ĐỔI: Hàm onRefresh chung cho cả trang.
  Future<void> _onRefresh() async {
    // Tìm BLoC của tab đang hoạt động và gọi refresh
    final activeBloc = _postBlocs[_tabController.index];
    activeBloc.add(const PostEvent.refreshRequested());
    _userInfoBloc.add(UserInfoRequested(userId: widget.userId));
    // Đợi BLoC xử lý xong (không còn loading) để RefreshIndicator biến mất
    await activeBloc.stream.firstWhere((s) => s.status != PostStatus.loading);
  }

  void _triggerRefreshAndScroll() {
    _scrollToTop();
    _onRefresh();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(value: _userInfoBloc),
      ],
      child: Scaffold(
        // THAY ĐỔI: Không còn AppBar ở đây.
        // Toàn bộ cấu trúc được thay bằng RefreshIndicator và NestedScrollView.
        body: NestedScrollView(
          // THAY ĐỔI: Gán controller duy nhất cho NestedScrollView.
          controller: _outerScrollController,
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              // AppBar bây giờ là một SliverAppBar
              SliverAppBar(
                automaticallyImplyLeading: false,
                backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                surfaceTintColor: Colors.transparent,
                leading: widget.userId != null
                    ? IconButton(
                        onPressed: () => context.pop(),
                        icon: const Icon(Icons.arrow_back_ios_new, size: 16),
                      )
                    : null,
                title: BlocBuilder<UserInfoBloc, UserInfoState>(
                  builder: (context, state) {
                    if (state is UserInfoSuccess) {
                      return Text(state.appUser.username ?? 'Profile');
                    }
                    return const SizedBox();
                  },
                ),
                titleTextStyle: appTextTheme(context).titleMedium,
                centerTitle: true,
                actions: [
                  if (_isMyProfile) const LogoutButton(),
                ],
                // Thuộc tính quan trọng để ghim AppBar và hiển thị lại khi cuộn xuống.
                pinned: true,
                floating: true,
                forceElevated: innerBoxIsScrolled,
              ),
              // Widget ProfileInfo được bọc trong SliverToBoxAdapter.
              const SliverToBoxAdapter(
                child: ProfileInfo(),
              ),
              // TabBar được ghim lại bằng SliverPersistentHeader.
              SliverPersistentHeader(
                delegate: _SliverPersistentHeaderDelegate(
                  TabBar(
                    controller: _tabController,
                    // THAY ĐỔI: Thêm logic để cuộn lên đầu khi nhấn vào tab đang active.
                    onTap: (index) {
                      if (index == _tabController.index) {
                        _scrollToTop();
                      }
                    },
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
          // Body là TabBarView chứa các GridView.
          body: TabBarView(
            controller: _tabController,
            children: [
              BlocProvider.value(
                value: _postBlocs[0],
                child: const PostGridTabView(
                  key: PageStorageKey<String>('profilePosts'),
                  noItemsFoundMessage: 'Chưa có bài viết nào.',
                ),
              ),
              if (_isMyProfile)
                BlocProvider.value(
                  value: _postBlocs[1],
                  child: const PostGridTabView(
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
