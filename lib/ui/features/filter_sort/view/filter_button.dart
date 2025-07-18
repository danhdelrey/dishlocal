import 'package:dishlocal/app/theme/theme.dart';
import 'package:dishlocal/data/categories/post/model/filter_sort_model/filter_sort_params.dart';
import 'package:dishlocal/data/categories/post/model/filter_sort_model/sort_option.dart';
import 'package:dishlocal/ui/features/filter_sort/view/filters_wrap.dart';
import 'package:dishlocal/ui/features/filter_sort/view/sorting_bottom_sheet.dart';
import 'package:dishlocal/ui/features/post/bloc/post_bloc.dart';
import 'package:dishlocal/ui/features/result_search/bloc/result_search_bloc.dart';
import 'package:dishlocal/ui/widgets/input_widgets/custom_choice_chip.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logging/logging.dart';

class FilterButton extends StatelessWidget {
  const FilterButton({
    super.key,
    this.postBloc,
    this.resultSearchBloc,
    this.showWrap = true,
  });

  final PostBloc? postBloc;
  final ResultSearchBloc? resultSearchBloc;
  final bool showWrap;

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
    } else if (postBloc != null) {
      final currentFilters = postBloc!.state.filterSortParams;
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
        postBloc!.add(PostEvent.filtersChanged(newFilters: newFilters));
      } else {
        log.warning('🟡 Params không thay đổi. Không gửi event.');
      }
    } else {
      log.severe('🔴 Không có BLoC nào được cung cấp để mở bộ lọc!');
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
          return _buildFilterWidget(context, state.filterSortParams);
        },
      );
    } else if (resultSearchBloc != null) {
      return BlocBuilder<ResultSearchBloc, ResultSearchState>(
        // buildWhen giúp tối ưu hóa, chỉ rebuild khi filterSortParams thay đổi.
        buildWhen: (previous, current) => previous.filterParams != current.filterParams,
        builder: (context, state) {
          return _buildFilterWidget(context, state.filterParams);
        },
      );
    }
    return const SizedBox();
  }

  Widget _buildFilterWidget(BuildContext context, FilterSortParams filterParams) {
    final hasActiveFilters = !filterParams.isDefault(filterParams.context);

    // Filter button
    final filterButton = showWrap
        ? InkWell(
            onTap: () => _openFilterSortSheet(context),
            borderRadius: BorderRadius.circular(2),
            child: Container(
              padding: const EdgeInsets.all(2),
              child: Row(
                children: [
                  Icon(
                    Icons.tune_rounded,
                    size: 20,
                    color: hasActiveFilters ? appColorScheme(context).primary : appColorScheme(context).onSurfaceVariant,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    hasActiveFilters ? 'Lọc & Sắp xếp (đã áp dụng)' : 'Lọc & Sắp xếp',
                    style: appTextTheme(context).labelLarge?.copyWith(
                          fontWeight: FontWeight.w700,
                          color: hasActiveFilters ? appColorScheme(context).primary : appColorScheme(context).onSurfaceVariant,
                        ),
                  ),
                ],
              ),
            ),
          )
        : IconButton(
            onPressed: () => _openFilterSortSheet(context),
            icon: Icon(
              Icons.tune_rounded,
              size: 24,
              color: hasActiveFilters ? appColorScheme(context).primary : appColorScheme(context).onSurfaceVariant,
            ),
            tooltip: hasActiveFilters ? 'Lọc & Sắp xếp (đã áp dụng)' : 'Lọc & Sắp xếp',
          );

    // Nếu showWrap = false, chỉ hiển thị nút duy nhất
    if (!showWrap) {
      return filterButton;
    }

    // Nếu showWrap = true, hiển thị wrap với tất cả filter chips

    return FiltersWrap(filterParams: filterParams, openFilterSortSheet: _openFilterSortSheet);
  }
}
