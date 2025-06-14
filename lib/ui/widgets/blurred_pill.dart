import 'package:flutter/material.dart';

import 'dart:ui';
import 'package:flutter/material.dart';

class BlurredPill extends StatelessWidget {
  const BlurredPill({
    super.key,
    this.icon,
    required this.label,
  });

  final Widget? icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(1000),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(1000),
            border: Border.all(color: Colors.white.withValues(alpha: 0.2)),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (icon != null) ...[
                icon!,
                const SizedBox(width: 4),
              ],
              Text(
                label,
                style: Theme.of(context).textTheme.labelSmall?.copyWith(
                      color: Colors.white, // Đảm bảo rõ chữ trên nền mờ
                    ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
