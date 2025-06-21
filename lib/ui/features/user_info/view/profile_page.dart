import 'package:dishlocal/app/theme/app_icons.dart';
import 'package:dishlocal/app/theme/theme.dart';
import 'package:dishlocal/core/dependencies_injection/service_locator.dart';
import 'package:dishlocal/data/categories/app_user/model/app_user.dart';
import 'package:dishlocal/data/categories/post/repository/interface/post_repository.dart';
import 'package:dishlocal/ui/features/auth/view/logout_button.dart';
import 'package:dishlocal/ui/features/post/bloc/post_bloc.dart';
import 'package:dishlocal/ui/features/post/view/grid_post_page.dart';
import 'package:dishlocal/ui/features/user_info/view/custom_rich_text.dart';
import 'package:dishlocal/ui/features/user_info/bloc/user_info_bloc.dart';
import 'package:dishlocal/ui/features/user_info/view/profile_info.dart';
import 'package:dishlocal/ui/widgets/containers_widgets/glass_container.dart';
import 'package:dishlocal/ui/widgets/element_widgets/glass_sliver_app_bar.dart';
import 'package:dishlocal/ui/widgets/guard_widgets/connectivity_and_location_guard.dart';
import 'package:dishlocal/ui/widgets/image_widgets/cached_circle_avatar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key, this.userId});

  final String? userId;

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> with SingleTickerProviderStateMixin {
  // 2. Khai báo các controller và BLoC, y hệt HomePage
  late final TabController _tabController;
  final ScrollController _mainScrollController = ScrollController();
  final List<ScrollController> _tabScrollControllers = [
    ScrollController(), // Controller cho Tab "Bài viết"
    ScrollController(), // Controller cho Tab "Đã lưu"
  ];
  late final List<PostBloc> _postBlocs;
  int _currentTabIndex = 0;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);

    // Khởi tạo các BLoC cho từng tab
    // Giả sử Tab 1 là bài viết của user, Tab 2 là bài viết user đã lưu
    final postRepository = getIt<PostRepository>();
    _postBlocs = [
      // BLoC cho tab "Bài viết của user"
      // TODO: Cập nhật event và repository method phù hợp (ví dụ: getPostsByUserId)
      PostBloc(postRepository.getPosts)..add(PostEvent.fetchNextPostPageRequested()),

      // BLoC cho tab "Bài viết đã lưu"
      // TODO: Cập nhật event và repository method phù hợp
      PostBloc(postRepository.getSavedPosts)..add(const PostEvent.fetchNextPostPageRequested()),
    ];
  }

  // 3. Sao chép logic xử lý nhấn tab
  void _scrollToTopAndRefresh(int index) {
    // 1. Cuộn NestedScrollView chính (SliverAppBar) về đầu
    if (_mainScrollController.hasClients) {
      _mainScrollController.animateTo(
        0.0,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
    // 2. Cuộn CustomScrollView của tab tương ứng về đầu
    if (_tabScrollControllers[index].hasClients) {
      _tabScrollControllers[index].animateTo(
        0.0,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
    // 3. Gửi sự kiện refresh đến BLoC tương ứng
    // TODO: Đảm bảo PostBloc của bạn có event 'refreshRequested'
    _postBlocs[index].add(const PostEvent.refreshRequested());
  }

  @override
  void dispose() {
    _tabController.dispose();
    _mainScrollController.dispose();
    for (var controller in _tabScrollControllers) {
      controller.dispose();
    }
    for (var bloc in _postBlocs) {
      bloc.close();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ConnectivityAndLocationGuard(builder: (context) {
      // UserInfoBloc được cung cấp riêng cho phần header
      return BlocProvider(
        create: (context) => getIt<UserInfoBloc>()..add(UserInfoRequested(userId: widget.userId)),
        child: Scaffold(
          body: NestedScrollView(
            // Gán controller chính
            controller: _mainScrollController,
            headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
              return <Widget>[
                GlassSliverAppBar(
                  leading: widget.userId != null
                      ? IconButton(
                          onPressed: () {
                            context.pop();
                          },
                          icon: AppIcons.left.toSvg(
                            color: appColorScheme(context).onSurface,
                          ),
                        )
                      : null,
                  pinned: true,
                  floating: true,
                  title: BlocBuilder<UserInfoBloc, UserInfoState>(
                    builder: (context, state) {
                      if (state is UserInfoSuccess) {
                        return Text(state.appUser.username ?? 'error');
                      }
                      return const SizedBox();
                    },
                  ),
                  centerTitle: true,
                  actions: [
                    widget.userId != null ? const SizedBox() : const LogoutButton(),
                  ],
                ),
                const SliverToBoxAdapter(
                  child: ProfileInfo(),
                ),
                SliverPersistentHeader(
                  delegate: _SliverAppBarDelegate(
                    TabBar(
                      // 4. Gán TabController và thêm logic onTap
                      controller: _tabController,
                      onTap: (index) {
                        if (index == _currentTabIndex) {
                          _scrollToTopAndRefresh(index);
                        } else {
                          // Cập nhật lại tab index hiện tại
                          setState(() {
                            _currentTabIndex = index;
                          });
                        }
                      },
                      dividerColor: Colors.white.withAlpha(25), // withValues is deprecated
                      tabs: const [
                        Tab(icon: Icon(Icons.grid_view_rounded)),
                        Tab(icon: Icon(Icons.bookmark_rounded)),
                      ],
                    ),
                  ),
                  pinned: true,
                ),
              ];
            },
            body: TabBarView(
              // 5. Cập nhật TabBarView
              controller: _tabController,
              children: [
                // --- TAB 1: Bài viết của user ---
                BlocProvider.value(
                  value: _postBlocs[0],
                  child: GridPostPage(
                    scrollController: _tabScrollControllers[0],
                    noItemsFoundMessage: 'Chưa có bài viết nào.',
                  ),
                ),
                // --- TAB 2: Bài viết đã lưu ---
                BlocProvider.value(
                  value: _postBlocs[1],
                  child: GridPostPage(
                    scrollController: _tabScrollControllers[1],
                    noItemsFoundMessage: 'Chưa có bài viết nào được lưu.',
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}

// Giữ nguyên _SliverAppBarDelegate để không thay đổi giao diện
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
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return false;
  }
}
