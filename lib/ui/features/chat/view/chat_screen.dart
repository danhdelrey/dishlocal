import 'package:dishlocal/app/theme/theme.dart';
import 'package:dishlocal/core/dependencies_injection/service_locator.dart';
import 'package:dishlocal/core/utils/time_formatter.dart';
import 'package:dishlocal/data/categories/app_user/model/app_user.dart';
import 'package:dishlocal/data/categories/app_user/repository/interface/app_user_repository.dart';
import 'package:dishlocal/data/categories/chat/model/message.dart';
import 'package:dishlocal/data/categories/chat/repository/interface/chat_repository.dart';
import 'package:dishlocal/data/singleton/app_route_observer.dart';
import 'package:dishlocal/data/singleton/notification_service.dart';
import 'package:dishlocal/ui/features/chat/bloc/chat_bloc.dart';
import 'package:dishlocal/ui/features/chat/view/message_bubble.dart';
import 'package:dishlocal/ui/features/chat/view/message_input.dart';
import 'package:dishlocal/ui/widgets/image_widgets/cached_circle_avatar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class ChatScreen extends StatefulWidget {
  final String conversationId;
  final AppUser otherUser;

  const ChatScreen({
    super.key,
    required this.conversationId,
    required this.otherUser,
  });

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> with WidgetsBindingObserver {
  final ScrollController _scrollController = ScrollController();
  late final String _currentUserId;

  // === BƯỚC 1: KHAI BÁO BIẾN ĐỂ LƯU THAM CHIẾU BLOC ===
  late final ChatBloc _chatBloc;
  late final FocusNode _chatFocusNode;

  @override
  void initState() {
    super.initState();
    _currentUserId = getIt<AppUserRepository>().getCurrentUserId()!;

    // === BƯỚC 2: GÁN GIÁ TRỊ CHO BLOC NGAY TỪ ĐẦU ===
    // Tạo BLoC và truyền vào các tham số cần thiết
    _chatBloc = getIt<ChatBloc>()
      ..add(ChatEvent.started(
        conversationId: widget.conversationId,
        otherUser: widget.otherUser,
        //otherUserPhotoUrl: widget.otherUserPhotoUrl, // Truyền avatar url
      ));
    _chatFocusNode = FocusNode();

    getIt<NotificationService>().clearAllChatNotifications();

    getIt<AppRouteObserver>().enterChatScreen(widget.conversationId);

    _scrollController.addListener(_onScroll);
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    // === BƯỚC 3: SỬ DỤNG THAM CHIẾU _chatBloc ===
    getIt<AppRouteObserver>().exitChatScreen();
    _chatBloc.add(const ChatEvent.screenStatusChanged(isActive: false));
    WidgetsBinding.instance.removeObserver(this);
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    // Đừng quên đóng BLoC khi màn hình bị hủy
    _chatBloc.close();
    _chatFocusNode.dispose();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);

    // === BƯỚC 3: SỬ DỤNG THAM CHIẾU _chatBloc ===
    if (state == AppLifecycleState.resumed) {
      _chatBloc.add(const ChatEvent.screenStatusChanged(isActive: true));
      final currentState = _chatBloc.state;
      if (currentState is ChatLoaded) {
        getIt<ChatRepository>().markConversationAsReadAndTouch(
          conversationId: currentState.conversationId,
        );
      }
    } else {
      _chatBloc.add(const ChatEvent.screenStatusChanged(isActive: false));
    }
  }

  void _onScroll() {
    if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
      // === BƯỚC 3: SỬ DỤNG THAM CHIẾU _chatBloc ===
      _chatBloc.add(const ChatEvent.moreMessagesLoaded());
    }
  }

  @override
  Widget build(BuildContext context) {
    // === BƯỚC 4: CUNG CẤP INSTANCE BLOC ĐÃ TẠO SẴN ===
    return BlocProvider.value(
      value: _chatBloc,
      child: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () {
          _chatFocusNode.unfocus();
        },
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            elevation: 0,
            surfaceTintColor: Colors.transparent,
            titleSpacing: 0,
            title: GestureDetector(
              behavior: HitTestBehavior.translucent,
              onTap: () {
                context.push('/post_detail/profile', extra: {'userId': widget.otherUser.userId});
              },
              child: Row(
                children: [
                  CachedCircleAvatar(
                    imageUrl: widget.otherUser.photoUrl ?? '',
                    circleRadius: 15,
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  Text(
                    widget.otherUser.displayName ?? '',
                    style: appTextTheme(context).titleMedium,
                    maxLines: 1,
                  ),
                ],
              ),
            ),
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
                      ChatLoaded(
                        messages: final messages,
                        isLoadingMore: final isLoadingMore,
                        otherUserLastReadAt: final otherUserLastReadAt,
                      ) =>
                        ListView.builder(
                          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
                          controller: _scrollController,
                          reverse: true,
                          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 15),
                          itemCount: messages.length + (isLoadingMore ? 1 : 0),
                          itemBuilder: (context, index) {
                            if (isLoadingMore && index == messages.length) {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            }

                            final message = messages[index];

                            // --- LOGIC HIỂN THỊ ---
                            // Lấy tin nhắn trước đó (do list bị reverse, "trước đó" là index + 1)
                            final Message? previousMessage = (index + 1 < messages.length) ? messages[index + 1] : null;

                            // 1. Logic hiển thị Avatar
                            // Chỉ hiển thị avatar nếu tin nhắn này là của người kia VÀ
                            // tin nhắn trước đó không tồn tại HOẶC là của mình.
                            //final bool shouldShowAvatar = !isMe && (previousMessage == null || previousMessage.senderId == _currentUserId);

                            // 2. Logic hiển thị Label ngày
                            // Hiển thị nếu tin nhắn này là tin nhắn cuối cùng trong list HOẶC
                            // ngày của nó khác với ngày của tin nhắn trước đó.
                            final bool shouldShowDateLabel;
                            if (previousMessage == null) {
                              shouldShowDateLabel = true; // Luôn hiển thị cho tin nhắn cũ nhất
                            } else {
                              final currentMessageDate = message.createdAt.toLocal();
                              final previousMessageDate = previousMessage.createdAt.toLocal();
                              // So sánh chỉ ngày, tháng, năm
                              shouldShowDateLabel = currentMessageDate.year != previousMessageDate.year || currentMessageDate.month != previousMessageDate.month || currentMessageDate.day != previousMessageDate.day;
                            }

                            // 3. Logic hiển thị Label thời gian nghỉ (ví dụ: 30 phút)
                            final bool shouldShowTimeGapLabel;
                            if (previousMessage != null) {
                              final timeDifference = message.createdAt.difference(previousMessage.createdAt);
                              shouldShowTimeGapLabel = timeDifference.inMinutes > 10;
                            } else {
                              shouldShowTimeGapLabel = false;
                            }

                            // Lấy tin nhắn tiếp theo (do list bị reverse, "tiếp theo" là index - 1)
                            final Message? nextMessage = (index > 0) ? messages[index - 1] : null;

// 1. Logic hiển thị Avatar (của người kia)
// Hiển thị avatar nếu đây là tin nhắn cuối cùng của người đó trong một chuỗi.
// (Tức là tin nhắn tiếp theo không tồn tại HOẶC là của mình)
                            final bool isMe = message.senderId == _currentUserId;
                            final bool shouldShowAvatar = !isMe && (nextMessage == null || nextMessage.senderId == _currentUserId);

// 2. Logic hiển thị Status Icon (của mình)
// Hiển thị status icon nếu đây là tin nhắn cuối cùng của mình trong một chuỗi.
// (Tức là tin nhắn tiếp theo không tồn tại HOẶC là của người kia)
                            final bool shouldShowStatus = isMe && (nextMessage == null || nextMessage.senderId != _currentUserId);

                            return Column(
                              children: [
                                if (shouldShowDateLabel) _DateLabel(dateTime: message.createdAt),
                                if (shouldShowTimeGapLabel && !shouldShowDateLabel) _DateLabel(dateTime: message.createdAt),

                                // MessageBubble giờ đây không cần Row bên ngoài nữa, nó tự xử lý
                                MessageBubble(
                                  message: message,
                                  isMe: isMe,
                                  otherUser: widget.otherUser,
                                  otherUserLastReadAt: otherUserLastReadAt,
                                  // === TRUYỀN CÁC CỜ MỚI XUỐNG ===
                                  shouldShowAvatar: shouldShowAvatar,
                                  shouldShowStatus: shouldShowStatus,
                                ),
                              ],
                            );
                          },
                        ),
                    },
                  ),
                  MessageInput(
                    focusNode: _chatFocusNode,
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

class _DateLabel extends StatelessWidget {
  final DateTime dateTime;
  const _DateLabel({required this.dateTime});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 30),
      child: Text(
        // Sử dụng intl để format đẹp hơn
        TimeFormatter.formatDateTime(dateTime.toLocal()),
        style: const TextStyle(
          color: Colors.grey,
          fontSize: 12,
        ),
      ),
    );
  }
}

class _Avatar extends StatelessWidget {
  final String? imageUrl;
  final bool isVisible;

  const _Avatar({this.imageUrl, required this.isVisible});

  @override
  Widget build(BuildContext context) {
    return isVisible
        ? CircleAvatar(
            radius: 14,
            backgroundImage: imageUrl != null ? NetworkImage(imageUrl!) : null,
            child: imageUrl == null ? const Icon(Icons.person, size: 14) : null,
          )
        : const SizedBox(width: 28); // Tạo khoảng trống bằng kích thước avatar
  }
}
