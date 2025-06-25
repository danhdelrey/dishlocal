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
    return InkWell(
      borderRadius: BorderRadius.circular(20),
      onTap: () async {
        final result = await context.push('/post_detail', extra: {
          "post": post,
        });
        if (result == true) {
          onDeletePostPopBack();
        }
      },
      child: Stack(
        children: [
          Positioned.fill(
            child: ClipRRect(
              // Clip để bo tròn góc cho lớp nền, khớp với viền của nội dung
              borderRadius: BorderRadius.circular(20),
              child: ShaderMask(
                // ShaderMask là widget chính để tạo hiệu ứng gradient opacity
                shaderCallback: (bounds) {
                  // Tạo một dải màu gradient tuyến tính từ trên xuống dưới
                  return RadialGradient(
                    // Bắt đầu gradient từ chính giữa
                    center: Alignment.center,
                    // Bán kính của gradient, 1.0 sẽ vừa khít các cạnh ngắn hơn
                    // Bạn có thể chỉnh giá trị này để vòng tròn to/nhỏ hơn
                    radius: 0.8,
                    // Màu sắc quyết định độ trong suốt
                    colors: [
                      Colors.white.withValues(alpha: 0.4), // Rất mờ
                      Colors.white.withValues(alpha: 0.3),
                      Colors.white.withValues(alpha: 0.0),
                    ],
                    stops: const [0.0, 0.6, 1.0], // Vùng sáng lan tỏa rộng
                  ).createShader(bounds);
                },
                // BlendMode.dstIn sẽ áp dụng alpha (độ trong suốt) của shader
                // lên child widget (BlurHash)
                blendMode: BlendMode.dstIn,
                child: BlurHash(
                  // Sử dụng blurhash từ post object của bạn
                  // Thêm một giá trị mặc định phòng trường hợp post.blurHash là null
                  hash: post.blurHash ?? 'L00000fQfQfQ00fQfQfQ00fQfQfQ',
                  imageFit: BoxFit.cover, // Đảm bảo blurhash lấp đầy không gian
                ),
              ),
            ),
          ),
          Container(
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
                                  icon: post.isLiked ? AppIcons.heart.toSvg(width: 12, color: Colors.pink) : AppIcons.heart1.toSvg(width: 12, color: appColorScheme(context).onSurface),
                                  label: post.likeCount.toString(),
                                  labelStyle: appTextTheme(context).labelSmall?.copyWith(
                                        color: post.isLiked ? Colors.pink : appColorScheme(context).onSurface,
                                      ),
                                ),
                                CustomIconWithLabel(
                                  icon: post.isSaved ? AppIcons.bookmark.toSvg(width: 12, color: Colors.amber) : AppIcons.bookmark1.toSvg(width: 12, color: appColorScheme(context).onSurface),
                                  label: post.saveCount.toString(),
                                  labelStyle: appTextTheme(context).labelSmall?.copyWith(
                                        color: post.isSaved ? Colors.amber : appColorScheme(context).onSurface,
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
        ],
      ),
    );
  }
}
