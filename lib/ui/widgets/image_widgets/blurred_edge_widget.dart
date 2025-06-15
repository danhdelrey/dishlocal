import 'package:dishlocal/ui/widgets/image_widgets/cached_image.dart';
import 'package:flutter/material.dart';
import 'dart:ui';

class BlurredEdgeWidget extends StatelessWidget {
  // Thêm các tham số tùy chọn để linh hoạt hơn
  final double blurSigma;
  final double clearRadius;
  final List<double> gradientStops;
  final double imageBorderRadius;

  final Widget blurredChild;
  final Widget topChild;

  const BlurredEdgeWidget({
    super.key,
    this.blurSigma = 5,
    this.clearRadius = 0.7,
    this.gradientStops = const [0.5, 1.0],
    this.imageBorderRadius = 20,
    required this.blurredChild,
    required this.topChild,
  });

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1,
      child: Stack(
        fit: StackFit.expand,
        children: [
          ImageFiltered(
            imageFilter: ImageFilter.blur(sigmaX: blurSigma, sigmaY: blurSigma),
            child: blurredChild,
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
            child: ClipRRect(
              borderRadius: BorderRadius.circular(imageBorderRadius),
              child: topChild,
            ),
          ),
        ],
      ),
    );
  }
}
