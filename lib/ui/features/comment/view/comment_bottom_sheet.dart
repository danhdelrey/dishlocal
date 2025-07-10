import 'package:dishlocal/app/theme/app_icons.dart';
import 'package:dishlocal/app/theme/theme.dart';
import 'package:dishlocal/data/categories/comment/model/comment.dart';
import 'package:dishlocal/data/categories/comment/model/comment_reply.dart';
import 'package:dishlocal/ui/features/comment/bloc/comment_bloc.dart';
import 'package:dishlocal/ui/features/comment/view/comment_input_field.dart';
import 'package:dishlocal/ui/features/comment/view/comment_list_view.dart';
import 'package:dishlocal/ui/widgets/containers_widgets/glass_container.dart';
import 'package:dishlocal/ui/widgets/element_widgets/custom_icon_with_label.dart';
import 'package:dishlocal/ui/widgets/image_widgets/cached_circle_avatar.dart';
import 'package:dishlocal/ui/widgets/input_widgets/app_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart'; // Giả sử bạn dùng get_it
import 'package:timeago/timeago.dart' as timeago; // Thư viện để hiển thị "4 giờ trước"

/// Hiển thị bottom sheet chứa toàn bộ giao diện bình luận cho một bài viết.
void showCommentBottomSheet(
  BuildContext context, {
  required String postId,
  required String postAuthorId,
  required int totalCommentCount,
}) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (_) {
      return BlocProvider(
        create: (context) => GetIt.instance<CommentBloc>()
          ..add(CommentEvent.initialized(
            postId: postId,
            totalCommentCount: totalCommentCount,
          )),
        child: CommentBottomSheet(postAuthorId: postAuthorId),
      );
    },
  );
}

class CommentBottomSheet extends StatefulWidget {
  final String postAuthorId;
  const CommentBottomSheet({super.key, required this.postAuthorId});

  @override
  State<CommentBottomSheet> createState() => _CommentBottomSheetState();
}

class _CommentBottomSheetState extends State<CommentBottomSheet> {
  @override
  void initState() {
    super.initState();
  }

  void _showErrorDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        // Sử dụng dialogContext để đóng dialog
        return AlertDialog(
          // Dùng theme để có màu sắc và font chữ nhất quán
          backgroundColor: Theme.of(context).colorScheme.surface,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.0),
          ),
          title: Row(
            children: [
              Icon(
                Icons.warning_amber_rounded,
                color: Theme.of(context).colorScheme.error,
              ),
              const SizedBox(width: 10),
              const Text('Thông báo'),
            ],
          ),
          content: Text(
            message,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Đã hiểu'),
              onPressed: () {
                // Đóng dialog
                Navigator.of(dialogContext).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<CommentBloc, CommentState>(
      listener: (context, state) {
        // Sử dụng thuộc tính `failureMessage` như đã thống nhất
        // hoặc `state.failure.message` nếu bạn vẫn dùng lớp Failure
        final errorMessage = state.failure?.message;
        if (errorMessage != null) {
          // Gọi hàm hiển thị Dialog
          _showErrorDialog(context, errorMessage);
          // QUAN TRỌNG: Reset trạng thái lỗi trong BLoC để dialog không hiện lại
          // khi người dùng đóng nó và state được build lại.
          context.read<CommentBloc>().add(const CommentEvent.errorCleared());
        }
      },
      child: DraggableScrollableSheet(
          // Kích thước ban đầu 90% màn hình
          initialChildSize: 0.8,
          // Kích thước tối đa
          maxChildSize: 0.8,
          // Kích thước tối thiểu, cho phép kéo xuống một khoảng trước khi đóng
          minChildSize: 0.6,
          expand: false,
          builder: (BuildContext context, ScrollController scrollController) {
            return GlassContainer(
              borderRadius: 20,
              radiusBottomLeft: false,
              radiusBottomRight: false,
              blur: 50,
              backgroundColor: Colors.black,
              backgroundAlpha: 0.5,
              child: Stack(
                children: [
                  Column(
                    children: [
                      // Thanh kéo và tiêu đề
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Container(
                          width: 40,
                          height: 5,
                          decoration: BoxDecoration(
                            color: appColorScheme(context).outlineVariant,
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),

                      Expanded(
                        child: CommentListView(
                          scrollController: scrollController,
                          postAuthorId: widget.postAuthorId,
                        ),
                      ),
                      // Ô nhập liệu
                    ],
                  ),
                  const Positioned.fill(
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: CommentInputField(),
                    ),
                  ),
                ],
              ),
            );
          }),
    );
  }
}
