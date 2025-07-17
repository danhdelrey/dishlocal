import 'package:dishlocal/app/theme/theme.dart';
import 'package:dishlocal/ui/features/filter_sort/view/sorting_bottom_sheet.dart';
import 'package:dishlocal/ui/features/post/bloc/post_bloc.dart';
import 'package:dishlocal/ui/features/result_search/bloc/result_search_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FilterButton extends StatelessWidget {
  const FilterButton({super.key, this.postBloc, this.resultSearchBloc});
  final PostBloc? postBloc;
  final ResultSearchBloc? resultSearchBloc;

  /// Hàm này sẽ lấy BLoC, đọc state, và mở bottom sheet
  void _openFilterSortSheet(BuildContext context) async {
    if (postBloc != null) {
      // Lấy bộ lọc hiện tại từ state của BLoC
      final currentFilters = postBloc!.state.filterSortParams;

      // Hiển thị bottom sheet và chờ kết quả trả về
      final newFilters = await SortingBottomSheet.show(context, currentFilters);

      // Nếu người dùng xác nhận một bộ lọc mới và nó khác với bộ lọc cũ,
      // gửi event 'filtersChanged' tới BLoC.
      if (newFilters != null && newFilters != currentFilters) {
        postBloc!.add(PostEvent.filtersChanged(newFilters: newFilters));
      }
    } else if (resultSearchBloc != null) {
      // Lấy bộ lọc hiện tại từ state của BLoC
      final currentFilters = resultSearchBloc!.state.filterParams;

      // Hiển thị bottom sheet và chờ kết quả trả về
      final newFilters = await SortingBottomSheet.show(context, currentFilters);

      // Nếu người dùng xác nhận một bộ lọc mới và nó khác với bộ lọc cũ,
      // gửi event 'filtersChanged' tới BLoC.
      if (newFilters != null && newFilters != currentFilters) {
        resultSearchBloc!.add(ResultSearchEvent.filtersChanged(newFilters: newFilters));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    // Sử dụng BlocBuilder để widget tự động cập nhật khi state của BLoC thay đổi.
    // Chúng ta chỉ rebuild nút này, không rebuild toàn bộ trang.
    if (postBloc != null) {
      return BlocBuilder<PostBloc, PostState>(
        // buildWhen giúp tối ưu hóa, chỉ rebuild khi filterSortParams thay đổi.
        buildWhen: (previous, current) => previous.filterSortParams != current.filterSortParams,
        builder: (context, state) {
          // Kiểm tra xem có bộ lọc nào đang được áp dụng không
          final hasActiveFilters = !state.filterSortParams.isDefault();

          return IconButton(
            onPressed: () => _openFilterSortSheet(context),
            icon: Icon(
              Icons.tune_rounded,
              size: 24,
              color: hasActiveFilters ? appColorScheme(context).primary : appColorScheme(context).onSurfaceVariant,
            ),
          );
        },
      );
    } else if (resultSearchBloc != null) {
      return BlocBuilder<ResultSearchBloc, ResultSearchState>(
        // buildWhen giúp tối ưu hóa, chỉ rebuild khi filterSortParams thay đổi.
        buildWhen: (previous, current) => previous.filterParams != current.filterParams,
        builder: (context, state) {
          // Kiểm tra xem có bộ lọc nào đang được áp dụng không
          final hasActiveFilters = !state.filterParams.isDefault();

          return IconButton(
            onPressed: () => _openFilterSortSheet(context),
            icon: Icon(
              Icons.tune_rounded,
              size: 24,
              color: hasActiveFilters ? appColorScheme(context).primary : appColorScheme(context).onSurfaceVariant,
            ),
          );
        },
      );
    }
    return const SizedBox();
  }
}
