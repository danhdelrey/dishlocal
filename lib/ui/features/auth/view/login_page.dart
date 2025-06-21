import 'package:dishlocal/app/theme/custom_colors.dart';
import 'package:dishlocal/app/theme/app_icons.dart';
import 'package:dishlocal/app/theme/theme.dart';
import 'package:dishlocal/ui/features/auth/bloc/auth_bloc.dart';
import 'package:dishlocal/ui/widgets/element_widgets/custom_loading_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthFailure) {
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                const SnackBar(
                  content: Text(
                    'Đăng nhập thất bại',
                  ),
                  behavior: SnackBarBehavior.floating,
                ),
              );
          } else if (state is Authenticated) {
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                const SnackBar(
                  content: Text(
                    'Đăng nhập thành công!',
                  ),
                  behavior: SnackBarBehavior.floating,
                ),
              );
          }
        },
        child: BlocBuilder<AuthBloc, AuthState>(
          builder: (context, state) {
            if (state is AuthLoading) {
              return const Center(
                child: CustomLoadingIndicator(indicatorSize: 40),
              );
            }
            return SizedBox(
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
                      ShaderMask(
                        shaderCallback: (bounds) => primaryGradient.createShader(Rect.fromLTWH(0, 0, bounds.width, bounds.height)),
                        child: const Text(
                          'DishLocal',
                          style: TextStyle(
                            fontFamily: 'SFProDisplay',
                            fontWeight: FontWeight.w700,
                            fontSize: 40,
                          ),
                        ),
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
                      context.read<AuthBloc>().add(GoogleSignInRequested());
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
            );
          },
        ),
      ),
    );
  }
}
