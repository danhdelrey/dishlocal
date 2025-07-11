import 'package:dishlocal/app/theme/app_icons.dart';
import 'package:dishlocal/app/theme/theme.dart';
import 'package:dishlocal/core/utils/number_formatter.dart';
import 'package:dishlocal/core/utils/time_formatter.dart';
import 'package:dishlocal/data/categories/post/model/post.dart';
import 'package:dishlocal/ui/widgets/element_widgets/custom_icon_with_label.dart';
import 'package:dishlocal/ui/widgets/element_widgets/glass_icon_labels_wrap.dart';
import 'package:dishlocal/ui/widgets/image_widgets/cached_circle_avatar.dart';
import 'package:dishlocal/ui/widgets/image_widgets/cached_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blurhash/flutter_blurhash.dart';
import 'package:go_router/go_router.dart';

class SmallPost extends StatelessWidget {
  const SmallPost({super.key, required this.post, required this.onDeletePostPopBack});

  final Post post;
  final VoidCallback onDeletePostPopBack;

  @override
  Widget build(BuildContext context) {
    return Material(
      child: InkWell(
        borderRadius: BorderRadius.circular(20),
        onTap: () async {
          final result = await context.push('/post_detail', extra: {
            "post": post,
          });
          if (result == true) {
            onDeletePostPopBack();
          }
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                post.dishName ?? '',
                style: Theme.of(context).textTheme.labelMedium,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(
                height: 5,
              ),
              Stack(
                children: [
                  Hero(
                    tag: 'post_image_${post.postId}',
                    child: CachedImage(
                      imageUrl: post.imageUrl ?? '',
                      blurHash: post.blurHash ?? '',
                    ),
                  ),
                  Positioned.fill(
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Wrap(
                          spacing: 5,
                          runSpacing: 5,
                          children: [
                            GlassIconLabelsWrap(
                              iconLabels: [
                                CustomIconWithLabel(
                                  icon: AppIcons.location1.toSvg(
                                    width: 12,
                                    color: Theme.of(context).colorScheme.onSurface,
                                  ),
                                  label: NumberFormatter.formatDistance(post.distance),
                                  labelStyle: appTextTheme(context).labelSmall,
                                ),
                              ],
                            ),
                            GlassIconLabelsWrap(
                              iconLabels: [
                                CustomIconWithLabel(
                                  icon: AppIcons.wallet4.toSvg(
                                    width: 12,
                                    color: Theme.of(context).colorScheme.onSurface,
                                  ),
                                  label: NumberFormatter.formatMoney(post.price ?? 0),
                                  labelStyle: appTextTheme(context).labelSmall,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Positioned.fill(
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: GlassIconLabelsWrap(
                          iconLabels: [
                            CustomIconWithLabel(
                              //TODO: thêm điều kiện chỉ hiển thị màu nếu là của mình đã like/save,còn của người khác like hay save thì mình ko hiện màu vì mình chưa có like/save
                              icon: AppIcons.heart1.toSvg(width: 12, color: appColorScheme(context).onSurface),
                              label: NumberFormatter.formatCompactNumberStable(post.likeCount),
                              labelStyle: appTextTheme(context).labelSmall?.copyWith(
                                    color: appColorScheme(context).onSurface,
                                  ),
                            ),
                            CustomIconWithLabel(
                              icon: AppIcons.comment2.toSvg(width: 12, color: appColorScheme(context).onSurface),
                              label: NumberFormatter.formatCompactNumberStable(post.commentCount),
                              labelStyle: appTextTheme(context).labelSmall?.copyWith(
                                    color: appColorScheme(context).onSurface,
                                  ),
                            ),
                            CustomIconWithLabel(
                              icon: AppIcons.bookmark1.toSvg(width: 12, color: appColorScheme(context).onSurface),
                              label: NumberFormatter.formatCompactNumberStable(post.saveCount),
                              labelStyle: appTextTheme(context).labelSmall?.copyWith(
                                    color: appColorScheme(context).onSurface,
                                  ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  CachedCircleAvatar(
                    imageUrl: post.authorAvatarUrl ?? '',
                    circleRadius: 8,
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Expanded(
                    child: Text(
                      post.authorUsername,
                      style: Theme.of(context).textTheme.labelMedium,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    TimeFormatter.formatTimeAgo(post.createdAt),
                    style: Theme.of(context).textTheme.labelSmall!.copyWith(
                          color: Theme.of(context).colorScheme.outline,
                        ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
