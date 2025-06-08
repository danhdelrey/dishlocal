import 'package:flutter/material.dart';

class RoundedSquareImageAsset extends StatelessWidget {
  const RoundedSquareImageAsset({
    super.key,
    required this.assetPath,
  });

  final String assetPath;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: AspectRatio(
        aspectRatio: 1,
        child: Image.asset(
          assetPath,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
