import 'package:dishlocal/app/theme/app_icons.dart';
import 'package:dishlocal/ui/widgets/element_widgets/custom_icon_with_label.dart';
import 'package:dishlocal/ui/widgets/image_widgets/cached_circle_avatar.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class Comment extends StatelessWidget {
  const Comment({
    super.key,
    this.subComment,
    this.circleAvatarRadius = 18,
  });

  final Widget? subComment;
  final double circleAvatarRadius;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 10,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
           CachedCircleAvatar(
            imageUrl: 'https://dep.com.vn/wp-content/uploads/2024/10/Lana.jpg',
            circleRadius: circleAvatarRadius,
          ),
          const SizedBox(
            width: 10,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RichText(
                  text: TextSpan(
                    text: 'lanadelrey',
                    style: Theme.of(context).textTheme.labelLarge,
                    children: [
                      TextSpan(
                        text: ' • Tác giả',
                        style: Theme.of(context).textTheme.labelMedium!.copyWith(
                              color: Theme.of(context).colorScheme.primary,
                            ),
                        recognizer: TapGestureRecognizer()..onTap = () {},
                      )
                    ],
                  ),
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
                CustomIconWithLabel(
                  icon: AppIcons.locationCheckFilled.toSvg(
                    color: Colors.blue,
                    width: 14,
                  ),
                  label: '13:45 25/05/2025',
                  labelStyle: Theme.of(context).textTheme.labelMedium!.copyWith(
                        color: Colors.blue,
                      ),
                ),
                Text(
                  'Mình vừa check lại, hình như quán còn có cả món cơm tấm sườn nướng mật ong nữa đó cả nhà, ai thích ngọt ngọt thì thử nha! Đỉnh của chóp!',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                const SizedBox(
                  height: 5,
                ),
                Row(
                  children: [
                    Text(
                      '4 giờ',
                      style: Theme.of(context).textTheme.labelMedium!.copyWith(
                            color: Theme.of(context).colorScheme.outline,
                          ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      'Trả lời',
                      style: Theme.of(context).textTheme.labelMedium!.copyWith(
                            color: Theme.of(context).colorScheme.onSurface,
                          ),
                    ),
                    const Spacer(),
                    CustomIconWithLabel(
                      icon: AppIcons.heart1.toSvg(
                        color: Theme.of(context).colorScheme.outline,
                        width: 14,
                      ),
                      label: '123',
                      labelStyle: Theme.of(context).textTheme.labelMedium!.copyWith(
                            color: Theme.of(context).colorScheme.outline,
                          ),
                    ),
                  ],
                ),
                if (subComment != null)
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: subComment!,
                  ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  'Xem 120 trả lời...',
                  style: Theme.of(context).textTheme.labelMedium!.copyWith(
                        color: Theme.of(context).colorScheme.outline,
                      ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
