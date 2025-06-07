import 'package:dishlocal/ui/widgets/cropped_image.dart';
import 'package:flutter/material.dart';

class MaxWidthWithHeightConstraintCroppedImage extends StatelessWidget {
  const MaxWidthWithHeightConstraintCroppedImage({
    super.key,
    required this.imagePath,
  });

  final String imagePath;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return CroppedImage(
          borderRadius: 12,
          height: constraints.maxWidth,
          path: imagePath,
        );
      },
    );
  }
}
