import 'package:dishlocal/app/theme/app_icons.dart';
import 'package:dishlocal/app/theme/theme.dart';
import 'package:dishlocal/core/utils/number_formatter.dart';
import 'package:dishlocal/core/utils/time_formatter.dart';
import 'package:dishlocal/data/categories/post/model/post.dart';
import 'package:dishlocal/ui/features/comment/view/comment_input.dart';
import 'package:dishlocal/ui/features/comment/view/comment_section.dart';
import 'package:dishlocal/ui/features/post/view/reaction_bar.dart';
import 'package:dishlocal/ui/widgets/element_widgets/glass_sliver_app_bar.dart';
import 'package:dishlocal/ui/widgets/element_widgets/custom_icon_with_label.dart';
import 'package:dishlocal/ui/widgets/containers_widgets/glass_space.dart';
import 'package:dishlocal/ui/widgets/buttons_widgets/gradient_filled_button.dart';
import 'package:dishlocal/ui/widgets/image_widgets/blurred_edge_widget.dart';
import 'package:dishlocal/ui/widgets/image_widgets/cached_circle_avatar.dart';
import 'package:dishlocal/ui/widgets/image_widgets/cached_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:maps_launcher/maps_launcher.dart';

class PostDetailPage extends StatelessWidget {
  const PostDetailPage({super.key, required this.post});

  final Post post;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        extendBody: true,
        body: SafeArea(
          child: Stack(
            children: [
              _buildMainContent(context),
              // const Positioned(
              //   left: 0,
              //   right: 0,
              //   bottom: 0,
              //   child: CommentInput(),
              // ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMainContent(BuildContext context) {
    return CustomScrollView(
      physics: const BouncingScrollPhysics(),
      keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
      slivers: [
        GlassSliverAppBar(
          floating: true,
          pinned: true,
          leading: IconButton(
            onPressed: () {
              context.pop();
            },
            icon: AppIcons.left.toSvg(
              color: Theme.of(context).colorScheme.onSurface,
            ),
          ),
          title: Text(post.dishName ?? ''),
        ),
        SliverToBoxAdapter(
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
                      BlurredEdgeWidget(
                        blurredChild: CachedImage(blurHash: post.blurHash ?? '', imageUrl: post.imageUrl ?? ''),
                        clearRadius: 1,
                        blurSigma: 100,
                        topChild: CachedImage(blurHash: post.blurHash ?? '', imageUrl: post.imageUrl ?? ''),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      CustomIconWithLabel(
                        icon: AppIcons.location1.toSvg(
                          width: 16,
                          color: Theme.of(context).colorScheme.onSurface,
                        ),
                        label: 'Khoảng cách: ${NumberFormatter.formatDistance(post.distance)}',
                      ),
                      Text(
                        post.diningLocationName ?? '',
                        style: Theme.of(context).textTheme.labelLarge,
                      ),
                      Text(
                        '${post.address?.exactAddress ?? ''}, ${post.address?.displayName ?? ''}',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      CustomIconWithLabel(
                        icon: AppIcons.wallet4.toSvg(
                          width: 16,
                          color: Theme.of(context).colorScheme.onSurface,
                        ),
                        label: 'Giá: ${NumberFormatter.formatMoney(post.price ?? 0)}',
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
                        onTap: () {
                          if (post.address != null) {
                            MapsLauncher.launchCoordinates(post.address!.latitude, post.address!.longitude);
                          }
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          CachedCircleAvatar(
                            imageUrl: post.authorAvatarUrl ?? '',
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
                                  label: TimeFormatter.formatDateTimeFull(post.createdAt),
                                  labelColor: Colors.blue,
                                ),
                              ],
                            ),
                          ),
                          const FollowButton(),
                        ],
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Text(
                        post.insight ?? '',
                        style: appTextTheme(context).bodyMedium,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      ReactionBar(likeCount: post.likeCount, saveCount: post.saveCount),
                    ],
                  ),
                ),
                Divider(
                  color: Colors.white.withValues(alpha: 0.1),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class FollowButton extends StatefulWidget {
  const FollowButton({super.key});

  @override
  State<FollowButton> createState() => _FollowButtonState();
}

class _FollowButtonState extends State<FollowButton> {
  bool isFollowing = false;

  void _toggleFollow() {
    setState(() {
      isFollowing = !isFollowing;
    });
  }

  @override
  Widget build(BuildContext context) {
    final primary = appColorScheme(context).primary;
    final onPrimary = appColorScheme(context).onPrimary;
    final surface = appColorScheme(context).surface;
    final onSurface = appColorScheme(context).onSurface;

    final backgroundColor = isFollowing ? surface : primary;
    final textColor = isFollowing ? onSurface : onPrimary;

    return InkWell(
      onTap: _toggleFollow,
      borderRadius: BorderRadius.circular(12),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(isFollowing ? 24 : 12),
          border: Border.all(
            color: isFollowing ? primary : Colors.transparent,
            width: 1,
          ),
        ),
        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 200),
          transitionBuilder: (child, animation) {
            // Fade + slide lên hoặc xuống
            final offsetAnimation = Tween<Offset>(
              begin: const Offset(0, 0.3),
              end: Offset.zero,
            ).animate(animation);
            return FadeTransition(
              opacity: animation,
              child: SlideTransition(position: offsetAnimation, child: child),
            );
          },
          child: Text(
            isFollowing ? 'Đang theo dõi' : 'Theo dõi',
            key: ValueKey(isFollowing),
            style: Theme.of(context).textTheme.labelMedium!.copyWith(
                  color: textColor,
                  fontWeight: FontWeight.w500,
                ),
          ),
        ),
      ),
    );
  }
}
