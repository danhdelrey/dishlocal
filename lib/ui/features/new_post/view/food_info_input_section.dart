import 'package:dishlocal/app/theme/app_icons.dart';
import 'package:dishlocal/ui/widgets/app_text_field.dart';
import 'package:flutter/material.dart';

class FoodInfoInputSection extends StatelessWidget {
  const FoodInfoInputSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainerLow,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          const SizedBox(
            height: 10,
          ),
          Text(
            'Thông tin món ăn',
            style: Theme.of(context).textTheme.labelLarge!.copyWith(
                  color: Theme.of(context).colorScheme.outline,
                ),
          ),
          const Divider(
            indent: 15,
            endIndent: 15,
          ),
          const AppTextField(
            title: 'Tên món ăn*',
            hintText: 'Nhập tên món ăn...',
            showSupportingText: false,
            maxLength: 100,
          ),
          // const Divider(
          //   indent: 15,
          //   endIndent: 15,
          // ),
          // AppTextField(
          //   title: 'Giá*',
          //   hintText: 'Nhập giá của món ăn...',
          //   showSupportingText: false,
          //   leadingIcon: AppIcons.wallet4.toSvg(
          //     width: 20,
          //   ),
          // ),
          const SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }
}
