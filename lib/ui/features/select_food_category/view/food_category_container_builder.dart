import 'package:dishlocal/core/dependencies_injection/service_locator.dart';
import 'package:dishlocal/core/enum/food_category.dart';
import 'package:dishlocal/ui/features/select_food_category/bloc/select_food_category_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FoodCategoryContainerBuilder extends StatelessWidget {
  const FoodCategoryContainerBuilder({super.key, required this.builder, this.allowMultiSelect = false, required this.initialFoodCategory});

  final Widget Function(BuildContext context, List<FoodCategory> allCategories, Set<FoodCategory> selectedCategories, bool allowMultiSelect) builder;
  final bool allowMultiSelect;
  final Set<FoodCategory> initialFoodCategory;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<SelectFoodCategoryBloc>()
        ..add(
          SelectFoodCategoryEvent.initialized(
            allCategories: FoodCategory.values,
            allowMultiSelect: allowMultiSelect,
            initialSelection: initialFoodCategory,
          ),
        ),
      child: BlocBuilder<SelectFoodCategoryBloc, SelectFoodCategoryState>(
        builder: (context, state) {
          // Kiểm tra nếu trạng thái là _Loaded
          if (state is SelectFoodCategoryLoaded) {
            // Do state đã được xác nhận là _Loaded, chúng ta có thể
            // truy cập các thuộc tính của nó một cách an toàn.
            return builder(context, state.allCategories, state.selectedCategories, state.allowMultiSelect);
          } else {
            // Nếu không phải _Loaded, thì nó là _Initial (hoặc trạng thái khác)
            // Hiển thị vòng xoay chờ.
            return const SizedBox();
          }
        },
      ),
    );
  }
}
