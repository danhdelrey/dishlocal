
import 'package:dishlocal/app/theme/app_icons.dart';
import 'package:dishlocal/ui/features/view_post/view/grid_view_posts.dart';
import 'package:dishlocal/ui/widgets/custom_badge.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        body: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverAppBar(
                automaticallyImplyLeading: false,
                leading: Row(
                  children: [
                    const SizedBox(
                      width: 10,
                    ),
                    AppIcons.appIconGradient.toSvg(
                      width: 24,
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    const Text(
                      'DishLocal',
                      style: TextStyle(
                        fontFamily: 'SFProDisplay',
                        fontWeight: FontWeight.w800,
                        fontSize: 18,
                      ),
                    ),
                  ],
                ),
                leadingWidth: 150,
                surfaceTintColor: Colors.transparent,
                backgroundColor: Theme.of(context).colorScheme.surface,
                actions: [
                  IconButton.filledTonal(
                    onPressed: () {},
                    icon: AppIcons.search.toSvg(
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
                    style: IconButton.styleFrom(
                      backgroundColor:
                          Theme.of(context).colorScheme.surfaceContainerLow,
                    ),
                  ),
                  IconButton.filledTonal(
                    onPressed: () {},
                    icon: CustomBadge(
                      showBadge: false,
                      child: AppIcons.notification1.toSvg(
                        color: Theme.of(context).colorScheme.onSurface,
                      ),
                    ),
                    style: IconButton.styleFrom(
                      backgroundColor:
                          Theme.of(context).colorScheme.surfaceContainerLow,
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                ],
                pinned: true,
                floating: true,
                snap: true,
                bottom: const TabBar(
                  indicatorSize: TabBarIndicatorSize.tab,
                  tabs: [
                    Tab(
                      text: 'Dành cho bạn',
                    ),
                    Tab(
                      text: 'Đang theo dõi',
                    ),
                    Tab(
                      text: 'Xu hướng',
                    ),
                  ],
                ),
              ),
            ];
          },
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
