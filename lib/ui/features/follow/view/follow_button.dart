import 'package:dishlocal/app/theme/theme.dart';
import 'package:dishlocal/core/dependencies_injection/service_locator.dart';
import 'package:dishlocal/data/categories/app_user/model/app_user.dart';
import 'package:dishlocal/ui/features/follow/bloc/follow_bloc.dart';
import 'package:dishlocal/ui/features/view_post/view/post_detail_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FollowButton extends StatelessWidget {
  const FollowButton({super.key, required this.targetUser});
  final AppUser targetUser;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<FollowBloc>(param1: targetUser),
      child: BlocBuilder<FollowBloc, FollowState>(
        builder: (context, state) {
// Lấy trạng thái isFollowing từ BLoC thay vì từ state cục bộ
          final isFollowing = state.isFollowing;
          final primary = appColorScheme(context).primary;
          final onPrimary = appColorScheme(context).onPrimary;
          final surface = appColorScheme(context).surface;
          final onSurface = appColorScheme(context).onSurface;

          final backgroundColor = isFollowing ? surface : primary;
          final textColor = isFollowing ? onSurface : onPrimary;

          return GestureDetector(
            // THAY ĐỔI: Gửi sự kiện tới BLoC khi người dùng nhấn vào
            onTap: () {
              context.read<FollowBloc>().add(const FollowEvent.followToggled());
            },
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 150),
              curve: Curves.easeInOut,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: backgroundColor,
                borderRadius: BorderRadius.circular(1000),
                border: Border.all(
                  color: isFollowing ? primary : Colors.transparent,
                  width: 1,
                ),
              ),
              child: AnimatedSize(
                duration: const Duration(milliseconds: 150),
                curve: Curves.easeInOut,
                alignment: Alignment.center,
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 100),
                  transitionBuilder: (child, animation) {
                    final offsetAnimation = Tween<Offset>(
                      begin: const Offset(0, 0.3),
                      end: Offset.zero,
                    ).animate(animation);
                    return FadeTransition(
                      opacity: animation,
                      child: SlideTransition(position: offsetAnimation, child: child),
                    );
                  },
                  child: Text(
                    isFollowing ? 'Đang theo dõi' : 'Theo dõi',
                    // Điểm mấu chốt để AnimatedSwitcher hoạt động đúng là key phải thay đổi
                    key: ValueKey(isFollowing),
                    style: Theme.of(context).textTheme.labelMedium!.copyWith(
                          color: textColor,
                          fontWeight: FontWeight.w500,
                        ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
