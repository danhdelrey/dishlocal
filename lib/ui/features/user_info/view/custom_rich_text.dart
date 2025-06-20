import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class CustomRichText extends StatelessWidget {
  const CustomRichText({
    super.key,
    required this.label1,
    required this.description1,
    required this.label2,
    required this.description2,
  });

  final String label1;
  final String description1;
  final String label2;
  final String description2;

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        style: Theme.of(context).textTheme.titleMedium,
        children: [
          TextSpan(
            text: label1,
            style: Theme.of(context).textTheme.labelMedium!.copyWith(
                  color: Theme.of(context).colorScheme.onSurface,
                ),
            recognizer: TapGestureRecognizer()..onTap = () {},
            children: [
              TextSpan(
                text: description1,
                style: Theme.of(context).textTheme.labelMedium!.copyWith(
                      color: Theme.of(context).colorScheme.outline,
                    ),
              ),
            ],
          ),
          TextSpan(
            text: label2,
            style: Theme.of(context).textTheme.labelMedium!.copyWith(
                  color: Theme.of(context).colorScheme.onSurface,
                ),
            recognizer: TapGestureRecognizer()..onTap = () {},
            children: [
              TextSpan(
                text: description2,
                style: Theme.of(context).textTheme.labelMedium!.copyWith(
                      color: Theme.of(context).colorScheme.outline,
                    ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
