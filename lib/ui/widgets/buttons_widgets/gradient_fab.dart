import 'package:dishlocal/app/theme/custom_colors.dart';
import 'package:flutter/material.dart';

class GradientFab extends StatelessWidget {
  const GradientFab({super.key, this.onTap, this.size, this.iconSize});

  final void Function()? onTap;
  final double? size;
  final double? iconSize;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          InkWell(
            onTap: onTap,
            borderRadius: BorderRadius.circular(1000),
            child: Ink(
              decoration: onTap != null
                  ? BoxDecoration(
                      gradient: primaryGradient,
                      borderRadius: BorderRadius.circular(1000),
                    )
                  : BoxDecoration(
                      color: Theme.of(context).colorScheme.surfaceContainerLow,
                      borderRadius: BorderRadius.circular(1000),
                    ),
              width: size ?? 40,
              height: size ?? 40,
              child: Icon(
                Icons.camera_alt,
                size: iconSize ?? 24,
                color: onTap != null ? Colors.white : Theme.of(context).colorScheme.outlineVariant,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
