import 'package:dishlocal/app/theme/theme.dart';
import 'package:flutter/material.dart';

class AnimatedChip extends StatefulWidget {
  final String label;
  final bool isSelected;
  final Color color;
  final ValueChanged<bool> onSelected;

  const AnimatedChip({
    super.key,
    required this.label,
    required this.isSelected,
    required this.color,
    required this.onSelected,
  });

  @override
  State<AnimatedChip> createState() => _AnimatedChipState();
}

class _AnimatedChipState extends State<AnimatedChip> {
  double _scale = 1.0;

  void _onTapDown(TapDownDetails details) => setState(() => _scale = 0.95);
  void _onTapUp(TapUpDetails details) => setState(() => _scale = 1.0);
  void _onTapCancel() => setState(() => _scale = 1.0);

  @override
  Widget build(BuildContext context) {
    final isSelected = widget.isSelected;
    final baseColor = widget.color;
    final bgColor = isSelected ? baseColor.withValues(alpha: 0.8) : baseColor.withValues(alpha: 0.1);
    final textColor = isSelected ? appColorScheme(context).onSurface : baseColor;

    return GestureDetector(
      onTapDown: _onTapDown,
      onTapUp: _onTapUp,
      onTapCancel: _onTapCancel,
      onTap: () => widget.onSelected(!isSelected),
      child: AnimatedScale(
        duration: const Duration(milliseconds: 100),
        scale: _scale,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          decoration: BoxDecoration(
            color: bgColor,
            borderRadius: BorderRadius.circular(100),
          ),
          child: Text(
            widget.label,
            style: appTextTheme(context).labelLarge!.copyWith(color: textColor),
          ),
        ),
      ),
    );
  }
}
