import 'package:dishlocal/data/categories/post/model/filter_sort_model/filter_sort_params.dart';
import 'package:dishlocal/data/categories/post/model/filter_sort_model/sort_option.dart';
import 'package:dishlocal/ui/widgets/input_widgets/custom_choice_chip.dart';
import 'package:flutter/material.dart';

class FiltersWrap extends StatelessWidget {
  const FiltersWrap({super.key, required this.filterParams, required this.openFilterSortSheet});
  final FilterSortParams filterParams;
  final void Function(BuildContext context) openFilterSortSheet;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
      child: Wrap(
        spacing: 8.0,
        runSpacing: 8.0,
        alignment: WrapAlignment.start,
        crossAxisAlignment: WrapCrossAlignment.center,
        children: [
          ..._buildFilterChips(context, filterParams),
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
            openFilterSortSheet(context);
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
          openFilterSortSheet(context);
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
          openFilterSortSheet(context);
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
          openFilterSortSheet(context);
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
