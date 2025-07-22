import 'package:dishlocal/app/theme/app_icons.dart';
import 'package:dishlocal/app/theme/custom_colors.dart';
import 'package:dishlocal/app/theme/theme.dart';
import 'package:dishlocal/core/dependencies_injection/service_locator.dart';
import 'package:dishlocal/data/categories/app_user/model/app_user.dart';
import 'package:dishlocal/data/categories/chat/repository/interface/chat_repository.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class MessageButton extends StatefulWidget {
  final AppUser otherUser;
  final Widget? child;
  final ButtonStyle? style;

  const MessageButton({
    super.key,
    required this.otherUser,
    this.child,
    this.style,
  });

  @override
  State<MessageButton> createState() => _MessageButtonState();
}

class _MessageButtonState extends State<MessageButton> {
  bool _isLoading = false;

  /// Xử lý logic khi nút được nhấn.
  Future<void> _handleOnPressed() async {
    // Ngăn người dùng nhấn nhiều lần khi đang xử lý
    if (_isLoading) return;

    setState(() {
      _isLoading = true;
    });

    try {
      // Lấy repository từ DI
      final chatRepository = getIt<ChatRepository>();

      // Gọi repository để lấy hoặc tạo cuộc trò chuyện
      final result = await chatRepository.getOrCreateConversation(
        otherUserId: widget.otherUser.userId,
      );

      // Xử lý kết quả và điều hướng
      // Kiểm tra `mounted` để đảm bảo widget vẫn còn trên cây widget trước khi dùng BuildContext
      if (!mounted) return;

      result.fold(
        (failure) {
          // Hiển thị lỗi cho người dùng
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Không thể bắt đầu cuộc trò chuyện: ${failure.message}')),
          );
        },
        (conversationId) {
          context.push('/chat', extra: {
            'conversationId': conversationId,
            'otherUser': widget.otherUser,
          });
        },
      );
    } finally {
      // Luôn đảm bảo tắt trạng thái loading, dù thành công hay thất bại
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: InkWell(
        borderRadius: BorderRadius.circular(8),
        onTap: _isLoading ? null : _handleOnPressed,
        child: Ink(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          decoration: BoxDecoration(
            color: appColorScheme(context).outlineVariant,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              _isLoading
                  // Hiển thị vòng quay tải khi đang loading
                  ? Container(
                      width: 18,
                      height: 18,
                      padding: const EdgeInsets.all(2.0),
                      child: CircularProgressIndicator(
                        color: appColorScheme(context).primary,
                        strokeWidth: 2,
                      ),
                    )
                  : AppIcons.chat3.toSvg(
                      width: 18,
                      height: 18,
                      color: appColorScheme(context).primary,
                    ),
              const SizedBox(width: 8),
              ShaderMask(
                shaderCallback: (bounds) => primaryGradient.createShader(
                  Rect.fromLTWH(0, 0, bounds.width, bounds.height),
                ),
                blendMode: BlendMode.srcIn,
                child: Text(
                  "Nhắn tin",
                  style: Theme.of(context).textTheme.labelMedium?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
