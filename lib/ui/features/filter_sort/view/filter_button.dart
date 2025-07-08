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
          width: double.infinity, // Kéo dài toàn bộ chiều rộng
          margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
          child: Material(
            color: Colors.transparent, // Để dùng màu nền trong BoxDecoration
            borderRadius: BorderRadius.circular(12), // Bo tròn 12
            child: InkWell(
              onTap: () => _openFilterSortSheet(context),
              borderRadius: BorderRadius.circular(12),
              splashColor: appColorScheme(context).primary.withOpacity(0.1),
              highlightColor: appColorScheme(context).primary.withOpacity(0.05),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                decoration: BoxDecoration(
                  color: hasActiveFilters ? appColorScheme(context).primary.withOpacity(0.2) : Colors.transparent,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: hasActiveFilters ? appColorScheme(context).primary : Colors.white.withOpacity(0.1),
                    width: 1,
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Icon(
                      hasActiveFilters ? Icons.tune_rounded : Icons.tune_rounded,
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
