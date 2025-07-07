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
    return FilterSortBuilder(
      builder: (context, state) {
        final bloc = context.read<FilterSortBloc>();

        return SizedBox(
          height: MediaQuery.of(context).size.height * 0.85,
          child: ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
            child: Scaffold(
              extendBodyBehindAppBar: true,
              backgroundColor: Colors.transparent,
              appBar: _buildAppBar(context, bloc),
              body: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.only(top: kToolbarHeight + 16, left: 16, right: 16, bottom: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // --- Section Loại món ---
                      _FilterSection(
                        title: '📋 Loại món',
                        children: state.allCategories.map((category) {
                          return _buildChoiceChip(
                            context: context,
                            label: category.label,
                            isSelected: state.currentParams.categories.contains(category),
                            onSelected: (_) => bloc.add(FilterSortEvent.categoryToggled(category)),
                          );
                        }).toList(),
                      ),
                      _buildDivider(),

                      // --- Section Mức giá ---
                      _FilterSection(
                        title: '💰 Mức giá',
                        children: state.allRanges.map((range) {
                          return _buildChoiceChip(
                            context: context,
                            label: range.displayName,
                            isSelected: state.currentParams.range == range,
                            onSelected: (_) => bloc.add(FilterSortEvent.priceRangeToggled(range)),
                          );
                        }).toList(),
                      ),
                      _buildDivider(),

                      // --- Section Khoảng cách ---
                      _FilterSection(
                        title: '📍 Khoảng cách',
                        children: state.allDistances.map((distance) {
                          return _buildChoiceChip(
                            context: context,
                            label: distance.displayName,
                            isSelected: state.currentParams.distance == distance,
                            onSelected: (_) => bloc.add(FilterSortEvent.distanceRangeToggled(distance)),
                          );
                        }).toList(),
                      ),
                      _buildDivider(),

                      // --- Section Sắp xếp (được xử lý riêng do có logic phức tạp hơn) ---
                      _buildSortSection(context, state, bloc),

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
    FilterSortBloc bloc,
  ) {
    return AppBar(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      backgroundColor: Colors.transparent,
      elevation: 0,
      surfaceTintColor: Colors.transparent,
      automaticallyImplyLeading: false,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Leading: "Đặt lại"
          TextButton(
            onPressed: () => bloc.add(const FilterSortEvent.filtersCleared()),
            child: const Text('Đặt lại'),
          ),

          // Title
          Expanded(
            child: Center(
              child: Text(
                'Bộ lọc & sắp xếp',
                style: appTextTheme(context).titleMedium,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),

          // Action: "Áp dụng"
          TextButton(
            onPressed: () {
              bloc.add(const FilterSortEvent.filtersSubmitted());
              context.pop();
            },
            child: const Text('Áp dụng'),
          ),
        ],
      ),
      centerTitle: false, // Không cần vì title giờ nằm trong Row
    );
  }

  /// Widget riêng cho section Sắp xếp do có nút đảo chiều đặc biệt.
  Widget _buildSortSection(BuildContext context, FilterSortLoaded state, FilterSortBloc bloc) {
    final currentSortOption = state.currentParams.sortOption;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildSectionTitle(context, '📊 Sắp xếp theo'),
            if (currentSortOption.isReversible)
              TextButton.icon(
                onPressed: () => bloc.add(const FilterSortEvent.sortDirectionToggled()),
                icon: Icon(
                  currentSortOption.direction == SortDirection.desc ? Icons.arrow_downward : Icons.arrow_upward,
                  size: 16,
                ),
                label: Text(currentSortOption.direction == SortDirection.desc ? 'Giảm dần' : 'Tăng dần'),
                style: TextButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
              ),
          ],
        ),
        const SizedBox(height: 12),
        Wrap(
          spacing: 8.0,
          runSpacing: 8.0,
          children: SortOption.uniqueFields.map((field) {
            return _buildChoiceChip(
              context: context,
              label: '${field.icon} ${field.label}',
              isSelected: currentSortOption.field == field,
              onSelected: (_) {
                if (currentSortOption.field != field) {
                  bloc.add(FilterSortEvent.sortOptionSelected(SortOption(field: field, direction: SortDirection.desc)));
                }
              },
            );
          }).toList(),
        ),
      ],
    );
  }

  /// Hàm helper duy nhất để tạo và tạo kiểu cho tất cả các ChoiceChip.
  /// Việc thay đổi giao diện chip giờ chỉ cần sửa ở một nơi duy nhất.
  Widget _buildChoiceChip({
    required BuildContext context,
    required String label,
    required bool isSelected,
    required void Function(bool) onSelected,
  }) {
    return ChoiceChip(
      label: Text(label),
      labelStyle: TextStyle(
        color: isSelected ? appColorScheme(context).onPrimary : appColorScheme(context).onSurface,
      ),
      selected: isSelected,
      onSelected: onSelected,
      selectedColor: appColorScheme(context).primary,
      backgroundColor: appColorScheme(context).surfaceContainer,
      side: BorderSide(color: appColorScheme(context).outlineVariant.withValues(alpha: 0.1)),
      showCheckmark: false,
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
    );
  }

  Widget _buildSectionTitle(BuildContext context, String title) {
    return Text(
      title,
      style: appTextTheme(context).titleMedium?.copyWith(fontWeight: FontWeight.w600),
    );
  }

  Widget _buildDivider() {
    return const Padding(
      padding: EdgeInsets.symmetric(vertical: 24),
      child: Divider(height: 1, indent: 8, endIndent: 8),
    );
  }
}

/// Một widget chung, có thể tái sử dụng để hiển thị một section bộ lọc.
/// Nó bao gồm tiêu đề và một danh sách các chip.
class _FilterSection extends StatelessWidget {
  const _FilterSection({
    required this.title,
    required this.children,
  });

  final String title;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: appTextTheme(context).titleMedium?.copyWith(fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 16),
        Wrap(
          spacing: 8.0,
          runSpacing: 8.0,
          children: children,
        ),
      ],
    );
  }
}
