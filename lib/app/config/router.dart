import 'package:dishlocal/app/config/main_shell.dart';
import 'package:dishlocal/data/categories/address/model/address.dart';
import 'package:dishlocal/ui/features/camera/view/camera_page.dart';
import 'package:dishlocal/ui/features/home/view/home_page.dart';
import 'package:dishlocal/ui/features/auth/view/login_page.dart';
import 'package:dishlocal/ui/features/dining_info_input/view/new_post_page.dart';
import 'package:dishlocal/ui/features/profile/view/profile_page.dart';
import 'package:dishlocal/ui/features/update_profile/view/account_setup_page.dart';
import 'package:dishlocal/ui/features/view_post/view/post_detail_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

final GoRouter router = GoRouter(
  initialLocation: '/login',
  routes: [
    GoRoute(
      path: '/login',
      builder: (context, state) => const LoginPage(),
    ),
    GoRoute(
      path: '/account_setup',
      builder: (context, state) => const AccountSetupPage(),
    ),
    GoRoute(
      path: '/post_detail',
      builder: (context, state) {
        final extraMap = state.extra as Map<String, dynamic>;
        final int postId = extraMap['postId'];
        return PostDetailPage(
          postId: postId,
        );
      },
    ),
    GoRoute(
      path: '/camera',
      builder: (context, state) => const CameraPage(),
      routes: [
        GoRoute(
          path: 'new_post',
          builder: (context, state) {
            final extraMap = state.extra as Map<String, dynamic>;
            final String imagePath = extraMap['imagePath'];
            final Address address = extraMap['address'];
            return NewPostPage(
              imagePath: imagePath,
              address: address,
            );
          },
        ),
      ],
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
        // StatefulShellBranch(
        //   routes: [
        //     GoRoute(
        //       path: '/explore', // Đặt tên route rõ ràng
        //       builder: (context, state) => const SizedBox(), // Dùng page tương ứng
        //     ),
        //   ],
        // ),

        // Branch 2: Tin nhắn
        // StatefulShellBranch(
        //   routes: [
        //     GoRoute(
        //       path: '/messages',
        //       builder: (context, state) => const SizedBox(),
        //     ),
        //   ],
        // ),
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
