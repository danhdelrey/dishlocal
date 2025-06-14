import 'dart:ui';

import 'package:dishlocal/app/theme/app_icons.dart';
import 'package:dishlocal/app/theme/theme.dart';
import 'package:dishlocal/ui/features/view_post/view/grid_view_posts.dart';
import 'package:dishlocal/ui/widgets/cropped_image.dart';
import 'package:dishlocal/ui/widgets/custom_badge.dart';
import 'package:dishlocal/ui/widgets/glass_space.dart';
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
              SliverAppBar(
                flexibleSpace: const GlassSpace(
                  blur: 50,
                  backgourndColor: Colors.transparent,
                ),
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
                backgroundColor: Colors.transparent,
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
                pinned: true,
                floating: true,
                snap: true,
                bottom: TabBar(
                  unselectedLabelColor: appColorScheme(context).onSurface,
                  dividerColor: Colors.white.withValues(alpha: 0.1),
                  indicatorSize: TabBarIndicatorSize.tab,
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

class FilterItem extends StatelessWidget {
  const FilterItem({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const CroppedImage(
          borderRadius: 1000,
          width: 50,
          height: 50,
          path: 'assets/images/com-tam-suon-bi-cha-2.jpg',
        ),
        const SizedBox(
          height: 10,
        ),
        Text(
          'Cơm',
          style: Theme.of(context).textTheme.labelMedium,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
