import 'package:dishlocal/app/theme/app_icons.dart';
import 'package:dishlocal/app/theme/theme.dart';
import 'package:dishlocal/core/dependencies_injection/service_locator.dart';
import 'package:dishlocal/core/utils/number_formatter.dart';
import 'package:dishlocal/core/utils/time_formatter.dart';
import 'package:dishlocal/data/categories/app_user/model/app_user.dart';
import 'package:dishlocal/data/categories/post/model/post.dart';
import 'package:dishlocal/ui/features/comment/view/comment_input.dart';
import 'package:dishlocal/ui/features/comment/view/comment_section.dart';
import 'package:dishlocal/ui/features/post/view/bouncing_overlay_menu.dart';
import 'package:dishlocal/ui/features/follow/view/follow_button.dart';
import 'package:dishlocal/ui/features/post_reaction_bar/bloc/post_reaction_bar_bloc.dart';
import 'package:dishlocal/ui/features/post_reaction_bar/view/reaction_bar.dart';
import 'package:dishlocal/ui/features/view_post/bloc/view_post_bloc.dart';
import 'package:dishlocal/ui/widgets/animated_widgets/fade_slide_up.dart';
import 'package:dishlocal/ui/widgets/containers_widgets/glass_container.dart';
import 'package:dishlocal/ui/widgets/element_widgets/custom_loading_indicator.dart';
import 'package:dishlocal/ui/widgets/element_widgets/glass_sliver_app_bar.dart';
import 'package:dishlocal/ui/widgets/element_widgets/custom_icon_with_label.dart';
import 'package:dishlocal/ui/widgets/containers_widgets/glass_space.dart';
import 'package:dishlocal/ui/widgets/buttons_widgets/gradient_filled_button.dart';
import 'package:dishlocal/ui/widgets/image_widgets/blurred_edge_widget.dart';
import 'package:dishlocal/ui/widgets/image_widgets/cached_circle_avatar.dart';
import 'package:dishlocal/ui/widgets/image_widgets/cached_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:maps_launcher/maps_launcher.dart';

class PostDetailPage extends StatefulWidget {
  const PostDetailPage({super.key, required this.post});

  final Post post;

  @override
  State<PostDetailPage> createState() => _PostDetailPageState();
}

class _PostDetailPageState extends State<PostDetailPage> {
  late final BouncingOverlayMenuController _menuController;

  @override
  void initState() {
    super.initState();
    _menuController = BouncingOverlayMenuController();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<ViewPostBloc>()..add(ViewPostEvent.started(widget.post)),
      child: Builder(builder: (context) {
        return GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
            _menuController.hideIfVisible();
          },
          child: Scaffold(
            extendBody: true,
            body: SafeArea(
              child: Stack(
                children: [
                  RefreshIndicator(
                    onRefresh: () => Future.sync(
                      () => context.read<ViewPostBloc>().add(
                            ViewPostEvent.started(widget.post),
                          ),
                    ),
                    child: NotificationListener<ScrollStartNotification>(
                      onNotification: (notification) {
                        _menuController.hideIfVisible(); // 👈 Ẩn ngay khi bắt đầu chạm kéo
                        return false; // không chặn event
                      },
                      child: CustomScrollView(
                        physics: const AlwaysScrollableScrollPhysics().applyTo(const BouncingScrollPhysics()),
                        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
                        slivers: [
                          BlocBuilder<ViewPostBloc, ViewPostState>(
                            builder: (context, state) {
                              if (state is Success) {
                                return GlassSliverAppBar(
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
                                  actions: [
                                    BouncingOverlayMenu(
                                      controller: _menuController,
                                      menuItems: [
                                        if (state.currentUserId == widget.post.authorUserId)
                                          MenuActionItem(
                                            icon: Icons.edit,
                                            label: 'Chỉnh sửa bài viết',
                                            onTap: () async {
                                              final result = await context.push('/edit_post', extra: widget.post);
                                              if (result == true) {
                                                if (!context.mounted) {
                                                  return;
                                                }
                                                context.pop();
                                              }
                                            },
                                          ),
                                        if (state.currentUserId == widget.post.authorUserId)
                                          MenuActionItem(
                                            icon: Icons.delete,
                                            label: 'Xóa bài viết',
                                            onTap: () {},
                                          ),
                                        if (state.currentUserId != widget.post.authorUserId)
                                          MenuActionItem(
                                            icon: Icons.report,
                                            label: 'Báo cáo bài viết',
                                            onTap: () {},
                                          ),
                                        MenuActionItem(
                                          icon: Icons.link,
                                          label: 'Sao chép liên kết',
                                          onTap: () {},
                                        ),
                                      ],
                                    )
                                  ],
                                  title: FadeSlideUp(child: Text(state.post.dishName ?? '')),
                                );
                              }
                              return GlassSliverAppBar(
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
                              );
                            },
                          ),
                          SliverToBoxAdapter(
                            child: Padding(
                              padding: const EdgeInsets.only(left: 15, right: 15, top: 10, bottom: 150),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  BlurredEdgeWidget(
                                    blurredChild: CachedImage(blurHash: widget.post.blurHash ?? '', imageUrl: widget.post.imageUrl ?? ''),
                                    clearRadius: 1,
                                    blurSigma: 100,
                                    topChild: CachedImage(blurHash: widget.post.blurHash ?? '', imageUrl: widget.post.imageUrl ?? ''),
                                  ),
                                  BlocBuilder<ViewPostBloc, ViewPostState>(
                                    builder: (context, state) {
                                      return switch (state) {
                                        Loading() => const Center(child: CustomLoadingIndicator(indicatorSize: 40)),
                                        Success() => _buildMainContent(context, state.post, state.currentUserId, state.author),
                                        Failure() => const Center(child: Text('Có lỗi xảy ra')),
                                      };
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
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
      }),
    );
  }

  Column _buildMainContent(BuildContext context, Post post, String currentUserId, AppUser author) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 10,
        ),
        FadeSlideUp(
          child: CustomIconWithLabel(
            icon: AppIcons.location1.toSvg(
              width: 16,
              color: Theme.of(context).colorScheme.onSurface,
            ),
            label: 'Khoảng cách: ${NumberFormatter.formatDistance(post.distance)}',
          ),
        ),
        FadeSlideUp(
          delay: const Duration(milliseconds: 100),
          child: Text(
            post.diningLocationName ?? '',
            style: Theme.of(context).textTheme.labelLarge,
          ),
        ),
        FadeSlideUp(
          delay: const Duration(milliseconds: 200),
          child: Text(
            '${post.address?.exactAddress ?? ''}, ${post.address?.displayName ?? ''}',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        FadeSlideUp(
          delay: const Duration(milliseconds: 300),
          child: CustomIconWithLabel(
            icon: AppIcons.wallet4.toSvg(
              width: 16,
              color: Theme.of(context).colorScheme.onSurface,
            ),
            label: 'Giá: ${NumberFormatter.formatMoney(post.price ?? 0)}',
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        FadeSlideUp(
          delay: const Duration(milliseconds: 400),
          child: GradientFilledButton(
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
        ),
        const SizedBox(
          height: 20,
        ),
        FadeSlideUp(
          delay: const Duration(milliseconds: 500),
          child: _buildAuthorInfo(post, context, currentUserId, author),
        ),
        if (post.insight != null)
          FadeSlideUp(
            delay: const Duration(milliseconds: 600),
            child: Padding(
              padding: const EdgeInsets.only(top: 15),
              child: Text(
                post.insight!,
                style: appTextTheme(context).bodyMedium,
              ),
            ),
          ),
        BlocProvider(
          create: (context) => getIt<PostReactionBarBloc>(param1: post),
          child: BlocBuilder<PostReactionBarBloc, PostReactionBarState>(
            builder: (context, state) {
              return FadeSlideUp(
                delay: const Duration(milliseconds: 700),
                child: Padding(
                  padding: const EdgeInsets.only(top: 15),
                  child: ReactionBar(
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
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildAuthorInfo(Post post, BuildContext context, String currentUserId, AppUser author) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () {
        context.push('/post_detail/profile', extra: {'userId': author.userId});
      },
      child: Row(
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
                RichText(
                  text: TextSpan(
                    style: Theme.of(context).textTheme.labelLarge,
                    children: [
                      const TextSpan(text: 'danhdelrey'),
                      if (post.authorUserId != currentUserId && author.isFollowing == true)
                        TextSpan(
                          text: ' • Đang theo dõi',
                          style: Theme.of(context).textTheme.labelLarge?.copyWith(
                                color: appColorScheme(context).outline,
                                fontStyle: FontStyle.italic,
                              ),
                        ),
                    ],
                  ),
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
        ],
      ),
    );
  }
}
