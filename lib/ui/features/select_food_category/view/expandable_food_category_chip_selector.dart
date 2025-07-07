import 'package:dishlocal/app/theme/theme.dart';
import 'package:dishlocal/ui/features/filter_sort/model/food_category.dart';
import 'package:dishlocal/ui/features/select_food_category/view/animated_chip.dart';
import 'package:flutter/material.dart';

class ExpandableFoodCategoryChipSelector extends StatefulWidget {
  final String title;
  final List<FoodCategory> items;

  // ----- THAY ĐỔI -----
  // Nhận các mục đã chọn từ bên ngoài (từ BLoC state)
  final Set<FoodCategory> selectedItems;
  // Nhận callback để xử lý khi một mục được nhấn
  final ValueChanged<FoodCategory> onCategoryTapped;
  // -----------------

  const ExpandableFoodCategoryChipSelector({
    super.key,
    required this.title,
    required this.items,
    required this.selectedItems, // Bắt buộc
    required this.onCategoryTapped, // Bắt buộc
  });

  @override
  State<ExpandableFoodCategoryChipSelector> createState() => _ExpandableFoodCategoryChipSelectorState();
}

class _ExpandableFoodCategoryChipSelectorState extends State<ExpandableFoodCategoryChipSelector> {
  // Không cần `_selectedItems` nữa, vì trạng thái được quản lý từ bên ngoài
  bool _isExpanded = false;

  // Không cần `initState`, `_onItemSelected`, `_toggleAll` nữa

  @override
  Widget build(BuildContext context) {
    final String buttonLabel;
    if (widget.selectedItems.isNotEmpty) {
      buttonLabel = widget.selectedItems.first.label;
    } else {
      buttonLabel = '${widget.title} (Đã chọn ${widget.selectedItems.length})';
    }

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        OutlinedButton.icon(
          onPressed: () => setState(() => _isExpanded = !_isExpanded),
          icon: Icon(_isExpanded ? Icons.expand_less : Icons.expand_more),
          label: Text(
            buttonLabel,
            style: appTextTheme(context).labelLarge,
          ),
          style: ElevatedButton.styleFrom(
            shape: const StadiumBorder(),
            backgroundColor: widget.selectedItems.isNotEmpty ? widget.selectedItems.first.color.withAlpha(50) : null,
            foregroundColor: appColorScheme(context).onSurface,
            side: widget.selectedItems.isNotEmpty ? BorderSide(color: widget.selectedItems.first.color) : null,
          ),
        ),
        AnimatedSwitcher(
          duration: const Duration(milliseconds: 150),
          transitionBuilder: (child, animation) {
            return SizeTransition(
              sizeFactor: animation,
              child: FadeTransition(opacity: animation, child: child),
            );
          },
          child: _isExpanded
              ? Padding(
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  child: Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: [
                      ...widget.items.map((category) {
                        final isSelected = widget.selectedItems.contains(category);
                        return AnimatedChip(
                          label: category.label,
                          isSelected: isSelected,
                          color: category.color,
                          // ----- THAY ĐỔI -----
                          onSelected: (_) => widget.onCategoryTapped(category),
                        );
                      }),
                    ],
                  ),
                )
              : const SizedBox(key: ValueKey('collapsed_chips')),
        ),
      ],
    );
  }
}
