import 'package:dishlocal/app/theme/theme.dart';
import 'package:dishlocal/data/categories/post/model/filter_sort_model/filter_sort_params.dart';
import 'package:dishlocal/data/categories/post/model/filter_sort_model/sort_option.dart';
import 'package:dishlocal/ui/widgets/input_widgets/custom_choice_chip.dart';
import 'package:flutter/material.dart';

class FiltersWrap extends StatefulWidget {
  const FiltersWrap({super.key, required this.filterParams, required this.openFilterSortSheet});
  final FilterSortParams filterParams;
  final void Function(BuildContext context) openFilterSortSheet;

  @override
  State<FiltersWrap> createState() => _FiltersWrapState();
}

class _FiltersWrapState extends State<FiltersWrap> with SingleTickerProviderStateMixin {
  bool _isExpanded = true;
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _animation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    );

    if (_isExpanded) {
      _animationController.forward();
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final hasActiveFilters = !widget.filterParams.isDefault(widget.filterParams.context);
    if (!hasActiveFilters) {
      return const SizedBox.shrink();
    }
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            behavior: HitTestBehavior.translucent,
            onTap: () {
              setState(() {
                _isExpanded = !_isExpanded;
                if (_isExpanded) {
                  _animationController.forward();
                } else {
                  _animationController.reverse();
                }
              });
            },
            child: Row(
              children: [
                Icon(
                  Icons.tune_rounded,
                  size: 20,
                  color: appColorScheme(context).primary,
                ),
                const SizedBox(width: 8),
                Text(
                  'Đã áp dụng bộ lọc',
                  style: appTextTheme(context).labelLarge?.copyWith(
                        fontWeight: FontWeight.w700,
                        color: appColorScheme(context).primary,
                      ),
                ),
                const SizedBox(width: 10),
                AnimatedRotation(
                  duration: const Duration(milliseconds: 300),
                  turns: _isExpanded ? 0.5 : 0.0,
                  child: Icon(
                    Icons.expand_more,
                    color: appColorScheme(context).primary,
                  ),
                ),
              ],
            ),
          ),
          SizeTransition(
            sizeFactor: _animation,
            child: Column(
              children: [
                const SizedBox(height: 10),
                Wrap(
                  spacing: 8.0,
                  runSpacing: 8.0,
                  alignment: WrapAlignment.start,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    ..._buildFilterChips(context, widget.filterParams),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> _buildFilterChips(BuildContext context, FilterSortParams filterParams) {
    final hasActiveFilters = !filterParams.isDefault(filterParams.context);

    if (!hasActiveFilters) {
      return [];
    }

    final chips = <Widget>[];

    // Categories chips
    chips.addAll(filterParams.categories.map((category) => CustomChoiceChip(
          label: category.label,
          isSelected: true,
          onSelected: (_) {
            widget.openFilterSortSheet(context);
          },
          itemColor: category.color,
          contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
          borderRadius: 8,
        )));

    // Price range chip
    if (filterParams.range != null) {
      chips.add(CustomChoiceChip(
        label: filterParams.range!.displayName,
        isSelected: true,
        onSelected: (_) {
          widget.openFilterSortSheet(context);
        },
        itemColor: Colors.amber,
        contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        borderRadius: 8,
      ));
    }

    // Distance chip
    if (filterParams.distance != null) {
      chips.add(CustomChoiceChip(
        label: filterParams.distance!.displayName,
        isSelected: true,
        onSelected: (_) {
          widget.openFilterSortSheet(context);
        },
        itemColor: Colors.blue,
        contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        borderRadius: 8,
      ));
    }

    // Sort option chip with direction arrow
    if (filterParams.sortOption.field != SortField.relevance) {
      chips.add(CustomChoiceChip(
        label: _buildSortLabel(filterParams.sortOption),
        isSelected: true,
        onSelected: (_) {
          widget.openFilterSortSheet(context);
        },
        itemColor: Colors.lightGreen,
        contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        borderRadius: 8,
      ));
    }

    return chips;
  }

  String _buildSortLabel(SortOption sortOption) {
    final arrow = sortOption.direction == SortDirection.desc ? ' ↓' : ' ↑';
    return '${sortOption.field.icon} ${sortOption.field.label}$arrow';
  }
}
