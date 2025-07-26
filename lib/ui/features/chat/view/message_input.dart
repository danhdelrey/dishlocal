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
  bool _canSend = false;

  @override
  void initState() {
    super.initState();
    // Lắng nghe sự thay đổi của text để cập nhật trạng thái nút gửi
    _textController.addListener(_onTextChanged);
  }

  @override
  void dispose() {
    // Hủy controller khi widget bị xóa khỏi cây widget
    _textController.removeListener(_onTextChanged);
    _textController.dispose();
    super.dispose();
  }

  void _sendMessage() {
    if (!_canSend) return; // Không làm gì nếu không thể gửi

    final text = _textController.text.trim();
    if (text.isNotEmpty) {
      context.read<ChatBloc>().add(ChatEvent.messageSent(content: text));
      _textController.clear();
      // Reset lại trạng thái của nút gửi
      setState(() {
        _canSend = false;
      });
    }
  }

  void _onTextChanged() {
    // Cập nhật trạng thái của nút gửi
    final isTextEmpty = _textController.text.trim().isEmpty;
    if (_canSend == isTextEmpty) {
      setState(() {
        _canSend = !isTextEmpty;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: appColorScheme(context).outlineVariant,
                  borderRadius: BorderRadius.circular(24),
                ),
                child: AppTextField(
                  borderRadius: 20,
                  autoFocus: true,
                  focusNode: widget.focusNode,
                  controller: _textController,
                  hintText: 'Nhắn tin...',
                ),
              ),
            ),
            if (_canSend)
              const SizedBox(
                width: 5,
              ),
            if (_canSend)
              InkWell(
                borderRadius: BorderRadius.circular(1000),
                onTap: _canSend == true ? _sendMessage : null,
                child: Icon(
                  CupertinoIcons.arrow_up_circle_fill,
                  size: 40,
                  color: _canSend ? appColorScheme(context).primary : appColorScheme(context).outlineVariant,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
