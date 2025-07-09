import 'package:dishlocal/app/theme/app_icons.dart';
import 'package:dishlocal/app/theme/theme.dart';
import 'package:dishlocal/ui/widgets/containers_widgets/glass_container.dart';
import 'package:dishlocal/ui/widgets/buttons_widgets/gradient_fab.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

final searchTabResetNotifier = ValueNotifier<int>(0);


class MainShell extends StatelessWidget {
  final StatefulNavigationShell navigationShell;

  const MainShell({
    super.key,
    required this.navigationShell,
  });

  // Hàm để chuyển tab
  void _onTap(BuildContext context, int index) {
    final isTappedAgain = index == navigationShell.currentIndex;

    navigationShell.goBranch(
      index,
      initialLocation: isTappedAgain,
    );

    // Nếu là tab Search (index 1) và được nhấn lại
    if (isTappedAgain && index == 1) {
      searchTabResetNotifier.value++;
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      // 1. Nội dung của các tab được hiển thị ở đây
      body: navigationShell,

      // 3. BottomAppBar thay thế cho PersistentTabView
      bottomNavigationBar: GlassContainer(
        borderRadius: 0,
        backgroundColor: Colors.transparent,
        blur: 50,
        borderTop: true,
        child: BottomAppBar(
          padding: const EdgeInsets.all(0),
          height: kBottomNavigationBarHeight,
          color: Colors.transparent,
          child: Row(
            // Chia các item ra các bên của vết lõm

            children: <Widget>[
              // Item 0
              _buildTabItem(
                context: context,
                activeIcon: AppIcons.home4.toSvg(
                  color: Theme.of(context).colorScheme.primary,
                ),
                icon: AppIcons.home41.toSvg(
                  color: appColorScheme(context).onSurface,
                ),
                index: 0,
              ),
              // Item 1
              _buildTabItem(
                context: context,
                activeIcon: AppIcons.search.toSvg(
                  color: Theme.of(context).colorScheme.primary,
                ),
                icon: AppIcons.search.toSvg(
                  color: appColorScheme(context).onSurface,
                ),
                index: 1,
              ),
              // FAB
              GradientFab(
                onTap: () {
                  context.push("/camera");
                },
              ),
              // Item 3
              _buildTabItem(
                context: context,
                activeIcon: AppIcons.rocketFill.toSvg(
                  color: Theme.of(context).colorScheme.primary,
                ),
                icon: AppIcons.rocketLine.toSvg(
                  color: appColorScheme(context).onSurface,
                ),
                index: 2,
              ),
              // Item 4
              _buildTabItem(
                context: context,
                activeIcon: AppIcons.user3.toSvg(
                  color: Theme.of(context).colorScheme.primary,
                ),
                icon: AppIcons.user31.toSvg(
                  color: appColorScheme(context).onSurface,
                ),
                index: 3,
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Widget helper để tạo từng item cho thanh điều hướng
  Widget _buildTabItem({
    required BuildContext context,
    required Widget icon,
    required Widget activeIcon,
    required int index,
  }) {
    final bool isSelected = navigationShell.currentIndex == index;

    return Expanded(
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          _onTap(context, index);
        },
        child: AnimatedScale(
          // 1. Điều khiển tỷ lệ phóng to/thu nhỏ
          scale: isSelected ? 1.25 : 1.0,

          // 2. Thời gian diễn ra animation
          duration: const Duration(milliseconds: 200),

          // 3. Kiểu đường cong animation (tùy chọn, để mượt hơn)
          curve: Curves.easeIn,
          child: Align(
            alignment: Alignment.center,
            child: isSelected ? activeIcon : icon,
          ),
        ),
      ),
    );
  }
}
