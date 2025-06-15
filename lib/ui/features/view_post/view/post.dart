import 'package:dishlocal/app/theme/app_icons.dart';
import 'package:dishlocal/app/theme/theme.dart';
import 'package:dishlocal/ui/widgets/element_widgets/custom_icon_with_label.dart';
import 'package:dishlocal/ui/widgets/element_widgets/glass_icon_labels_wrap.dart';
import 'package:dishlocal/ui/widgets/image_widgets/blurred_edge_widget.dart';
import 'package:dishlocal/ui/widgets/containers_widgets/glass_container.dart';
import 'package:dishlocal/ui/widgets/image_widgets/cached_circle_avatar.dart';
import 'package:dishlocal/ui/widgets/image_widgets/cached_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class Post extends StatelessWidget {
  const Post({super.key, required this.postId});

  final int postId;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(12),
      onTap: () => context.push('/post_detail', extra: {
        "postId": postId,
      }),
      child: GlassContainer(
        borderTop: true,
        borderLeft: true,
        borderRight: true,
        borderBottom: true,
        borderRadius: 12,
        horizontalPadding: 10,
        verticalPadding: 5,
        borderWidth: 0.5,
        backgroundColor: Colors.transparent,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(
              height: 5,
            ),
            Stack(
              children: [
                Hero(
                  tag: 'post_$postId',
                  child: const CachedImage(
                    imageUrl: 'https://www.foodiesfeed.com/wp-content/uploads/2023/06/burger-with-melted-cheese.jpg',
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
                                label: '2 km',
                                labelStyle: appTextTheme(context).labelSmall,
                              ),
                            ],
                          ),
                          GlassIconLabelsWrap(
                            iconLabels: [
                              CustomIconWithLabel(
                                icon: AppIcons.location1.toSvg(
                                  width: 12,
                                  color: Theme.of(context).colorScheme.onSurface,
                                ),
                                label: '2 km',
                                labelStyle: appTextTheme(context).labelSmall,
                              ),
                            ],
                          ),
                          GlassIconLabelsWrap(
                            iconLabels: [
                              CustomIconWithLabel(
                                icon: AppIcons.time.toSvg(
                                  width: 12,
                                  color: Theme.of(context).colorScheme.onSurface,
                                ),
                                label: '4:00-23:00',
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
                            label: '12K',
                            labelStyle: appTextTheme(context).labelSmall,
                          ),
                          CustomIconWithLabel(
                            icon: AppIcons.locationCheck.toSvg(width: 12, color: appColorScheme(context).onSurface),
                            label: '345',
                            labelStyle: appTextTheme(context).labelSmall,
                          ),
                          CustomIconWithLabel(
                            icon: AppIcons.bookmark1.toSvg(width: 12, color: appColorScheme(context).onSurface),
                            label: '1.2K',
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
              height: 5,
            ),
            Text(
              'Cơm tấm sườn bì chả',
              style: Theme.of(context).textTheme.labelMedium,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              children: [
                const CachedCircleAvatar(
                  imageUrl: 'https://dep.com.vn/wp-content/uploads/2024/10/Lana.jpg',
                  circleRadius: 8,
                ),
                const SizedBox(
                  width: 5,
                ),
                Expanded(
                  child: Text(
                    'danhdelrey',
                    style: Theme.of(context).textTheme.labelMedium,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  '4 giờ',
                  style: Theme.of(context).textTheme.labelSmall!.copyWith(
                        color: Theme.of(context).colorScheme.outline,
                      ),
                ),
              ],
            ),
            const SizedBox(
              height: 2,
            ),
          ],
        ),
      ),
    );
  }
}
