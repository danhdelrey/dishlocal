import 'package:dishlocal/core/dependencies_injection/service_locator.dart';
import 'package:dishlocal/ui/features/filter_sort/bloc/filter_sort_bloc.dart';
import 'package:dishlocal/data/categories/post/model/filter_sort_model/filter_sort_params.dart';
import 'package:dishlocal/data/categories/post/model/filter_sort_model/food_category.dart';
import 'package:dishlocal/data/categories/post/model/filter_sort_model/price_range.dart';
import 'package:dishlocal/data/categories/post/model/filter_sort_model/sort_option.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FilterSortBuilder extends StatelessWidget {
  const FilterSortBuilder({
    super.key,
    required this.builder,
    this.initialParams, // <-- Đổi thành initialParams
  });

  final FilterSortParams? initialParams; // <-- Đổi thành FilterSortParams

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
            initialParams: initialParams, // <-- Truyền vào đây
          ),
        ),
      child: BlocBuilder<FilterSortBloc, FilterSortState>(
        builder: (context, state) {
          if (state is FilterSortLoaded) {
            return builder(context, state);
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
