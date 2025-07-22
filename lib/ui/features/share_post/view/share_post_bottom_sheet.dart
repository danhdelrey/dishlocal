import 'package:dishlocal/core/dependencies_injection/service_locator.dart';
import 'package:dishlocal/data/categories/chat/model/conversation.dart';
import 'package:dishlocal/ui/features/share_post/cubit/share_post_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class SharePostBottomSheet extends StatefulWidget {
  final String postId;
  final BuildContext parentContext;

  const SharePostBottomSheet({super.key, required this.postId, required this.parentContext});

  @override
  State<SharePostBottomSheet> createState() => _SharePostBottomSheetState();
}

class _SharePostBottomSheetState extends State<SharePostBottomSheet> {
  // Lưu lại các conversation đã được chọn
  final Set<Conversation> _selectedConversations = {};

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<SharePostCubit>()..fetchConversations(),
      child: BlocListener<SharePostCubit, SharePostState>(
        listener: (context, state) {
          // Lắng nghe sự kiện gửi thành công/thất bại
          switch (state) {
            case SharePostSendSuccess(conversationId: final convoId, otherUser: final otherUser):
              // Đóng bottom sheet
              if (Navigator.canPop(context)) {
                Navigator.of(context).pop();
              }
              // Hiện SnackBar
              ScaffoldMessenger.of(widget.parentContext).showSnackBar(
                SnackBar(
                  content: Text('Đã gửi bài viết cho ${otherUser.displayName}'),
                  action: SnackBarAction(
                    label: 'Xem',
                    onPressed: () {
                      context.push('/chat', extra: {
                        'conversationId': convoId,
                        'otherUser': otherUser,
                      });
                    },
                  ),
                ),
              );
              break;
            case SharePostSendError(message: final msg):
              Navigator.of(context).pop();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Gửi thất bại: $msg')),
              );
              break;
            default:
              break;
          }
        },
        child: DraggableScrollableSheet(
          initialChildSize: 0.6,
          minChildSize: 0.4,
          maxChildSize: 0.9,
          expand: false,
          builder: (context, scrollController) {
            return Column(
              children: [
                // Phần tiêu đề và thanh kéo
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Container(
                    width: 40,
                    height: 5,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
                const Text('Chia sẻ đến', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                const Divider(),
                // Danh sách các cuộc trò chuyện
                Expanded(
                  child: BlocBuilder<SharePostCubit, SharePostState>(
                    builder: (context, state) {
                      return switch (state) {
                        SharePostInitial() || SharePostLoading() => const Center(child: CircularProgressIndicator()),
                        SharePostError(message: final msg) => Center(child: Text('Lỗi: $msg')),
                        SharePostLoaded(conversations: final conversations) => ListView.builder(
                            controller: scrollController,
                            itemCount: conversations.length,
                            itemBuilder: (context, index) {
                              final conversation = conversations[index];
                              final isSelected = _selectedConversations.contains(conversation);
                              return ListTile(
                                leading: CircleAvatar(
                                  backgroundImage: conversation.otherParticipant.photoUrl != null ? NetworkImage(conversation.otherParticipant.photoUrl!) : null,
                                ),
                                title: Text(conversation.otherParticipant.displayName ?? ''),
                                trailing: Checkbox(
                                  value: isSelected,
                                  onChanged: (bool? value) {
                                    setState(() {
                                      if (value == true) {
                                        _selectedConversations.add(conversation);
                                      } else {
                                        _selectedConversations.remove(conversation);
                                      }
                                    });
                                  },
                                ),
                              );
                            },
                          ),
                        // Các trạng thái gửi không cần hiển thị UI trong list
                        SharePostSendSuccess() || SharePostSendError() => const SizedBox.shrink(),
                      };
                    },
                  ),
                ),
                // Nút Gửi
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size.fromHeight(50),
                    ),
                    onPressed: _selectedConversations.isEmpty
                        ? null // Vô hiệu hóa nút nếu chưa chọn ai
                        : () {
                            final cubit = context.read<SharePostCubit>();
                            // Chỉ xử lý gửi cho người đầu tiên được chọn để đơn giản hóa logic snackbar
                            // Có thể mở rộng để gửi cho nhiều người
                            final firstSelection = _selectedConversations.first;
                            cubit.sendPost(
                              postId: widget.postId,
                              conversationId: firstSelection.conversationId,
                              otherUser: firstSelection.otherParticipant,
                            );
                          },
                    child: Text('Gửi (${_selectedConversations.length})'),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
