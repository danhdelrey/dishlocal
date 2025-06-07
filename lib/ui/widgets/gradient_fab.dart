import 'package:dishlocal/app/theme/custom_colors.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class GradientFab extends StatelessWidget {
  const GradientFab({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        context.push("/new_post");
      },
      borderRadius: BorderRadius.circular(1000),
      child: Ink(
        decoration: BoxDecoration(
          gradient: primaryGradient,
          borderRadius: BorderRadius.circular(1000),
        ),
        width: 40,
        height: 40,
        child: const Icon(Icons.add),
      ),
    );
  }
}
