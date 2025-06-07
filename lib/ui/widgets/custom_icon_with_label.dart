import 'package:flutter/material.dart';

class CustomIconWithLabel extends StatelessWidget {
  const CustomIconWithLabel({
    super.key,
    required this.icon,
    required this.label,
    this.labelColor,
  });

  final Widget icon;
  final String label;
  final Color? labelColor;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        icon,
        const SizedBox(
          width: 2,
        ),
        Text(
          label,
          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                color: labelColor,
              ),
        )
      ],
    );
  }
}
