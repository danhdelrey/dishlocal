import 'package:dishlocal/app/theme/app_icons.dart';
import 'package:dishlocal/app/theme/theme.dart';
import 'package:dishlocal/ui/widgets/containers_widgets/glass_container.dart';
import 'package:dishlocal/ui/widgets/buttons_widgets/gradient_fab.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

// Thay thế các icon AppIcons.xxx.toSvg() bằng các Icon widget chuẩn
// hoặc giữ lại nếu bạn đã có sẵn.
// Ví dụ: Icon(Icons.home)

class MainShell extends StatelessWidget {
  final StatefulNavigationShell navigationShell;

  const MainShell({
    super.key,
    required this.navigationShell,
  });

  // Hàm để chuyển tab
  void _onTap(BuildContext context, int index) {
    navigationShell.goBranch(
      index,
      // duy trì state khi quay lại tab cũ nếu có thể
      initialLocation: index == navigationShell.currentIndex,
    );
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
              // _buildTabItem(
              //   context: context,
              //   activeIcon: AppIcons.rocketFill.toSvg(
              //     color: Theme.of(context).colorScheme.primary,
              //   ),
              //   icon: AppIcons.rocketLine.toSvg(
              //     color: appColorScheme(context).onSurface,
              //   ),
              //   index: 1,
              // ),
              // FAB
              GradientFab(
                onTap: () {
                  context.push("/camera");
                },
              ),
              // Item 3
              // _buildTabItem(
              //   context: context,
              //   activeIcon: AppIcons.mail.toSvg(
              //     color: Theme.of(context).colorScheme.primary,
              //   ),
              //   icon: CustomBadge(
              //     showBadge: false,
              //     child: AppIcons.mail1.toSvg(
              //       color: appColorScheme(context).onSurface,
              //     ),
              //   ),
              //   index: 2,
              // ),
              // Item 4
              _buildTabItem(
                context: context,
                activeIcon: AppIcons.user3.toSvg(
                  color: Theme.of(context).colorScheme.primary,
                ),
                icon: AppIcons.user31.toSvg(
                  color: appColorScheme(context).onSurface,
                ),
                index: 1,
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
