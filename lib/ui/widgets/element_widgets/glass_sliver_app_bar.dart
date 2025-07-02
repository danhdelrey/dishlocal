import 'package:dishlocal/app/theme/theme.dart';
import 'package:dishlocal/ui/widgets/containers_widgets/glass_space.dart';
import 'package:flutter/material.dart';

class GlassSliverAppBar extends StatelessWidget {
  const GlassSliverAppBar({
    super.key,
    this.title,
    this.leading,
    this.actions,
    this.centerTitle,
    this.hasBorder = true,
    this.floating = false,
    this.pinned = false,
    this.snap = false,
    this.bottom,
    this.titleSpacing,
  });

  final Widget? title;
  final Widget? leading;
  final List<Widget>? actions;
  final bool? centerTitle;
  final bool hasBorder;
  final bool floating;
  final bool snap;
  final bool pinned;
  final PreferredSizeWidget? bottom;
  final double? titleSpacing;

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      titleSpacing: titleSpacing,
      floating: floating,
      snap: snap,
      pinned: pinned,
      shape: hasBorder
          ? Border(
              bottom: BorderSide(
                width: 1,
                color: Colors.white.withValues(alpha: 0.1),
                style: BorderStyle.solid,
              ),
            )
          : null,
      title: title,
      automaticallyImplyLeading: false,
      leading: leading,
      titleTextStyle: appTextTheme(context).titleMedium,
      surfaceTintColor: Colors.transparent,
      backgroundColor: Colors.transparent,
      centerTitle: centerTitle,
      flexibleSpace: const GlassSpace(
        blur: 50,
        backgroundColor: Colors.transparent,
      ),
      actions: actions,
      bottom: bottom,
    );
  }
}
