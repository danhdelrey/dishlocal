import 'package:dishlocal/app/theme/theme.dart';
import 'package:dishlocal/ui/features/filter_sort/view/sorting_bottom_sheet.dart';
import 'package:dishlocal/ui/features/post/bloc/post_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FilterButton extends StatelessWidget {
  const FilterButton({super.key});

  /// Hàm này sẽ lấy BLoC, đọc state, và mở bottom sheet
  void _openFilterSortSheet(BuildContext context) async {
    // Lấy PostBloc từ context.
    // Điều này yêu cầu FilterButton phải được đặt trong một cây widget
    // có BlocProvider<PostBloc> ở phía trên.
    final bloc = context.read<PostBloc>();

    // Lấy bộ lọc hiện tại từ state của BLoC
    final currentFilters = bloc.state.filterSortParams;

    // Hiển thị bottom sheet và chờ kết quả trả về
    final newFilters = await SortingBottomSheet.show(context, currentFilters);

    // Nếu người dùng xác nhận một bộ lọc mới và nó khác với bộ lọc cũ,
    // gửi event 'filtersChanged' tới BLoC.
    if (newFilters != null && newFilters != currentFilters) {
      bloc.add(PostEvent.filtersChanged(newFilters: newFilters));
    }
  }

  @override
  Widget build(BuildContext context) {
    // Sử dụng BlocBuilder để widget tự động cập nhật khi state của BLoC thay đổi.
    // Chúng ta chỉ rebuild nút này, không rebuild toàn bộ trang.
    return BlocBuilder<PostBloc, PostState>(
      // buildWhen giúp tối ưu hóa, chỉ rebuild khi filterSortParams thay đổi.
      buildWhen: (previous, current) => previous.filterSortParams != current.filterSortParams,
      builder: (context, state) {
        // Kiểm tra xem có bộ lọc nào đang được áp dụng không
        final hasActiveFilters = !state.filterSortParams.isDefault();

        return Container(
          // Căn chỉnh nút sang trái
          alignment: Alignment.centerLeft,
          margin: const EdgeInsets.only(bottom: 15, left: 10, right: 10),
          child: Material(
            color: appColorScheme(context).surfaceContainer, // Màu nền nhẹ
            borderRadius: BorderRadius.circular(100), // Bo tròn như một viên thuốc (pill)
            elevation: 1,
            shadowColor: Colors.black.withOpacity(0.1),
            child: InkWell(
              onTap: () => _openFilterSortSheet(context), // Gọi hàm đã được định nghĩa
              borderRadius: BorderRadius.circular(100),
              splashColor: appColorScheme(context).primary.withOpacity(0.1),
              highlightColor: appColorScheme(context).primary.withOpacity(0.05),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  border: Border.all(
                    // Viền màu primary khi có filter, nếu không thì trong suốt
                    color: hasActiveFilters ? appColorScheme(context).primary : Colors.transparent,
                    width: 1.5,
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      // Đổi icon nếu có filter
                      hasActiveFilters ? Icons.filter_1_outlined : Icons.tune_rounded,
                      size: 20,
                      color: hasActiveFilters ? appColorScheme(context).primary : appColorScheme(context).onSurfaceVariant,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'Lọc & Sắp xếp',
                      style: appTextTheme(context).labelLarge?.copyWith(
                            fontWeight: FontWeight.w600,
                            color: hasActiveFilters ? appColorScheme(context).primary : appColorScheme(context).onSurfaceVariant,
                          ),
                    ),
                    // Hiển thị một chấm nhỏ nếu có filter đang hoạt động
                    if (hasActiveFilters)
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Container(
                          width: 8,
                          height: 8,
                          decoration: BoxDecoration(
                            color: appColorScheme(context).primary,
                            shape: BoxShape.circle,
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

