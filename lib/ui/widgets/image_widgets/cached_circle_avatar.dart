import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CachedCircleAvatar extends StatelessWidget {
  const CachedCircleAvatar({
    super.key,
    required this.imageUrl,
    this.circleRadius = 18,
  });

  final String imageUrl;
  final double circleRadius;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: circleRadius,
      backgroundImage: CachedNetworkImageProvider(imageUrl),
    );
  }
}
