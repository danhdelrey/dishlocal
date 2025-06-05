import 'dart:ui';

import 'package:dishlocal/app/config/router.dart';
import 'package:dishlocal/app/theme/app_icons.dart';
import 'package:dishlocal/ui/widgets/custom_badge.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        body: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverAppBar(
                surfaceTintColor: Colors.transparent,
                backgroundColor: Theme.of(context).colorScheme.surface,
                title: Row(
                  children: [
                    AppIcons.appIconGradient.toSvg(
                      width: 24,
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    const Text(
                      'DishLocal',
                      style: TextStyle(
                        fontFamily: 'SFProDisplay',
                        fontWeight: FontWeight.w800,
                        fontSize: 18,
                      ),
                    ),
                    const Spacer(),
                    IconButton.filledTonal(
                      onPressed: () {},
                      icon: AppIcons.search.toSvg(
                        color: Theme.of(context).colorScheme.onSurface,
                      ),
                      style: IconButton.styleFrom(
                        backgroundColor:
                            Theme.of(context).colorScheme.surfaceContainerLow,
                      ),
                    ),
                    IconButton.filledTonal(
                      onPressed: () {},
                      icon: CustomBadge(
                        child: AppIcons.notification1.toSvg(
                          color: Theme.of(context).colorScheme.onSurface,
                        ),
                      ),
                      style: IconButton.styleFrom(
                        backgroundColor:
                            Theme.of(context).colorScheme.surfaceContainerLow,
                      ),
                    ),
                  ],
                ),
                pinned: true,
                floating: true,
                snap: true,
                bottom: const TabBar(
                  indicatorSize: TabBarIndicatorSize.tab,
                  tabs: [
                    Tab(
                      text: 'Dành cho bạn',
                    ),
                    Tab(
                      text: 'Đang theo dõi',
                    ),
                    Tab(
                      text: 'Xu hướng',
                    ),
                  ],
                ),
              ),
            ];
          },
          body: TabBarView(
            children: [
              ListView.builder(
                itemBuilder: (context, index) => const TwoPostsRow(),
                itemCount: 20, // Tăng số lượng item để dễ cuộn
              ),
              ListView.builder(
                itemBuilder: (context, index) => const TwoPostsRow(),
                itemCount: 5,
              ),
              ListView.builder(
                itemBuilder: (context, index) => const TwoPostsRow(),
                itemCount: 10,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class TwoPostsRow extends StatelessWidget {
  const TwoPostsRow({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.only(left: 20, right: 20, bottom: 20),
      child: Row(
        children: [
          Post(),
          SizedBox(
            width: 20,
          ),
          Post(),
        ],
      ),
    );
  }
}

class Post extends StatelessWidget {
  const Post({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: LayoutBuilder(builder: (context, constraints) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Cơm tấm sườn bì chả',
              style: Theme.of(context).textTheme.labelMedium,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(
              height: 5,
            ),
            Stack(
              children: [
                CroppedImage(
                  height: constraints.maxWidth,
                  borderRadius: 12,
                  path: 'assets/images/com-tam-suon-bi-cha-2.jpg',
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
                    alignment: Alignment.bottomLeft,
                    child: ClipRRect(
                      borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(12),
                        bottomRight: Radius.circular(12),
                      ),
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.3),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(
                              top: 5,
                              bottom: 5,
                              left: 10,
                              right: 10,
                            ),
                            child: SizedBox(
                              width: double.infinity,
                              child: Wrap(
                                alignment: WrapAlignment.center,
                                spacing: 5,
                                children: [
                                  Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      AppIcons.heart1.toSvg(
                                        width: 12,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onSurface,
                                      ),
                                      const SizedBox(
                                        width: 2,
                                      ),
                                      Text(
                                        '1.234',
                                        style: Theme.of(context)
                                            .textTheme
                                            .labelSmall,
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      AppIcons.locationCheck.toSvg(
                                        width: 12,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onSurface,
                                      ),
                                      const SizedBox(
                                        width: 2,
                                      ),
                                      Text(
                                        '678',
                                        style: Theme.of(context)
                                            .textTheme
                                            .labelSmall,
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      AppIcons.bookmark1.toSvg(
                                        width: 12,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onSurface,
                                      ),
                                      const SizedBox(
                                        width: 2,
                                      ),
                                      Text(
                                        '323',
                                        style: Theme.of(context)
                                            .textTheme
                                            .labelSmall,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
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
                  path: 'assets/images/com-tam-suon-bi-cha-2.jpg',
                ),
                const SizedBox(
                  width: 2,
                ),
                Expanded(
                  child: Text(
                    'danhdelreyrererererererere',
                    style: Theme.of(context).textTheme.labelSmall,
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
        );
      }),
    );
  }
}

class BlurredPill extends StatelessWidget {
  const BlurredPill({super.key, this.icon, required this.label});

  final Widget? icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(1000),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.3),
          ),
          child: Padding(
            padding: const EdgeInsets.only(
              left: 5,
              right: 5,
              top: 2,
              bottom: 2,
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                icon ?? const SizedBox(),
                const SizedBox(
                  width: 2,
                ),
                Text(
                  label,
                  style: Theme.of(context).textTheme.labelSmall,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CroppedImage extends StatelessWidget {
  const CroppedImage({
    super.key,
    required this.borderRadius,
    this.width,
    this.height,
    required this.path,
  });

  final String path;
  final double borderRadius;
  final double? width;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius), // Bo tròn góc
      child: SizedBox(
        width: width,
        height: height,
        child: Image.asset(
          path, // Thay bằng đường dẫn ảnh của bạn
          fit: BoxFit
              .cover, // Đảm bảo ảnh lấp đầy khung hình và cắt bỏ phần thừa
        ),
      ),
    );
  }
}
