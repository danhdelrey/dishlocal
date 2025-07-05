import 'package:dishlocal/ui/widgets/selector/animated_category_chip.dart';
import 'package:flutter/material.dart';

// AnimatedCategoryChip không thay đổi nhiều, vẫn là một widget phụ trợ tốt.
// Tôi đã để nó ở cuối file này để dễ quản lý.
// Bạn cũng có thể tách nó ra file riêng nếu muốn.

class ExpandableChipSelector extends StatefulWidget {
  /// Tiêu đề hiển thị trên nút expand/collapse.
  final String title;

  /// Map chứa các mục để hiển thị. Key là nhãn (label), Value là màu sắc.
  final Map<String, Color> items;

  /// Các mục được chọn ban đầu khi widget được tạo.
  final Set<String> initialSelection;

  /// Cho phép chọn nhiều mục hay không. Mặc định là false (chỉ chọn một).
  final bool allowMultiSelect;

  /// Văn bản cho nút "Chọn tất cả". Chỉ hiển thị nếu `allowMultiSelect` là true.
  final String? selectAllText;

  /// Màu sắc cho nút "Chọn tất cả".
  final Color? selectAllColor;

  /// Callback được gọi mỗi khi lựa chọn thay đổi, trả về một Set các mục đã chọn.
  final ValueChanged<Set<String>> onSelectionChanged;

  const ExpandableChipSelector({
    super.key,
    required this.title,
    required this.items,
    required this.onSelectionChanged,
    this.initialSelection = const {},
    this.allowMultiSelect = false,
    this.selectAllText,
    this.selectAllColor,
  });

  @override
  State<ExpandableChipSelector> createState() => _ExpandableChipSelectorState();
}

class _ExpandableChipSelectorState extends State<ExpandableChipSelector> {
  // Trạng thái nội bộ của widget
  late final Set<String> _selectedItems;
  bool _isExpanded = false;

  @override
  void initState() {
    super.initState();
    // Khởi tạo các mục đã chọn từ tham số đầu vào
    _selectedItems = Set<String>.from(widget.initialSelection);
  }

  // Getter để kiểm tra xem tất cả có được chọn không
  bool get _isAllSelected => _selectedItems.length == widget.items.length;

  // Hàm xử lý khi nhấn nút "Chọn tất cả"
  void _toggleAll() {
    setState(() {
      if (_isAllSelected) {
        _selectedItems.clear();
      } else {
        _selectedItems.addAll(widget.items.keys);
      }
    });
    // Thông báo cho widget cha về sự thay đổi
    widget.onSelectionChanged(_selectedItems);
  }

  // Hàm xử lý khi chọn một mục
  void _onItemSelected(String item, bool isSelected) {
    setState(() {
      if (widget.allowMultiSelect) {
        // Chế độ chọn nhiều
        if (isSelected) {
          _selectedItems.add(item);
        } else {
          _selectedItems.remove(item);
        }
      } else {
        // Chế độ chọn một
        _selectedItems.clear();
        if (isSelected) {
          _selectedItems.add(item);
        }
      }
    });
    // Thông báo cho widget cha về sự thay đổi
    widget.onSelectionChanged(_selectedItems);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min, // Giúp Column chỉ chiếm không gian cần thiết
      children: [
        // Nút mở rộng/thu gọn
        ElevatedButton.icon(
          onPressed: () => setState(() => _isExpanded = !_isExpanded),
          icon: Icon(_isExpanded ? Icons.expand_less : Icons.expand_more),
          label: Text(
            widget.title,
            style: const TextStyle(fontSize: 16),
          ),
          style: ElevatedButton.styleFrom(
            shape: const StadiumBorder(),
          ),
        ),
        const SizedBox(height: 12),

        // AnimatedSwitcher để trào mượt
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
                    // Nút "Chọn tất cả" (nếu được cho phép)
                    if (widget.allowMultiSelect && widget.selectAllText != null)
                      AnimatedCategoryChip(
                        label: widget.selectAllText!,
                        isSelected: _isAllSelected,
                        color: widget.selectAllColor ?? Colors.indigo,
                        onSelected: (_) => _toggleAll(),
                      ),
                    // Danh sách các mục
                    ...widget.items.entries.map((entry) {
                      final label = entry.key;
                      final color = entry.value;
                      final isSelected = _selectedItems.contains(label);
                      return AnimatedCategoryChip(
                        label: label,
                        isSelected: isSelected,
                        color: color,
                        onSelected: (selected) => _onItemSelected(label, selected),
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


