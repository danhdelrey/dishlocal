import 'package:dishlocal/app/theme/app_icons.dart';
import 'package:dishlocal/app/theme/custom_colors.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class GradientFilledButton extends StatelessWidget {
  const GradientFilledButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        context.go("/home_page");
      },
      borderRadius: BorderRadius.circular(8),
      child: Ink(
        decoration: BoxDecoration(
          gradient: primaryGradient,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Padding(
          padding: const EdgeInsets.only(
            left: 20,
            right: 20,
            top: 10,
            bottom: 10,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              AppIcons.rocketFill.toSvg(
                width: 18,
                color: Colors.white,
              ),
              const SizedBox(
                width: 5,
              ),
              Text(
                'Bắt đầu khám phá',
                style:
                    Theme.of(context).textTheme.labelLarge!.copyWith(
                          color: Colors.white,
                        ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
