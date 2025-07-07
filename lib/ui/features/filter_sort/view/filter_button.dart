import 'package:dishlocal/app/theme/theme.dart';
import 'package:flutter/material.dart';

class FilterButton extends StatelessWidget {
  const FilterButton({
    super.key,
    required this.hasActiveFilters,
  });

  final bool hasActiveFilters;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      child: Material(
        color: hasActiveFilters ? appColorScheme(context).primary.withOpacity(0.1) : appColorScheme(context).surfaceContainerHighest.withOpacity(0.5),
        borderRadius: BorderRadius.circular(12),
        elevation: 1,
        child: InkWell(
          onTap: () {
            // Mở bộ lọc
          },
          borderRadius: BorderRadius.circular(12),
          splashColor: appColorScheme(context).primary.withOpacity(0.1),
          highlightColor: Colors.transparent,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: hasActiveFilters ? appColorScheme(context).primary : appColorScheme(context).outline.withOpacity(0.2),
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Stack(
                  children: [
                    Icon(
                      Icons.tune,
                      size: 20,
                      color: hasActiveFilters ? appColorScheme(context).primary : appColorScheme(context).onSurface,
                    ),
                    if (hasActiveFilters)
                      Positioned(
                        right: 0,
                        top: 0,
                        child: Container(
                          width: 8,
                          height: 8,
                          decoration: BoxDecoration(
                            color: appColorScheme(context).primary,
                            shape: BoxShape.circle,
                          ),
                        ),
                      ),
                  ],
                ),
                const SizedBox(width: 8),
                Text(
                  hasActiveFilters ? 'Bộ lọc (đã áp dụng)' : 'Bộ lọc',
                  style: TextStyle(
                    color: hasActiveFilters ? appColorScheme(context).primary : appColorScheme(context).onSurface,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
