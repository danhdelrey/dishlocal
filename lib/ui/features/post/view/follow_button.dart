import 'package:dishlocal/app/theme/theme.dart';
import 'package:dishlocal/ui/features/post/view/post_detail_page.dart';
import 'package:flutter/material.dart';

class FollowButton extends StatefulWidget {
  const FollowButton({super.key});

  @override
  State<FollowButton> createState() => _FollowButtonState();
}

class _FollowButtonState extends State<FollowButton> with TickerProviderStateMixin {
  bool isFollowing = false;

  void _toggleFollow() {
    setState(() {
      isFollowing = !isFollowing;
    });
  }

  @override
  Widget build(BuildContext context) {
    final primary = appColorScheme(context).primary;
    final onPrimary = appColorScheme(context).onPrimary;
    final surface = appColorScheme(context).surface;
    final onSurface = appColorScheme(context).onSurface;

    final backgroundColor = isFollowing ? surface : primary;
    final textColor = isFollowing ? onSurface : onPrimary;

    return GestureDetector(
      onTap: _toggleFollow,
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
  }
}
