import 'package:dishlocal/app/theme/theme.dart';
import 'package:dishlocal/ui/features/filter_sort/bloc/filter_sort_bloc.dart';
import 'package:dishlocal/data/categories/post/model/filter_sort_model/filter_sort_params.dart';
import 'package:dishlocal/data/categories/post/model/filter_sort_model/sort_option.dart';
import 'package:dishlocal/ui/features/filter_sort/view/filter_sort_builder.dart';
import 'package:dishlocal/ui/features/select_food_category/view/expandable_food_category_chip_selector.dart';
import 'package:dishlocal/ui/widgets/containers_widgets/glass_container.dart';
import 'package:dishlocal/ui/widgets/element_widgets/glass_sliver_app_bar.dart';
import 'package:dishlocal/ui/widgets/input_widgets/custom_choice_chip.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class SortingBottomSheet extends StatelessWidget {
  const SortingBottomSheet({super.key, required this.initialParams});
  final FilterSortParams initialParams;

  static Future<FilterSortParams?> show(BuildContext context, FilterSortParams initialParams) {
    return showModalBottomSheet<FilterSortParams?>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => SortingBottomSheet(
        initialParams: initialParams,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
        // Kích thước ban đầu của sheet (85% chiều cao màn hình)
        initialChildSize: 0.61,
        // Kích thước tối đa (không cho phép kéo to hơn kích thước ban đầu)
        maxChildSize: 0.8,
        // Kích thước tối thiểu trước khi đóng (có thể đặt thấp hơn để có hiệu ứng kéo dài hơn)
        minChildSize: 0.6,
        expand: false, // Quan trọng: không để nó tự động chiếm toàn màn hình
        builder: (BuildContext context, ScrollController scrollController) {
          return FilterSortBuilder(
            initialParams: initialParams,
            builder: (context, state) {
              final bloc = context.read<FilterSortBloc>();

              return Container(
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(30)),
                  border: Border.all(
                    color: appColorScheme(context).onSurface.withValues(alpha: 0.1),
                    width: 1,
                  ),
                ),
                child: GlassContainer(
                  borderRadius: 30,
                  blur: 50,
                  radiusBottomLeft: false,
                  radiusBottomRight: false,
                  backgroundColor: Colors.black,
                  backgroundAlpha: 0.5,
                  child: Scaffold(
                    extendBodyBehindAppBar: true,
                    backgroundColor: Colors.transparent,
                    body: CustomScrollView(
                      controller: scrollController,
                      physics: const BouncingScrollPhysics(),
                      slivers: [
                        GlassSliverAppBar(
                          hasBorder: false,
                          pinned: true,
                          title: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              // Leading: "Đặt lại"
                              TextButton(
                                onPressed: () => bloc.add(const FilterSortEvent.filtersCleared()),
                                style: TextButton.styleFrom(
                                  foregroundColor: appColorScheme(context).onSurface,
                                  textStyle: appTextTheme(context).labelMedium,
                                ),
                                child: const Text('Đặt lại'),
                              ),

                              // Title
                              Expanded(
                                child: Center(
                                  child: Text(
                                    'Bộ lọc & sắp xếp',
                                    style: appTextTheme(context).labelLarge,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ),

                              // Action: "Áp dụng"
                              TextButton(
                                onPressed: () {
                                  bloc.add(const FilterSortEvent.filtersSubmitted());
                                  context.pop(state.currentParams);
                                },
                                style: TextButton.styleFrom(
                                  foregroundColor: appColorScheme(context).primary,
                                  textStyle: appTextTheme(context).labelMedium,
                                ),
                                child: const Text('Áp dụng'),
                              ),
                            ],
                          ),
                        ),
                        SliverToBoxAdapter(
                          child: Padding(
                            padding: const EdgeInsets.only(top: 16, left: 16, right: 16, bottom: 16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // --- Section Loại món ---
                                _FilterSection(
                                  title: '📋 Loại món',
                                  children: state.allCategories.map((category) {
                                    return CustomChoiceChip(
                                      context: context,
                                      label: category.label,
                                      isSelected: state.currentParams.categories.contains(category),
                                      onSelected: (_) => bloc.add(FilterSortEvent.categoryToggled(category)),
                                      itemColor: category.color,
                                    );
                                  }).toList(),
                                ),
                                const SizedBox(height: 32), // Khoảng cách giữa các section

                                // --- Section Mức giá ---
                                _FilterSection(
                                  title: '💰 Mức giá',
                                  children: state.allRanges.map((range) {
                                    return CustomChoiceChip(
                                      context: context,
                                      label: range.displayName,
                                      isSelected: state.currentParams.range == range,
                                      onSelected: (_) => bloc.add(FilterSortEvent.priceRangeToggled(range)),
                                      itemColor: Colors.amber,
                                    );
                                  }).toList(),
                                ),
                                const SizedBox(height: 32),
                                // --- Section Khoảng cách ---
                                _FilterSection(
                                  title: '📍 Khoảng cách',
                                  children: state.allDistances.map((distance) {
                                    return CustomChoiceChip(
                                      context: context,
                                      label: distance.displayName,
                                      isSelected: state.currentParams.distance == distance,
                                      onSelected: (_) => bloc.add(FilterSortEvent.distanceRangeToggled(distance)),
                                      itemColor: Colors.blue,
                                    );
                                  }).toList(),
                                ),
                                const SizedBox(height: 32),

                                // --- Section Sắp xếp (được xử lý riêng do có logic phức tạp hơn) ---
                                _buildSortSection(context, state, bloc),

                                const SizedBox(height: kBottomNavigationBarHeight + 16),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        });
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
                  textStyle: appTextTheme(context).labelMedium,
                  foregroundColor: Colors.lightGreen,
                ),
              ),
          ],
        ),
        const SizedBox(height: 12),
        Wrap(
          spacing: 8.0,
          runSpacing: 8.0,
          children: SortOption.uniqueFields.map((field) {
            return CustomChoiceChip(
              context: context,
              label: '${field.icon} ${field.label}',
              isSelected: currentSortOption.field == field,
              onSelected: (_) {
                if (currentSortOption.field != field) {
                  bloc.add(FilterSortEvent.sortOptionSelected(SortOption(field: field, direction: SortDirection.desc)));
                }
              },
              itemColor: Colors.lightGreen,
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildSectionTitle(BuildContext context, String title) {
    return Text(
      title,
      style: appTextTheme(context).labelLarge,
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
          style: appTextTheme(context).labelLarge,
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
