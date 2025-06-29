import 'package:dishlocal/app/theme/app_icons.dart';
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
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Chiều cao 90% màn hình
    final screenHeight = MediaQuery.of(context).size.height;
    final bottomSheetHeight = screenHeight * 0.9;

    return BlocListener<CommentBloc, CommentState>(
      listener: (context, state) {
        // Hiển thị lỗi bằng SnackBar
        if (state.failure != null) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(SnackBar(content: Text(state.failure!.message)));
        }
      },
      child: Container(
        height: bottomSheetHeight,
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: Column(
          children: [
            // Thanh kéo và tiêu đề
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Container(
                width: 40,
                height: 5,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                'Bình luận',
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),
            const Divider(),
            // Danh sách bình luận
            Expanded(
              child: CommentListView(
                scrollController: _scrollController,
                postAuthorId: widget.postAuthorId,
              ),
            ),
            // Ô nhập liệu
            const CommentInputField(),
          ],
        ),
      ),
    );
  }
}

