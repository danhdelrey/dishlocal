import 'package:dishlocal/app/theme/app_icons.dart';
import 'package:dishlocal/app/theme/custom_colors.dart';
import 'package:dishlocal/ui/widgets/app_text_field.dart';
import 'package:dishlocal/ui/widgets/cropped_image.dart';
import 'package:dishlocal/ui/widgets/glass_container.dart';
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
      blur: 30,
      borderTop: true,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            const CroppedImage(
              borderRadius: 1000,
              path: 'assets/images/Lana.jpg',
              width: 36,
              height: 36,
            ),
            const SizedBox(
              width: 10,
            ),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Theme.of(context).colorScheme.surfaceContainerLow,
                ),
                child: const AppTextField(
                  hintText: 'Viết bình luận của bạn...',
                ),
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
