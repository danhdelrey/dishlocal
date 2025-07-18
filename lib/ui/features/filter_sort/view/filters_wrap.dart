import 'package:dishlocal/app/theme/theme.dart';
import 'package:dishlocal/data/categories/post/model/filter_sort_model/filter_sort_params.dart';
import 'package:dishlocal/data/categories/post/model/filter_sort_model/sort_option.dart';
import 'package:dishlocal/ui/features/filter_sort/view/sorting_bottom_sheet.dart';
import 'package:dishlocal/ui/features/post/bloc/post_bloc.dart';
import 'package:dishlocal/ui/features/result_search/bloc/result_search_bloc.dart';
import 'package:dishlocal/ui/widgets/input_widgets/custom_choice_chip.dart';
import 'package:flutter/material.dart';
import 'package:logging/logging.dart';

class FiltersWrap extends StatefulWidget {
  const FiltersWrap({super.key, required this.filterParams, this.postBloc, this.resultSearchBloc});
  final FilterSortParams filterParams;
  final PostBloc? postBloc;
  final ResultSearchBloc? resultSearchBloc;

  @override
  State<FiltersWrap> createState() => _FiltersWrapState();
}

class _FiltersWrapState extends State<FiltersWrap> with SingleTickerProviderStateMixin {
  bool _isExpanded = true;
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _animation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    );

    if (_isExpanded) {
      _animationController.forward();
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  /// Hàm này sẽ lấy BLoC, đọc state, và mở bottom sheet
  void _openFilterSortSheet(BuildContext context) async {
    final log = Logger('FiltersWrap'); // Tạo một logger tạm thời

    if (widget.resultSearchBloc != null) {
      final currentFilters = widget.resultSearchBloc!.state.filterParams;
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
        widget.resultSearchBloc!.add(ResultSearchEvent.filtersChanged(newFilters: newFilters));
      } else {
        log.warning('🟡 Params không thay đổi. Không gửi event.');
      }
    } else if (widget.postBloc != null) {
      final currentFilters = widget.postBloc!.state.filterSortParams;
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
        widget.postBloc!.add(PostEvent.filtersChanged(newFilters: newFilters));
      } else {
        log.warning('🟡 Params không thay đổi. Không gửi event.');
      }
    } else {
      log.severe('🔴 Không có BLoC nào được cung cấp để mở bộ lọc!');
    }
  }

  @override
  Widget build(BuildContext context) {
    final hasActiveFilters = !widget.filterParams.isDefault(widget.filterParams.context);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          hasActiveFilters
              ? GestureDetector(
                  behavior: HitTestBehavior.translucent,
                  onTap: () {
                    setState(() {
                      _isExpanded = !_isExpanded;
                      if (_isExpanded) {
                        _animationController.forward();
                      } else {
                        _animationController.reverse();
                      }
                    });
                  },
                  child: Row(
                    children: [
                      Icon(
                        Icons.tune_rounded,
                        size: 20,
                        color: appColorScheme(context).primary,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'Đã áp dụng bộ lọc',
                        style: appTextTheme(context).labelLarge?.copyWith(
                              fontWeight: FontWeight.w700,
                              color: appColorScheme(context).primary,
                            ),
                      ),
                      const SizedBox(width: 10),
                      AnimatedRotation(
                        duration: const Duration(milliseconds: 300),
                        turns: _isExpanded ? 0.5 : 0.0,
                        child: Icon(
                          Icons.expand_more,
                          color: appColorScheme(context).primary,
                        ),
                      ),
                    ],
                  ),
                )
              : GestureDetector(
                  behavior: HitTestBehavior.translucent,
                  onTap: () {
                    _openFilterSortSheet(context);
                  },
                  child: Row(
                    children: [
                      Icon(
                        Icons.tune_rounded,
                        size: 20,
                        color: appColorScheme(context).onSurface,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'Lọc và sắp xếp',
                        style: appTextTheme(context).labelLarge?.copyWith(
                              fontWeight: FontWeight.w700,
                              color: appColorScheme(context).onSurface,
                            ),
                      ),
                    ],
                  ),
                ),
          if (hasActiveFilters)
            SizeTransition(
              sizeFactor: _animation,
              child: Column(
                children: [
                  const SizedBox(height: 10),
                  Wrap(
                    spacing: 8.0,
                    runSpacing: 8.0,
                    alignment: WrapAlignment.start,
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: [
                      ..._buildFilterChips(context, widget.filterParams),
                    ],
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }

  List<Widget> _buildFilterChips(BuildContext context, FilterSortParams filterParams) {
    final hasActiveFilters = !filterParams.isDefault(filterParams.context);

    if (!hasActiveFilters) {
      return [];
    }

    final chips = <Widget>[];

    // Categories chips
    chips.addAll(filterParams.categories.map((category) => CustomChoiceChip(
          label: category.label,
          isSelected: true,
          onSelected: (_) {
            _openFilterSortSheet(context);
          },
          itemColor: category.color,
          contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
          borderRadius: 8,
        )));

    // Price range chip
    if (filterParams.range != null) {
      chips.add(CustomChoiceChip(
        label: filterParams.range!.displayName,
        isSelected: true,
        onSelected: (_) {
          _openFilterSortSheet(context);
        },
        itemColor: Colors.amber,
        contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        borderRadius: 8,
      ));
    }

    // Distance chip
    if (filterParams.distance != null) {
      chips.add(CustomChoiceChip(
        label: filterParams.distance!.displayName,
        isSelected: true,
        onSelected: (_) {
          _openFilterSortSheet(context);
        },
        itemColor: Colors.blue,
        contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        borderRadius: 8,
      ));
    }

    // Sort option chip with direction arrow
    if (filterParams.sortOption.field != SortField.relevance) {
      chips.add(CustomChoiceChip(
        label: _buildSortLabel(filterParams.sortOption),
        isSelected: true,
        onSelected: (_) {
          _openFilterSortSheet(context);
        },
        itemColor: Colors.lightGreen,
        contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        borderRadius: 8,
      ));
    }

    return chips;
  }

  String _buildSortLabel(SortOption sortOption) {
    final arrow = sortOption.direction == SortDirection.desc ? ' ↓' : ' ↑';
    return '${sortOption.field.icon} ${sortOption.field.label}$arrow';
  }
}
