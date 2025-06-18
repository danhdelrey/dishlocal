import 'package:dishlocal/app/theme/app_icons.dart';
import 'package:dishlocal/app/theme/theme.dart';
import 'package:dishlocal/ui/features/profile/view/custom_rich_text.dart';
import 'package:dishlocal/ui/features/user_info/view/profile_info.dart';
import 'package:dishlocal/ui/features/view_post/view/grid_view_posts.dart';
import 'package:dishlocal/ui/widgets/containers_widgets/glass_container.dart';
import 'package:dishlocal/ui/widgets/element_widgets/glass_sliver_app_bar.dart';
import 'package:dishlocal/ui/widgets/image_widgets/cached_circle_avatar.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    // DefaultTabController phải bọc toàn bộ widget sử dụng TabController
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        // Sử dụng NestedScrollView làm body của Scaffold
        body: NestedScrollView(
          // 1. headerSliverBuilder: chứa các widget ở trên cùng (phần header)
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              GlassSliverAppBar(
                pinned: true,
                floating: true,
                title: const Text('lanadelrey'),
                centerTitle: true,
                actions: [
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.logout_rounded),
                  )
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
              GridViewPosts(),
              GridViewPosts(),
            ],
          ),
        ),
      ),
    );
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
