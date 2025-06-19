import 'package:dishlocal/app/theme/theme.dart';
import 'package:dishlocal/ui/features/post/view/post_detail_page.dart';
import 'package:dishlocal/ui/widgets/containers_widgets/glass_container.dart';
import 'package:flutter/material.dart';

class BouncingOverlayMenu extends StatefulWidget {
  const BouncingOverlayMenu({super.key});

  @override
  State<BouncingOverlayMenu> createState() => _BouncingOverlayMenuState();
}

class _BouncingOverlayMenuState extends State<BouncingOverlayMenu> with SingleTickerProviderStateMixin {
  final _overlayPortalController = OverlayPortalController();
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  bool _isShowing = false;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );

    _scaleAnimation = TweenSequence<double>([
      // Show (forward): đơn giản
      TweenSequenceItem(
        tween: Tween(begin: 0.0, end: 1.0).chain(
          CurveTween(curve: Curves.easeOutBack),
        ),
        weight: 1,
      ),
    ]).animate(_animationController);

    _animationController.addStatusListener((status) {
      if (status == AnimationStatus.dismissed && _isShowing) {
        _overlayPortalController.hide();
        _isShowing = false;
      }
    });
  }

  void _toggleOverlay() async {
    if (_overlayPortalController.isShowing) {
      // 👇 Reverse: nảy lên rồi mới thu nhỏ
      await _animationController.animateTo(
        1.1,
        duration: const Duration(milliseconds: 80),
        curve: Curves.easeOut,
      );
      await _animationController.reverse();
    } else {
      _overlayPortalController.show();
      _isShowing = true;
      _animationController.forward(from: 0);
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      color: appColorScheme(context).onSurface,
      onPressed: _toggleOverlay,
      icon: OverlayPortal(
        controller: _overlayPortalController,
        overlayChildBuilder: (context) {
          return Positioned(
            top: 50,
            right: 50,
            child: ScaleTransition(
              scale: _scaleAnimation,
              child: const GlassContainer(
                borderBottom: true,
                borderLeft: true,
                borderTop: true,
                borderRight: true,
                borderRadius: 20,
                backgroundColor: Colors.black,
                blur: 50,
                child: SizedBox(
                  width: 200,
                  height: 200,
                  child: Column(
                    children: [
                      Text('data'),
                      Text('data'),
                      Text('data'),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
        child: const Icon(Icons.more_horiz_rounded),
      ),
    );
  }
}
