import 'package:dishlocal/app/theme/app_icons.dart';
import 'package:dishlocal/app/theme/theme.dart';
import 'package:dishlocal/ui/widgets/glass_container.dart';
import 'package:flutter/material.dart';
import 'package:logging/logging.dart';

class AppTextField extends StatefulWidget {
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
    this.enabled = true,
    this.autoFocus = false,
    this.focusNode,
    this.borderRadius,
    this.padding,
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
  final bool enabled;
  final bool autoFocus;
  final FocusNode? focusNode;
  final double? borderRadius;

  final EdgeInsetsGeometry? padding;

  @override
  State<AppTextField> createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  final _log = Logger('_AppTextFieldState');
  late final FocusNode _focusNode;

  @override
  void initState() {
    if (widget.focusNode != null) {
      _focusNode = widget.focusNode!;
      _log.info('Textfield ${widget.title} nhận vào một focus node.');
    } else {
      _log.info('Textfield ${widget.title} không nhận vào focus node nào');
      if (widget.enabled) {
        _log.info('Textfield ${widget.title} được enable. Tạo focus node');
        _focusNode =  FocusNode();
      } else {
        _log.info('Textfield ${widget.title} bị disabled. Không tạo focus node');
      }
    }

    super.initState();
  }

  @override
  void dispose() {
    if (widget.focusNode == null) {
      if (widget.enabled) {
        _log.info('Dispose focus node mà Textfield ${widget.title} đang quản lý.');
        _focusNode.dispose();
      } else {
        _log.info('Textfield ${widget.title} bị disabled nên trước đó nên không khởi tạo focus node nào hết, vì vậy không dispose.');
      }
    } else {
      _log.info('Focus node của Textfield ${widget.title} được nơi khác quản lý nên không dispose ở đây.');
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.enabled ? () => _focusNode.requestFocus() : null,
      child: GlassContainer(
        borderTop: true,
        borderBottom: true,
        borderLeft: true,
        borderRight: true,
        backgroundColor: Colors.transparent,
        borderRadius: widget.borderRadius ?? 12,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(widget.borderRadius ?? 12),
            border: Border.all(
              color: widget.errorText != null ? appColorScheme(context).error : Colors.transparent,
            ),
          ),
          child: Padding(
            padding: widget.padding ??
                const EdgeInsets.only(
                  left: 10,
                  right: 10,
                  top: 5,
                  bottom: 5,
                ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (widget.title != null)
                  Text(
                    widget.title!,
                    style: Theme.of(context).textTheme.labelLarge!.copyWith(
                          color: widget.errorText != null ? appColorScheme(context).error : Theme.of(context).colorScheme.outline,
                        ),
                  ),
                Row(
                  children: [
                    if (widget.leadingIcon != null)
                      Row(
                        children: [
                          widget.leadingIcon!,
                          const SizedBox(
                            width: 10,
                          ),
                        ],
                      ),
                    Expanded(
                      child: TextFormField(
                        focusNode: widget.focusNode,
                        autofocus: widget.autoFocus,
                        enabled: widget.enabled,
                        initialValue: widget.initialValue,
                        onChanged: widget.onChanged,
                        keyboardType: TextInputType.multiline,
                        minLines: 1,
                        maxLines: 5,
                        maxLength: widget.maxLength,
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                              color: widget.enabled ? appColorScheme(context).onSurface : appColorScheme(context).outline,
                            ),
                        decoration: InputDecoration.collapsed(
                          hintText: widget.hintText,
                          hintStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                color: Theme.of(context).colorScheme.outlineVariant,
                              ),
                        ),
                        buildCounter: (context, {required currentLength, required isFocused, required maxLength}) => null,
                      ),
                    ),
                    if (widget.trailingIcon != null)
                      Row(
                        children: [
                          const SizedBox(
                            width: 10,
                          ),
                          widget.trailingIcon!,
                        ],
                      ),
                  ],
                ),
                if (widget.errorText != null)
                  Padding(
                    padding: const EdgeInsets.only(top: 5.0),
                    child: Text(
                      widget.errorText!,
                      style: Theme.of(context).textTheme.labelSmall!.copyWith(
                            color: Theme.of(context).colorScheme.error,
                          ),
                    ),
                  ),
                if (widget.supportingText != null)
                  Padding(
                    padding: const EdgeInsets.only(top: 5.0),
                    child: Text(
                      widget.supportingText!,
                      style: Theme.of(context).textTheme.labelSmall!.copyWith(
                            color: Theme.of(context).colorScheme.outline,
                          ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
