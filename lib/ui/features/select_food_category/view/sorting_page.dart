import 'package:dishlocal/core/dependencies_injection/service_locator.dart';
import 'package:dishlocal/data/categories/post/model/filter_sort_model/filter_sort_params.dart';
import 'package:dishlocal/data/categories/post/model/filter_sort_model/food_category.dart';
import 'package:dishlocal/ui/features/select_food_category/bloc/select_food_category_bloc.dart';
import 'package:dishlocal/ui/features/filter_sort/view/sorting_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// Import widget tái sử dụng bạn vừa tạo

class SortingPage extends StatefulWidget {
  const SortingPage({super.key});

  @override
  State<SortingPage> createState() => _SortingPageState();
}

class _SortingPageState extends State<SortingPage> {
  // Biến state để lưu trữ các tham số bộ lọc đã được áp dụng.
  // Ban đầu là null, nghĩa là chưa có bộ lọc nào.
  FilterSortParams? _appliedFilters;

  // Hàm để mở bottom sheet và xử lý kết quả trả về.
  Future<void> _openFilterSheet() async {
    // Gọi và chờ kết quả từ bottom sheet.
    // `showModalBottomSheet` trả về giá trị được truyền trong `context.pop(result)`.
    final result = await SortingBottomSheet.show(context);

    // Kiểm tra xem người dùng có nhấn "Áp dụng" hay không (result không null)
    // và kết quả có đúng là kiểu FilterSortParams không.
    if (result is FilterSortParams) {
      // Nếu có kết quả, cập nhật state của widget để build lại UI.
      setState(() {
        _appliedFilters = result;
      });
    }
    // Nếu người dùng đóng sheet mà không nhấn "Áp dụng", result sẽ là null
    // và chúng ta không làm gì cả.
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Trang Lọc & Sắp Xếp'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Khu vực hiển thị các bộ lọc đang được áp dụng
              _buildAppliedFiltersDisplay(),

              const SizedBox(height: 40),

              // Nút để mở bottom sheet
              FilledButton.icon(
                onPressed: _openFilterSheet,
                icon: const Icon(Icons.filter_list),
                label: const Text('Mở Bộ lọc'),
                style: FilledButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  textStyle: Theme.of(context).textTheme.titleMedium,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Widget để hiển thị các bộ lọc và tùy chọn sắp xếp đã được chọn.
  Widget _buildAppliedFiltersDisplay() {
    // Lấy bộ lọc từ state
    final params = _appliedFilters;

    // Nếu chưa có bộ lọc nào, hiển thị một thông báo
    if (params == null) {
      return Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surfaceContainer,
          borderRadius: BorderRadius.circular(12),
        ),
        child: const Center(
          child: Text(
            'Chưa có bộ lọc nào được áp dụng.\nNhấn nút bên dưới để bắt đầu.',
            textAlign: TextAlign.center,
          ),
        ),
      );
    }

    // Nếu có bộ lọc, xây dựng danh sách các chip để hiển thị
    // Sử dụng `List.generate` và `where` để code gọn gàng hơn
    final List<Widget> filterChips = [
      // Luôn hiển thị chip sắp xếp
      Chip(
        avatar: const Icon(Icons.sort, size: 18),
        label: Text(params.sortOption.displayName),
        backgroundColor: Theme.of(context).colorScheme.tertiaryContainer,
      ),

      // Thêm các chip khác nếu chúng tồn tại
      if (params.range != null)
        Chip(
          avatar: const Icon(Icons.attach_money, size: 18),
          label: Text(params.range!.displayName),
        ),
      if (params.distance != null)
        Chip(
          avatar: const Icon(Icons.location_on_outlined, size: 18),
          label: Text(params.distance!.displayName),
        ),
      // Thêm tất cả các chip danh mục
      ...params.categories.map((category) => Chip(
            label: Text(category.label),
            backgroundColor: category.color.withOpacity(0.2), // Dùng màu của danh mục
          )),
    ];

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Theme.of(context).colorScheme.outlineVariant),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Bộ lọc đang áp dụng:',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8.0,
            runSpacing: 8.0,
            children: filterChips,
          ),
        ],
      ),
    );
  }
}
