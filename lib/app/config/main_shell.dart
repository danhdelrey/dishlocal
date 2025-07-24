import 'dart:async';

import 'package:dishlocal/app/theme/app_icons.dart';
import 'package:dishlocal/app/theme/theme.dart';
import 'package:dishlocal/core/dependencies_injection/service_locator.dart';
import 'package:dishlocal/ui/global/cubits/cubit/unread_badge_cubit.dart';
import 'package:dishlocal/ui/widgets/containers_widgets/glass_container.dart';
import 'package:dishlocal/ui/widgets/buttons_widgets/gradient_fab.dart';
import 'package:dishlocal/ui/widgets/element_widgets/custom_badge.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

/// Lớp quản lý sự kiện yêu cầu làm mới các tab.
/// Đây là một Singleton Pattern đơn giản sử dụng Stream.
class RefreshManager {
  // Tạo một StreamController có thể phát sự kiện tới nhiều người nghe (broadcast).
  // Stream này sẽ mang theo 'int' là chỉ số của tab cần làm mới.
  final StreamController<int> _controller = StreamController<int>.broadcast();

  /// Stream để các trang có thể lắng nghe sự kiện.
  Stream<int> get refreshStream => _controller.stream;

  /// Hàm để MainShell gọi khi muốn yêu cầu một tab làm mới.
  void requestRefresh(int tabIndex) {
    _controller.add(tabIndex);
  }

  // Hàm để đóng controller khi không cần thiết (thường là không cần trong vòng đời app).
  void dispose() {
    _controller.close();
  }
}

// Tạo một instance duy nhất để toàn bộ ứng dụng sử dụng.
final refreshManager = RefreshManager();

class MainShell extends StatelessWidget {
  final StatefulNavigationShell navigationShell;

  const MainShell({
    super.key,
    required this.navigationShell,
  });

  // Hàm để chuyển tab
  void _onTap(BuildContext context, int index) {
    final isTappedAgain = index == navigationShell.currentIndex;

    // THAY ĐỔI: Nếu nhấn lại vào tab hiện tại, hãy gửi yêu cầu làm mới.
    if (isTappedAgain) {
      refreshManager.requestRefresh(index);
    } else {
      // Nếu là tab khác, chỉ chuyển tab như bình thường.
      navigationShell.goBranch(
        index,
        initialLocation: false, // Không cần reset stack khi chuyển tab
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // 1. Nội dung của các tab được hiển thị ở đây
      body: navigationShell,
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.push("/camera"),
        shape: const CircleBorder(),
        backgroundColor: appColorScheme(context).primary,
        child: const Icon(
          CupertinoIcons.camera,
        ),
      ),

      // 3. BottomAppBar thay thế cho PersistentTabView
      bottomNavigationBar: BottomAppBar(
        padding: const EdgeInsets.all(0),
        height: kBottomNavigationBarHeight,
        color: Theme.of(context).scaffoldBackgroundColor,
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

            // Item 3
            _buildTabItem(
              context: context,
              activeIcon: AppIcons.rocketFill.toSvg(
                color: Theme.of(context).colorScheme.primary,
              ),
              icon: AppIcons.rocketLine.toSvg(
                color: appColorScheme(context).onSurface,
              ),
              index: 1,
            ),

            Expanded(
              child: GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () {
                  _onTap(context, 2);
                },
                child: CustomBadge(
                  child: AnimatedScale(
                    // 1. Điều khiển tỷ lệ phóng to/thu nhỏ
                    scale: navigationShell.currentIndex == 2 ? 1.25 : 1.0,

                    // 2. Thời gian diễn ra animation
                    duration: const Duration(milliseconds: 200),

                    // 3. Kiểu đường cong animation (tùy chọn, để mượt hơn)
                    curve: Curves.easeIn,
                    child: Align(
                      alignment: Alignment.center,
                      child: navigationShell.currentIndex == 2
                          ? AppIcons.chatFilled.toSvg(
                              color: Theme.of(context).colorScheme.primary,
                            )
                          : AppIcons.chat3.toSvg(
                              color: appColorScheme(context).onSurface,
                            ),
                    ),
                  ),
                ),
              ),
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
