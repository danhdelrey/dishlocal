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

            return Container(
              width: double.infinity,
              height: double.infinity,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/bg_image.png'),
                  fit: BoxFit.cover,
                  opacity: 0.6,
                ),
              ),
              child: Stack(
                children: [
                  Positioned.fill(
                    child: Align(
                      alignment: Alignment.center,
                      child: _buildLogo(context),
                    ),
                  ),
                  Positioned.fill(
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: _buildLoginButton(isLoading, context),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Column _buildLogo(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
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
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 10,
                offset: Offset(0, 4), // Đổ bóng xuống dưới
              ),
            ],
          ),
          child: AppIcons.app.toSvg(),
        ),
        const SizedBox(height: 30),
        Text(
          'Chia sẻ & Khám phá',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.w700,
              ),
          textAlign: TextAlign.center,
        ),
        Text(
          'ẩm thực quanh bạn',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.w700,
              ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Column _buildLoginButton(bool isLoading, BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (isLoading)
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(28),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 10,
                  offset: Offset(0, 4), // Đổ bóng xuống dưới
                ),
              ],
            ),
            child: const Padding(
              padding: EdgeInsets.symmetric(vertical: 4, horizontal: 15),
              child: CustomLoadingIndicator(indicatorSize: 24),
            ),
          )
        else
          Container(
            decoration: const BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 10,
                  offset: Offset(0, 4), // Đổ bóng xuống dưới
                ),
              ],
            ),
            child: FilledButton.icon(
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
          ),
        const SizedBox(height: 15),
        Text(
          'Đăng nhập để tiếp tục...',
          style: Theme.of(context).textTheme.labelLarge?.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.w700,
              ),
        ),
        const SizedBox(height: 40),
      ],
    );
  }
}
