import 'package:dishlocal/app/theme/theme.dart';
import 'package:dishlocal/ui/features/filter_sort/bloc/filter_sort_bloc.dart';
import 'package:dishlocal/ui/features/filter_sort/model/sort_option.dart';
import 'package:dishlocal/ui/features/filter_sort/view/filter_sort_builder.dart';
import 'package:dishlocal/ui/features/select_food_category/bloc/select_food_category_bloc.dart';
import 'package:dishlocal/ui/features/select_food_category/view/expandable_food_category_chip_selector.dart';
import 'package:dishlocal/ui/features/select_food_category/view/food_category_builder.dart';
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
      builder: (context) => const SortingBottomSheet(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.8,
      child: ClipRRect(
        borderRadius: const BorderRadius.vertical(top: Radius.circular(30)),
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            surfaceTintColor: Colors.transparent,
            automaticallyImplyLeading: false,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  onPressed: () {
                    context.pop();
                  },
                  child: const Text('Đặt lại'),
                ),
                Text(
                  'Bộ lọc & sắp xếp',
                  style: Theme.of(context).textTheme.labelLarge,
                ),
                TextButton(
                  onPressed: () {
                    context.pop();
                  },
                  child: const Text('Đồng ý'),
                ),
              ],
            ),
          ),
          body: FilterSortBuilder(builder: (context, state) {
            final bloc = context.read<FilterSortBloc>();
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Header with Reset and Agree buttons
                    Row(
                      children: [
                        const Icon(
                          Icons.filter_alt,
                          size: 12,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          'Lọc theo',
                          style: Theme.of(context).textTheme.labelLarge,
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    ExpandableFoodCategoryChipSelector(
                      title: '📋 Loại món',
                      items: state.allCategories,
                      allowMultiSelect: true,
                      selectedItems: state.selectedCategories,
                      onCategoryTapped: (category) {
                        bloc.add(FilterSortEvent.categoryToggled(category));
                      },
                      onSelectAllTapped: () {
                        bloc.add(const FilterSortEvent.allCategoriesToggled());
                      },
                      selectAllText: '📋 Tất cả',
                      selectAllColor: Colors.indigo,
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    const Divider(),
                    // Sắp xếp section
                    Row(
                      children: [
                        const Icon(
                          Icons.sort,
                          size: 12,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          'Sắp xếp theo',
                          style: Theme.of(context).textTheme.labelLarge,
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),

                    const SizedBox(height: 24),
                    const Divider(),
                    const SizedBox(height: 16),
                    Text(
                      'Các mục đang được chọn:',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(height: 8),
                    if (state.selectedCategories.isEmpty)
                      const Text('Chưa có mục nào được chọn.')
                    else
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: state.selectedCategories.map((category) {
                          return Chip(
                            label: Text(category.label),
                            backgroundColor: category.color.withAlpha(50),
                            side: BorderSide(color: category.color),
                          );
                        }).toList(),
                      ),
                  ],
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}
