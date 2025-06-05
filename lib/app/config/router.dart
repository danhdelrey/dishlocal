import 'package:dishlocal/ui/features/home/view/home_page.dart';
import 'package:dishlocal/ui/features/login/view/login_page.dart';
import 'package:dishlocal/ui/features/update_profile/view/account_setup_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';

GoRouter router = GoRouter(
  initialLocation: '/home',
  routes: [
    GoRoute(
      path: '/login',
      builder: (context, state) => const LoginPage(),
    ),
    GoRoute(
      path: '/account_setup',
      builder: (context, state) => const AccountSetupPage(),
    ),
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) {
        // UI "khung" chứa PersistentTabView.router
        return PersistentTabView.router(
          tabs: [
            PersistentRouterTabConfig(
              item: ItemConfig(icon: const Icon(Icons.home), title: "Home"),
            ),
            PersistentRouterTabConfig(
              item: ItemConfig(icon: const Icon(Icons.list), title: "Products"),
            ),
            PersistentRouterTabConfig(
              item: ItemConfig(
                  icon: const Icon(Icons.settings), title: "Settings"),
            ),
          ],
          navBarBuilder: (navBarConfig) => Style1BottomNavBar(
            navBarConfig: navBarConfig,
          ),
          navigationShell: navigationShell,
        );
      },
      branches: [
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/home',
              builder: (context, state) => const HomePage(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/teset',
              builder: (context, state) => const HomePage(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/sdggf',
              builder: (context, state) => const HomePage(),
            ),
          ],
        ),
      ],
    )
  ],
);
