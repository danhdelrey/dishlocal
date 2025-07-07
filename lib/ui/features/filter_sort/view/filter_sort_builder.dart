import 'package:dishlocal/core/dependencies_injection/service_locator.dart';
import 'package:dishlocal/ui/features/filter_sort/bloc/filter_sort_bloc.dart';
import 'package:dishlocal/ui/features/filter_sort/model/food_category.dart';
import 'package:dishlocal/ui/features/filter_sort/model/price_range.dart';
import 'package:dishlocal/ui/features/filter_sort/model/sort_option.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FilterSortBuilder extends StatelessWidget {
  const FilterSortBuilder({
    super.key,
    required this.builder,
    this.initialCategories,
    this.initialRange,
    this.initialSort,
  });

  /// Các lựa chọn ban đầu khi khởi tạo widget.
  final Set<FoodCategory>? initialCategories;
  final PriceRange? initialRange;
  final SortOption? initialSort;

  /// Hàm builder được gọi mỗi khi trạng thái thay đổi.
  final Widget Function(
    BuildContext context,
    FilterSortLoaded state,
  ) builder;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<FilterSortBloc>()
        ..add(
          FilterSortEvent.initialized(
            initialCategories: initialCategories,
            initialRange: initialRange,
            initialSort: initialSort,
          ),
        ),
      child: BlocBuilder<FilterSortBloc, FilterSortState>(
        builder: (context, state) {
          if (state is FilterSortLoaded) {
            return builder(context, state);
          } else {
            return const SizedBox.shrink();
          }
        },
      ),
    );
  }
}
