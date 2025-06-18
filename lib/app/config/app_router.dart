import 'dart:async';

import 'package:dishlocal/app/config/main_shell.dart';
import 'package:dishlocal/data/categories/address/model/address.dart';
import 'package:dishlocal/ui/features/auth/bloc/auth_bloc.dart';
import 'package:dishlocal/ui/features/auth/view/login_page.dart';
import 'package:dishlocal/ui/features/camera/view/camera_page.dart';
import 'package:dishlocal/ui/features/dining_info_input/view/new_post_page.dart';
import 'package:dishlocal/ui/features/home/view/home_page.dart';
import 'package:dishlocal/ui/features/user_info/view/profile_page.dart';
import 'package:dishlocal/ui/features/account_setup/view/account_setup_page.dart';
import 'package:dishlocal/ui/features/view_post/view/post_detail_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:logging/logging.dart';

class AppRouter {
  final AuthBloc authBloc;
  AppRouter(this.authBloc);

  final _log = Logger('AppRouter');

  late final router = GoRouter(
    initialLocation: '/login',
    refreshListenable: GoRouterRefreshStream(authBloc.stream), // Lắng nghe BLoC
    redirect: redirect,
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

  FutureOr<String?> redirect(BuildContext context, GoRouterState state) {
    
    final authState = authBloc.state;
    final isLoggingIn = state.matchedLocation == '/login';
    final isSettingUpAccount = state.matchedLocation == '/account_setup';

    _log.info("Bắt đầu logic điều hướng (redirect). Vị trí đang cố gắng truy cập: '${state.matchedLocation}'.");
    _log.fine("Trạng thái xác thực hiện tại: ${authState.runtimeType}. "
        "Đang ở trang đăng nhập: $isLoggingIn. "
        "Đang ở trang cài đặt tài khoản: $isSettingUpAccount.");

    // Khi chưa xác thực, điều hướng đến login
    if (authState is Unauthenticated && !isLoggingIn) {
      _log.info("-> Điều kiện THỎA MÃN: Người dùng chưa xác thực và không ở trang đăng nhập. Chuyển hướng đến '/login'.");
      return '/login';
    }

    // Khi cần tạo username, điều hướng đến màn hình tạo
    if (authState is NeedsUsername && !isSettingUpAccount) {
      _log.info("-> Điều kiện THỎA MÃN: Người dùng cần tạo username và không ở trang cài đặt. Chuyển hướng đến '/account_setup'.");
      return '/account_setup';
    }

    // Khi đã xác thực và có username, điều hướng đến home
    if (authState is Authenticated && (isLoggingIn || isSettingUpAccount)) {
      _log.info("-> Điều kiện THỎA MÃN: Người dùng đã xác thực và đang truy cập trang đăng nhập hoặc cài đặt. Chuyển hướng đến '/home'.");
      return '/home';
    }

    _log.info("-> Không có điều kiện nào thỏa mãn. KHÔNG thực hiện chuyển hướng, cho phép truy cập '${state.matchedLocation}'.");
    return null; // Không cần điều hướng
  }
}

// Helper class để GoRouter lắng nghe stream của BLoC
class GoRouterRefreshStream extends ChangeNotifier {
  final _log = Logger('GoRouterRefreshStream');

  GoRouterRefreshStream(Stream<dynamic> stream) {
    _log.info('Khởi tạo GoRouterRefreshStream. Lớp này sẽ lắng nghe một stream và kích hoạt GoRouter làm mới (refresh).');

    // Log cho lần gọi notifyListeners() đầu tiên
    _log.fine('Thực hiện gọi `notifyListeners()` ngay lập tức để kích hoạt logic `redirect` của GoRouter lần đầu tiên khi ứng dụng khởi động.');
    notifyListeners();

    // Log cho việc bắt đầu lắng nghe stream
    _log.info('Bắt đầu đăng ký lắng nghe (subscribe) vào stream đầu vào.');
    stream.asBroadcastStream().listen((_) {
      // Log mỗi khi stream phát ra một sự kiện mới
      _log.fine('Stream đã phát ra một sự kiện mới. Đang gọi `notifyListeners()` để thông báo cho GoRouter rằng cần đánh giá lại các điều hướng (redirect).');
      notifyListeners();
    });
  }
}
