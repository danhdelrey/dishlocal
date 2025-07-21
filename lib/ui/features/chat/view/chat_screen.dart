import 'package:dishlocal/core/dependencies_injection/service_locator.dart';
import 'package:dishlocal/data/categories/app_user/repository/interface/app_user_repository.dart';
import 'package:dishlocal/data/categories/chat/repository/interface/chat_repository.dart';
import 'package:dishlocal/ui/features/chat/bloc/chat_bloc.dart';
import 'package:dishlocal/ui/features/chat/view/message_bubble.dart';
import 'package:dishlocal/ui/features/chat/view/message_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatScreen extends StatefulWidget {
  final String conversationId;
  final String otherUserName;

  const ChatScreen({
    super.key,
    required this.conversationId,
    required this.otherUserName,
  });

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> with WidgetsBindingObserver {
  final ScrollController _scrollController = ScrollController();
  // Giả sử bạn có một service để lấy ID người dùng hiện tại
  late final String _currentUserId; // Lấy ID người dùng thật ở đây

  @override
  void initState() {
    super.initState();
    _currentUserId = getIt<AppUserRepository>().getCurrentUserId()!;
    _scrollController.addListener(_onScroll);
    // Đăng ký observer
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    // Thông báo cho BLoC rằng màn hình không còn active
    context.read<ChatBloc>().add(const ChatEvent.screenStatusChanged(isActive: false));
    // Hủy đăng ký observer
    WidgetsBinding.instance.removeObserver(this);
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    // Khi người dùng quay lại ứng dụng
    if (state == AppLifecycleState.resumed) {
      context.read<ChatBloc>().add(const ChatEvent.screenStatusChanged(isActive: true));
      // Đánh dấu đã đọc lại phòng trường hợp có tin nhắn đến khi app ở background
      final state = context.read<ChatBloc>().state;
      if (state is ChatLoaded) {
        context.read<ChatRepository>().markConversationAsRead(
              conversationId: state.conversationId,
            );
      }
    } else {
      // Khi người dùng rời khỏi ứng dụng
      context.read<ChatBloc>().add(const ChatEvent.screenStatusChanged(isActive: false));
    }
  }

  void _onScroll() {
    // Nếu người dùng cuộn đến cuối danh sách (đầu cuộc trò chuyện) -> tải thêm tin nhắn
    if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
      context.read<ChatBloc>().add(const ChatEvent.moreMessagesLoaded());
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<ChatBloc>() // Sử dụng DI để tạo BLoC
        ..add(ChatEvent.started(
          conversationId: widget.conversationId,
          otherUserName: widget.otherUserName,
        )),
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.otherUserName),
        ),
        body: BlocBuilder<ChatBloc, ChatState>(
          builder: (context, state) {
            return Column(
              children: [
                Expanded(
                  child: switch (state) {
                    //  cho trạng thái ban đầu
                    ChatInitial() => const SizedBox.shrink(),

                    //  cho trạng thái đang tải lần đầu
                    ChatLoading() => const Center(child: CircularProgressIndicator()),

                    //  cho trạng thái lỗi
                    ChatError(message: final message) => Center(child: Text('Lỗi: $message')),

                    //  cho trạng thái đã tải xong, sử dụng pattern matching để trích xuất dữ liệu
                    ChatLoaded(messages: final messages, isLoadingMore: final isLoadingMore) => ListView.builder(
                        controller: _scrollController,
                        reverse: true, // Quan trọng để chat bắt đầu từ dưới lên
                        itemCount: messages.length + (isLoadingMore ? 1 : 0),
                        itemBuilder: (context, index) {
                          // Hiển thị vòng quay tải ở cuối danh sách nếu đang tải thêm
                          if (isLoadingMore && index == messages.length) {
                            return const Center(
                                child: Padding(
                              padding: EdgeInsets.all(8.0),
                              child: CircularProgressIndicator(),
                            ));
                          }
                          final message = messages[index];
                          return MessageBubble(
                            message: message,
                            isMe: message.senderId == _currentUserId,
                          );
                        },
                      ),
                  },
                ),
                const MessageInput(), // Ô nhập liệu
              ],
            );
          },
        ),
      ),
    );
  }
}
