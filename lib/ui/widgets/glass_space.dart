import 'dart:ui';
import 'package:flutter/material.dart';

class GlassSpace extends StatelessWidget {
  const GlassSpace({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 50.0, sigmaY: 50.0),
        child: Container(
          // Thêm một lớp màu nhẹ để hiệu ứng glass nổi bật hơn
          // và dễ đọc chữ hơn trên nền mờ.
          color: Colors.black.withValues(alpha: 0.1),
        ),
      ),
    );
  }
}
