import 'package:dishlocal/app/theme/app_icons.dart';
import 'package:dishlocal/app/theme/custom_colors.dart';
import 'package:dishlocal/app/theme/theme.dart';
import 'package:dishlocal/core/dependencies_injection/service_locator.dart';
import 'package:dishlocal/ui/features/post/bloc/post_bloc.dart';
import 'package:dishlocal/ui/features/post/view/grid_post_page.dart';
import 'package:dishlocal/ui/widgets/element_widgets/custom_badge.dart';
import 'package:dishlocal/ui/widgets/containers_widgets/glass_space.dart';
import 'package:dishlocal/ui/widgets/element_widgets/glass_sliver_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<PostBloc>(),
      child: DefaultTabController(
        length: 2,
        child: Scaffold(
          extendBody: true,
          body: NestedScrollView(
            headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
              return <Widget>[
                GlassSliverAppBar(
                  centerTitle: true,
                  hasBorder: false,
                  title: ShaderMask(
                    shaderCallback: (bounds) => primaryGradient.createShader(Rect.fromLTWH(0, 0, bounds.width, bounds.height)),
                    child: const Text(
                      'DishLocal',
                      style: TextStyle(
                        fontFamily: 'SFProDisplay',
                        fontWeight: FontWeight.w700,
                        fontSize: 24,
                      ),
                    ),
                  ),
                  bottom: TabBar(
                    dividerColor: Colors.white.withValues(alpha: 0.1),
                    indicatorSize: TabBarIndicatorSize.tab,
                    tabs: const [
                      Tab(
                        text: 'Dành cho bạn',
                      ),
                      Tab(
                        text: 'Đang theo dõi',
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
                GridPostPage(),
                GridPostPage(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
