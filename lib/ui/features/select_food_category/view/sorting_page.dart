import 'package:dishlocal/core/dependencies_injection/service_locator.dart';
import 'package:dishlocal/ui/features/filter_sort/model/food_category.dart';
import 'package:dishlocal/ui/features/select_food_category/bloc/select_food_category_bloc.dart';
import 'package:dishlocal/ui/features/sorting/view/sorting_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// Import widget tái sử dụng bạn vừa tạo
import 'expandable_chip_selector.dart';

class SortingPage extends StatelessWidget {
  const SortingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FilledButton(
        onPressed: () {
          SortingBottomSheet.show(context);
        },
        child: const Text('Mở Bottom Sheet'),
      ),
    );
  }
}
