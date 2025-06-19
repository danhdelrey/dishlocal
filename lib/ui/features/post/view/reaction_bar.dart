import 'package:dishlocal/app/theme/app_icons.dart';
import 'package:dishlocal/ui/widgets/element_widgets/custom_icon_with_label.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ReactionBar extends StatelessWidget {
  const ReactionBar({
    super.key,
    required this.likeCount,
    required this.saveCount,
  });

  final int likeCount;
  final int saveCount;

  @override
  Widget build(BuildContext context) {
    return const Row(
      children: [
        LikeButton(likeCount: 0),
        SizedBox(
          width: 20,
        ),
        LikeButton(likeCount: 0),
      ],
    );
  }
}

class AnimatedSwitcherIconWithLabel extends StatelessWidget {
  final Widget icon;
  final String label;
  final Color labelColor;

  const AnimatedSwitcherIconWithLabel({
    super.key,
    required this.icon,
    required this.label,
    required this.labelColor,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        AnimatedSwitcher(
          duration: const Duration(milliseconds: 200),
          transitionBuilder: (child, animation) {
            return ScaleTransition(scale: animation, child: child);
          },
          child: icon is SvgPicture
              ? KeyedSubtree(
                  key: ValueKey((icon as SvgPicture)),
                  child: icon,
                )
              : icon,
        ),
        const SizedBox(width: 4),
        Text(
          label,
          style: TextStyle(color: labelColor),
        ),
      ],
    );
  }
}

class LikeButton extends StatefulWidget {
  final int likeCount;
  const LikeButton({super.key, required this.likeCount});

  @override
  State<LikeButton> createState() => _LikeButtonState();
}

class _LikeButtonState extends State<LikeButton> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  bool isLiked = false;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );

    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.3).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeOut,
        reverseCurve: Curves.easeIn,
      ),
    );

    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _controller.reverse();
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onTap() {
    setState(() {
      isLiked = !isLiked;
    });
    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    final color = isLiked ? Theme.of(context).colorScheme.primary : Theme.of(context).colorScheme.onSurface;

    final icon = isLiked ? AppIcons.heart.toSvg(width: 16, color: color) : AppIcons.heart1.toSvg(width: 16, color: color);

    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: _onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 5,
          vertical: 5,
        ),
        child: ScaleTransition(
          scale: _scaleAnimation,
          child: AnimatedSwitcherIconWithLabel(
            icon: icon,
            label: (widget.likeCount + (isLiked ? 1 : 0)).toString(),
            labelColor: color,
          ),
        ),
      ),
    );
  }
}
