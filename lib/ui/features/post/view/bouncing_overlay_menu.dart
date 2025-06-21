import 'package:dishlocal/app/theme/theme.dart';
import 'package:dishlocal/ui/features/view_post/view/post_detail_page.dart';
import 'package:dishlocal/ui/widgets/containers_widgets/glass_container.dart';
import 'package:flutter/material.dart';

class MenuActionItem {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const MenuActionItem({
    required this.icon,
    required this.label,
    required this.onTap,
  });
}

class BouncingOverlayMenu extends StatefulWidget {
  const BouncingOverlayMenu({
    super.key,
    required this.menuItems,
    this.position = const Offset(50, 50),
  });

  final List<MenuActionItem> menuItems;
  final Offset position;

  @override
  State<BouncingOverlayMenu> createState() => _BouncingOverlayMenuState();
}

class _BouncingOverlayMenuState extends State<BouncingOverlayMenu> with SingleTickerProviderStateMixin {
  final _overlayPortalController = OverlayPortalController();
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  bool _isShowing = false;
  bool _isProcessing = false;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );

    _scaleAnimation = TweenSequence<double>([
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
            top: widget.position.dy,
            right: widget.position.dx,
            child: ScaleTransition(
              scale: _scaleAnimation,
              child: GlassContainer(
                borderBottom: true,
                borderLeft: true,
                borderTop: true,
                borderRight: true,
                borderRadius: 20,
                backgroundColor: Colors.black,
                blur: 50,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: widget.menuItems.map((item) => _buildMenuItem(context, item)).toList(),
                ),
              ),
            ),
          );
        },
        child: const Icon(Icons.more_horiz_rounded),
      ),
    );
  }

  Widget _buildMenuItem(BuildContext context, MenuActionItem item) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: _isProcessing
            ? null
            : () async {
                if (_isProcessing) return;

                setState(() {
                  _isProcessing = true;
                });

                _toggleOverlay();

                try {
                  await Future.microtask(item.onTap);
                } catch (_) {}

                Future.delayed(const Duration(milliseconds: 500), () {
                  if (mounted) {
                    setState(() {
                      _isProcessing = false;
                    });
                  }
                });
              },
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(item.icon, size: 16, color: Colors.white),
              const SizedBox(width: 8),
              Text(
                item.label,
                style: appTextTheme(context).labelLarge?.copyWith(color: Colors.white),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
