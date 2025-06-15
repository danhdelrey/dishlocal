import 'package:dishlocal/app/theme/theme.dart';
import 'package:flutter/material.dart';

class CustomIconWithLabel extends StatelessWidget {
  const CustomIconWithLabel({
    super.key,
    required this.icon,
    required this.label,
    this.labelColor,
    this.labelStyle,
  });

  final Widget icon;
  final String label;
  final Color? labelColor;
  final TextStyle? labelStyle;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        icon,
        const SizedBox(
          width: 2,
        ),
        Text(
          label,
          style: labelStyle ??
              Theme.of(context).textTheme.labelLarge!.copyWith(
                    color: labelColor ?? appColorScheme(context).onSurface,
                  ),
        )
      ],
    );
  }
}
