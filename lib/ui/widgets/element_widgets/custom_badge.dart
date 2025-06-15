import 'package:badges/badges.dart' as badges;
import 'package:flutter/material.dart';

class CustomBadge extends StatelessWidget {
  const CustomBadge({
    super.key,
    required this.child, required this.showBadge,
  });

  final Widget child;
  final bool showBadge;

  @override
  Widget build(BuildContext context) {
    return badges.Badge(
      showBadge: showBadge,
      badgeAnimation: const badges.BadgeAnimation.scale(),
      badgeContent: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(1000),
          color: Colors.red,
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 5, right: 5),
          child: Text(
            '9',
            style: Theme.of(context).textTheme.labelSmall,
          ),
        ),
      ),
      position: badges.BadgePosition.topStart(
        top: -10,
        start: 7,
      ),
      badgeStyle: const badges.BadgeStyle(
        badgeColor: Colors.transparent,
      ),
      child: child,
    );
  }
}
