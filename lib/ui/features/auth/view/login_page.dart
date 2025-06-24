import 'package:dishlocal/app/theme/custom_colors.dart';
import 'package:dishlocal/app/theme/app_icons.dart';
import 'package:dishlocal/app/theme/theme.dart';
import 'package:dishlocal/data/categories/app_user/repository/failure/app_user_failure.dart';
import 'package:dishlocal/ui/features/auth/bloc/auth_bloc.dart';
import 'package:dishlocal/ui/widgets/element_widgets/custom_loading_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<AuthBloc, AuthState>(
        // Lắng nghe sự thay đổi trạng thái để hiển thị SnackBar, v.v.
        listener: (context, state) {
          // Chỉ lắng nghe khi state là Failure
          // Các trạng thái thành công (Authenticated, NewUser) sẽ được GoRouter xử lý tự động
          switch (state) {
            case Failure(failure: final f): // Sử dụng pattern matching
              // "Dịch" lỗi sang thông báo thân thiện
              final message = switch (f) {
                SignInCancelledFailure() => 'Bạn đã hủy đăng nhập.',
                SignInServiceFailure(message: final msg) => msg,
                _ => 'Đăng nhập thất bại. Vui lòng thử lại.',
              };

              ScaffoldMessenger.of(context)
                ..hideCurrentSnackBar()
                ..showSnackBar(
                  SnackBar(
                    content: Text(message),
                    behavior: SnackBarBehavior.floating,
                    backgroundColor: Theme.of(context).colorScheme.error,
                  ),
                );
              break;
            default:
              // Không làm gì với các state khác
              break;
          }
        },
        child: BlocBuilder<AuthBloc, AuthState>(
          // Builder để xây dựng UI dựa trên trạng thái
          builder: (context, state) {
            // Nếu đang trong quá trình đăng nhập, hiển thị loading indicator
            // và vô hiệu hóa nút bấm để tránh người dùng nhấn nhiều lần.
            final bool isLoading = state is InProgress;

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
                      // ... (Toàn bộ phần UI logo và text của bạn giữ nguyên) ...
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
                        child: AppIcons.app.toSvg(),
                      ),
                      const SizedBox(height: 10),
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
                      const SizedBox(height: 10),
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

                  // Nút Đăng nhập
                  if (isLoading)
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 12.0),
                      child: CustomLoadingIndicator(indicatorSize: 40),
                    )
                  else
                    FilledButton.icon(
                      onPressed: () {
                        // Gửi event đến BLoC
                        context.read<AuthBloc>().add(const SignInWithGoogleRequested());
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

                  const SizedBox(height: 15),
                  Text(
                    'Đăng nhập để tiếp tục...',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
