import 'package:dishlocal/app/theme/app_icons.dart';
import 'package:dishlocal/app/theme/custom_colors.dart';
import 'package:dishlocal/app/theme/theme.dart';
import 'package:dishlocal/ui/features/comment/bloc/comment_bloc.dart';
import 'package:dishlocal/ui/features/comment/view/comment_bottom_sheet.dart';
import 'package:dishlocal/ui/widgets/buttons_widgets/gradient_fab.dart';
import 'package:dishlocal/ui/widgets/containers_widgets/glass_container.dart';
import 'package:dishlocal/ui/widgets/element_widgets/custom_icon_with_label.dart';
import 'package:dishlocal/ui/widgets/image_widgets/cached_circle_avatar.dart';
import 'package:dishlocal/ui/widgets/input_widgets/app_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CommentInputField extends StatefulWidget {
  const CommentInputField({super.key});

  @override
  State<CommentInputField> createState() => _CommentInputFieldState();
}

class _CommentInputFieldState extends State<CommentInputField> {
  final _textController = TextEditingController();
  final _focusNode = FocusNode();

  @override
  void dispose() {
    _textController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _submit() {
    if (_textController.text.trim().isEmpty) return;

    final bloc = context.read<CommentBloc>();
    final state = bloc.state;

    if (state.replyTarget != null) {
      bloc.add(CommentEvent.replySubmitted(content: _textController.text.trim()));
    } else {
      bloc.add(CommentEvent.commentSubmitted(content: _textController.text.trim()));
    }
    _textController.clear();
    _focusNode.unfocus();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CommentBloc, CommentState>(
      listenWhen: (p, c) => p.replyTarget != c.replyTarget,
      listener: (context, state) {
        if (state.replyTarget != null) {
          _focusNode.requestFocus();
        }
      },
      builder: (context, state) {
        return GlassContainer(
          borderRadius: 0,
          radiusBottomLeft: false,
          radiusBottomRight: false,
          radiusTopLeft: false,
          radiusTopRight: false,
          borderTop: true,
          backgroundColor: Colors.transparent,
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (state.replyTarget != null)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: Row(
                      children: [
                        CustomIconWithLabel(
                          label: 'Đang trả lời @${state.replyTarget!.replyToUsername}',
                          labelStyle: Theme.of(context).textTheme.labelMedium,
                          icon: const Icon(Icons.share),
                        ),
                        const Spacer(),
                        GestureDetector(
                          onTap: () => context.read<CommentBloc>().add(const CommentEvent.replyTargetCleared()),
                          child: Text('Hủy', style: Theme.of(context).textTheme.labelLarge!.copyWith(color: Theme.of(context).colorScheme.primary)),
                        ),
                      ],
                    ),
                  ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    CachedCircleAvatar(imageUrl: state.currentUser?.photoUrl ?? ''),
                    const SizedBox(width: 10),
                    Expanded(
                      child: AppTextField(
                        borderRadius: 20,
                        controller: _textController,
                        focusNode: _focusNode,
                        hintText: 'Viết bình luận...',
                      ),
                    ),
                    const SizedBox(width: 10),
                    Container(
                      decoration: BoxDecoration(
                        gradient: primaryGradient,
                        borderRadius: BorderRadius.circular(1000),
                      ),
                      child: Material(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.circular(1000),
                        child: InkWell(
                          onTap: _submit,
                          borderRadius: BorderRadius.circular(1000),
                          child: SizedBox(
                            width: 36,
                            height: 36,
                            child: Padding(
                              padding: const EdgeInsets.all(6.0),
                              child: AppIcons.sendFill.toSvg(
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
