import 'package:dishlocal/app/theme/theme.dart';
import 'package:dishlocal/data/categories/post/model/filter_sort_model/food_category.dart';
import 'package:dishlocal/ui/widgets/input_widgets/custom_choice_chip.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class RatingSection extends StatelessWidget {
  const RatingSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Món ăn',
          style: appTextTheme(context).labelLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
        const SizedBox(height: 10),
        RatingBar.builder(
          glow: false,
          initialRating: 3,
          minRating: 0,
          direction: Axis.horizontal,
          allowHalfRating: true,
          itemCount: 5,
          itemSize: 24,
          itemPadding: const EdgeInsets.symmetric(horizontal: 2.0),
          itemBuilder: (context, _) => const Icon(
            CupertinoIcons.star_fill,
            color: Colors.amber,
          ),
          onRatingUpdate: (rating) {
            
          },
        ),
        const SizedBox(height: 16),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: FoodCategory.values.map((category) {
            return CustomChoiceChip(
              borderRadius: 8,
              contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              label: category.label,
              isSelected: false,
              onSelected: (selected) => print('${category.label}: $selected'),
              itemColor: category.color,
            );
          }).toList(),
        ),
      ],
    );
  }
}