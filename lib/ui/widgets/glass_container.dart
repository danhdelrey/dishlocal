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
  });

  final Widget child;
  final double horizontalPadding;
  final double verticalPadding;
  final double blur;
  final double borderRadius;
  final Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: blur, sigmaY: blur),
        child: Container(
          decoration: BoxDecoration(
            color: backgroundColor.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(1000),
            border: Border.all(color: Colors.white.withValues(alpha: 0.2)),
          ),
          padding: EdgeInsets.symmetric(horizontal: horizontalPadding, vertical: verticalPadding),
          child: child,
        ),
      ),
    );
  }
}
