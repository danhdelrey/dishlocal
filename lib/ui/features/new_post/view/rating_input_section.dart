import 'package:dishlocal/ui/features/new_post/view/app_rating_text_field.dart';
import 'package:flutter/material.dart';

class RatingInputSection extends StatelessWidget {
  const RatingInputSection({
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
            'Đánh giá của bạn',
            style: Theme.of(context).textTheme.labelLarge!.copyWith(
                  color: Theme.of(context).colorScheme.outline,
                ),
          ),
          const Divider(
            indent: 15,
            endIndent: 15,
          ),
          const AppRatingTextField(
            title: 'Đồ ăn',
            hintText: 'Cảm nhận về đồ ăn...',
            showSupportingText: false,
            maxLength: 1000,
          ),
          const Divider(
            indent: 15,
            endIndent: 15,
          ),
          const AppRatingTextField(
            title: 'Không gian',
            hintText: 'Cảm nhận về không gian quán...',
            showSupportingText: false,
            maxLength: 1000,
          ),
          const Divider(
            indent: 15,
            endIndent: 15,
          ),
          const AppRatingTextField(
            title: 'Phục vụ',
            hintText: 'Cảm nhận về cách phục vụ...',
            showSupportingText: false,
            maxLength: 1000,
          ),
          const Divider(
            indent: 15,
            endIndent: 15,
          ),
          const AppRatingTextField(
            title: 'Giá cả',
            hintText: 'Cảm nhận về giá cả...',
            showSupportingText: false,
            maxLength: 1000,
          ),
          const SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }
}
