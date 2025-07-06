import 'package:dishlocal/core/dependencies_injection/service_locator.dart';
import 'package:dishlocal/core/enum/food_category.dart';
import 'package:dishlocal/ui/features/select_food_category/bloc/select_food_category_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// Import widget tái sử dụng bạn vừa tạo
import 'expandable_chip_selector.dart';

class SortingPage extends StatelessWidget {
  const SortingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<SelectFoodCategoryBloc>()
        ..add(
          const SelectFoodCategoryEvent.initialized(
            allCategories: FoodCategory.values,
            allowMultiSelect: false,
          ),
        ),
      child: Builder(builder: (context) {
        return Scaffold(
          appBar: AppBar(title: const Text('Chọn loại món (BLoC Demo)')),
          body: BlocBuilder<SelectFoodCategoryBloc, SelectFoodCategoryState>(
            builder: (context, state) {
              // ---- BẮT ĐẦU THAY ĐỔI ----

              // Kiểm tra nếu trạng thái là _Loaded
              if (state is SelectFoodCategoryLoaded) {
                // Do state đã được xác nhận là _Loaded, chúng ta có thể
                // truy cập các thuộc tính của nó một cách an toàn.
                return Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ExpandableChipSelector(
                        title: '📋 Chọn loại món',
                        items: state.allCategories,
                        allowMultiSelect: state.allowMultiSelect,
                        selectedItems: state.selectedCategories,
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
                );
              } else {
                // Nếu không phải _Loaded, thì nó là _Initial (hoặc trạng thái khác)
                // Hiển thị vòng xoay chờ.
                return const Center(child: CircularProgressIndicator());
              }

              // ---- KẾT THÚC THAY ĐỔI ----
            },
          ),
        );
      }),
    );
  }
}
