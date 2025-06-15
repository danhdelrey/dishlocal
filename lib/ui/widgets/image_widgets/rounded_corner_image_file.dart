import 'dart:io';
import 'package:flutter/material.dart';

class RoundedCornerImageFile extends StatelessWidget {
  const RoundedCornerImageFile({
    super.key,
    required this.imagePath,
    this.borderRadius = 20,
  });

  final String imagePath;
  final double borderRadius;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius),
      child: AspectRatio(
        aspectRatio: 1,
        child: Image.file(
          File(imagePath),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
