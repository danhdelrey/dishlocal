import 'package:dishlocal/app/theme/app_icons.dart';
import 'package:dishlocal/ui/widgets/app_text_field.dart';
import 'package:flutter/material.dart';

class DiningLocationInfoInputSection extends StatelessWidget {
  const DiningLocationInfoInputSection({
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
            'Thông tin quán ăn',
            style: Theme.of(context).textTheme.labelLarge!.copyWith(
                  color: Theme.of(context).colorScheme.outline,
                ),
          ),
          const Divider(
            indent: 15,
            endIndent: 15,
          ),
          const AppTextField(
            title: 'Tên quán ăn*',
            hintText: 'Nhập tên món ăn...',
            showSupportingText: false,
            maxLength: 100,
          ),
          const Divider(
            indent: 15,
            endIndent: 15,
          ),
          const AppTextField(
            title: 'Vị trí quán',
            hintText: 'Nhập vị trí quán...',
            showSupportingText: false,
          ),
          const Divider(
            indent: 15,
            endIndent: 15,
          ),
          AppTextField(
            title: 'Giờ mở cửa',
            hintText: 'Nhập giờ mở...',
            showSupportingText: false,
            leadingIcon: AppIcons.time.toSvg(
              width: 20,
            ),
          ),
          const Divider(
            indent: 15,
            endIndent: 15,
          ),
          const AppTextField(
            title: 'Chỉ dẫn đến quán',
            hintText: 'Nhập chỉ dẫn đến quán...',
            showSupportingText: false,
            maxLength: 500,
          ),
          const SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }
}
