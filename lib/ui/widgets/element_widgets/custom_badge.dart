import 'package:badges/badges.dart' as badges;
import 'package:dishlocal/ui/global/cubits/cubit/unread_badge_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logging/logging.dart';

class CustomBadge extends StatelessWidget {
  const CustomBadge({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UnreadBadgeCubit, UnreadBadgeState>(
      builder: (context, badgeState) {
        final totalUnread = badgeState.totalUnreadCount;
        Logger("CustomBadge").info('[CustomBadge] BlocBuilder is rebuilding. totalUnread = $totalUnread');
        return Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            badges.Badge(
              showBadge: totalUnread > 0,
              badgeAnimation: const badges.BadgeAnimation.scale(),
              badgeContent: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(1000),
                  color: Colors.red,
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 5, right: 5),
                  child: Text(
                    totalUnread > 99 ? '99+' : totalUnread.toString(),
                    style: Theme.of(context).textTheme.labelSmall,
                  ),
                ),
              ),
              position: badges.BadgePosition.topStart(
                top: 4,
                start: 10,
              ),
              badgeStyle: const badges.BadgeStyle(
                badgeColor: Colors.transparent,
              ),
              child: child,
            ),
          ],
        );
      },
    );
  }
}
