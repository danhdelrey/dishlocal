import 'package:dishlocal/app/theme/theme.dart';
import 'package:dishlocal/ui/features/chat/bloc/chat_bloc.dart';
import 'package:dishlocal/ui/widgets/input_widgets/app_text_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MessageInput extends StatefulWidget {
  const MessageInput({super.key, required this.focusNode});
  final FocusNode focusNode;

  @override
  State<MessageInput> createState() => _MessageInputState();
}

class _MessageInputState extends State<MessageInput> {
  final TextEditingController _textController = TextEditingController();

  void _sendMessage() {
    final text = _textController.text.trim();
    if (text.isNotEmpty) {
      context.read<ChatBloc>().add(ChatEvent.messageSent(content: text));
      _textController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    var canSend = _textController.text.trim().isNotEmpty;
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: appColorScheme(context).outlineVariant,
                  borderRadius: BorderRadius.circular(24),
                ),
                child: TextField(
                  autofocus: true,
                  focusNode: widget.focusNode,
                  controller: _textController,
                  decoration: InputDecoration(
                    focusColor: Colors.transparent,
                    hintText: 'Nhắn tin...',
                    hintStyle: appTextTheme(context).bodyMedium?.copyWith(
                          color: appColorScheme(context).outline,
                        ),
                    border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(24.0)),
                      borderSide: BorderSide.none,
                    ),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 16.0),
                  ),
                  onSubmitted: (_) => _sendMessage(),
                  onChanged: (value) {
                    setState(() {});
                  },
                  style: appTextTheme(context).bodyMedium,
                ),
              ),
            ),
            const SizedBox(
              width: 5,
            ),
            InkWell(
              borderRadius: BorderRadius.circular(1000),
              onTap: canSend == true ? _sendMessage : null,
              child: Icon(
                CupertinoIcons.arrow_up_circle_fill,
                size: 40,
                color: canSend ? appColorScheme(context).primary : appColorScheme(context).outlineVariant,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
