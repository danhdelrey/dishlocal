import 'package:dishlocal/app/theme/app_icons.dart';
import 'package:dishlocal/app/theme/theme.dart';
import 'package:dishlocal/core/dependencies_injection/service_locator.dart';
import 'package:dishlocal/data/categories/app_user/model/app_user.dart';
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

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key, this.userId});

  final String? userId;

  @override
  Widget build(BuildContext context) {
    // DefaultTabController phải bọc toàn bộ widget sử dụng TabController
    return ConnectivityAndLocationGuard(builder: (context) {
      return MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => getIt<UserInfoBloc>()..add(UserInfoRequested(userId: userId)),
          ),
          BlocProvider(
            create: (context) => getIt<PostBloc>(),
          ),
        ],
        child: DefaultTabController(
          length: 2,
          child: Scaffold(
            // Sử dụng NestedScrollView làm body của Scaffold
            body: NestedScrollView(
              // 1. headerSliverBuilder: chứa các widget ở trên cùng (phần header)
              headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
                return <Widget>[
                  GlassSliverAppBar(
                    leading: userId != null
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
                      userId != null ? const SizedBox() : const LogoutButton(),
                    ],
                  ),

                  // SliverToBoxAdapter để bọc các widget không phải là Sliver
                  const SliverToBoxAdapter(
                    child: ProfileInfo(),
                  ),

                  // SliverPersistentHeader để "ghim" TabBar ở trên cùng khi cuộn
                  SliverPersistentHeader(
                    delegate: _SliverAppBarDelegate(
                      TabBar(
                        dividerColor: Colors.white.withValues(alpha: 0.1),
                        tabs: const [
                          Tab(
                            icon: Icon(Icons.grid_view_rounded),
                          ),
                          Tab(
                            icon: Icon(Icons.bookmark_rounded),
                          ),
                        ],
                      ),
                    ),
                    pinned: true,
                  ),
                ];
              },
              // 2. body: chứa nội dung chính có thể cuộn (TabBarView)
              body: const TabBarView(
                children: [
                  GridPostPage(),
                  GridPostPage(),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}

// Lớp helper để tạo SliverPersistentHeader cho TabBar
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
