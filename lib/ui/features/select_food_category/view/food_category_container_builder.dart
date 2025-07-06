import 'package:dishlocal/core/dependencies_injection/service_locator.dart';
import 'package:dishlocal/core/enum/food_category.dart';
import 'package:dishlocal/ui/features/select_food_category/bloc/select_food_category_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FoodCategoryContainerBuilder extends StatelessWidget {
  const FoodCategoryContainerBuilder({super.key, required this.builder});

  final Widget Function(List<FoodCategory> allCategories, Set<FoodCategory> selectedCategories, bool allowMultiSelect) builder;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SelectFoodCategoryBloc, SelectFoodCategoryState>(
      builder: (context, state) {
        // Kiểm tra nếu trạng thái là _Loaded
        if (state is SelectFoodCategoryLoaded) {
          // Do state đã được xác nhận là _Loaded, chúng ta có thể
          // truy cập các thuộc tính của nó một cách an toàn.
          return Container(
            height: double.infinity,
            width: double.infinity,
            decoration: BoxDecoration(
              gradient: state.selectedCategories.isNotEmpty
                  ? LinearGradient(
                      colors: [
                        state.selectedCategories.first.color.withValues(alpha: 0.2),
                        Colors.transparent,
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    )
                  : null,
            ),
            child: builder(state.allCategories, state.selectedCategories, state.allowMultiSelect),
          );
        } else {
          // Nếu không phải _Loaded, thì nó là _Initial (hoặc trạng thái khác)
          // Hiển thị vòng xoay chờ.
          return const SizedBox();
        }
      },
    );
  }
}
