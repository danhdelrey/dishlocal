import 'dart:ui';
import 'package:flutter/material.dart';

class GlassSpace extends StatelessWidget {
  const GlassSpace({
    super.key,
    required this.backgourndColor,
    required this.blur,
  });

  final Color backgourndColor;
  final double blur;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: blur, sigmaY: blur),
        child: Container(
          // Thêm một lớp màu nhẹ để hiệu ứng glass nổi bật hơn
          // và dễ đọc chữ hơn trên nền mờ.
          color: backgourndColor.withValues(alpha: 0.1),
        ),
      ),
    );
  }
}
