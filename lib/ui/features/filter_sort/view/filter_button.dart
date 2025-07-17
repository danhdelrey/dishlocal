import 'package:dishlocal/app/theme/theme.dart';
import 'package:dishlocal/ui/features/filter_sort/view/sorting_bottom_sheet.dart';
import 'package:dishlocal/ui/features/post/bloc/post_bloc.dart';
import 'package:dishlocal/ui/features/result_search/bloc/result_search_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logging/logging.dart';

class FilterButton extends StatelessWidget {
  const FilterButton({super.key, this.postBloc, this.resultSearchBloc});
  final PostBloc? postBloc;
  final ResultSearchBloc? resultSearchBloc;

  /// Hàm này sẽ lấy BLoC, đọc state, và mở bottom sheet
  void _openFilterSortSheet(BuildContext context) async {
    final log = Logger('FilterButton'); // Tạo một logger tạm thời

    if (resultSearchBloc != null) {
      final currentFilters = resultSearchBloc!.state.filterParams;
      log.info('🔵 Mở bộ lọc với params hiện tại: ${currentFilters.toVietnameseString}');

      final newFilters = await SortingBottomSheet.show(context, currentFilters);

      // LOG KẾT QUẢ TRẢ VỀ TỪ BOTTOM SHEET
      if (newFilters == null) {
        log.warning('🟡 Bottom sheet đã đóng mà không có kết quả (newFilters is null).');
        return;
      }

      log.info('🟢 Bottom sheet trả về params mới: ${newFilters.toVietnameseString}');

      // So sánh và gửi event
      if (newFilters != currentFilters) {
        log.info('✅ Params đã thay đổi! Gửi event filtersChanged...');
        resultSearchBloc!.add(ResultSearchEvent.filtersChanged(newFilters: newFilters));
      } else {
        log.warning('🟡 Params không thay đổi. Không gửi event.');
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
          final hasActiveFilters = !state.filterSortParams.isDefault(state.filterSortParams.context);

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
          final hasActiveFilters = !state.filterParams.isDefault(state.filterParams.context);

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
