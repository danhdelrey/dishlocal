import 'package:dishlocal/app/theme/custom_colors.dart';
import 'package:dishlocal/app/theme/app_icons.dart';
import 'package:dishlocal/app/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(
              height: 200,
            ),
            Column(
              children: [
                Container(
                  width: 100,
                  height: 100,
                  padding: const EdgeInsets.all(15),
                  decoration: const BoxDecoration(
                    gradient: primaryGradient,
                    borderRadius: BorderRadius.all(
                      Radius.circular(28),
                    ),
                  ),
                  // Màu nền để dễ thấy
                  child: AppIcons.app.toSvg(),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  'DishLocal',
                  style: Theme.of(context).textTheme.headlineLarge!.copyWith(fontWeight: FontWeight.w800),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  'Chia sẻ & Khám phá trực tiếp',
                  style: Theme.of(context).textTheme.titleLarge,
                  textAlign: TextAlign.center,
                ),
                Text(
                  'ẩm thực quanh bạn',
                  style: Theme.of(context).textTheme.titleLarge,
                  textAlign: TextAlign.center,
                ),
              ],
            ),
            const Expanded(child: SizedBox()),
            FilledButton.icon(
              onPressed: () {
                context.go('/account_setup');
              },
              label: Text(
                'Đăng nhập bằng tài khoản Google',
                style: appTextTheme(context).labelLarge!.copyWith(
                      color: Colors.black,
                    ),
              ),
              icon: AppIcons.google.toSvg(
                width: 20,
              ),
              style: FilledButton.styleFrom(
                backgroundColor: Colors.white,
                padding: const EdgeInsetsDirectional.only(
                  top: 10,
                  bottom: 10,
                  start: 12,
                  end: 12,
                ),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Text(
              'Đăng nhập để tiếp tục...',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}
