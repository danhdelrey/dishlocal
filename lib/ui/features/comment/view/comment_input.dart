import 'package:cached_network_image/cached_network_image.dart';
import 'package:dishlocal/app/theme/app_icons.dart';
import 'package:dishlocal/app/theme/custom_colors.dart';
import 'package:dishlocal/ui/widgets/input_widgets/app_text_field.dart';
import 'package:dishlocal/ui/widgets/containers_widgets/glass_container.dart';
import 'package:dishlocal/ui/widgets/image_widgets/cached_circle_avatar.dart';
import 'package:flutter/material.dart';

class CommentInput extends StatelessWidget {
  const CommentInput({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GlassContainer(
      borderRadius: 0,
      backgroundColor: Colors.transparent,
      blur: 50,
      borderTop: true,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            const CachedCircleAvatar(
              imageUrl: 'https://dep.com.vn/wp-content/uploads/2024/10/Lana.jpg',
            ),
            const SizedBox(
              width: 10,
            ),
            const Expanded(
              child: AppTextField(
                borderRadius: 20,
                hintText: 'Viết bình luận của bạn...',
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Container(
              decoration: BoxDecoration(
                gradient: primaryGradient,
                borderRadius: BorderRadius.circular(1000),
              ),
              child: Material(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(1000),
                child: InkWell(
                  onTap: () {},
                  borderRadius: BorderRadius.circular(1000),
                  child: SizedBox(
                    width: 36,
                    height: 36,
                    child: Padding(
                      padding: const EdgeInsets.all(6.0),
                      child: AppIcons.sendFill.toSvg(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
