import 'package:dishlocal/core/dependencies_injection/service_locator.dart';
import 'package:dishlocal/data/categories/chat/model/conversation.dart';
import 'package:dishlocal/ui/features/share_post/cubit/share_post_cubit.dart';
import 'package:dishlocal/ui/widgets/containers_widgets/glass_container.dart';
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
          // === THAY ĐỔI: Cập nhật listener ===
          switch (state) {
            case SharePostSendSuccess(
                recipient: final recipient,
                totalSent: final total,
                firstConversationId: final convoId,
              ):
              if (Navigator.canPop(context)) {
                Navigator.of(context).pop();
              }

              // Tạo thông báo tùy thuộc vào số lượng
              final String message;
              if (total == 1) {
                message = 'Đã gửi bài viết cho ${recipient.displayName}';
              } else {
                message = 'Đã gửi bài viết cho ${recipient.displayName} và ${total - 1} người khác';
              }

              ScaffoldMessenger.of(widget.parentContext).showSnackBar(
                SnackBar(
                  content: Text(message),
                  // Chỉ hiển thị nút "Xem" nếu chỉ gửi cho 1 người
                  action: total == 1
                      ? SnackBarAction(
                          label: 'Xem',
                          onPressed: () {
                            widget.parentContext.push('/chat', extra: {
                              'conversationId': convoId,
                              'otherUser': _selectedConversations.first.otherParticipant,
                            });
                          },
                        )
                      : null,
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
          initialChildSize: 0.61,
          // Kích thước tối đa (không cho phép kéo to hơn kích thước ban đầu)
          maxChildSize: 0.8,
          // Kích thước tối thiểu trước khi đóng (có thể đặt thấp hơn để có hiệu ứng kéo dài hơn)
          minChildSize: 0.6,
          expand: false,
          builder: (context, scrollController) {
            return GlassContainer(
              borderRadius: 30,
              radiusBottomRight: false,
              radiusBottomLeft: false,
              backgroundColor: Colors.black,
              backgroundAlpha: 0.3,
              blur: 50,
              borderLeft: true,
              borderRight: true,
              borderTop: true,
              child: Column(
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
                          ? null
                          : () {
                              // === THAY ĐỔI: Gọi hàm mới ===
                              context.read<SharePostCubit>().sendPostToMultiple(
                                    postId: widget.postId,
                                    conversations: _selectedConversations.toList(),
                                  );
                            },
                      child: Text('Gửi (${_selectedConversations.length})'),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
