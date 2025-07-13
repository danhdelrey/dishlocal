import 'package:dishlocal/app/theme/theme.dart';
import 'package:dishlocal/core/dependencies_injection/service_locator.dart';
import 'package:dishlocal/data/categories/app_user/model/app_user.dart';
import 'package:dishlocal/ui/features/follow/bloc/follow_bloc.dart';
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
          final isFollowing = state.isFollowing;
          final primary = appColorScheme(context).primary;
          final surface = appColorScheme(context).surface;

          // Xác định style cho từng trạng thái
          final BoxDecoration decoration;
          final Color iconAndTextColor;

          if (isFollowing) {
            // Style khi ĐANG THEO DÕI (giống style nút có viền)
            decoration = BoxDecoration(
              color: surface,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: primary, width: 1.5),
            );
            iconAndTextColor = primary;
          } else {
            // Style khi CHƯA THEO DÕI (style gradient)
            decoration = BoxDecoration(
              gradient: const LinearGradient(
                colors: [
                  Color(0xFFfc6076), // Cam nhạt dịu
                  Color(0xFFff9a44), // Hồng đào ấm áp
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(8),
            );
            iconAndTextColor = Colors.white;
          }

          return GestureDetector(
            onTap: () {
              context.read<FollowBloc>().add(const FollowEvent.followToggled());
            },
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              curve: Curves.easeInOut,
              // Áp dụng padding mới
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              // Decoration thay đổi linh hoạt theo trạng thái
              decoration: decoration,
              child: AnimatedSize(
                duration: const Duration(milliseconds: 200),
                curve: Curves.easeInOut,
                alignment: Alignment.center,
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 150),
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
                  // THAY ĐỔI QUAN TRỌNG:
                  // Child bây giờ là một Row chứa Icon và Text.
                  // `key` được đặt trên Row để AnimatedSwitcher hoạt động.
                  child: Row(
                    key: ValueKey(isFollowing), // Điểm mấu chốt cho animation
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Icon thay đổi theo trạng thái
                      Icon(
                        isFollowing ? Icons.check : Icons.add,
                        color: iconAndTextColor,
                        size: 18,
                      ),
                      const SizedBox(width: 8),
                      // Text thay đổi theo trạng thái
                      Text(
                        isFollowing ? 'Đang theo dõi' : 'Theo dõi',
                        style: Theme.of(context).textTheme.labelMedium!.copyWith(
                              color: iconAndTextColor,
                              fontWeight: FontWeight.bold, // Làm chữ đậm hơn cho nổi bật
                            ),
                      ),
                    ],
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
