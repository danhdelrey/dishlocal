import 'dart:math';

import 'package:dishlocal/app/theme/theme.dart';
import 'package:dishlocal/ui/features/comment/bloc/comment_bloc.dart';
import 'package:dishlocal/ui/features/comment/view/comment_bottom_sheet.dart';
import 'package:dishlocal/ui/features/comment/view/comment_item.dart';
import 'package:dishlocal/ui/widgets/animated_widgets/fade_slide_up.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CommentListView extends StatelessWidget {
  final ScrollController scrollController;
  final String postAuthorId;

  const CommentListView({super.key, required this.scrollController, required this.postAuthorId});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CommentBloc, CommentState>(
      builder: (context, state) {
        if (state.status == CommentStatus.initial || (state.status == CommentStatus.loading && state.comments.isEmpty)) {
          return ListView.builder(
            itemBuilder: (context, index) => const ShimmeringComment(
              isReply: false,
              paddingLeft: 15,
            ),
            itemCount: 10,
          );
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
          physics: const AlwaysScrollableScrollPhysics(parent: BouncingScrollPhysics()),
          controller: scrollController,
          padding: const EdgeInsets.only(left: 15, right: 15, bottom: kBottomNavigationBarHeight + 15),
          // +1 cho nút "Xem thêm" nếu cần
          itemCount: state.comments.length + (shouldShowLoadMoreButton || state.status == CommentStatus.loading ? 1 : 0),
          itemBuilder: (context, index) {
            // ----- LOGIC HIỂN THỊ ITEM CUỐI CÙNG -----
            if (index >= state.comments.length) {
              // Nếu đang tải, hiển thị vòng quay
              if (state.status == CommentStatus.loading) {
                return const ShimmeringComment(
                  isReply: false,
                );
              }

              // Nếu không đang tải và còn bình luận, hiển thị nút "Xem thêm"
              if (shouldShowLoadMoreButton) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  child: Row(
                    children: [
                      TextButton.icon(
                        icon: const Icon(
                          Icons.keyboard_arrow_down_rounded,
                        ),
                        onPressed: () => context.read<CommentBloc>().add(const CommentEvent.moreCommentsRequested()),
                        label: Text(
                          // Hiển thị số lượng còn lại chính xác
                          'Xem thêm $remainingCount bình luận...',
                        ),
                        style: TextButton.styleFrom(
                          foregroundColor: Theme.of(context).colorScheme.onSurface,
                          textStyle: Theme.of(context).textTheme.labelMedium,
                          padding: EdgeInsets.zero,

                          tapTargetSize: MaterialTapTargetSize.shrinkWrap, // 👈 Loại bỏ padding mặc định cho hit test
                          minimumSize: const Size(0, 0), // 👈 Tránh chiều cao tối thiểu mặc định
                        ),
                      ),
                    ],
                  ),
                );
              }
              // Trường hợp không còn gì để hiển thị
              return const SizedBox.shrink();
            }

            // ----- LOGIC HIỂN THỊ BÌNH LUẬN GỐC -----
            final comment = state.comments[index];
            return CommentItem(
              comment: comment,
              postAuthorId: postAuthorId,
            );
          },
        );
      },
    );
  }
}

class ShimmeringComment extends StatefulWidget {
  const ShimmeringComment({super.key, required this.isReply, this.paddingLeft = 0});
  final bool isReply;
  final double paddingLeft;

  @override
  State<ShimmeringComment> createState() => _ShimmeringCommentState();
}

class _ShimmeringCommentState extends State<ShimmeringComment> with SingleTickerProviderStateMixin {
  // 1. Khai báo AnimationController
  late final AnimationController _controller;
  late final Animation<double> _opacityAnimation;
  late final int randomWidth;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    )..repeat(reverse: true);

    _opacityAnimation = Tween<double>(begin: 0.3, end: 0.8).animate(_controller);
    randomWidth = 100 + Random().nextInt(100);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: widget.isReply ? 0 : widget.paddingLeft, top: widget.isReply ? 10 : 20),
      child: FadeTransition(
        opacity: _opacityAnimation,
        child: _buildPlaceholderContent(),
      ),
    );
  }

  // Tách phần nội dung placeholder ra cho dễ đọc
  Widget _buildPlaceholderContent() {
    // Màu nền cho các thành phần placeholder
    final placeholderColor = appColorScheme(context).outlineVariant;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: widget.isReply ? 24 : 36,
          height: widget.isReply ? 24 : 36,
          decoration: BoxDecoration(
            color: placeholderColor,
            borderRadius: BorderRadius.circular(1000),
          ),
        ),
        const SizedBox(
          width: 10,
        ),
        Container(
          height: widget.isReply ? 30 : 50,
          width: randomWidth.toDouble(),
          decoration: BoxDecoration(
            color: placeholderColor,
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ],
    );
  }
}
