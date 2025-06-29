// file: lib/presentation/widgets/comment/comment_bottom_sheet.dart

import 'dart:async';

import 'package:dishlocal/data/categories/comment/model/comment.dart';
import 'package:dishlocal/data/categories/comment/model/comment_reply.dart';
import 'package:dishlocal/ui/features/comment/bloc/comment_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart'; // Giả sử bạn dùng get_it
import 'package:intl/intl.dart'; // Để định dạng thời gian

/// Hàm helper để hiển thị Comment Bottom Sheet.
/// Dễ dàng gọi từ bất kỳ đâu trong ứng dụng.
void showCommentBottomSheet(
  BuildContext context, {
  required String postId,
  required int totalCommentCount,
}) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true, // Cho phép sheet chiếm toàn màn hình
    backgroundColor: Colors.transparent,
    builder: (_) => CommentBottomSheet(
      postId: postId,
      totalCommentCount: totalCommentCount,
    ),
  );
}

class CommentBottomSheet extends StatelessWidget {
  final String postId;
  final int totalCommentCount;

  const CommentBottomSheet({
    super.key,
    required this.postId,
    required this.totalCommentCount,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      // Tạo một instance mới của CommentBloc mỗi khi bottom sheet mở
      create: (context) => GetIt.instance<CommentBloc>()
        ..add(CommentEvent.initialized(
          postId: postId,
          totalCommentCount: totalCommentCount,
        )),
      child: BlocConsumer<CommentBloc, CommentState>(
        listener: (context, state) {
          // Hiển thị snackbar nếu có lỗi
          if (state.failure != null) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.failure!.message),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
        builder: (context, state) {
          // Giao diện chính của Bottom Sheet
          return DraggableScrollableSheet(
            initialChildSize: 0.7,
            minChildSize: 0.4,
            maxChildSize: 0.95,
            builder: (_, scrollController) {
              return Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                ),
                child: Column(
                  children: [
                    // Handle để kéo và tiêu đề
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Column(
                        children: [
                          Container(
                            width: 40,
                            height: 5,
                            decoration: BoxDecoration(
                              color: Colors.grey[300],
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            '${state.totalCommentCount} bình luận',
                            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                          const Divider(),
                        ],
                      ),
                    ),
                    // Danh sách bình luận hoặc màn hình tải
                    Expanded(
                      child: (state.status == CommentStatus.loading && state.comments.isEmpty) ? const Center(child: CircularProgressIndicator()) : _CommentListView(scrollController: scrollController),
                    ),
                    // Vùng nhập liệu
                    const _CommentInputField(),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}

/// Widget hiển thị danh sách các bình luận và xử lý lazy-loading
class _CommentListView extends StatefulWidget {
  final ScrollController scrollController;

  const _CommentListView({super.key, required this.scrollController});

  @override
  State<_CommentListView> createState() => _CommentListViewState();
}

class _CommentListViewState extends State<_CommentListView> {
  @override
  void initState() {
    super.initState();
    // Thêm listener để phát hiện khi cuộn đến cuối và tải thêm
    widget.scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    final bloc = context.read<CommentBloc>();
    if (widget.scrollController.position.pixels >= widget.scrollController.position.maxScrollExtent * 0.9 && bloc.state.status != CommentStatus.loading && bloc.state.hasMoreComments) {
      bloc.add(const CommentEvent.moreCommentsRequested());
    }
  }

  @override
  void dispose() {
    widget.scrollController.removeListener(_onScroll);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CommentBloc, CommentState>(
      buildWhen: (p, c) => p.comments != c.comments || p.hasMoreComments != c.hasMoreComments,
      builder: (context, state) {
        return ListView.builder(
          controller: widget.scrollController,
          itemCount: state.comments.length + 1, // +1 cho nút "Xem thêm" hoặc loading
          itemBuilder: (context, index) {
            if (index < state.comments.length) {
              final comment = state.comments[index];
              return _CommentItem(comment: comment);
            } else {
              // Widget ở cuối danh sách
              return _LoadMoreCommentsButton();
            }
          },
        );
      },
    );
  }
}

/// Widget cho một bình luận gốc
class _CommentItem extends StatelessWidget {
  final Comment comment;
  const _CommentItem({super.key, required this.comment});

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<CommentBloc>();
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                radius: 18,
                backgroundImage: comment.authorAvatarUrl != null ? NetworkImage(comment.authorAvatarUrl!) : null,
                child: comment.authorAvatarUrl == null ? const Icon(Icons.person) : null,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(text: '${comment.authorUsername}  ', style: const TextStyle(fontWeight: FontWeight.bold)),
                          TextSpan(text: comment.content, style: const TextStyle(fontSize: 14)),
                        ],
                      ),
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        Text(DateFormat('dd/MM').format(comment.createdAt), style: TextStyle(color: Colors.grey[600], fontSize: 12)),
                        const SizedBox(width: 16),
                        GestureDetector(
                          onTap: () => bloc.add(CommentEvent.replyTargetSet(
                            target: ReplyTarget(
                              parentCommentId: comment.commentId,
                              replyToUserId: comment.authorUserId,
                              replyToUsername: comment.authorUsername,
                            ),
                          )),
                          child: Text('Trả lời', style: TextStyle(color: Colors.grey[700], fontWeight: FontWeight.bold, fontSize: 12)),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Column(
                children: [
                  IconButton(
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                    icon: Icon(
                      comment.isLiked ? Icons.favorite : Icons.favorite_border,
                      color: comment.isLiked ? Colors.red : Colors.grey,
                      size: 18,
                    ),
                    onPressed: () => bloc.add(CommentEvent.commentLiked(
                      commentId: comment.commentId,
                      isLiked: !comment.isLiked,
                    )),
                  ),
                  Text(comment.likeCount.toString(), style: const TextStyle(fontSize: 12)),
                ],
              )
            ],
          ),
          if (comment.replyCount > 0)
            Padding(
              padding: const EdgeInsets.only(left: 50.0, top: 8.0),
              child: _ReplySection(parentComment: comment),
            ),
        ],
      ),
    );
  }
}

/// Widget quản lý việc hiển thị và tải các trả lời
class _ReplySection extends StatelessWidget {
  final Comment parentComment;
  const _ReplySection({super.key, required this.parentComment});

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<CommentBloc>();
    return BlocBuilder<CommentBloc, CommentState>(
      buildWhen: (p, c) => p.replies[parentComment.commentId] != c.replies[parentComment.commentId] || p.replyLoadStatus[parentComment.commentId] != c.replyLoadStatus[parentComment.commentId] || p.hasMoreReplies[parentComment.commentId] != c.hasMoreReplies[parentComment.commentId],
      builder: (context, state) {
        final replies = state.replies[parentComment.commentId] ?? [];
        final hasMore = state.hasMoreReplies[parentComment.commentId] ?? true;
        final status = state.replyLoadStatus[parentComment.commentId] ?? CommentStatus.initial;
        final remainingCount = parentComment.replyCount - replies.length;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Danh sách các replies đã được tải
            ...replies.map((reply) => _ReplyItem(reply: reply, parentCommentId: parentComment.commentId)),
            // Nút "Xem thêm" hoặc loading indicator
            if (status == CommentStatus.loading)
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 8.0),
                child: SizedBox(height: 20, width: 20, child: CircularProgressIndicator(strokeWidth: 2)),
              )
            else if (remainingCount > 0 && hasMore)
              GestureDetector(
                onTap: () => bloc.add(CommentEvent.repliesRequested(parentCommentId: parentComment.commentId)),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Text('Xem thêm $remainingCount trả lời', style: TextStyle(color: Colors.grey[700], fontWeight: FontWeight.bold, fontSize: 12)),
                ),
              ),
          ],
        );
      },
    );
  }
}

/// Widget cho một trả lời
class _ReplyItem extends StatelessWidget {
  final CommentReply reply;
  final String parentCommentId;
  const _ReplyItem({super.key, required this.reply, required this.parentCommentId});

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<CommentBloc>();
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 14,
            backgroundImage: reply.authorAvatarUrl != null ? NetworkImage(reply.authorAvatarUrl!) : null,
            child: reply.authorAvatarUrl == null ? const Icon(Icons.person, size: 14) : null,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(text: '${reply.authorUsername}  ', style: const TextStyle(fontWeight: FontWeight.bold)),
                      // logic hiển thị @username
                      //if(reply.replyToUsername != parentComment.authorUsername)
                      TextSpan(text: '@${reply.replyToUsername} ', style: TextStyle(color: Theme.of(context).primaryColor, fontWeight: FontWeight.bold)),
                      TextSpan(
                        text: reply.content,
                        style: const TextStyle(fontSize: 14),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Text(DateFormat('dd/MM').format(reply.createdAt), style: TextStyle(color: Colors.grey[600], fontSize: 12)),
                    const SizedBox(width: 16),
                    GestureDetector(
                      onTap: () => bloc.add(CommentEvent.replyTargetSet(
                        target: ReplyTarget(
                          parentCommentId: parentCommentId,
                          replyToUserId: reply.authorUserId,
                          replyToUsername: reply.authorUsername,
                        ),
                      )),
                      child: Text('Trả lời', style: TextStyle(color: Colors.grey[700], fontWeight: FontWeight.bold, fontSize: 12)),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Column(
            children: [
              IconButton(
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
                icon: Icon(
                  reply.isLiked ? Icons.favorite : Icons.favorite_border,
                  color: reply.isLiked ? Colors.red : Colors.grey,
                  size: 16,
                ),
                onPressed: () => bloc.add(CommentEvent.replyLiked(
                  replyId: reply.replyId,
                  parentCommentId: parentCommentId,
                  isLiked: !reply.isLiked,
                )),
              ),
              Text(reply.likeCount.toString(), style: const TextStyle(fontSize: 12)),
            ],
          )
        ],
      ),
    );
  }
}

/// Widget cho vùng nhập liệu ở cuối bottom sheet
class _CommentInputField extends StatefulWidget {
  const _CommentInputField({super.key});

  @override
  State<_CommentInputField> createState() => _CommentInputFieldState();
}

class _CommentInputFieldState extends State<_CommentInputField> {
  final _textController = TextEditingController();
  final _focusNode = FocusNode();

  @override
  void dispose() {
    _textController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _submit() {
    final bloc = context.read<CommentBloc>();
    final content = _textController.text.trim();
    if (content.isEmpty) return;

    if (bloc.state.replyTarget != null) {
      bloc.add(CommentEvent.replySubmitted(content: content));
    } else {
      bloc.add(CommentEvent.commentSubmitted(content: content));
    }

    _textController.clear();
    _focusNode.unfocus();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<CommentBloc, CommentState>(
      // Tự động focus khi người dùng chọn "Trả lời"
      listenWhen: (p, c) => p.replyTarget != c.replyTarget,
      listener: (context, state) {
        if (state.replyTarget != null) {
          _focusNode.requestFocus();
        }
      },
      child: Container(
        padding: EdgeInsets.only(
          left: 16,
          right: 16,
          top: 8,
          bottom: MediaQuery.of(context).viewInsets.bottom + 16, // Đẩy lên trên bàn phím
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(top: BorderSide(color: Colors.grey[200]!)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Thanh "Đang trả lời..."
            _ReplyTargetIndicator(),
            Row(
              children: [
                const CircleAvatar(radius: 18 /* Lấy ảnh user hiện tại */),
                const SizedBox(width: 12),
                Expanded(
                  child: TextField(
                    controller: _textController,
                    focusNode: _focusNode,
                    decoration: const InputDecoration(
                      hintText: 'Thêm bình luận...',
                      border: InputBorder.none,
                    ),
                    onSubmitted: (_) => _submit(),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.send),
                  onPressed: _submit,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _ReplyTargetIndicator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CommentBloc, CommentState>(
      buildWhen: (p, c) => p.replyTarget != c.replyTarget,
      builder: (context, state) {
        if (state.replyTarget == null) return const SizedBox.shrink();

        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
          margin: const EdgeInsets.only(bottom: 8),
          decoration: BoxDecoration(
            color: Colors.grey[100],
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Đang trả lời @${state.replyTarget!.replyToUsername}',
                style: TextStyle(color: Colors.grey[600]),
              ),
              IconButton(
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
                icon: Icon(Icons.close, size: 16, color: Colors.grey[600]),
                onPressed: () => context.read<CommentBloc>().add(const CommentEvent.replyTargetCleared()),
              )
            ],
          ),
        );
      },
    );
  }
}

class _LoadMoreCommentsButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CommentBloc, CommentState>(
      buildWhen: (p, c) => p.hasMoreComments != c.hasMoreComments || p.status != c.status,
      builder: (context, state) {
        if (state.status == CommentStatus.loading) {
          return const Center(child: Padding(padding: EdgeInsets.all(16.0), child: CircularProgressIndicator()));
        }
        if (state.hasMoreComments) {
          final remaining = state.totalCommentCount - state.comments.length;
          return TextButton(
            onPressed: () => context.read<CommentBloc>().add(const CommentEvent.moreCommentsRequested()),
            child: Text('Xem thêm $remaining bình luận', style: TextStyle(color: Colors.grey[700], fontWeight: FontWeight.bold)),
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}
