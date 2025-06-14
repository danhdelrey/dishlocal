import 'package:dishlocal/app/theme/app_icons.dart';
import 'package:dishlocal/app/theme/theme.dart';
import 'package:dishlocal/ui/widgets/glass_container.dart';
import 'package:flutter/material.dart';

class AppTextField extends StatelessWidget {
  const AppTextField({
    super.key,
    this.title,
    this.hintText,
    this.supportingText,
    this.leadingIcon,
    this.trailingIcon,
    this.maxLength,
    this.initialValue,
    this.onChanged,
    this.errorText,
    this.enabled,
    this.autoFocus = false,
    this.focusNode,
    this.borderRadius,
  });

  final String? title;
  final String? hintText;
  final String? supportingText;
  final Widget? leadingIcon;
  final Widget? trailingIcon;
  final int? maxLength;

  final String? initialValue;
  final ValueChanged<String>? onChanged;
  final String? errorText;
  final bool? enabled;
  final bool autoFocus;
  final FocusNode? focusNode;
  final double? borderRadius;

  @override
  Widget build(BuildContext context) {
    return GlassContainer(
      borderTop: true,
      borderBottom: true,
      borderLeft: true,
      borderRight: true,
      backgroundColor: Colors.transparent,
      borderRadius: borderRadius ?? 12,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(borderRadius ?? 12),
          border: Border.all(
            color: errorText != null ? appColorScheme(context).error : Colors.transparent,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.only(
            left: 10,
            right: 10,
            top: 5,
            bottom: 5,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (title != null)
                Text(
                  title!,
                  style: Theme.of(context).textTheme.labelLarge!.copyWith(
                        color: errorText != null ? appColorScheme(context).error : Theme.of(context).colorScheme.outline,
                      ),
                ),
              Row(
                children: [
                  if (leadingIcon != null)
                    Row(
                      children: [
                        leadingIcon!,
                        const SizedBox(
                          width: 10,
                        ),
                      ],
                    ),
                  Expanded(
                    child: TextFormField(
                      focusNode: focusNode,
                      autofocus: autoFocus,
                      enabled: enabled,
                      initialValue: initialValue,
                      onChanged: onChanged,
                      keyboardType: TextInputType.multiline,
                      minLines: 1,
                      maxLines: 5,
                      maxLength: maxLength,
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            color: enabled != null ? appColorScheme(context).outline : appColorScheme(context).onSurface,
                          ),
                      decoration: InputDecoration.collapsed(
                        hintText: hintText,
                        hintStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
                              color: Theme.of(context).colorScheme.outlineVariant,
                            ),
                      ),
                      buildCounter: (context, {required currentLength, required isFocused, required maxLength}) => null,
                    ),
                  ),
                  if (trailingIcon != null)
                    Row(
                      children: [
                        const SizedBox(
                          width: 10,
                        ),
                        trailingIcon!,
                      ],
                    ),
                ],
              ),
              if (errorText != null)
                Padding(
                  padding: const EdgeInsets.only(top: 5.0),
                  child: Text(
                    errorText!,
                    style: Theme.of(context).textTheme.labelSmall!.copyWith(
                          color: Theme.of(context).colorScheme.error,
                        ),
                  ),
                ),
              if (supportingText != null)
                Padding(
                  padding: const EdgeInsets.only(top: 5.0),
                  child: Text(
                    supportingText!,
                    style: Theme.of(context).textTheme.labelSmall!.copyWith(
                          color: Theme.of(context).colorScheme.outline,
                        ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
