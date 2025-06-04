import 'package:dishlocal/ui/features/home/view/home_page.dart';
import 'package:dishlocal/ui/features/login/view/login_page.dart';
import 'package:dishlocal/ui/features/update_profile/view/update_profile_page.dart';
import 'package:go_router/go_router.dart';

GoRouter router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const LoginPage(),
    ),
    GoRoute(
      path: '/home_page',
      builder: (context, state) => const HomePage(),
    ),
    GoRoute(
      path: '/update_profile_page',
      builder: (context, state) => const UpdateProfilePage(),
    )
  ],
);
