import 'dart:async';

import 'package:dishlocal/app/config/main_shell.dart';
import 'package:dishlocal/data/categories/address/model/address.dart';
import 'package:dishlocal/data/categories/post/model/post.dart';
import 'package:dishlocal/ui/features/auth/bloc/auth_bloc.dart';
import 'package:dishlocal/ui/features/auth/view/login_page.dart';
import 'package:dishlocal/ui/features/camera/view/camera_page.dart';
import 'package:dishlocal/ui/features/create_post/view/new_post_page.dart';
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
    initialLocation: '/home',
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
            final Post post = extraMap['post'];
            return PostDetailPage(
              post: post,
            );
          },
          routes: [
            GoRoute(
              path: 'profile',
              builder: (context, state) {
                final extraMap = state.extra as Map<String, dynamic>;
                final String userId = extraMap['userId'];
                return ProfilePage(
                  userId: userId,
                );
              },
            ),
          ]),
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
              final String blurHash = extraMap['blurHash'];
              return NewPostPage.create(
                imagePath: imagePath,
                address: address,
                blurHash: blurHash,
              );
            },
          ),
        ],
      ),

      GoRoute(
        path: '/edit_post',
        builder: (context, state) {
          final postToUpdate = state.extra as Post;
          return NewPostPage.edit(postToUpdate: postToUpdate);
        },
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
    final currentLocation = state.matchedLocation;

    final isLogin = currentLocation == '/login';
    final isSetup = currentLocation == '/account_setup';

    _log.info('🔁 [REDIRECT] Đang xử lý điều hướng...');
    _log.info('📍 Vị trí hiện tại: $currentLocation');
    _log.info('🔐 Trạng thái xác thực hiện tại: ${authState.runtimeType}');

    

    // 🔐 2. Người dùng chưa đăng nhập
    if (authState is Unauthenticated) {
      if (!isLogin) {
        _log.info('🚫 Người dùng chưa đăng nhập. Chuyển hướng về /login.');
        return '/login';
      }
      _log.info('✅ Người dùng chưa đăng nhập nhưng đã ở /login → giữ nguyên.');
      return null;
    }

    // 🧑 3. Người dùng cần setup username
    if (authState is NeedsUsername) {
      if (!isSetup) {
        _log.info('🛠️ Người dùng cần cài đặt username. Chuyển hướng đến /account_setup.');
        return '/account_setup';
      }
      _log.info('✅ Người dùng đang ở trang /account_setup → giữ nguyên.');
      return null;
    }

    // 🏠 4. Người dùng đã đăng nhập hoàn chỉnh
    if (authState is Authenticated) {
      if (isLogin || isSetup) {
        _log.info('🔓 Người dùng đã đăng nhập hoàn chỉnh. Rời khỏi login/setup → chuyển về /home.');
        return '/home';
      }

      _log.info('✅ Người dùng đã xác thực và đang ở trang phù hợp → giữ nguyên.');
      return null;
    }

    // ❓ 5. Không khớp điều kiện nào
    _log.warning('❗ Không có điều kiện nào thỏa mãn trong redirect → giữ nguyên.');
    return null;
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
