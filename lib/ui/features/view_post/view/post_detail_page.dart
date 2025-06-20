import 'package:dishlocal/app/theme/app_icons.dart';
import 'package:dishlocal/app/theme/theme.dart';
import 'package:dishlocal/core/dependencies_injection/service_locator.dart';
import 'package:dishlocal/core/utils/number_formatter.dart';
import 'package:dishlocal/core/utils/time_formatter.dart';
import 'package:dishlocal/data/categories/post/model/post.dart';
import 'package:dishlocal/ui/features/comment/view/comment_input.dart';
import 'package:dishlocal/ui/features/comment/view/comment_section.dart';
import 'package:dishlocal/ui/features/post/view/bouncing_overlay_menu.dart';
import 'package:dishlocal/ui/features/post/view/follow_button.dart';
import 'package:dishlocal/ui/features/post_reaction_bar/bloc/post_reaction_bar_bloc.dart';
import 'package:dishlocal/ui/features/post_reaction_bar/view/reaction_bar.dart';
import 'package:dishlocal/ui/features/view_post/bloc/view_post_bloc.dart';
import 'package:dishlocal/ui/widgets/containers_widgets/glass_container.dart';
import 'package:dishlocal/ui/widgets/element_widgets/glass_sliver_app_bar.dart';
import 'package:dishlocal/ui/widgets/element_widgets/custom_icon_with_label.dart';
import 'package:dishlocal/ui/widgets/containers_widgets/glass_space.dart';
import 'package:dishlocal/ui/widgets/buttons_widgets/gradient_filled_button.dart';
import 'package:dishlocal/ui/widgets/image_widgets/blurred_edge_widget.dart';
import 'package:dishlocal/ui/widgets/image_widgets/cached_circle_avatar.dart';
import 'package:dishlocal/ui/widgets/image_widgets/cached_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:maps_launcher/maps_launcher.dart';

class PostDetailPage extends StatelessWidget {
  const PostDetailPage({super.key, required this.post});

  final Post post;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<ViewPostBloc>()..add(ViewPostEvent.started(post)),
      child: BlocBuilder<ViewPostBloc, ViewPostState>(
        builder: (context, state) {
          return switch (state) {
            Initial() => const SizedBox(),
            Loading() => const Center(
                child: CircularProgressIndicator(),
              ),
            Success() => _buildMainContent(context, state.post),
            Failure() => const Text('Có lỗi xảy ra'),
          };
        },
      ),
    );
  }

  GestureDetector _buildMainContent(BuildContext context, Post post) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        extendBody: true,
        body: SafeArea(
          child: Stack(
            children: [
              RefreshIndicator(
                onRefresh: () => Future.sync(
                  () => context.read<ViewPostBloc>().add(
                        ViewPostEvent.started(post),
                      ),
                ),
                child: CustomScrollView(
                  physics: const AlwaysScrollableScrollPhysics().applyTo(const BouncingScrollPhysics()),
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
                      actions: const [
                        BouncingOverlayMenu(),
                      ],
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
                                  BlocProvider(
                                    create: (context) => getIt<PostReactionBarBloc>(param1: post),
                                    child: BlocBuilder<PostReactionBarBloc, PostReactionBarState>(
                                      builder: (context, state) {
                                        return ReactionBar(
                                          likeColor: Colors.pink,
                                          saveColor: Colors.amber,
                                          isLiked: state.isLiked,
                                          likeCount: state.likeCount,
                                          isSaved: state.isSaved,
                                          saveCount: state.saveCount,
                                          // Khi nhấn, gửi event đến BLoC
                                          onLikeTap: () {
                                            context.read<PostReactionBarBloc>().add(const PostReactionBarEvent.likeToggled());
                                          },
                                          onSaveTap: () {
                                            context.read<PostReactionBarBloc>().add(const PostReactionBarEvent.saveToggled());
                                          },
                                        );
                                      },
                                    ),
                                  ),
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
                ),
              ),
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
}
