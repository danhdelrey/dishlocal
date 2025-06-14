import 'dart:ui';
import 'package:flutter/material.dart';

class GlassContainer extends StatelessWidget {
  const GlassContainer({
    super.key,
    required this.child,
    this.horizontalPadding,
    this.verticalPadding,
    this.blur = 10,
    this.borderRadius = 1000,
    this.backgroundColor = Colors.white,
    this.gradient,
    this.borderWidth = 1,
    this.borderTop,
    this.borderLeft,
    this.borderBottom,
    this.borderRight,
  });

  final Widget child;
  final double? horizontalPadding;
  final double? verticalPadding;
  final double blur;
  final double borderRadius;
  final Color backgroundColor;
  final Gradient? gradient; // Gradient có thể null

  final double borderWidth;
  final bool? borderTop;
  final bool? borderBottom;
  final bool? borderLeft;
  final bool? borderRight;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: blur, sigmaY: blur),
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: horizontalPadding ?? 0,
            vertical: verticalPadding ?? 0,
          ),
          decoration: BoxDecoration(
            // --- LOGIC QUAN TRỌNG NẰM Ở ĐÂY ---
            // Nếu có gradient, sử dụng nó. Nếu không, dùng màu nền như cũ.
            // BoxDecoration không cho phép có cả `color` và `gradient` cùng lúc.
            gradient: gradient,
            color: gradient == null ? backgroundColor.withValues(alpha: 0.1) : null,
            borderRadius: BorderRadius.circular(borderRadius),
            border: Border(
              top: borderTop != null
                  ? BorderSide(
                      width: borderWidth,
                      color: Colors.white.withValues(alpha: 0.1),
                      style: BorderStyle.solid,
                    )
                  : BorderSide.none,
              bottom: borderBottom != null
                  ? BorderSide(
                      width: borderWidth,
                      color: Colors.white.withValues(alpha: 0.1),
                      style: BorderStyle.solid,
                    )
                  : BorderSide.none,
              left: borderLeft != null
                  ? BorderSide(
                      width: borderWidth,
                      color: Colors.white.withValues(alpha: 0.1),
                      style: BorderStyle.solid,
                    )
                  : BorderSide.none,
              right: borderRight != null
                  ? BorderSide(
                      width: borderWidth,
                      color: Colors.white.withValues(alpha: 0.1),
                      style: BorderStyle.solid,
                    )
                  : BorderSide.none,
            ),
          ),
          child: child,
        ),
      ),
    );
  }
}
