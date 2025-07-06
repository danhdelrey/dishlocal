import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blurhash/flutter_blurhash.dart';

class CachedImage extends StatefulWidget {
  const CachedImage({
    super.key,
    required this.imageUrl,
    required this.blurHash,  this.borderRadius = 12,
  });

  final String imageUrl;
  final String blurHash;
  final double borderRadius;

  @override
  State<CachedImage> createState() => _CachedImageState();
}

class _CachedImageState extends State<CachedImage> {
  bool _showPlaceholder = true;

  void _onImageLoaded() async {
    // Đợi 500ms trước khi ẩn placeholder
    await Future.delayed(const Duration(milliseconds: 500));
    if (mounted) {
      setState(() {
        _showPlaceholder = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(widget.borderRadius),
      child: AspectRatio(
        aspectRatio: 1,
        child: Stack(
          fit: StackFit.expand,
          children: [
            CachedNetworkImage(
              fit: BoxFit.cover,
              imageUrl: widget.imageUrl,
              // Khi ảnh đã load xong
              imageBuilder: (context, imageProvider) {
                _onImageLoaded();
                return Image(
                  image: imageProvider,
                  fit: BoxFit.cover,
                );
              },
              errorWidget: (context, url, error) => const Icon(Icons.error),
            ),
            AnimatedOpacity(
              opacity: _showPlaceholder ? 1.0 : 0.0,
              duration: const Duration(milliseconds: 400),
              curve: Curves.easeOut,
              child: BlurHash(
                hash: widget.blurHash,
                imageFit: BoxFit.cover,
                color: Colors.transparent,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
