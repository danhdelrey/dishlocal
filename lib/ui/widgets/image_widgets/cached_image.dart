import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blurhash/flutter_blurhash.dart';

class CachedImage extends StatelessWidget {
  const CachedImage({
    super.key,
    required this.imageUrl,
    required this.blurHash,
    this.borderRadius = 12,
  });

  final String imageUrl;
  final String blurHash;
  final double borderRadius;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius),
      child: AspectRatio(
        aspectRatio: 1,
        child: CachedNetworkImage(
          imageUrl: imageUrl,
          fit: BoxFit.cover,
          // Sử dụng placeholder builder
          placeholder: (context, url) => BlurHash(hash: blurHash, imageFit: BoxFit.cover),
          // Thêm hiệu ứng fade in mượt mà
          fadeInDuration: const Duration(milliseconds: 300),
          // Widget hiển thị khi có lỗi
          errorWidget: (context, url, error) => const Icon(Icons.error),
        ),
      ),
    );
  }
}
