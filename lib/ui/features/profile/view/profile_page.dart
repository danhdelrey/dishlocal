import 'package:dishlocal/app/theme/app_icons.dart';
import 'package:dishlocal/ui/features/view_post/view/grid_view_posts.dart';
import 'package:dishlocal/ui/widgets/cropped_image.dart';
import 'package:flutter/gestures.dart';
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
              // SliverAppBar để có hiệu ứng cuộn đẹp cho AppBar
              SliverAppBar(
                automaticallyImplyLeading: true,
                surfaceTintColor: Colors.transparent,
                backgroundColor: Theme.of(context).colorScheme.surface,
                title: const Text('lanadelrey'),
                titleTextStyle: Theme.of(context).textTheme.titleMedium,
                centerTitle: true,
                actions: [
                  IconButton(
                    onPressed: () {},
                    
                    icon: AppIcons.userSettingLine.toSvg(
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
                  )
                ],
                // Để AppBar luôn hiện khi cuộn lên
                pinned: true,
                // Để AppBar hiện ra ngay khi cuộn xuống dù đang ở giữa list
                floating: true,
                // Quan trọng: forceElevated giúp tạo bóng đổ khi nội dung cuộn bên dưới
                forceElevated: innerBoxIsScrolled,
              ),

              // SliverToBoxAdapter để bọc các widget không phải là Sliver
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const CroppedImage(
                            borderRadius: 1000,
                            path: 'assets/images/Lana.jpg',
                            width: 60,
                            height: 60,
                          ),
                          const SizedBox(
                            width: 15,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Đỗ Lan Anh',
                                style: Theme.of(context).textTheme.titleMedium,
                              ),
                              RichText(
                                text: TextSpan(
                                  style:
                                      Theme.of(context).textTheme.titleMedium,
                                  children: [
                                    TextSpan(
                                      text: '125 N',
                                      style: Theme.of(context)
                                          .textTheme
                                          .labelLarge!
                                          .copyWith(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .onSurface,
                                          ),
                                      recognizer: TapGestureRecognizer()
                                        ..onTap = () {},
                                      children: [
                                        TextSpan(
                                          text: ' người theo dõi • ',
                                          style: Theme.of(context)
                                              .textTheme
                                              .labelLarge!
                                              .copyWith(
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .outline,
                                              ),
                                        ),
                                      ],
                                    ),
                                    TextSpan(
                                      text: '96',
                                      style: Theme.of(context)
                                          .textTheme
                                          .labelLarge!
                                          .copyWith(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .onSurface,
                                          ),
                                      recognizer: TapGestureRecognizer()
                                        ..onTap = () {},
                                      children: [
                                        TextSpan(
                                          text: ' đang theo dõi',
                                          style: Theme.of(context)
                                              .textTheme
                                              .labelLarge!
                                              .copyWith(
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .outline,
                                              ),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Text(
                        'Follow mình để cùng "ăn sập" thế giới nhé! Mình là một người đam mê ẩm thực, luôn tìm kiếm những trải nghiệm mới lạ và độc đáo.',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      //thêm phần tab ở đây (scroll sẽ dính lên trên cùng)
                      //nội dung của tab ở đây
                    ],
                  ),
                ),
              ),

              // SliverPersistentHeader để "ghim" TabBar ở trên cùng khi cuộn
              SliverPersistentHeader(
                delegate: _SliverAppBarDelegate(
                  const TabBar(
                    indicatorSize: TabBarIndicatorSize.tab,
                    tabs: [
                      Tab(text: 'Bài đăng'),
                      Tab(text: 'Đã lưu'),
                      Tab(text: 'Đã đến'),
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
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: Theme.of(context)
          .scaffoldBackgroundColor, // Màu nền để che nội dung bên dưới
      child: _tabBar,
    );
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return false;
  }
}
