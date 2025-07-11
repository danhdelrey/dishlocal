import 'package:dishlocal/app/theme/custom_colors.dart';
import 'package:flutter/material.dart';

class GradientFilledButton extends StatelessWidget {
  const GradientFilledButton({
    super.key,
    required this.icon,
    required this.label,
    required this.onTap,
    this.maxWidth,
    this.color1,
    this.color2,
  });
  final Widget icon;
  final String label;
  final Function() onTap;
  final bool? maxWidth;
  final Color? color1;
  final Color? color2;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Ink(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              color1 ?? const Color(0xFFfc6076), // Cam nhạt dịu (mang cảm giác ẩm thực)
              color2 ?? const Color(0xFFff9a44), // Hồng đào ấm áp
            ],
            stops: const [0.0, 1.0],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
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
            mainAxisSize: maxWidth == true ? MainAxisSize.max : MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              icon,
              const SizedBox(
                width: 5,
              ),
              Text(
                label,
                style: Theme.of(context).textTheme.labelLarge!.copyWith(
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
