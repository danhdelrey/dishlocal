import 'package:dishlocal/core/enum/food_category.dart';
import 'package:flutter/material.dart';
// Import widget tái sử dụng bạn vừa tạo
import 'expandable_chip_selector.dart';

class SortingPage extends StatefulWidget {
  const SortingPage({super.key});

  @override
  State<SortingPage> createState() => _SortingPageState();
}

class _SortingPageState extends State<SortingPage> {
  // ---- THAY ĐỔI KIỂU DỮ LIỆU CỦA TRẠNG THÁI ----
  // Sử dụng Set<FoodCategory> thay vì Set<String>
  // Khởi tạo rỗng để mặc định là "Chọn loại món"
  Set<FoodCategory> _selectedCategories = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Chọn loại món (Demo)')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ExpandableChipSelector(
              title: '📋 Chọn loại món',
              // Truyền vào danh sách tất cả các giá trị của enum
              items: FoodCategory.values, // <-- THAY ĐỔI
              initialSelection: _selectedCategories,
              onSelectionChanged: (selected) {
                setState(() {
                  _selectedCategories = selected;
                });
              },
            ),
            const SizedBox(height: 24),
            const Divider(),
            const SizedBox(height: 16),
            Text(
              'Các mục đang được chọn:',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 8),
            if (_selectedCategories.isEmpty)
              const Text('Chưa có mục nào được chọn.')
            else
              Wrap(
                spacing: 8,
                runSpacing: 8,
                // ---- THAY ĐỔI LOGIC HIỂN THỊ KẾT QUẢ ----
                children: _selectedCategories.map((category) {
                  return Chip(
                    label: Text(category.label), // Lấy từ enum
                    backgroundColor: category.color.withAlpha(50), // Lấy từ enum
                    side: BorderSide(color: category.color),
                  );
                }).toList(),
              ),
          ],
        ),
      ),
    );
  }
}
