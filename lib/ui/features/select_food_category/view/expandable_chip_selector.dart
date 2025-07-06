import 'package:dishlocal/core/enum/food_category.dart';
import 'package:dishlocal/ui/features/select_food_category/view/animated_category_chip.dart';
import 'package:flutter/material.dart';

class ExpandableChipSelector extends StatefulWidget {
  final String title;
  final List<FoodCategory> items;
  final bool allowMultiSelect;

  // ----- THAY ĐỔI -----
  // Nhận các mục đã chọn từ bên ngoài (từ BLoC state)
  final Set<FoodCategory> selectedItems;
  // Nhận callback để xử lý khi một mục được nhấn
  final ValueChanged<FoodCategory> onCategoryTapped;
  // Nhận callback cho nút "Chọn tất cả"
  final VoidCallback? onSelectAllTapped;
  // -----------------

  final String? selectAllText;
  final Color? selectAllColor;

  const ExpandableChipSelector({
    super.key,
    required this.title,
    required this.items,
    required this.selectedItems, // Bắt buộc
    required this.onCategoryTapped, // Bắt buộc
    this.onSelectAllTapped,
    this.allowMultiSelect = false,
    this.selectAllText,
    this.selectAllColor,
  });

  @override
  State<ExpandableChipSelector> createState() => _ExpandableChipSelectorState();
}

class _ExpandableChipSelectorState extends State<ExpandableChipSelector> {
  // Không cần `_selectedItems` nữa, vì trạng thái được quản lý từ bên ngoài
  bool _isExpanded = false;

  // Không cần `initState`, `_onItemSelected`, `_toggleAll` nữa

  @override
  Widget build(BuildContext context) {
    final String buttonLabel;
    if (!widget.allowMultiSelect && widget.selectedItems.isNotEmpty) {
      buttonLabel = widget.selectedItems.first.label;
    } else {
      buttonLabel = widget.title;
    }

    final isAllSelected = widget.allowMultiSelect && widget.items.isNotEmpty && widget.selectedItems.length == widget.items.length;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        ElevatedButton.icon(
          onPressed: () => setState(() => _isExpanded = !_isExpanded),
          icon: Icon(_isExpanded ? Icons.expand_less : Icons.expand_more),
          label: Text(buttonLabel, style: const TextStyle(fontSize: 16)),
          style: ElevatedButton.styleFrom(shape: const StadiumBorder()),
        ),
        const SizedBox(height: 12),
        AnimatedSwitcher(
          duration: const Duration(milliseconds: 150),
          // ... (giữ nguyên transitionBuilder)
          child: _isExpanded
              ? Wrap(
                  // ... (giữ nguyên Wrap)
                  children: [
                    if (widget.allowMultiSelect && widget.selectAllText != null)
                      AnimatedCategoryChip(
                        label: widget.selectAllText!,
                        isSelected: isAllSelected,
                        color: widget.selectAllColor ?? Colors.indigo,
                        // ----- THAY ĐỔI -----
                        onSelected: (_) => widget.onSelectAllTapped?.call(),
                      ),
                    ...widget.items.map((category) {
                      final isSelected = widget.selectedItems.contains(category);
                      return AnimatedCategoryChip(
                        label: category.label,
                        isSelected: isSelected,
                        color: category.color,
                        // ----- THAY ĐỔI -----
                        onSelected: (_) => widget.onCategoryTapped(category),
                      );
                    }),
                  ],
                )
              : const SizedBox(key: ValueKey('collapsed_chips')),
        ),
      ],
    );
  }
}
