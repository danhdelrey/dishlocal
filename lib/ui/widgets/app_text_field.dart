import 'package:dishlocal/app/theme/app_icons.dart';
import 'package:flutter/material.dart';

class AppTextField extends StatelessWidget {
  const AppTextField({
    super.key,
    required this.title,
    required this.hintText,
    required this.showSupportingText,
    this.showLeadingIcon = false,
    this.maxLength,
  });

  final String title;
  final String hintText;
  final bool showSupportingText;
  final bool showLeadingIcon;

  final int? maxLength;

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
            height: 5,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (showLeadingIcon)
                Row(
                  children: [
                    AppIcons.wallet4.toSvg(),
                    const SizedBox(
                      width: 10,
                    ),
                  ],
                ),
              Expanded(
                child: TextFormField(
                  maxLength: maxLength,
                  style: Theme.of(context).textTheme.bodyLarge,
                  decoration: InputDecoration.collapsed(
                    hintText: hintText,
                    hintStyle: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          color: Theme.of(context).colorScheme.outlineVariant,
                        ),
                  ),
                  buildCounter: maxLength != null
                      ? (context,
                              {required currentLength,
                              required isFocused,
                              required maxLength}) =>
                          Text(
                            '$currentLength/$maxLength',
                            style: Theme.of(context)
                                .textTheme
                                .labelSmall!
                                .copyWith(
                                  color: isFocused == false
                                      ? Theme.of(context).colorScheme.outline
                                      : Theme.of(context).colorScheme.onSurface,
                                ),
                          )
                      : null,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
