import 'package:dishlocal/ui/features/comment/bloc/comment_bloc.dart';
import 'package:dishlocal/ui/features/comment/view/comment_bottom_sheet.dart';
import 'package:dishlocal/ui/features/comment/view/comment_item.dart';
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
          physics: const AlwaysScrollableScrollPhysics(parent: BouncingScrollPhysics()),
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
