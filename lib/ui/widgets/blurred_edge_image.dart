import 'package:flutter/material.dart';
import 'dart:ui';

class BlurredEdgeImage extends StatelessWidget {
  final String imageUrl;

  // Thêm các tham số tùy chọn để linh hoạt hơn
  final double blurSigma;
  final double clearRadius;
  final List<double> gradientStops;

  const BlurredEdgeImage({
    super.key,
    required this.imageUrl,
    this.blurSigma = 5,
    this.clearRadius = 0.7,
    this.gradientStops = const [0.5, 1.0],
  });

  @override
  Widget build(BuildContext context) {
    // Không cần SizedBox hay ClipRRect ở đây nữa
    // Widget này sẽ fill vào không gian mà cha nó cung cấp
    return Stack(
      fit: StackFit.expand,
      children: [
        ImageFiltered(
          imageFilter: ImageFilter.blur(sigmaX: blurSigma, sigmaY: blurSigma),
          child: Image.network(
            imageUrl,
            fit: BoxFit.cover,
          ),
        ),
        ShaderMask(
          shaderCallback: (Rect bounds) {
            return RadialGradient(
              center: Alignment.center,
              radius: clearRadius,
              colors: const [
                Colors.black,
                Colors.transparent,
              ],
              stops: gradientStops,
              tileMode: TileMode.clamp,
            ).createShader(bounds);
          },
          blendMode: BlendMode.dstIn,
          child: Image.network(
            imageUrl,
            fit: BoxFit.cover,
          ),
        ),
      ],
    );
  }
}
