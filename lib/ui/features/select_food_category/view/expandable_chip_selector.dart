import 'package:dishlocal/core/enum/food_category.dart';
import 'package:dishlocal/ui/features/select_food_category/view/animated_category_chip.dart';
import 'package:flutter/material.dart';

class ExpandableChipSelector extends StatefulWidget {
  final String title;

  // ---- THAY ĐỔI CÁC THAM SỐ ----
  /// Danh sách các mục FoodCategory để hiển thị.
  final List<FoodCategory> items;

  /// Các mục được chọn ban đầu.
  final Set<FoodCategory> initialSelection;

  /// Callback được gọi mỗi khi lựa chọn thay đổi.
  final ValueChanged<Set<FoodCategory>> onSelectionChanged;

  final bool allowMultiSelect;
  final String? selectAllText;
  final Color? selectAllColor;

  const ExpandableChipSelector({
    super.key,
    required this.title,
    required this.items, // <-- THAY ĐỔI
    required this.onSelectionChanged, // <-- THAY ĐỔI
    this.initialSelection = const {}, // <-- THAY ĐỔI
    this.allowMultiSelect = false,
    this.selectAllText,
    this.selectAllColor,
  });

  @override
  State<ExpandableChipSelector> createState() => _ExpandableChipSelectorState();
}

class _ExpandableChipSelectorState extends State<ExpandableChipSelector> {
  // ---- THAY ĐỔI KIỂU DỮ LIỆU CỦA TRẠNG THÁI ----
  late final Set<FoodCategory> _selectedItems;
  bool _isExpanded = false;

  @override
  void initState() {
    super.initState();
    _selectedItems = Set<FoodCategory>.from(widget.initialSelection);
  }

  bool get _isAllSelected => widget.items.isNotEmpty && _selectedItems.length == widget.items.length;

  void _toggleAll() {
    setState(() {
      if (_isAllSelected) {
        _selectedItems.clear();
      } else {
        // Thêm tất cả các mục từ danh sách
        _selectedItems.addAll(widget.items);
      }
    });
    widget.onSelectionChanged(_selectedItems);
  }

  // ---- THAY ĐỔI KIỂU DỮ LIỆU CỦA THAM SỐ ----
  void _onItemSelected(FoodCategory item, bool isSelected) {
    setState(() {
      if (widget.allowMultiSelect) {
        if (isSelected) {
          _selectedItems.add(item);
        } else {
          _selectedItems.remove(item);
        }
      } else {
        _selectedItems.clear();
        if (isSelected) {
          _selectedItems.add(item);
        }
        _isExpanded = false;
      }
    });
    widget.onSelectionChanged(_selectedItems);
  }

  @override
  Widget build(BuildContext context) {
    final String buttonLabel;
    if (!widget.allowMultiSelect && _selectedItems.isNotEmpty) {
      // Lấy nhãn từ đối tượng enum đã chọn
      buttonLabel = _selectedItems.first.label; // <-- THAY ĐỔI
    } else {
      buttonLabel = widget.title;
    }

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
          transitionBuilder: (child, animation) {
            return SizeTransition(
              sizeFactor: animation,
              child: FadeTransition(opacity: animation, child: child),
            );
          },
          child: _isExpanded
              ? Wrap(
                  key: const ValueKey('expanded_chips'),
                  spacing: 10,
                  runSpacing: 10,
                  children: [
                    if (widget.allowMultiSelect && widget.selectAllText != null)
                      AnimatedCategoryChip(
                        label: widget.selectAllText!,
                        isSelected: _isAllSelected,
                        color: widget.selectAllColor ?? Colors.indigo,
                        onSelected: (_) => _toggleAll(),
                      ),

                    // ---- THAY ĐỔI LOGIC LẶP ----
                    ...widget.items.map((category) {
                      final isSelected = _selectedItems.contains(category);
                      return AnimatedCategoryChip(
                        label: category.label, // Lấy từ enum
                        isSelected: isSelected,
                        color: category.color, // Lấy từ enum
                        onSelected: (selected) => _onItemSelected(category, selected),
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
