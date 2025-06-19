import 'package:dishlocal/ui/features/post_reaction_bar/view/reaction_bar.dart';
import 'package:flutter/material.dart';

class AnimatedIconCounterButton extends StatefulWidget {
  final bool isActive;
  final int count;
  final Widget Function(bool isActive, Color color) iconBuilder;
  final VoidCallback onTap;

  const AnimatedIconCounterButton({
    super.key,
    required this.isActive,
    required this.count,
    required this.iconBuilder,
    required this.onTap,
  });

  @override
  State<AnimatedIconCounterButton> createState() => _AnimatedIconCounterButtonState();
}

class _AnimatedIconCounterButtonState extends State<AnimatedIconCounterButton> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

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

  // Quan trọng: Chỉ chạy animation khi widget được build lại VÀ trạng thái `isActive` thay đổi từ false sang true.
  @override
  void didUpdateWidget(covariant AnimatedIconCounterButton oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isActive && !oldWidget.isActive) {
      _controller.forward();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final color = widget.isActive ? Theme.of(context).colorScheme.primary : Theme.of(context).colorScheme.onSurface;

    // Sử dụng ValueKey để AnimatedSwitcher nhận biết sự thay đổi của icon
    final icon = KeyedSubtree(
      key: ValueKey<bool>(widget.isActive),
      child: widget.iconBuilder(widget.isActive, color),
    );

    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: widget.onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
        child: ScaleTransition(
          scale: _scaleAnimation,
          child: _AnimatedSwitcherIconWithLabel(
            icon: icon,
            label: widget.count.toString(),
            labelColor: color,
          ),
        ),
      ),
    );
  }
}

// --- WIDGET HỖ TRỢ: ICON VÀ NHÃN VỚI ANIMATION SWITCHER ---
// Widget này không thay đổi, nó đã được thiết kế khá tốt.
// Chỉ đổi tên thành private để chỉ nên được sử dụng bên trong file này.
class _AnimatedSwitcherIconWithLabel extends StatelessWidget {
  final Widget icon;
  final String label;
  final Color labelColor;

  const _AnimatedSwitcherIconWithLabel({
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
          child: icon,
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
