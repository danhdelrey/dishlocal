import 'dart:ui';

import 'package:dishlocal/app/theme/app_icons.dart';
import 'package:dishlocal/app/theme/theme.dart';
import 'package:dishlocal/ui/features/comment/view/comment_input.dart';
import 'package:dishlocal/ui/features/comment/view/comment_section.dart';
import 'package:dishlocal/ui/features/view_post/view/review_section.dart';
import 'package:dishlocal/ui/widgets/blurred_edge_image.dart';
import 'package:dishlocal/ui/widgets/cropped_image.dart';
import 'package:dishlocal/ui/widgets/custom_icon_with_label.dart';
import 'package:dishlocal/ui/widgets/glass_space.dart';
import 'package:dishlocal/ui/widgets/gradient_filled_button.dart';
import 'package:dishlocal/ui/widgets/rounded_square_image_asset.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class PostDetailPage extends StatelessWidget {
  const PostDetailPage({super.key, required this.postId});

  final int postId;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        extendBody: true,
        appBar: AppBar(
          shape: Border(
            bottom: BorderSide(
              width: 1,
              color: Colors.white.withValues(alpha: 0.1),
              style: BorderStyle.solid,
            ),
          ),
          title: const Text('Cơm tấm sườn bì chả'),
          automaticallyImplyLeading: false,
          leading: IconButton(
            onPressed: () {
              context.pop();
            },
            icon: AppIcons.left.toSvg(
              color: Theme.of(context).colorScheme.onSurface,
            ),
          ),
          titleTextStyle: appTextTheme(context).titleMedium,
          surfaceTintColor: Colors.transparent,
          backgroundColor: Colors.transparent,
          flexibleSpace: const GlassSpace(
            blur: 50,
            backgourndColor: Colors.transparent,
          ),
          actions: [
            IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.more_horiz,
              ),
            ),
          ],
        ),
        body: SafeArea(
          child: Stack(
            children: [
              _buildMainContent(context),
              const Positioned(
                left: 0,
                right: 0,
                bottom: 0,
                child: CommentInput(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMainContent(BuildContext context) {
    return SingleChildScrollView(
      keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 150),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  Hero(
                    tag: 'post_$postId',
                    child: const AspectRatio(
                      aspectRatio: 1,
                      child: BlurredEdgeImage(
                        clearRadius: 1,
                        imageUrl: 'https://www.foodiesfeed.com/wp-content/uploads/2023/06/burger-with-melted-cheese.jpg',
                        blurSigma: 50,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  CustomIconWithLabel(
                    icon: AppIcons.location.toSvg(
                      width: 16,
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
                    label: '2 km',
                  ),
                  Text(
                    'Cơm tấm Hoàng Sang',
                    style: Theme.of(context).textTheme.labelLarge,
                  ),
                  Text(
                    '75/36 Võ Trường Toản, phường An Hòa, quận Ninh Kiều, tp. Cần Thơ',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  CustomIconWithLabel(
                    icon: AppIcons.time.toSvg(
                      width: 16,
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
                    label: 'Giờ mở cửa: Từ 8:00 đến 23:00',
                  ),
                  CustomIconWithLabel(
                    icon: AppIcons.wallet4.toSvg(
                      width: 16,
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
                    label: 'Giá: 100.000đ',
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  CustomIconWithLabel(
                    icon: AppIcons.locationCheckFilled.toSvg(
                      color: Colors.blue,
                      width: 16,
                    ),
                    label: 'Bạn đã đến đây vào ngày 01/06/2025 lúc 10:23',
                    labelColor: Colors.blue,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  GradientFilledButton(
                    maxWidth: true,
                    icon: AppIcons.location.toSvg(
                      width: 16,
                      color: Colors.white,
                    ),
                    label: 'Xem trên bản đồ',
                    onTap: () {},
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
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
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'danhdelrey',
                              style: Theme.of(context).textTheme.labelLarge,
                            ),
                            CustomIconWithLabel(
                              icon: AppIcons.locationCheckFilled.toSvg(
                                color: Colors.blue,
                                width: 14,
                              ),
                              labelStyle: appTextTheme(context).labelMedium!.copyWith(
                                    color: Colors.blue,
                                  ),
                              label: '13:45 25/05/2025',
                              labelColor: Colors.blue,
                            ),
                          ],
                        ),
                      ),
                      InkWell(
                        onTap: () {},
                        borderRadius: BorderRadius.circular(12),
                        child: Container(
                          decoration: BoxDecoration(
                            color: appColorScheme(context).primary,
                            borderRadius: BorderRadius.circular(12),
                            // border: BoxBorder.all(
                            //   color: appColorScheme(context).outline,
                            //   width: 1,
                            // ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                            child: Text(
                              'Theo dõi',
                              style: Theme.of(context).textTheme.labelMedium!.copyWith(
                                    color: appColorScheme(context).onPrimary,
                                  ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Mới vừa ăn một dĩa cơm tấm ở Quán Hoàng Sang... Ôi trời ơi, ngon xỉu up xỉu down luôn mọi người ơi! 🤤 Miếng sườn nướng thấm vị, nước mắm đỉnh cao, ăn xong chỉ muốn order thêm dĩa nữa. Highly recommend cho team mê cơm tấm nha! ❤️',
                    style: appTextTheme(context).bodyMedium,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  _buildReactionBar(context),
                ],
              ),
            ),
            const Divider(),
            const SizedBox(
              height: 10,
            ),
            const CommentSection(),
          ],
        ),
      ),
    );
  }

  Row _buildReactionBar(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CustomIconWithLabel(
          icon: AppIcons.heart1.toSvg(
            width: 16,
            color: Theme.of(context).colorScheme.outline,
          ),
          label: '12.4 N',
          labelColor: Theme.of(context).colorScheme.outline,
        ),
        CustomIconWithLabel(
          icon: AppIcons.comment2.toSvg(
            width: 16,
            color: Theme.of(context).colorScheme.outline,
          ),
          labelColor: Theme.of(context).colorScheme.outline,
          label: '345',
        ),
        CustomIconWithLabel(
          icon: AppIcons.locationCheck.toSvg(
            width: 16,
            color: Theme.of(context).colorScheme.outline,
          ),
          labelColor: Theme.of(context).colorScheme.outline,
          label: '345',
        ),
        CustomIconWithLabel(
          icon: AppIcons.bookmark1.toSvg(
            width: 16,
            color: Theme.of(context).colorScheme.outline,
          ),
          labelColor: Theme.of(context).colorScheme.outline,
          label: '1.567',
        ),
        CustomIconWithLabel(
          icon: AppIcons.shareForward.toSvg(
            width: 16,
            color: Theme.of(context).colorScheme.outline,
          ),
          labelColor: Theme.of(context).colorScheme.outline,
          label: '101',
        ),
      ],
    );
  }
}
