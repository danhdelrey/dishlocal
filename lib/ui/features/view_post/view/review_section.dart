import 'package:dishlocal/app/theme/app_icons.dart';
import 'package:flutter/material.dart';

class ReviewSection extends StatelessWidget {
  const ReviewSection({
    super.key,
    required this.category,
    required this.comment,
  });

  final String category;
  final String comment;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          category,
          style: Theme.of(context).textTheme.labelLarge!.copyWith(
                color: Theme.of(context).colorScheme.secondary,
              ),
        ),
        Row(
          children: [
            AppIcons.starFill.toSvg(
              width: 16,
              color: Theme.of(context).colorScheme.secondary,
            ),
            AppIcons.starFill.toSvg(
              width: 16,
              color: Theme.of(context).colorScheme.secondary,
            ),
            AppIcons.starFill.toSvg(
              width: 16,
              color: Theme.of(context).colorScheme.secondary,
            ),
            AppIcons.starFill.toSvg(
              width: 16,
              color: Theme.of(context).colorScheme.secondary,
            ),
            AppIcons.starFill.toSvg(
              width: 16,
              color: Theme.of(context).colorScheme.secondary,
            ),
            AppIcons.starFill.toSvg(
              width: 16,
              color: Theme.of(context).colorScheme.secondary,
            ),
            AppIcons.starFill.toSvg(
              width: 16,
              color: Theme.of(context).colorScheme.secondary,
            ),
            AppIcons.starFill.toSvg(
              width: 16,
              color: Theme.of(context).colorScheme.secondary,
            ),
            AppIcons.starFill.toSvg(
              width: 16,
              color: Theme.of(context).colorScheme.secondary,
            ),
            AppIcons.starFill.toSvg(
              width: 16,
              color: Theme.of(context).colorScheme.secondary,
            ),
            const SizedBox(
              width: 5,
            ),
            Text(
              '10/10',
              style: Theme.of(context).textTheme.labelLarge!.copyWith(
                    color: Theme.of(context).colorScheme.secondary,
                  ),
            ),
          ],
        ),
        Text(
          comment,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      ],
    );
  }
}
