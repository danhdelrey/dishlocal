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
  late final TabController _tabController;
  final ScrollController _mainScrollController = ScrollController();

  // KHÔNG CẦN _tabScrollControllers nữa
  // final List<ScrollController> _tabScrollControllers = ...

  late final List<PostBloc> _postBlocs;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);

    final postRepository = getIt<PostRepository>();
    _postBlocs = [
      PostBloc(
        // Vì getPostsByUserId cần tham số `userId`, chúng ta phải bọc nó
        // trong một hàm ẩn danh để khớp với kiểu PostFetcher
        ({required int limit, DateTime? startAfter}) => postRepository.getPostsByUserId(
          userId: widget.userId, // Lấy userId từ widget của trang Profile
          limit: limit,
          startAfter: startAfter,
        ),
      )..add(const PostEvent.fetchNextPostPageRequested()),
      PostBloc(postRepository.getSavedPosts)..add(const PostEvent.fetchNextPostPageRequested()),
    ];
  }

  // SỬA LẠI HÀM NÀY
  void _scrollToTopAndRefresh(int index) {
    // 1. Cuộn NestedScrollView chính (SliverAppBar) về đầu -> GIỮ NGUYÊN
    if (_mainScrollController.hasClients) {
      _mainScrollController.animateTo(
        0.0,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }

    // 2. Tìm và cuộn PrimaryScrollController của tab đang hoạt động
    // Đây là mấu chốt để điều khiển được grid bên trong mà không phá vỡ liên kết
    final innerController = PrimaryScrollController.of(context);
    if (innerController.hasClients) {
      innerController.animateTo(
        0.0,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }

    // 3. Gửi sự kiện refresh đến BLoC tương ứng -> GIỮ NGUYÊN
    _postBlocs[index].add(const PostEvent.refreshRequested());
  }

  @override
  void dispose() {
    _tabController.dispose();
    _mainScrollController.dispose();
    // KHÔNG CẦN dispose _tabScrollControllers nữa
    for (var bloc in _postBlocs) {
      bloc.close();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ConnectivityAndLocationGuard(builder: (context) {
      return BlocProvider(
        create: (context) => getIt<UserInfoBloc>()..add(UserInfoRequested(userId: widget.userId)),
        child: Scaffold(
          // Sử dụng lại cấu trúc ban đầu của bạn, nó đã đúng
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
                      controller: _tabController,
                      onTap: (index) {
                        // Logic onTap vẫn đúng. Nó kiểm tra xem người dùng
                        // có nhấn vào tab đang được chọn hay không.
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
            // Đưa TabBarView trở lại body
            body: TabBarView(
              controller: _tabController,
              children: [
                // --- TAB 1: Bài viết của user ---
                BlocProvider.value(
                  value: _postBlocs[0],
                  child: const GridPostPage(
                    // QUAN TRỌNG: Cung cấp một key duy nhất để lưu trạng thái cuộn
                    key: PageStorageKey<String>('profilePosts'),
                    // KHÔNG TRUYỀN SCROLL CONTROLLER NỮA
                    noItemsFoundMessage: 'Chưa có bài viết nào.',
                  ),
                ),
                // --- TAB 2: Bài viết đã lưu ---
                BlocProvider.value(
                  value: _postBlocs[1],
                  child: const GridPostPage(
                    // QUAN TRỌNG: Cung cấp một key duy nhất khác
                    key: PageStorageKey<String>('profileSavedPosts'),
                    // KHÔNG TRUYỀN SCROLL CONTROLLER NỮA
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
