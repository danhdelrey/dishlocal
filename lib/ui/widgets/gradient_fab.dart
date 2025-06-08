import 'package:dishlocal/app/theme/custom_colors.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class GradientFab extends StatelessWidget {
  const GradientFab({super.key, required this.icon, required this.onTap, this.size});

  final Widget icon;
  final void Function() onTap;
  final double? size;

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
              decoration: BoxDecoration(
                gradient: primaryGradient,
                borderRadius: BorderRadius.circular(1000),
              ),
              width: size ?? 40,
              height: size ?? 40,
              child: icon,
            ),
          ),
        ],
      ),
    );
  }
}
