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
                      _buildCategorySection(context, state, bloc),
                      _buildDivider(),
                      _buildPriceSection(state, bloc, textTheme, colorScheme, appColors),
                      _buildDivider(),
                      _buildDistanceRangeSection(state, bloc, textTheme, colorScheme),
                      _buildDivider(),
                      _buildSortSection(state, bloc, textTheme, colorScheme),
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

  Widget _buildCategorySection(BuildContext context, FilterSortLoaded state, FilterSortBloc bloc) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle('📋 Loại món', Theme.of(context).textTheme),
        const SizedBox(height: 16),
        Wrap(
          spacing: 8.0,
          runSpacing: 8.0,
          children: [
            // Nút "Tất cả loại món"
            _buildChoiceChip(
              label: 'Tất cả loại món',
              isSelected: state.allCategories.isNotEmpty && state.currentParams.categories.length == state.allCategories.length,
              onSelected: (_) => bloc.add(const FilterSortEvent.allCategoriesToggled()),
              colorScheme: Theme.of(context).colorScheme,
              appColors: appColorScheme(context),
            ),
            // Các chip loại món
            ...state.allCategories.map((category) {
              final isSelected = state.currentParams.categories.contains(category);
              return _buildChoiceChip(
                label: category.label,
                isSelected: isSelected,
                onSelected: (_) => bloc.add(FilterSortEvent.categoryToggled(category)),
                colorScheme: Theme.of(context).colorScheme,
                appColors: appColorScheme(context),
              );
            }),
          ],
        ),
      ],
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

  Widget _buildDistanceRangeSection(
    FilterSortLoaded state,
    FilterSortBloc bloc,
    TextTheme textTheme,
    ColorScheme colorScheme,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle('📍 Khoảng cách', textTheme),
        const SizedBox(height: 12),
        Wrap(
          spacing: 8.0,
          runSpacing: 8.0,
          children: state.allDistances.map((distance) {
            final isSelected = state.currentParams.distance == distance;
            return ChoiceChip(
              label: Text(distance.displayName),
              labelStyle: TextStyle(
                color: isSelected ? colorScheme.onPrimary : colorScheme.onSurface,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              ),
              selected: isSelected,
              onSelected: (_) {
                bloc.add(FilterSortEvent.distanceRangeToggled(distance));
              },
              selectedColor: colorScheme.primary,
              backgroundColor: colorScheme.surfaceContainerHighest.withOpacity(0.5),
              side: isSelected ? BorderSide.none : BorderSide(color: colorScheme.outline.withOpacity(0.5)),
              showCheckmark: false,
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
  ) {
    // Lấy tùy chọn sắp xếp hiện tại
    final currentSortOption = state.currentParams.sortOption;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Tiêu đề và nút đảo chiều
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildSectionTitle('📊 Sắp xếp theo', textTheme),

            // Chỉ hiển thị nút đảo chiều nếu trường hiện tại hỗ trợ
            if (currentSortOption.isReversible)
              TextButton.icon(
                onPressed: () {
                  bloc.add(const FilterSortEvent.sortDirectionToggled());
                },
                icon: Icon(
                  currentSortOption.direction == SortDirection.desc ? Icons.arrow_downward : Icons.arrow_upward,
                  size: 16,
                ),
                label: Text(
                  currentSortOption.direction == SortDirection.desc ? 'Giảm dần' : 'Tăng dần',
                ),
                style: TextButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
              ),
          ],
        ),
        const SizedBox(height: 12),

        // Các lựa chọn trường sắp xếp
        Wrap(
          spacing: 8.0,
          runSpacing: 8.0,
          children: SortOption.uniqueFields.map((field) {
            final isSelected = currentSortOption.field == field;

            return ChoiceChip(
              label: Text('${field.icon} ${field.label}'),
              labelStyle: TextStyle(
                color: isSelected ? colorScheme.onPrimary : colorScheme.onSurface,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              ),
              selected: isSelected,
              onSelected: (_) {
                if (!isSelected) {
                  // Khi chọn một field mới, BLoC sẽ tự động chọn chiều mặc định.
                  // Chúng ta chỉ cần gửi một SortOption với field đó.
                  bloc.add(FilterSortEvent.sortOptionSelected(
                    SortOption(field: field, direction: SortDirection.desc), // direction ở đây không quá quan trọng
                  ));
                }
              },
              selectedColor: colorScheme.primary,
              backgroundColor: colorScheme.surfaceContainerHighest.withOpacity(0.5),
              side: isSelected ? BorderSide.none : BorderSide(color: colorScheme.outline.withOpacity(0.5)),
              showCheckmark: false,
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
