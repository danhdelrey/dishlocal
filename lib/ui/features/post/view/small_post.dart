import 'package:dishlocal/app/theme/app_icons.dart';
import 'package:dishlocal/app/theme/theme.dart';
import 'package:dishlocal/core/utils/timeago_formatter.dart';
import 'package:dishlocal/data/categories/post/model/post.dart';
import 'package:dishlocal/ui/widgets/element_widgets/custom_icon_with_label.dart';
import 'package:dishlocal/ui/widgets/element_widgets/glass_icon_labels_wrap.dart';
import 'package:dishlocal/ui/widgets/image_widgets/blurred_edge_widget.dart';
import 'package:dishlocal/ui/widgets/containers_widgets/glass_container.dart';
import 'package:dishlocal/ui/widgets/image_widgets/cached_circle_avatar.dart';
import 'package:dishlocal/ui/widgets/image_widgets/cached_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SmallPost extends StatelessWidget {
  const SmallPost({super.key, required this.post});

  final Post post;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(20),
      onTap: () => context.push('/post_detail', extra: {
        "post" : post,
      }),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.white.withValues(alpha: 0.1),
          ),
          borderRadius: BorderRadius.circular(20),
        ),
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
                   CachedImage(
                    imageUrl: post.imageUrl ?? '',
                    blurHash: post.blurHash ?? '',
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
                                  label: '1.2 km',
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
                                  label: post.price.toString(),
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
                              icon: AppIcons.heart1.toSvg(width: 12, color: appColorScheme(context).onSurface),
                              label: post.likeCount.toString(),
                              labelStyle: appTextTheme(context).labelSmall,
                            ),
                            CustomIconWithLabel(
                              icon: AppIcons.bookmark1.toSvg(width: 12, color: appColorScheme(context).onSurface),
                              label: post.saveCount.toString(),
                              labelStyle: appTextTheme(context).labelSmall,
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
                    TimeagoFormatter.formatTimeAgo(post.createdAt),
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
