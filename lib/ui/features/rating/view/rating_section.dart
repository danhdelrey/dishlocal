import 'package:dishlocal/app/theme/theme.dart';
import 'package:dishlocal/data/categories/post/model/review/review_enums.dart';
import 'package:dishlocal/ui/widgets/input_widgets/custom_choice_chip.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class RatingSection extends StatelessWidget {
  const RatingSection({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: ReviewCategory.values.map((category) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  category.label,
                  style: appTextTheme(context).labelLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: category.color,
                      ),
                ),
                const SizedBox(height: 10),
                RatingBar.builder(
                  glow: false,
                  initialRating: 0,
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
                    // TODO: handle rating update
                  },
                ),
                const SizedBox(height: 16),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: category.availableChoices.map((choice) {
                    return CustomChoiceChip(
                      borderRadius: 8,
                      contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      label: choice.label,
                      isSelected: false,
                      onSelected: (selected) => print('${choice.label}: $selected'),
                      itemColor: category.color,
                    );
                  }).toList(),
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }
}
