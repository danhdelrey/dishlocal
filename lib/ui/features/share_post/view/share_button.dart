import 'package:dishlocal/app/theme/app_icons.dart';
import 'package:dishlocal/app/theme/theme.dart';
import 'package:dishlocal/ui/features/share_post/view/share_post_bottom_sheet.dart';
import 'package:flutter/material.dart';

class ShareButton extends StatelessWidget {
  final String postId;

  const ShareButton({super.key, required this.postId});

  void _showShareSheet(BuildContext context) {
    showModalBottomSheet(
      // === THAY ĐỔI: Sử dụng context của builder ===
      // Điều này đảm bảo context bên trong bottom sheet là context "mới"
      // và context bên ngoài vẫn có thể được truy cập an toàn.
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => SharePostBottomSheet(
        postId: postId,
        // Truyền context của màn hình cha vào
        parentContext: context,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () {
        _showShareSheet(context);
      },
      child: AppIcons.shareForward.toSvg(
        width: 20,
        height: 20,
        color: appColorScheme(context).onSurface,
      ),
    );
  }
}
