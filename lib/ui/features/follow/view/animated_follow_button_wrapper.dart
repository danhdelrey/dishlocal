import 'package:dishlocal/app/theme/theme.dart';
import 'package:dishlocal/core/dependencies_injection/service_locator.dart';
import 'package:dishlocal/data/categories/app_user/model/app_user.dart';
import 'package:dishlocal/ui/features/follow/bloc/follow_bloc.dart';
import 'package:dishlocal/ui/features/view_post/view/post_detail_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// Một Widget bao bọc FollowButton để cung cấp animation ẩn đi
/// sau khi người dùng nhấn "Follow".
///
/// Đây là widget bạn sẽ sử dụng trong UI của mình.
class AnimatedFollowButtonWrapper extends StatefulWidget {
  const AnimatedFollowButtonWrapper({
    super.key,
    required this.targetUser,
    this.hideAfterFollow = true, // Mặc định là sẽ ẩn
  });

  /// Đối tượng người dùng mục tiêu (người được theo dõi).
  final AppUser targetUser;

  /// Nếu `true`, nút sẽ biến mất với animation sau khi theo dõi thành công.
  /// Nếu `false`, nút sẽ chỉ chuyển trạng thái thành "Đang theo dõi".
  final bool hideAfterFollow;

  @override
  State<AnimatedFollowButtonWrapper> createState() => _AnimatedFollowButtonWrapperState();
}

class _AnimatedFollowButtonWrapperState extends State<AnimatedFollowButtonWrapper> {
  // Biến cục bộ để điều khiển việc hiển thị của nút.
  late bool _isVisible;

  @override
  void initState() {
    super.initState();
    // Ban đầu, nút sẽ hiển thị nếu người dùng chưa follow.
    // Nếu đã follow từ trước, nút sẽ bị ẩn ngay từ đầu (nếu có yêu cầu).
    _isVisible = !(widget.targetUser.isFollowing ?? false) || !widget.hideAfterFollow;
  }

  // Cập nhật _isVisible nếu đối tượng targetUser thay đổi.
  // Điều này rất quan trọng khi widget được dùng trong một danh sách (ListView).
  @override
  void didUpdateWidget(covariant AnimatedFollowButtonWrapper oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.targetUser.userId != oldWidget.targetUser.userId) {
      setState(() {
        _isVisible = !(widget.targetUser.isFollowing ?? false) || !widget.hideAfterFollow;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // Nếu không có yêu cầu ẩn, chỉ cần hiển thị nút bình thường.
    if (!widget.hideAfterFollow) {
      // Cung cấp BlocProvider cho FollowButton vì nó đứng một mình.
      return BlocProvider(
        create: (context) => getIt<FollowBloc>(param1: widget.targetUser),
        child: _FollowButton(targetUser: widget.targetUser),
      );
    }

    // Sử dụng AnimatedSwitcher để tạo hiệu ứng ẩn/hiện mượt mà.
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 300),
      transitionBuilder: (child, animation) {
        // Kết hợp hiệu ứng thu nhỏ và mờ dần.
        return SizeTransition(
          sizeFactor: animation,
          axisAlignment: -1.0, // Animation thu nhỏ về phía trên.
          child: FadeTransition(
            opacity: animation,
            child: child,
          ),
        );
      },
      child: _isVisible
          ? _buildFollowButton() // Nếu isVisible là true, hiển thị nút.
          : const SizedBox.shrink(), // Nếu là false, hiển thị một widget trống.
    );
  }

  /// Xây dựng nút Follow với BlocProvider và BlocListener.
  Widget _buildFollowButton() {
    return BlocProvider(
      // Thêm key để đảm bảo Bloc được tạo lại đúng cách nếu widget này được
      // tái sử dụng trong một danh sách cho một người dùng khác.
      key: ValueKey(widget.targetUser.userId),
      create: (context) => getIt<FollowBloc>(param1: widget.targetUser),
      child: BlocListener<FollowBloc, FollowState>(
        // Lắng nghe sự thay đổi state của BLoC.
        listener: (context, state) {
          // Khi trạng thái isFollowing chuyển thành `true`, chúng ta ẩn nút đi.
          if (state.isFollowing) {
            setState(() {
              _isVisible = false;
            });
          }
        },
        // FollowButton bây giờ là con của BlocListener.
        child: _FollowButton(
          targetUser: widget.targetUser,
        ),
      ),
    );
  }
}

//==============================================================================
// WIDGET CON: FollowButton (Logic hiển thị)
//==============================================================================

/// Widget chỉ chịu trách nhiệm hiển thị UI của nút "Follow" / "Đang theo dõi".
/// Nó nhận trạng thái từ một `FollowBloc` được cung cấp ở cây widget phía trên.
class _FollowButton extends StatelessWidget {
  const _FollowButton({
    super.key,
    required this.targetUser,
  });

  final AppUser targetUser;

  @override
  Widget build(BuildContext context) {
    // Dùng BlocBuilder để vẽ lại UI khi state thay đổi.
    return BlocBuilder<FollowBloc, FollowState>(
      builder: (context, state) {
        final isFollowing = state.isFollowing;

        // Lấy màu từ theme của ứng dụng.
        final primary = appColorScheme(context).primary;
        final onPrimary = appColorScheme(context).onPrimary;
        final surface = appColorScheme(context).surface;
        final onSurface = appColorScheme(context).onSurface;

        // Quyết định màu nền và màu chữ dựa trên trạng thái `isFollowing`.
        final backgroundColor = isFollowing ? surface : primary;
        final textColor = isFollowing ? onSurface : onPrimary;

        return GestureDetector(
          // Gửi sự kiện đến BLoC khi người dùng nhấn vào.
          onTap: () {
            context.read<FollowBloc>().add(const FollowEvent.followToggled());
          },
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 150),
            curve: Curves.easeInOut,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: backgroundColor,
              borderRadius: BorderRadius.circular(1000),
              border: Border.all(
                color: isFollowing ? primary : Colors.transparent,
                width: 1,
              ),
            ),
            child: AnimatedSize(
              duration: const Duration(milliseconds: 150),
              curve: Curves.easeInOut,
              alignment: Alignment.center,
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 100),
                transitionBuilder: (child, animation) {
                  final offsetAnimation = Tween<Offset>(
                    begin: const Offset(0, 0.3),
                    end: Offset.zero,
                  ).animate(animation);
                  return FadeTransition(
                    opacity: animation,
                    child: SlideTransition(position: offsetAnimation, child: child),
                  );
                },
                child: Text(
                  isFollowing ? 'Đang theo dõi' : 'Theo dõi',
                  // `key` là yếu tố quan trọng để AnimatedSwitcher biết khi nào cần chạy animation.
                  key: ValueKey(isFollowing),
                  style: Theme.of(context).textTheme.labelMedium!.copyWith(
                        color: textColor,
                        fontWeight: FontWeight.w500,
                      ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
