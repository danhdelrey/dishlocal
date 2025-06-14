import 'package:dishlocal/app/theme/theme.dart';
import 'package:dishlocal/ui/widgets/glass_container.dart';
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
    return GlassContainer(
      borderWidth: 0.5,
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
                  color: appColorScheme(context).onSurface, // Đảm bảo rõ chữ trên nền mờ
                ),
          ),
        ],
      ),
    );
  }
}
