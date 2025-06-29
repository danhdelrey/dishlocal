import 'package:dishlocal/app/theme/app_icons.dart';
import 'package:dishlocal/data/categories/comment/model/comment.dart';
import 'package:dishlocal/data/categories/comment/model/comment_reply.dart';
import 'package:dishlocal/ui/features/comment/bloc/comment_bloc.dart';
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
              child: _CommentListView(
                scrollController: _scrollController,
                postAuthorId: widget.postAuthorId,
              ),
            ),
            // Ô nhập liệu
            _CommentInput(),
          ],
        ),
      ),
    );
  }
}

// ---- CÁC WIDGET CON ----

class _CommentListView extends StatelessWidget {
  final ScrollController scrollController;
  final String postAuthorId;

  const _CommentListView({required this.scrollController, required this.postAuthorId});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CommentBloc, CommentState>(
      builder: (context, state) {
        if (state.status == CommentStatus.initial || (state.status == CommentStatus.loading && state.comments.isEmpty)) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state.comments.isEmpty) {
          return const Center(child: Text('Chưa có bình luận nào. Hãy là người đầu tiên!'));
        }

        // TÍNH TOÁN SỐ BÌNH LUẬN CÒN LẠI
        final remainingCount = state.totalCommentCount - state.comments.length;

        // KIỂM TRA XEM CÓ NÊN HIỂN THỊ NÚT 'XEM THÊM' HAY KHÔNG
        // Điều kiện: còn bình luận chưa tải VÀ không phải đang trong quá trình tải
        final shouldShowLoadMoreButton = remainingCount > 0 && state.status != CommentStatus.loading;

        return ListView.builder(
          controller: scrollController,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          // +1 cho nút "Xem thêm" nếu cần
          itemCount: state.comments.length + (shouldShowLoadMoreButton || state.status == CommentStatus.loading ? 1 : 0),
          itemBuilder: (context, index) {
            // ----- LOGIC HIỂN THỊ ITEM CUỐI CÙNG -----
            if (index >= state.comments.length) {
              // Nếu đang tải, hiển thị vòng quay
              if (state.status == CommentStatus.loading) {
                return const Padding(
                  padding: EdgeInsets.symmetric(vertical: 16.0),
                  child: Center(child: SizedBox(width: 24, height: 24, child: CircularProgressIndicator(strokeWidth: 2))),
                );
              }

              // Nếu không đang tải và còn bình luận, hiển thị nút "Xem thêm"
              if (shouldShowLoadMoreButton) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Center(
                    child: TextButton(
                      onPressed: () => context.read<CommentBloc>().add(const CommentEvent.moreCommentsRequested()),
                      child: Text(
                        // Hiển thị số lượng còn lại chính xác
                        'Xem thêm $remainingCount bình luận',
                        style: Theme.of(context).textTheme.labelLarge?.copyWith(color: Theme.of(context).colorScheme.primary),
                      ),
                    ),
                  ),
                );
              }
              // Trường hợp không còn gì để hiển thị
              return const SizedBox.shrink();
            }

            // ----- LOGIC HIỂN THỊ BÌNH LUẬN GỐC -----
            final comment = state.comments[index];
            return _CommentItem(
              comment: comment,
              postAuthorId: postAuthorId,
            );
          },
        );
      },
    );
  }
}

class _CommentItem extends StatelessWidget {
  final Comment comment;
  final String postAuthorId;

  const _CommentItem({required this.comment, required this.postAuthorId});

  @override
  Widget build(BuildContext context) {
    final isAuthor = comment.authorUserId == postAuthorId;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CachedCircleAvatar(imageUrl: comment.authorAvatarUrl ?? '', circleRadius: 18),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RichText(
                  text: TextSpan(
                    text: comment.authorUsername,
                    style: Theme.of(context).textTheme.labelLarge,
                    children: [
                      if (isAuthor)
                        TextSpan(
                          text: ' • Tác giả',
                          style: Theme.of(context).textTheme.labelMedium!.copyWith(color: Theme.of(context).colorScheme.primary),
                        ),
                    ],
                  ),
                ),
                Text(
                  comment.content,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                const SizedBox(height: 5),
                Row(
                  children: [
                    Text(
                      timeago.format(comment.createdAt, locale: 'vi'),
                      style: Theme.of(context).textTheme.labelMedium!.copyWith(color: Theme.of(context).colorScheme.outline),
                    ),
                    const SizedBox(width: 15),
                    GestureDetector(
                      onTap: () {
                        context.read<CommentBloc>().add(CommentEvent.replyTargetSet(
                              target: ReplyTarget(
                                parentCommentId: comment.commentId,
                                replyToUserId: comment.authorUserId,
                                replyToUsername: comment.authorUsername,
                              ),
                            ));
                      },
                      child: Text(
                        'Trả lời',
                        style: Theme.of(context).textTheme.labelMedium!.copyWith(color: Theme.of(context).colorScheme.onSurface),
                      ),
                    ),
                    const Spacer(),
                    GestureDetector(
                      onTap: () => context.read<CommentBloc>().add(CommentEvent.commentLiked(commentId: comment.commentId, isLiked: !comment.isLiked)),
                      child: CustomIconWithLabel(
                        icon: AppIcons.heart1.toSvg(
                          color: comment.isLiked ? Colors.red : Theme.of(context).colorScheme.outline,
                          width: 14,
                        ),
                        label: '${comment.likeCount}',
                        labelStyle: Theme.of(context).textTheme.labelMedium!.copyWith(color: Theme.of(context).colorScheme.outline),
                      ),
                    ),
                  ],
                ),
                if (comment.replyCount > 0)
                  _RepliesSection(
                    parentCommentId: comment.commentId,
                    totalReplyCount: comment.replyCount,
                    postAuthorId: postAuthorId,
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _RepliesSection extends StatelessWidget {
  final String parentCommentId;
  final int totalReplyCount;
  final String postAuthorId;

  const _RepliesSection({required this.parentCommentId, required this.totalReplyCount, required this.postAuthorId});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CommentBloc, CommentState>(
      buildWhen: (p, c) => p.replies[parentCommentId] != c.replies[parentCommentId] || p.replyLoadStatus[parentCommentId] != c.replyLoadStatus[parentCommentId],
      builder: (context, state) {
        final replies = state.replies[parentCommentId] ?? [];
        final hasMore = state.hasMoreReplies[parentCommentId] ?? true;
        final status = state.replyLoadStatus[parentCommentId] ?? CommentStatus.initial;
        final remainingCount = totalReplyCount - replies.length;

        return Padding(
          padding: const EdgeInsets.only(top: 10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ...replies.map((reply) => _ReplyItem(reply: reply, parentCommentId: parentCommentId, postAuthorId: postAuthorId)),
              if (status == CommentStatus.loading) const Padding(padding: EdgeInsets.symmetric(vertical: 8.0), child: SizedBox(width: 16, height: 16, child: CircularProgressIndicator(strokeWidth: 2))),
              if (hasMore && status != CommentStatus.loading && remainingCount > 0)
                GestureDetector(
                  onTap: () => context.read<CommentBloc>().add(CommentEvent.repliesRequested(parentCommentId: parentCommentId)),
                  child: Text(
                    'Xem $remainingCount trả lời...',
                    style: Theme.of(context).textTheme.labelMedium!.copyWith(color: Theme.of(context).colorScheme.outline),
                  ),
                )
            ],
          ),
        );
      },
    );
  }
}

class _ReplyItem extends StatelessWidget {
  final CommentReply reply;
  final String parentCommentId;
  final String postAuthorId;

  const _ReplyItem({required this.reply, required this.parentCommentId, required this.postAuthorId});

  @override
  Widget build(BuildContext context) {
    final isAuthor = reply.authorUserId == postAuthorId;
    return Padding(
      padding: const EdgeInsets.only(left: 10, top: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CachedCircleAvatar(imageUrl: reply.authorAvatarUrl ?? '', circleRadius: 12),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RichText(
                  text: TextSpan(
                    text: reply.authorUsername,
                    style: Theme.of(context).textTheme.labelLarge,
                    children: [
                      if (isAuthor)
                        TextSpan(
                          text: ' • Tác giả',
                          style: Theme.of(context).textTheme.labelMedium!.copyWith(color: Theme.of(context).colorScheme.primary),
                        ),
                    ],
                  ),
                ),
                RichText(
                  text: TextSpan(
                    style: Theme.of(context).textTheme.bodyMedium,
                    children: [
                      TextSpan(
                        text: '@${reply.replyToUsername} ',
                        style: TextStyle(color: Theme.of(context).colorScheme.primary, fontWeight: FontWeight.bold),
                      ),
                      TextSpan(text: reply.content),
                    ],
                  ),
                ),
                const SizedBox(height: 5),
                Row(
                  children: [
                    Text(
                      timeago.format(reply.createdAt, locale: 'vi'),
                      style: Theme.of(context).textTheme.labelMedium!.copyWith(color: Theme.of(context).colorScheme.outline),
                    ),
                    const SizedBox(width: 15),
                    GestureDetector(
                      onTap: () {
                        context.read<CommentBloc>().add(CommentEvent.replyTargetSet(
                              target: ReplyTarget(
                                parentCommentId: parentCommentId,
                                replyToUserId: reply.authorUserId,
                                replyToUsername: reply.authorUsername,
                              ),
                            ));
                      },
                      child: Text(
                        'Trả lời',
                        style: Theme.of(context).textTheme.labelMedium!.copyWith(color: Theme.of(context).colorScheme.onSurface),
                      ),
                    ),
                    const Spacer(),
                    GestureDetector(
                      onTap: () => context.read<CommentBloc>().add(CommentEvent.replyLiked(replyId: reply.replyId, parentCommentId: parentCommentId, isLiked: !reply.isLiked)),
                      child: CustomIconWithLabel(
                        icon: AppIcons.heart1.toSvg(
                          color: reply.isLiked ? Colors.red : Theme.of(context).colorScheme.outline,
                          width: 14,
                        ),
                        label: '${reply.likeCount}',
                        labelStyle: Theme.of(context).textTheme.labelMedium!.copyWith(color: Theme.of(context).colorScheme.outline),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _CommentInput extends StatefulWidget {
  @override
  State<_CommentInput> createState() => _CommentInputState();
}

class _CommentInputState extends State<_CommentInput> {
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
          // ... các thuộc tính của bạn
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
                    //const CachedCircleAvatar(imageUrl: '...'), // Lấy avatar user hiện tại
                    const SizedBox(width: 10),
                    Expanded(
                      child: AppTextField(
                        controller: _textController,
                        focusNode: _focusNode,
                        hintText: 'Viết bình luận...',
                      ),
                    ),
                    const SizedBox(width: 10),
                    InkWell(
                      onTap: _submit,
                      child: Container(
                        // ... style nút gửi
                        child: AppIcons.sendFill.toSvg(color: Colors.white),
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
