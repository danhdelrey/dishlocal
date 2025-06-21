import 'package:dishlocal/app/theme/app_icons.dart';
import 'package:dishlocal/app/theme/theme.dart';
import 'package:dishlocal/core/dependencies_injection/service_locator.dart';
import 'package:dishlocal/data/categories/app_user/model/app_user.dart';
import 'package:dishlocal/data/categories/app_user/repository/interface/app_user_repository.dart';
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

/// BƯỚC 1: ProfilePage trở thành container đơn giản, truyền userId xuống.
/// Nó có thể là StatelessWidget vì không còn quản lý state nào.
class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key, this.userId});

  final String? userId;

  @override
  Widget build(BuildContext context) {
    // Guard sẽ gọi _ProfilePageContent khi điều kiện được đáp ứng,
    // và truyền userId qua cho nó.
    return ConnectivityAndLocationGuard(
      builder: (context) => _ProfilePageContent(userId: userId),
    );
  }
}

/// BƯỚC 2: Widget nội dung chính, chứa toàn bộ logic và giao diện.
class _ProfilePageContent extends StatefulWidget {
  const _ProfilePageContent({this.userId});

  final String? userId;

  @override
  State<_ProfilePageContent> createState() => _ProfilePageContentState();
}

/// BƯỚC 3: State logic được chuyển hết vào đây.
class _ProfilePageContentState extends State<_ProfilePageContent> with SingleTickerProviderStateMixin {
  late final TabController _tabController;
  final ScrollController _mainScrollController = ScrollController();
  late final List<PostBloc> _postBlocs;
  late final UserInfoBloc _userInfoBloc;

  // BƯỚC 1: Thêm Set để theo dõi.
  final Set<int> _initializedTabs = {};

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);

    _userInfoBloc = getIt<UserInfoBloc>()..add(UserInfoRequested(userId: widget.userId));

    final postRepository = getIt<PostRepository>();

    // BƯỚC 2: Khởi tạo BLoCs nhưng không fetch.
    _postBlocs = [
      PostBloc(
        ({required int limit, DateTime? startAfter}) => postRepository.getPostsByUserId(
          userId: widget.userId,
          limit: limit,
          startAfter: startAfter,
        ),
      ),
      PostBloc(
        // Bọc trong hàm ẩn danh và truyền userId
        ({required int limit, DateTime? startAfter}) => postRepository.getSavedPosts(
          userId: widget.userId,
          limit: limit,
          startAfter: startAfter,
        ),
      ),
    ];

    // BƯỚC 3: Fetch cho tab đầu tiên.
    if (_postBlocs.isNotEmpty) {
      _postBlocs[0].add(const PostEvent.fetchNextPostPageRequested());
      _initializedTabs.add(0);
    }

    // BƯỚC 4: Thêm listener.
    _tabController.addListener(_handleTabSelection);
  }

  // BƯỚC 5: Tạo hàm xử lý listener.
  void _handleTabSelection() {
    final index = _tabController.index;
    if (!_initializedTabs.contains(index)) {
      _postBlocs[index].add(const PostEvent.fetchNextPostPageRequested());
      _initializedTabs.add(index);
    }
  }

  // _scrollToTopAndRefresh không thay đổi
  void _scrollToTopAndRefresh(int index) {
    if (_mainScrollController.hasClients) {
      _mainScrollController.animateTo(0.0, duration: const Duration(milliseconds: 300), curve: Curves.easeOut);
    }
    final innerController = PrimaryScrollController.of(context);
    if (innerController.hasClients) {
      innerController.animateTo(0.0, duration: const Duration(milliseconds: 300), curve: Curves.easeOut);
    }
    _postBlocs[index].add(const PostEvent.refreshRequested());
  }

  @override
  void dispose() {
    // BƯỚC 6: Gỡ listener.
    _tabController.removeListener(_handleTabSelection);
    _tabController.dispose();
    _mainScrollController.dispose();
    _userInfoBloc.close();
    for (var bloc in _postBlocs) {
      bloc.close();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final currentUserId = getIt<AppUserRepository>().getCurrentUserId();
    // Cung cấp UserInfoBloc đã được tạo cho cây widget bên dưới
    return BlocProvider.value(
      value: _userInfoBloc,
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
                  // Không cần builder ở đây nữa vì _userInfoBloc đã được cung cấp
                  builder: (context, state) {
                    if (state is UserInfoSuccess) {
                      return Text(state.appUser.username ?? 'error');
                    }
                    return const SizedBox();
                  },
                ),
                centerTitle: true,
                actions: [
                  // Bọc actions trong BlocBuilder để có thể quyết định hiển thị nút nào
                  BlocBuilder<UserInfoBloc, UserInfoState>(
                    builder: (context, state) {
                      // Chỉ hiển thị nút khi đã có thông tin người dùng
                      if (state is UserInfoSuccess) {
                        // So sánh ID người xem với ID của người trên trang profile
                        final bool isMyProfile = currentUserId == state.appUser.userId;

                        if (isMyProfile) {
                          // Nếu là trang của tôi, hiển thị nút Logout
                          return const LogoutButton();
                        } else {
                          // Nếu là trang của người khác, hiển thị nút More
                          // TODO: Tạo widget MoreButton hoặc dùng IconButton
                          return IconButton(
                            icon: const Icon(Icons.more_horiz),
                            onPressed: () {},
                          );
                        }
                      }
                      // Khi đang loading hoặc lỗi, không hiển thị gì cả
                      return const SizedBox();
                    },
                  ),
                ],
              ),
              const SliverToBoxAdapter(
                child: ProfileInfo(),
              ),
              SliverPersistentHeader(
                delegate: _SliverAppBarDelegate(
                  TabBar(
                    controller: _tabController,
                    onTap: (index) {
                      if (_tabController.indexIsChanging == false) {
                        _scrollToTopAndRefresh(index);
                      }
                    },
                    dividerColor: Colors.white.withAlpha(25),
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
            controller: _tabController,
            children: [
              BlocProvider.value(
                value: _postBlocs[0],
                child: const SafeArea(
                  top: false,
                  left: false,
                  right: false,
                  child: GridPostPage(
                    key: PageStorageKey<String>('profilePosts'),
                    noItemsFoundMessage: 'Chưa có bài viết nào.',
                  ),
                ),
              ),
              BlocProvider.value(
                value: _postBlocs[1],
                child: const SafeArea(
                  top: false,
                  left: false,
                  right: false,
                  child: GridPostPage(
                    key: PageStorageKey<String>('profileSavedPosts'),
                    noItemsFoundMessage: 'Chưa có bài viết nào được lưu.',
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Lớp _SliverAppBarDelegate không đổi
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
