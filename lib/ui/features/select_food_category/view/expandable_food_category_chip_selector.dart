import 'package:dishlocal/app/theme/theme.dart';
import 'package:dishlocal/data/categories/post/model/filter_sort_model/food_category.dart';
import 'package:dishlocal/ui/features/select_food_category/view/animated_chip.dart';
import 'package:dishlocal/ui/widgets/input_widgets/custom_choice_chip.dart';
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
      buttonLabel = widget.title;
    }

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: () => setState(() => _isExpanded = !_isExpanded),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            decoration: BoxDecoration(
              color: widget.selectedItems.isNotEmpty ? widget.selectedItems.first.color.withValues(alpha: 0.5) : Colors.transparent,
              borderRadius: BorderRadius.circular(12),
              border: widget.selectedItems.isNotEmpty
                  ? Border.all(
                      color: widget.selectedItems.first.color,
                      width: 1,
                    )
                  : Border.all(
                      color: appColorScheme(context).onSurface.withValues(alpha: 0.1),
                      width: 1,
                    ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  buttonLabel,
                  style: appTextTheme(context).labelMedium?.copyWith(
                        color: widget.selectedItems.isNotEmpty ? appColorScheme(context).onSurface : appColorScheme(context).onSurface,
                      ),
                ),
                const SizedBox(width: 8),
                Icon(
                  _isExpanded ? Icons.expand_less : Icons.expand_more,
                  size: 20,
                  color: widget.selectedItems.isNotEmpty ? appColorScheme(context).onSurface : appColorScheme(context).onSurface,
                ),
              ],
            ),
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
                        return CustomChoiceChip(
                          label: category.label,
                          isSelected: isSelected,
                          itemColor: category.color,
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
