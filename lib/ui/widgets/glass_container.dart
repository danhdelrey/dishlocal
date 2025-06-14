import 'dart:ui';
import 'package:flutter/material.dart';

class GlassContainer extends StatelessWidget {
  const GlassContainer({
    super.key,
    required this.child,
    this.horizontalPadding = 5,
    this.verticalPadding = 2,
    this.blur = 10,
    this.borderRadius = 1000,
    this.backgroundColor = Colors.white,
    this.gradient,
    this.borderColor,
    this.borderWidth = 1,
  });

  final Widget child;
  final double horizontalPadding;
  final double verticalPadding;
  final double blur;
  final double borderRadius;
  final Color backgroundColor;
  final Gradient? gradient; // Gradient có thể null
  final Color? borderColor;
  final double borderWidth;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: blur, sigmaY: blur),
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: horizontalPadding,
            vertical: verticalPadding,
          ),
          decoration: BoxDecoration(
            // --- LOGIC QUAN TRỌNG NẰM Ở ĐÂY ---
            // Nếu có gradient, sử dụng nó. Nếu không, dùng màu nền như cũ.
            // BoxDecoration không cho phép có cả `color` và `gradient` cùng lúc.
            gradient: gradient,
            color: gradient == null ? backgroundColor.withValues(alpha: 0.1) : null,
            borderRadius: BorderRadius.circular(borderRadius),
            border: Border.all(
              color: borderColor ?? Colors.white.withValues(alpha: 0.2),
              width: borderWidth,
            ),
          ),
          child: child,
        ),
      ),
    );
  }
}
