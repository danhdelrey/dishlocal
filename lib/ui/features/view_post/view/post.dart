import 'package:dishlocal/app/theme/app_icons.dart';
import 'package:dishlocal/ui/widgets/blurred_edge_image.dart';
import 'package:dishlocal/ui/widgets/blurred_pill.dart';
import 'package:dishlocal/ui/widgets/cropped_image.dart';
import 'package:dishlocal/ui/widgets/glass_container.dart';
import 'package:dishlocal/ui/widgets/rounded_square_image_asset.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class Post extends StatelessWidget {
  const Post({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(12),
      onTap: () => context.push('/post_detail'),
      child: GlassContainer(
        borderRadius: 12,
        horizontalPadding: 10,
        verticalPadding: 5,
        borderWidth: 0.5,
        gradient: LinearGradient(
          begin: Alignment.topCenter, // Bắt đầu từ trên
          end: Alignment.bottomCenter, // Kết thúc ở dưới
          colors: [
            // Màu bắt đầu: với 25% độ mờ (để vẫn thấy hiệu ứng glass)
            Colors.black.withValues(alpha: 0.25),
            // Màu kết thúc: với 0% độ mờ (hoàn toàn trong suốt)
            Colors.black.withValues(alpha: 0.0),
          ],
          // Tùy chọn: stops để kiểm soát điểm chuyển màu
          stops: const [0, 1.0],
        ),
        child: Expanded(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Cơm tấm sườn bì chả',
                style: Theme.of(context).textTheme.labelLarge,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(
                height: 5,
              ),
              Stack(
                children: [
                  const AspectRatio(
                    aspectRatio: 1,
                    child: BlurredEdgeImage(imageUrl: 'https://www.foodiesfeed.com/wp-content/uploads/2023/06/burger-with-melted-cheese.jpg'),
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
                            BlurredPill(
                              icon: AppIcons.location1.toSvg(
                                width: 12,
                                color: Theme.of(context).colorScheme.onSurface,
                              ),
                              label: '2 km',
                            ),
                            BlurredPill(
                              icon: AppIcons.wallet4.toSvg(
                                width: 12,
                                color: Theme.of(context).colorScheme.onSurface,
                              ),
                              label: '70.000đ',
                            ),
                            BlurredPill(
                              icon: AppIcons.time.toSvg(
                                width: 12,
                                color: Theme.of(context).colorScheme.onSurface,
                              ),
                              label: '4:00-23:00',
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Positioned.fill(
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: GlassContainer(
                        borderWidth: 0.5,
                        child: _buildSmallReactionBar(context),
                      ),
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 5,
              ),
              Row(
                children: [
                  const CroppedImage(
                    borderRadius: 1000,
                    width: 16,
                    height: 16,
                    path: 'assets/images/Lana.jpg',
                  ),
                  const SizedBox(
                    width: 2,
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
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSmallReactionBar(BuildContext context) {
    return Wrap(
      alignment: WrapAlignment.center,
      spacing: 5,
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            AppIcons.heart1.toSvg(
              width: 12,
              color: Theme.of(context).colorScheme.onSurface,
            ),
            const SizedBox(
              width: 2,
            ),
            Text(
              '1.4K',
              style: Theme.of(context).textTheme.labelSmall,
            ),
          ],
        ),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            AppIcons.locationCheck.toSvg(
              width: 12,
              color: Theme.of(context).colorScheme.onSurface,
            ),
            const SizedBox(
              width: 2,
            ),
            Text(
              '678',
              style: Theme.of(context).textTheme.labelSmall,
            ),
          ],
        ),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            AppIcons.bookmark1.toSvg(
              width: 12,
              color: Theme.of(context).colorScheme.onSurface,
            ),
            const SizedBox(
              width: 2,
            ),
            Text(
              '323',
              style: Theme.of(context).textTheme.labelSmall,
            ),
          ],
        ),
      ],
    );
  }
}
