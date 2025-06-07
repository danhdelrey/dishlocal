import 'package:dishlocal/app/theme/app_icons.dart';
import 'package:flutter/material.dart';

class AppRatingTextField extends StatelessWidget {
  const AppRatingTextField({
    super.key,
    required this.title,
    required this.hintText,
    required this.showSupportingText,
    required this.maxLength,
  });

  final String title;
  final String hintText;
  final bool showSupportingText;
  final int maxLength;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 15,
        right: 15,
        top: 10,
        bottom: 10,
      ),
      child: Column(
        children: [
          Row(
            children: [
              Text(
                title,
                style: Theme.of(context).textTheme.labelLarge!.copyWith(
                      color: Theme.of(context).colorScheme.outline,
                    ),
              ),
              const Expanded(
                child: SizedBox(),
              ),
              if (showSupportingText)
                Row(
                  children: [
                    AppIcons.informationLine.toSvg(
                      width: 14,
                      color: Theme.of(context).colorScheme.outline,
                    ),
                    const SizedBox(
                      width: 2,
                    ),
                    Text(
                      'supporting text',
                      style: Theme.of(context).textTheme.labelSmall!.copyWith(
                            color: Theme.of(context).colorScheme.outline,
                          ),
                    ),
                  ],
                ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            children: [
              AppIcons.starLine.toSvg(
                width: 20,
              ),
              const SizedBox(
                width: 5,
              ),
              AppIcons.starLine.toSvg(
                width: 20,
              ),
              const SizedBox(
                width: 5,
              ),
              AppIcons.starLine.toSvg(
                width: 20,
              ),
              const SizedBox(
                width: 5,
              ),
              AppIcons.starLine.toSvg(
                width: 20,
              ),
              const SizedBox(
                width: 5,
              ),
              AppIcons.starLine.toSvg(
                width: 20,
              ),
              const SizedBox(
                width: 5,
              ),
              AppIcons.starLine.toSvg(
                width: 20,
              ),
              const SizedBox(
                width: 5,
              ),
              AppIcons.starLine.toSvg(
                width: 20,
              ),
              const SizedBox(
                width: 5,
              ),
              AppIcons.starLine.toSvg(
                width: 20,
              ),
              const SizedBox(
                width: 5,
              ),
              AppIcons.starLine.toSvg(
                width: 20,
              ),
              const SizedBox(
                width: 5,
              ),
              AppIcons.starLine.toSvg(
                width: 20,
              ),
              const SizedBox(
                width: 5,
              ),
              Text(
                '0/10',
                style: Theme.of(context).textTheme.labelLarge!.copyWith(
                      color: Theme.of(context).colorScheme.outline,
                    ),
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          TextField(
            maxLength: maxLength,
            style: Theme.of(context).textTheme.bodyLarge,
            decoration: InputDecoration.collapsed(
              hintText: hintText,
              hintStyle: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    color: Theme.of(context).colorScheme.outlineVariant,
                  ),
            ),
            buildCounter: (context,
                    {required currentLength,
                    required isFocused,
                    required maxLength}) =>
                Text(
              '$currentLength/$maxLength',
              style: Theme.of(context).textTheme.labelSmall!.copyWith(
                    color: isFocused == false
                        ? Theme.of(context).colorScheme.outlineVariant
                        : Theme.of(context).colorScheme.onSurface,
                  ),
            ),
          ),
        ],
      ),
    );
  }
}
