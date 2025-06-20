import 'package:flutter/material.dart';

class FadeSlideUp extends StatefulWidget {
  final Widget child;
  final Duration duration;
  final double offsetY;

  const FadeSlideUp({
    super.key,
    required this.child,
    this.duration = const Duration(milliseconds: 400),
    this.offsetY = 20.0, // độ nổi lên (từ dưới lên)
  });

  @override
  State<FadeSlideUp> createState() => _FadeSlideUpState();
}

class _FadeSlideUpState extends State<FadeSlideUp> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _opacity;
  late Animation<Offset> _slide;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: widget.duration,
      vsync: this,
    );

    _opacity = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );

    _slide = Tween<Offset>(
      begin: Offset(0, widget.offsetY / 100), // nổi lên từ dưới
      end: Offset.zero,
    ).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );

    _controller.forward(); // bắt đầu animation khi widget được build
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _opacity,
      child: SlideTransition(
        position: _slide,
        child: widget.child,
      ),
    );
  }
}
