import 'package:dishlocal/app/theme/theme.dart';
import 'package:flutter/material.dart';

class ShimmeringSmallPost extends StatefulWidget {
  const ShimmeringSmallPost({super.key});
  @override
  State<ShimmeringSmallPost> createState() => _ShimmeringSmallPostState();
}

class _ShimmeringSmallPostState extends State<ShimmeringSmallPost> with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _opacityAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    )..repeat(reverse: true);
    _opacityAnimation = Tween<double>(begin: 0.3, end: 0.8).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: FadeTransition(
        opacity: _opacityAnimation,
        child: _buildPlaceholderContent(),
      ),
    );
  }

  Widget _buildPlaceholderContent() {
    final placeholderColor = appColorScheme(context).outlineVariant;
    return Column(
      children: [
        Container(
          height: 10,
          decoration: BoxDecoration(color: placeholderColor, borderRadius: BorderRadius.circular(1000)),
        ),
        const SizedBox(height: 5),
        AspectRatio(
          aspectRatio: 1,
          child: Container(
            decoration: BoxDecoration(color: placeholderColor, borderRadius: BorderRadius.circular(12)),
          ),
        ),
        const SizedBox(height: 5),
        Row(
          children: [
            Container(
              width: 16,
              height: 16,
              decoration: BoxDecoration(color: placeholderColor, borderRadius: BorderRadius.circular(1000)),
            ),
            const SizedBox(width: 5),
            Expanded(
              child: Container(
                height: 10,
                decoration: BoxDecoration(color: placeholderColor, borderRadius: BorderRadius.circular(20)),
              ),
            ),
            const SizedBox(width: 20),
            Container(
              width: 30,
              height: 10,
              decoration: BoxDecoration(color: placeholderColor, borderRadius: BorderRadius.circular(20)),
            ),
          ],
        ),
      ],
    );
  }
}
