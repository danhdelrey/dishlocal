import 'package:dishlocal/app/config/main_shell.dart';
import 'package:dishlocal/app/theme/app_icons.dart';
import 'package:dishlocal/app/theme/custom_colors.dart';
import 'package:dishlocal/ui/features/home/view/home_page.dart';
import 'package:dishlocal/ui/features/login/view/login_page.dart';
import 'package:dishlocal/ui/features/profile/view/profile_page.dart';
import 'package:dishlocal/ui/features/update_profile/view/account_setup_page.dart';
import 'package:dishlocal/ui/features/view_post/view/post_detail_page.dart';
import 'package:dishlocal/ui/widgets/custom_badge.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';
import 'package:badges/badges.dart' as badges;

// GoRouter router = GoRouter(
//   initialLocation: '/home',
//   routes: [
//     GoRoute(
//       path: '/login',
//       builder: (context, state) => const LoginPage(),
//     ),
//     GoRoute(
//       path: '/account_setup',
//       builder: (context, state) => const AccountSetupPage(),
//     ),
//     StatefulShellRoute.indexedStack(
//       builder: (context, state, navigationShell) {
//         // UI "khung" chứa PersistentTabView.router
//         return PersistentTabView.router(
          
//           tabs: [
//             PersistentRouterTabConfig(
//               item: ItemConfig(
//                 icon: AppIcons.home4.toSvg(
//                   color: Theme.of(context).colorScheme.primary,
//                 ),
//                 inactiveIcon: AppIcons.home41.toSvg(
//                   color: Theme.of(context).colorScheme.outline,
//                 ),
//               ),
//             ),
//             PersistentRouterTabConfig(
//               item: ItemConfig(
//                 icon: AppIcons.rocketFill.toSvg(
//                   color: Theme.of(context).colorScheme.primary,
//                 ),
//                 inactiveIcon: AppIcons.rocketLine.toSvg(
//                   color: Theme.of(context).colorScheme.outline,
//                 ),
//               ),
//             ),
//             PersistentRouterTabConfig(
//               item: ItemConfig(
//                 icon: AppIcons.fabGradient.toSvg(),
//                 activeForegroundColor: Colors.transparent,
//               ),
//             ),
//             PersistentRouterTabConfig(
//               item: ItemConfig(
//                 icon: AppIcons.mail.toSvg(
//                   color: Theme.of(context).colorScheme.primary,
//                 ),
//                 inactiveIcon: CustomBadge(
//                   showBadge: false,
//                   child: AppIcons.mail1.toSvg(
//                     color: Theme.of(context).colorScheme.outline,
//                   ),
//                 ),
//               ),
//             ),
//             PersistentRouterTabConfig(
//               item: ItemConfig(
//                 icon: AppIcons.user3.toSvg(
//                   color: Theme.of(context).colorScheme.primary,
//                 ),
//                 inactiveIcon: AppIcons.user31.toSvg(
//                   color: Theme.of(context).colorScheme.outline,
//                 ),
//               ),
//             ),
//           ],
//           navBarBuilder: (navBarConfig) => Style6BottomNavBar(
//             navBarConfig: navBarConfig,
//             navBarDecoration: NavBarDecoration(
//               color: Theme.of(context).colorScheme.surface,
//             ),
//           ),
//           navigationShell: navigationShell,
//         );
//       },
//       branches: [
//         StatefulShellBranch(
//           routes: [
//             GoRoute(
//               path: '/home',
//               builder: (context, state) => const HomePage(),
//             ),
//           ],
//         ),
//         StatefulShellBranch(
//           routes: [
//             GoRoute(
//               path: '/teset',
//               builder: (context, state) => const HomePage(),
//             ),
//           ],
//         ),
//         StatefulShellBranch(
//           routes: [
//             GoRoute(
//               path: '/rtertgfer',
//               builder: (context, state) => const HomePage(),
//             ),
//           ],
//         ),
//         StatefulShellBranch(
//           routes: [
//             GoRoute(
//               path: '/rterter',
//               builder: (context, state) => const HomePage(),
//             ),
//           ],
//         ),
//         StatefulShellBranch(
//           routes: [
//             GoRoute(
//               path: '/bcvbv',
//               builder: (context, state) => const HomePage(),
//             ),
//           ],
//         ),
//       ],
//     )
//   ],
// );

final GoRouter router = GoRouter(
  initialLocation: '/home',
  routes: [
    // Route này nằm ngoài ShellRoute, nên nó sẽ che toàn bộ màn hình
    GoRoute(
      path: '/post_detail',
      builder: (context, state) => const PostDetailPage(),
    ),
    GoRoute(
      path: '/login',
      builder: (context, state) => const LoginPage(),
    ),
    GoRoute(
      path: '/account_setup',
      builder: (context, state) => const AccountSetupPage(),
    ),

    // Sử dụng MainShell thay vì PersistentTabView.router
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) {
        // Trả về widget "khung" mà chúng ta vừa tạo
        return MainShell(navigationShell: navigationShell);
      },
      branches: [
        // Branch 0: Trang chủ
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/home',
              builder: (context, state) => const HomePage(),
            ),
          ],
        ),
        // Branch 1: Khám phá
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/explore', // Đặt tên route rõ ràng
              builder: (context, state) =>
                  const SizedBox(), // Dùng page tương ứng
            ),
          ],
        ),
        
        // Branch 2: Tin nhắn
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/messages',
              builder: (context, state) => const SizedBox(),
            ),
          ],
        ),
        // Branch 3: Cá nhân
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/profile',
              builder: (context, state) => const ProfilePage(),
            ),
          ],
        ),
      ],
    ),
  ],
);
