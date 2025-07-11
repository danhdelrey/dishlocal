import 'dart:async';

import 'package:dishlocal/app/config/main_shell.dart';
import 'package:dishlocal/data/categories/address/model/address.dart';
import 'package:dishlocal/data/categories/direction/model/location_data.dart';
import 'package:dishlocal/data/categories/post/model/filter_sort_model/filter_sort_params.dart';
import 'package:dishlocal/data/categories/post/model/post.dart';
import 'package:dishlocal/ui/features/auth/bloc/auth_bloc.dart';
import 'package:dishlocal/ui/features/auth/view/login_page.dart';
import 'package:dishlocal/ui/features/camera/view/camera_page.dart';
import 'package:dishlocal/ui/features/create_post/view/new_post_page.dart';
import 'package:dishlocal/ui/features/explore/view/explore_page.dart';
import 'package:dishlocal/ui/features/home/view/home_page.dart';
import 'package:dishlocal/ui/features/map/view/map_page.dart';
import 'package:dishlocal/ui/features/suggestion_search/view/search_input_page.dart';
import 'package:dishlocal/ui/features/result_search/view/search_result_page.dart';
import 'package:dishlocal/ui/features/user_info/view/profile_page.dart';
import 'package:dishlocal/ui/features/account_setup/view/account_setup_page.dart';
import 'package:dishlocal/ui/features/view_post/view/post_detail_page.dart';
import 'package:dishlocal/ui/features/rating/view/rating_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:logging/logging.dart';
import 'package:uuid/uuid.dart';

class AppRouter {
  final AuthBloc authBloc;
  AppRouter(this.authBloc);

  final _log = Logger('AppRouter');

  late final router = GoRouter(
    initialLocation: '/sorting',
    refreshListenable: GoRouterRefreshStream(authBloc.stream), // Lắng nghe BLoC
    redirect: _redirect,
    routes: [
      GoRoute(
        path: '/sorting',
        builder: (context, state) => const RatingPage(),
      ),
      GoRoute(
        path: '/login',
        builder: (context, state) => const LoginPage(),
      ),
      GoRoute(
        path: '/search_input',
        builder: (context, state) => const SearchInputPage(),
      ),

      GoRoute(
        path: '/search_result',
        builder: (context, state) {
          final extraMap = state.extra as Map<String, dynamic>;
          final String query = extraMap['query'];
          return SearchResultScreen(query: query);
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
        ],
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
          GoRoute(
            path: 'explore',
            builder: (context, state) {
              final extraMap = state.extra as Map<String, dynamic>;
              final FilterSortParams filterSortParams = extraMap['filterSortParams'];
              return ExplorePage(
                initialFilterSortParams: filterSortParams,
              );
            },
          ),
        ],
      ),
      GoRoute(
        path: '/camera',
        builder: (context, state) => CameraPage(),
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
      GoRoute(
        path: '/map',
        builder: (context, state) {
          final extraMap = state.extra as Map<String, dynamic>;
          final LocationData destination = extraMap['destination'];
          final String destinationName = extraMap['destinationName'];
          return MapPage(
            destination: destination,
            destinationName: destinationName,
          );
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
          // Branch 1: Tìm kiếm
          // StatefulShellBranch(
          //   routes: [
          //     GoRoute(
          //       path: '/search', // Đặt tên route rõ ràng
          //       builder: (context, state) => const SearchInputPage(), // Dùng page tương ứng
          //     ),
          //   ],
          // ),

          // Branch 1: Khám phá
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/explore',
                builder: (context, state) => const ExplorePage(),
              ),
            ],
          ),
          // Branch 2: Cá nhân
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

  FutureOr<String?> _redirect(BuildContext context, GoRouterState state) {
    final authState = authBloc.state;
    final currentLocation = state.matchedLocation;

    // Các đường dẫn được bảo vệ (yêu cầu đăng nhập)
    final protectedRoutes = ['/home', '/profile', '/camera', '/edit_post', '/explore'];

    _log.info('🔁 [REDIRECT] Đang xử lý điều hướng...');
    _log.info('📍 Vị trí hiện tại: $currentLocation');
    _log.info('🔐 Trạng thái xác thực hiện tại: ${authState.runtimeType}');

    // =====================================================================
    // Logic điều hướng dựa trên AuthState
    // =====================================================================

    // 1. Trạng thái ban đầu hoặc đang xử lý -> không làm gì, đợi state mới
    // Thường UI sẽ hiển thị một màn hình chờ (Splash/Loading) ở đây.
    if (authState is Initial || authState is InProgress) {
      _log.info('⏳ Trạng thái Initial/InProgress. Không điều hướng, đợi state tiếp theo.');
      return null; // Giữ nguyên vị trí hiện tại
    }

    // 2. Người dùng CHƯA ĐĂNG NHẬP (Unauthenticated)
    // Nếu họ đang cố vào một trang được bảo vệ, chuyển hướng về /login
    if (authState is Unauthenticated) {
      if (protectedRoutes.contains(currentLocation)) {
        _log.info('🚫 Người dùng chưa đăng nhập, cố vào trang được bảo vệ. Chuyển hướng về /login.');
        return '/login';
      }
      _log.info('✅ Người dùng chưa đăng nhập và đang ở trang công khai (login, etc). Giữ nguyên.');
      return null;
    }

    // 3. Người dùng là NGƯỜI DÙNG MỚI (NewUser), cần setup profile
    // Bất kể họ đang ở đâu, nếu chưa ở trang setup, hãy đưa họ về đó.
    if (authState is NewUser) {
      if (currentLocation != '/account_setup') {
        _log.info('✨ Người dùng mới, cần setup. Chuyển hướng đến /account_setup.');
        return '/account_setup';
      }
      _log.info('✅ Người dùng mới và đã ở trang /account_setup. Giữ nguyên.');
      return null;
    }

    // 4. Người dùng ĐÃ ĐĂNG NHẬP HOÀN CHỈNH (Authenticated)
    // Nếu họ đang ở trang login hoặc setup, đưa họ vào trong ứng dụng (trang chủ).
    if (authState is Authenticated) {
      if (currentLocation == '/login' || currentLocation == '/account_setup') {
        _log.info('🔓 Người dùng đã đăng nhập, rời khỏi trang login/setup. Chuyển hướng về /home.');
        return '/home';
      }
      _log.info('✅ Người dùng đã đăng nhập và đang ở trang phù hợp. Giữ nguyên.');
      return null;
    }

    // 5. Trường hợp có LỖI (Failure) hoặc các trạng thái khác
    // Thường không cần điều hướng, chỉ giữ nguyên vị trí.
    _log.warning('❗ Không có điều kiện điều hướng nào được áp dụng. Giữ nguyên.');
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
