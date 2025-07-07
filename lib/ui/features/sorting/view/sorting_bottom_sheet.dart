import 'package:dishlocal/app/theme/theme.dart';
import 'package:dishlocal/ui/features/select_food_category/bloc/select_food_category_bloc.dart';
import 'package:dishlocal/ui/features/select_food_category/view/expandable_chip_selector.dart';
import 'package:dishlocal/ui/features/select_food_category/view/food_category_container_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
      child: Scaffold(
        body: FoodCategoryContainerBuilder(
            allowMultiSelect: true,
            initialFoodCategory: const {},
            builder: (context, allCategories, selectedCategories, allowMultiSelect) {
              return SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ExpandableChipSelector(
                        title: '📋 Loại món',
                        items: allCategories,
                        allowMultiSelect: allowMultiSelect,
                        selectedItems: selectedCategories,
                        onCategoryTapped: (category) {
                          context.read<SelectFoodCategoryBloc>().add(SelectFoodCategoryEvent.categoryToggled(category));
                        },
                        onSelectAllTapped: () {
                          context.read<SelectFoodCategoryBloc>().add(const SelectFoodCategoryEvent.allToggled());
                        },
                        selectAllText: '📋 Tất cả',
                        selectAllColor: Colors.indigo,
                      ),
                      const SizedBox(height: 24),
                      const Divider(),
                      const SizedBox(height: 16),
                      Text(
                        'Các mục đang được chọn:',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      const SizedBox(height: 8),
                      if (selectedCategories.isEmpty)
                        const Text('Chưa có mục nào được chọn.')
                      else
                        Wrap(
                          spacing: 8,
                          runSpacing: 8,
                          children: selectedCategories.map((category) {
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
    );
  }
}
