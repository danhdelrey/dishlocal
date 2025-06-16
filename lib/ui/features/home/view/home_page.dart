import 'package:dishlocal/app/theme/app_icons.dart';
import 'package:dishlocal/app/theme/custom_colors.dart';
import 'package:dishlocal/app/theme/theme.dart';
import 'package:dishlocal/ui/features/view_post/view/grid_view_posts.dart';
import 'package:dishlocal/ui/widgets/element_widgets/custom_badge.dart';
import 'package:dishlocal/ui/widgets/containers_widgets/glass_space.dart';
import 'package:dishlocal/ui/widgets/element_widgets/glass_sliver_app_bar.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        extendBody: true,
        body: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              GlassSliverAppBar(
                hasBorder: false,
                title: ShaderMask(
                  shaderCallback: (bounds) => primaryGradient.createShader(Rect.fromLTWH(0, 0, bounds.width, bounds.height)),
                  child: const Text(
                    'DishLocal',
                    style: TextStyle(
                      fontFamily: 'SFProDisplay',
                      fontWeight: FontWeight.w800,
                      fontSize: 24,
                    ),
                  ),
                ),
                actions: [
                  IconButton(
                    onPressed: () {},
                    icon: AppIcons.search.toSvg(
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: CustomBadge(
                      showBadge: false,
                      child: AppIcons.notification1.toSvg(
                        color: Theme.of(context).colorScheme.onSurface,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                ],
                bottom: TabBar(
                  unselectedLabelColor: appColorScheme(context).onSurface,
                  dividerColor: Colors.white.withValues(alpha: 0.1),
                  indicatorSize: TabBarIndicatorSize.tab,
                  labelColor: appColorScheme(context).onSurface,
                  tabs: const [
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
                floating: true,
                snap: true,
                pinned: true,
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
