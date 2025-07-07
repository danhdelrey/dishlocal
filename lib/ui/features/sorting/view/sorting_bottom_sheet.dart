import 'package:dishlocal/app/theme/theme.dart';
import 'package:dishlocal/ui/features/filter_sort/bloc/filter_sort_bloc.dart';
import 'package:dishlocal/ui/features/filter_sort/model/sort_option.dart';
import 'package:dishlocal/ui/features/filter_sort/view/filter_sort_builder.dart';
import 'package:dishlocal/ui/features/select_food_category/view/expandable_food_category_chip_selector.dart';
import 'package:dishlocal/ui/widgets/containers_widgets/glass_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class SortingBottomSheet extends StatelessWidget {
  const SortingBottomSheet({super.key});

  static Future<void> show(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => const SortingBottomSheet(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;
    final appColors = appColorScheme(context);

    return FilterSortBuilder(
      builder: (context, state) {
        final bloc = context.read<FilterSortBloc>();

        return SizedBox(
          height: MediaQuery.of(context).size.height * 0.85,
          child: ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
            child: Scaffold(
              backgroundColor: colorScheme.surface,
              appBar: _buildAppBar(context, textTheme, colorScheme, bloc),
              body: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildCategorySection(state, bloc),
                      _buildDivider(),
                      _buildPriceSection(state, bloc, textTheme, colorScheme, appColors),
                      _buildDivider(),
                      _buildSortSection(state, bloc, textTheme, colorScheme, appColors),
                      const SizedBox(height: 32),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  PreferredSizeWidget _buildAppBar(
    BuildContext context,
    TextTheme textTheme,
    ColorScheme colorScheme,
    FilterSortBloc bloc,
  ) {
    return AppBar(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      backgroundColor: colorScheme.surface,
      elevation: 0,
      surfaceTintColor: Colors.transparent,
      automaticallyImplyLeading: false,
      title: Text(
        'Bộ lọc & sắp xếp',
        style: textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w600),
      ),
      centerTitle: true,
      leading: Padding(
        padding: const EdgeInsets.only(left: 8.0),
        child: TextButton(
          onPressed: () => bloc.add(const FilterSortEvent.filtersCleared()),
          style: TextButton.styleFrom(
            foregroundColor: colorScheme.primary,
            padding: EdgeInsets.zero,
          ),
          child: const Text('Đặt lại'),
        ),
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 8.0),
          child: FilledButton(
            onPressed: () {
              bloc.add(const FilterSortEvent.filtersSubmitted());
              context.pop();
            },
            style: FilledButton.styleFrom(
              backgroundColor: colorScheme.primary,
              foregroundColor: colorScheme.onPrimary,
            ),
            child: const Text('Áp dụng'),
          ),
        ),
      ],
    );
  }

  Widget _buildCategorySection(FilterSortLoaded state, FilterSortBloc bloc) {
    return ExpandableFoodCategoryChipSelector(
      title: '📋 Loại món',
      items: state.allCategories,
      allowMultiSelect: true,
      selectedItems: state.currentParams.categories,
      onCategoryTapped: (category) {
        bloc.add(FilterSortEvent.categoryToggled(category));
      },
      onSelectAllTapped: () {
        bloc.add(const FilterSortEvent.allCategoriesToggled());
      },
      selectAllText: 'Tất cả loại món',
      selectAllColor: Colors.indigo,
    );
  }

  Widget _buildPriceSection(
    FilterSortLoaded state,
    FilterSortBloc bloc,
    TextTheme textTheme,
    ColorScheme colorScheme,
    dynamic appColors,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle('💰 Mức giá', textTheme),
        const SizedBox(height: 16),
        Wrap(
          spacing: 8.0,
          runSpacing: 8.0,
          children: state.allRanges.map((range) {
            final isSelected = state.currentParams.range == range;
            return _buildChoiceChip(
              label: range.displayName,
              isSelected: isSelected,
              onSelected: (_) => bloc.add(FilterSortEvent.priceRangeToggled(range)),
              colorScheme: colorScheme,
              appColors: appColors,
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildSortSection(
    FilterSortLoaded state,
    FilterSortBloc bloc,
    TextTheme textTheme,
    ColorScheme colorScheme,
    dynamic appColors,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle('📊 Sắp xếp theo', textTheme),
        const SizedBox(height: 16),
        Wrap(
          spacing: 8.0,
          runSpacing: 8.0,
          children: state.allSortOptions.map((option) {
            final isSelected = state.currentParams.sortOption == option;
            return _buildChoiceChip(
              label: option.displayName,
              isSelected: isSelected,
              onSelected: (_) {
                if (!isSelected) {
                  bloc.add(FilterSortEvent.sortOptionSelected(option));
                }
              },
              colorScheme: colorScheme,
              appColors: appColors,
              showCheckIcon: true,
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildSectionTitle(String title, TextTheme textTheme) {
    return Text(
      title,
      style: textTheme.titleMedium?.copyWith(
        fontWeight: FontWeight.w600,
        letterSpacing: 0.15,
      ),
    );
  }

  Widget _buildChoiceChip({
    required String label,
    required bool isSelected,
    required void Function(bool) onSelected,
    required ColorScheme colorScheme,
    required dynamic appColors,
    bool showCheckIcon = false,
  }) {
    return ChoiceChip(
      label: Text(label),
      avatar: showCheckIcon && isSelected
          ? Icon(
              Icons.check,
              size: 16,
              color: colorScheme.onPrimary,
            )
          : null,
      labelStyle: TextStyle(
        color: isSelected ? colorScheme.onPrimary : colorScheme.onSurface,
        fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
        fontSize: 14,
      ),
      selected: isSelected,
      onSelected: onSelected,
      selectedColor: colorScheme.primary,
      backgroundColor: appColors.surfaceContainerLow.withValues(alpha: 0.5),
      side: isSelected
          ? BorderSide.none
          : BorderSide(
              color: colorScheme.outline.withValues(alpha: 0.5),
              width: 1,
            ),
      showCheckmark: false,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
    );
  }

  Widget _buildDivider() {
    return const Padding(
      padding: EdgeInsets.symmetric(vertical: 24),
      child: Divider(height: 1),
    );
  }
}
