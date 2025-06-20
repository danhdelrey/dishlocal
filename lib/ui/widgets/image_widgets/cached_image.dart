import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blurhash/flutter_blurhash.dart';

class CachedImage extends StatelessWidget {
  const CachedImage({
    super.key,
    required this.imageUrl,
    required this.blurHash,
  });

  final String imageUrl;
  final String blurHash;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: AspectRatio(
        aspectRatio: 1,
        child: CachedNetworkImage(
          fit: BoxFit.cover,
          imageUrl: imageUrl,
          placeholder: (context, url) => SizedBox.expand(
            child: BlurHash(
              hash: blurHash,
              imageFit: BoxFit.cover,
              color: Colors.transparent,
            ),
          ),
          errorWidget: (context, url, error) => const Icon(Icons.error),
        ),
      ),
    );
  }
}
