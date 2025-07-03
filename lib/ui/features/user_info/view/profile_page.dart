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

  final Set<int> _initializedTabs = {};

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _userInfoBloc = getIt<UserInfoBloc>()..add(UserInfoRequested(userId: widget.userId));
    final postRepository = getIt<PostRepository>();
    _postBlocs = [
      PostBloc(
        ({required int limit, DateTime? startAfter}) => postRepository.getPostsByUserId(
          userId: widget.userId,
          limit: limit,
          startAfter: startAfter,
        ),
      ),
      PostBloc(
        ({required int limit, DateTime? startAfter}) => postRepository.getSavedPosts(
          userId: widget.userId,
          limit: limit,
          startAfter: startAfter,
        ),
      ),
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
    if (_mainScrollController.hasClients) {
      _mainScrollController.animateTo(0.0, duration: const Duration(milliseconds: 300), curve: Curves.easeOut);
    }
    _postBlocs[index].add(const PostEvent.refreshRequested());
  }

  @override
  void dispose() {
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
    return BlocProvider.value(
      value: _userInfoBloc,
      child: Scaffold(
        body: NestedScrollView(
          controller: _mainScrollController,
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            // Phần headerSliverBuilder không thay đổi.
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
                      return Text(state.appUser.username ?? 'error');
                    }
                    return const SizedBox();
                  },
                ),
                centerTitle: true,
                actions: [
                  BlocBuilder<UserInfoBloc, UserInfoState>(
                    builder: (context, state) {
                      if (state is UserInfoSuccess) {
                        final bool isMyProfile = currentUserId == state.appUser.userId;
                        if (isMyProfile) {
                          return const LogoutButton();
                        }
                      }
                      return const SizedBox();
                    },
                  ),
                ],
              ),
              const SliverToBoxAdapter(child: ProfileInfo()),
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
          // THAY ĐỔI LỚN BẮT ĐẦU TỪ ĐÂY
          body: TabBarView(
            controller: _tabController,
            children: [
              // Tab bài viết đã đăng
              _buildPostTab(
                bloc: _postBlocs[0],
                pageKey: 'profilePosts',
                noItemsMessage: 'Chưa có bài viết nào.',
              ),
              // Tab bài viết đã lưu
              _buildPostTab(
                bloc: _postBlocs[1],
                pageKey: 'profileSavedPosts',
                noItemsMessage: 'Chưa có bài viết nào được lưu.',
                // Chỉ hiển thị tab này nếu là trang của chính mình
                isVisible: currentUserId == (widget.userId ?? currentUserId),
              ),
            ],
          ),
          // KẾT THÚC THAY ĐỔI
        ),
      ),
    );
  }

  /// Widget helper để tạo một tab hiển thị bài viết, tránh lặp code.
  Widget _buildPostTab({
    required PostBloc bloc,
    required String pageKey,
    required String noItemsMessage,
    bool isVisible = true, // Thêm tham số isVisible
  }) {
    // Nếu tab này không nên hiển thị (ví dụ: tab 'Đã lưu' của người khác),
    // trả về một widget rỗng hoặc một thông báo.
    if (!isVisible) {
      return const Center(
        child: Text("Bạn không thể xem các bài viết đã lưu của người khác."),
      );
    }

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
