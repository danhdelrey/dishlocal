import 'package:dishlocal/app/theme/theme.dart';
import 'package:dishlocal/ui/widgets/containers_widgets/glass_container.dart';
import 'package:flutter/material.dart';

class CustomChoiceChip extends StatelessWidget {
  const CustomChoiceChip({
    super.key,
    required this.context,
    required this.label,
    required this.isSelected,
    required this.onSelected,
    required this.itemColor,
  });

  final BuildContext context;
  final String label;
  final bool isSelected;
  final void Function(bool p1) onSelected;
  final Color? itemColor;

  @override
  Widget build(BuildContext context) {
    return GlassContainer(
      borderRadius: 12,
      blur: 0,
      child: InkWell(
        onTap: () => onSelected(!isSelected),
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
          decoration: BoxDecoration(
            color: isSelected ? itemColor?.withValues(alpha: 0.5) ?? appColorScheme(context).primary : Colors.transparent,
            borderRadius: BorderRadius.circular(12),
            border: isSelected
                ? Border.all(
                    color: itemColor ?? appColorScheme(context).primary,
                    width: 1,
                  )
                : Border.all(
                    color: appColorScheme(context).onSurface.withValues(alpha: 0.1),
                    width: 1,
                  ),
          ),
          child: Text(
            label,
            style: appTextTheme(context).labelMedium?.copyWith(
                  color: isSelected ? (itemColor != null ? appColorScheme(context).onSurface : appColorScheme(context).onPrimary) : appColorScheme(context).onSurface,
                ),
          ),
        ),
      ),
    );
  }
}
