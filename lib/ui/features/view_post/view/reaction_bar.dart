import 'package:dishlocal/app/theme/app_icons.dart';
import 'package:dishlocal/ui/widgets/element_widgets/custom_icon_with_label.dart';
import 'package:flutter/material.dart';

class ReactionBar extends StatelessWidget {
  const ReactionBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CustomIconWithLabel(
          icon: AppIcons.heart1.toSvg(
            width: 16,
            color: Theme.of(context).colorScheme.onSurface,
          ),
          label: '12K',
          labelColor: Theme.of(context).colorScheme.onSurface,
        ),
        const SizedBox(
          width: 20,
        ),
        CustomIconWithLabel(
          icon: AppIcons.bookmark1.toSvg(
            width: 16,
            color: Theme.of(context).colorScheme.onSurface,
          ),
          labelColor: Theme.of(context).colorScheme.onSurface,
          label: '1.2K',
        ),
      ],
    );
  }
}
