import 'package:dishlocal/app/theme/app_icons.dart';
import 'package:dishlocal/app/theme/theme.dart';
import 'package:dishlocal/core/dependencies_injection/service_locator.dart';
import 'package:dishlocal/core/utils/duration_formatter.dart';
import 'package:dishlocal/core/utils/number_formatter.dart';
import 'package:dishlocal/core/utils/time_formatter.dart';
import 'package:dishlocal/data/categories/app_user/model/app_user.dart';
import 'package:dishlocal/data/categories/direction/model/location_data.dart';
import 'package:dishlocal/data/categories/post/model/filter_sort_model/distance_range.dart';
import 'package:dishlocal/data/categories/post/model/filter_sort_model/filter_sort_params.dart';
import 'package:dishlocal/data/categories/post/model/filter_sort_model/price_range.dart';
import 'package:dishlocal/data/categories/post/model/filter_sort_model/sort_option.dart';
import 'package:dishlocal/data/categories/post/model/post.dart';
import 'package:dishlocal/ui/features/comment/view/comment_bottom_sheet.dart';
import 'package:dishlocal/ui/features/delete_post/bloc/delete_post_bloc.dart';
import 'package:dishlocal/ui/features/dish_description/view/dish_description_widget.dart';
import 'package:dishlocal/ui/features/post/view/bouncing_overlay_menu.dart';
import 'package:dishlocal/ui/features/post_reaction_bar/bloc/post_reaction_bar_bloc.dart';
import 'package:dishlocal/ui/features/post_reaction_bar/view/reaction_bar.dart';
import 'package:dishlocal/ui/features/share_post/view/share_button.dart';
import 'package:dishlocal/ui/features/view_post/bloc/view_post_bloc.dart';
import 'package:dishlocal/ui/widgets/animated_widgets/fade_slide_up.dart';
import 'package:dishlocal/ui/widgets/element_widgets/custom_loading_indicator.dart';
import 'package:dishlocal/ui/widgets/element_widgets/glass_sliver_app_bar.dart';
import 'package:dishlocal/ui/widgets/element_widgets/custom_icon_with_label.dart';
import 'package:dishlocal/ui/widgets/buttons_widgets/gradient_filled_button.dart';
import 'package:dishlocal/ui/widgets/image_widgets/blurred_edge_widget.dart';
import 'package:dishlocal/ui/widgets/image_widgets/cached_circle_avatar.dart';
import 'package:dishlocal/ui/widgets/image_widgets/cached_image.dart';
import 'package:dishlocal/ui/widgets/input_widgets/custom_choice_chip.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:maps_launcher/maps_launcher.dart';

class PostDetailPage extends StatelessWidget {
  const PostDetailPage({super.key, required this.post});

  final Post post;

  @override
  Widget build(BuildContext context) {
    // Cung cấp các BLoC cần thiết ở đây
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          // Logic tạo BLoC và add event `started` được đặt ở đây.
          create: (context) => getIt<ViewPostBloc>()..add(ViewPostEvent.started(post)),
        ),
        BlocProvider(
          create: (context) => getIt<DeletePostBloc>(),
        ),
      ],
      // Widget con _PostDetailView sẽ có quyền truy cập vào các BLoC này
      child: _PostDetailView(post: post),
    );
  }
}

class _PostDetailView extends StatefulWidget {
  const _PostDetailView({required this.post});
  final Post post;

  @override
  State<_PostDetailView> createState() => _PostDetailViewState();
}

class _PostDetailViewState extends State<_PostDetailView> {
  late final BouncingOverlayMenuController _menuController;
  // Khai báo biến để lưu BLoC
  late final ViewPostBloc _viewPostBloc;

  @override
  void initState() {
    super.initState();
    _menuController = BouncingOverlayMenuController();

    // Bây giờ, vì _PostDetailView nằm dưới BlocProvider,
    // context ở đây có thể tìm thấy ViewPostBloc một cách an toàn.
    _viewPostBloc = context.read<ViewPostBloc>();
  }

  @override
  void dispose() {
    // Sử dụng biến đã lưu trong dispose, hoàn toàn an toàn.
    _viewPostBloc.add(ViewPostEvent.pageExited(postId: widget.post.postId));
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      return GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
          _menuController.hideIfVisible();
        },
        child: LoaderOverlay(
          overlayWidgetBuilder: (progress) => const Center(
            child: CustomLoadingIndicator(
              indicatorSize: 40,
              indicatorText: 'Đang xóa bài viết...',
            ),
          ),
          child: BlocListener<DeletePostBloc, DeletePostState>(
            listener: (context, state) {
              if (state is DeletePostSuccess) {
                context.loaderOverlay.hide();
                ScaffoldMessenger.of(context)
                  ..hideCurrentSnackBar()
                  ..showSnackBar(
                    const SnackBar(
                      content: Text(
                        'Xóa bài viết thành công!',
                      ),
                      behavior: SnackBarBehavior.floating,
                    ),
                  );
                context.pop(true);
              }

              if (state is DeletePostLoading) {
                context.loaderOverlay.show();
              }

              if (state is DeletePostFailure) {
                context.loaderOverlay.hide();
                ScaffoldMessenger.of(context)
                  ..hideCurrentSnackBar()
                  ..showSnackBar(
                    const SnackBar(
                      content: Text(
                        'Đã có lỗi xảy ra khi xóa bài viết.',
                      ),
                      behavior: SnackBarBehavior.floating,
                    ),
                  );
              }
            },
            child: Scaffold(
              body: Stack(
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
                        physics: const AlwaysScrollableScrollPhysics(),
                        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
                        slivers: [
                          BlocBuilder<ViewPostBloc, ViewPostState>(
                            builder: (context, state) {
                              if (state is ViewPostSuccess) {
                                return SliverAppBar(
                                  centerTitle: true,
                                  backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                                  surfaceTintColor: Colors.transparent,
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
                                    if (state.currentUserId == widget.post.authorUserId)
                                      BouncingOverlayMenu(
                                        controller: _menuController,
                                        menuItems: [
                                          if (state.currentUserId == widget.post.authorUserId)
                                            MenuActionItem(
                                              icon: Icons.edit,
                                              label: 'Chỉnh sửa bài viết',
                                              onTap: () async {
                                                final result = await context.push('/edit_post', extra: state.post);
                                                if (result == true) {
                                                  if (!context.mounted) {
                                                    return;
                                                  }
                                                  context.read<ViewPostBloc>().add(
                                                        ViewPostEvent.started(state.post),
                                                      );
                                                }
                                              },
                                            ),
                                          if (state.currentUserId == widget.post.authorUserId)
                                            MenuActionItem(
                                              icon: Icons.delete,
                                              label: 'Xóa bài viết',
                                              onTap: () async {
                                                final bool? confirmed = await _showDeleteConfirmationDialog(context);

                                                if (confirmed == true) {
                                                  if (context.mounted) {
                                                    context.read<DeletePostBloc>().add(
                                                          DeletePostEvent.deletePostRequested(post: widget.post),
                                                        );
                                                  }
                                                }
                                              },
                                            ),
                                          // if (state.currentUserId != widget.post.authorUserId)
                                          //   MenuActionItem(
                                          //     icon: Icons.report,
                                          //     label: 'Báo cáo bài viết',
                                          //     onTap: () {},
                                          //   ),
                                          // MenuActionItem(
                                          //   icon: Icons.link,
                                          //   label: 'Sao chép liên kết',
                                          //   onTap: () {},
                                          // ),
                                        ],
                                      )
                                  ],
                                  // title: FadeSlideUp(child: Text(state.post.dishName ?? '')),
                                  // titleTextStyle: appTextTheme(context).titleMedium,
                                );
                              }
                              return SliverAppBar(
                                backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                                surfaceTintColor: Colors.transparent,
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
                              padding: const EdgeInsets.only(top: 10, bottom: 30),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 15),
                                    child: CachedImage(borderRadius: 30, blurHash: widget.post.blurHash ?? '', imageUrl: widget.post.imageUrl ?? ''),
                                  ),
                                  BlocBuilder<ViewPostBloc, ViewPostState>(
                                    builder: (context, state) {
                                      return switch (state) {
                                        ViewPostLoading() => const Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              SizedBox(
                                                height: 50,
                                              ),
                                              Center(
                                                  child: CustomLoadingIndicator(
                                                indicatorSize: 40,
                                                indicatorText: 'Đang tải nội dung bài viết...',
                                              )),
                                            ],
                                          ),
                                        ViewPostSuccess() => Padding(
                                            padding: const EdgeInsets.symmetric(horizontal: 15),
                                            child: _buildMainContent(context, state.post, state.currentUserId, state.author),
                                          ),
                                        ViewPostFailure() => const Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              SizedBox(
                                                height: 50,
                                              ),
                                              Center(child: Text('Có lỗi xảy ra khi tải bài viết!')),
                                            ],
                                          ),
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
        ),
      );
    });
  }

  //TODO: Làm cho nó glassy giống cái menu trong bài viết
  // Đặt hàm này bên trong class Widget của bạn, hoặc ở ngoài nếu bạn muốn
  Future<bool?> _showDeleteConfirmationDialog(BuildContext context) {
    return showDialog<bool>(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: const Text('Xác nhận xóa'),
          content: const Text('Bạn có chắc chắn muốn xóa bài viết này không? Hành động này không thể hoàn tác.'),
          actions: <Widget>[
            // Nút "Hủy"
            TextButton(
              child: const Text('Hủy'),
              onPressed: () {
                // Đóng dialog và trả về `false`
                Navigator.of(dialogContext).pop(false);
              },
            ),
            // Nút "Xóa"
            TextButton(
              style: TextButton.styleFrom(
                foregroundColor: Colors.red, // Làm cho nút xóa nổi bật
              ),
              child: const Text('Xóa'),
              onPressed: () {
                // Đóng dialog và trả về `true`
                Navigator.of(dialogContext).pop(true);
              },
            ),
          ],
        );
      },
    );
  }

  Column _buildMainContent(BuildContext context, Post post, String currentUserId, AppUser author) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 20,
        ),
        FadeSlideUp(
          child: DishDescriptionWidget(dishName: post.dishName!, imageUrl: post.imageUrl!),
        ),
        const SizedBox(
          height: 20,
        ),
        FadeSlideUp(
          child: Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              if (post.foodCategory != null)
                CustomChoiceChip(
                  label: post.foodCategory!.label,
                  isSelected: false,
                  itemColor: post.foodCategory?.color ?? Colors.transparent,
                  onSelected: (selected) {
                    context.push('/post_detail/explore', extra: {
                      'filterSortParams': FilterSortParams.defaultParamsForContext(FilterContext.explore).copyWith(
                        categories: {post.foodCategory!},
                      )
                    });
                  },
                ),
              CustomChoiceChip(
                label: '💵 ${NumberFormatter.formatMoney(post.price ?? 0)}',
                isSelected: false,
                itemColor: post.foodCategory?.color ?? Colors.transparent,
                onSelected: (selected) {
                  context.push('/post_detail/explore', extra: {
                    'filterSortParams': FilterSortParams.defaultParamsForContext(FilterContext.explore).copyWith(
                      range: PriceRange.fromPrice(post.price?.toDouble() ?? 9999999),
                    )
                  });
                },
              ),
              if (post.distance != null)
                CustomChoiceChip(
                  label: '📍 ${NumberFormatter.formatDistance(post.distance)} - ${DurationFormatter.formatEstimatedTime(post.distance!)}',
                  isSelected: false,
                  itemColor: post.foodCategory?.color ?? Colors.transparent,
                  onSelected: (selected) {
                    context.push('/post_detail/explore', extra: {
                      'filterSortParams': FilterSortParams.defaultParamsForContext(FilterContext.explore).copyWith(
                        distance: DistanceRange.fromDistance(post.distance ?? 999),
                      )
                    });
                  },
                ),
            ],
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        if (post.diningLocationName != null && post.diningLocationName!.trim().isNotEmpty)
          FadeSlideUp(
            delay: const Duration(milliseconds: 200),
            child: Padding(
              padding: const EdgeInsets.only(bottom: 5),
              child: Text(
                '📍 ${post.diningLocationName}',
                style: Theme.of(context).textTheme.labelLarge?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
              ),
            ),
          ),
        FadeSlideUp(
          delay: const Duration(milliseconds: 200),
          child: RichText(
            text: TextSpan(
              style: Theme.of(context).textTheme.bodyMedium,
              children: [
                if (post.address?.exactAddress != null && post.address!.exactAddress!.isNotEmpty)
                  TextSpan(
                    text: '(${post.address!.exactAddress!}) ',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontStyle: FontStyle.italic,
                        ),
                  ),
                if (post.address?.displayName != null && post.address!.displayName!.isNotEmpty) TextSpan(text: post.address!.displayName!),
              ],
            ),
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        FadeSlideUp(
          delay: const Duration(milliseconds: 300),
          child: Material(
            child: GradientFilledButton(
              maxWidth: true,
              icon: AppIcons.location.toSvg(
                width: 16,
                color: Colors.white,
              ),
              color1: post.foodCategory?.color,
              color2: post.foodCategory?.color.withValues(alpha: 0.8),
              label: 'Xem trên bản đồ',
              onTap: () {
                if (post.address != null) {
                  context.push(
                    '/map',
                    extra: {
                      'destination': LocationData(latitude: post.address!.latitude, longitude: post.address!.longitude),
                      'destinationName': post.diningLocationName,
                    },
                  );
                }
              },
            ),
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        FadeSlideUp(
          delay: const Duration(milliseconds: 400),
          child: _buildAuthorInfo(post, context, currentUserId, author),
        ),
        if (post.insight != null && post.insight!.trim().isNotEmpty)
          FadeSlideUp(
            delay: const Duration(milliseconds: 500),
            child: Padding(
              padding: const EdgeInsets.only(top: 15),
              child: Text(
                post.insight!,
                style: appTextTheme(context).bodyMedium,
              ),
            ),
          ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 15),
            ...post.reviews.asMap().entries.map((entry) {
              int index = entry.key;
              var review = entry.value;
              return FadeSlideUp(
                delay: Duration(milliseconds: 700 + (index * 100)),
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            review.category.label,
                            style: appTextTheme(context).labelLarge?.copyWith(
                                  color: appColorScheme(context).onSurface,
                                  fontWeight: FontWeight.w600,
                                ),
                          ),
                          const SizedBox(width: 10),
                          Row(
                            children: List.generate(5, (index) {
                              return Icon(
                                index < review.rating ? CupertinoIcons.star_fill : CupertinoIcons.star,
                                color: Colors.amber,
                                size: 16,
                              );
                            }),
                          ),
                        ],
                      ),
                      if (review.selectedChoices.isNotEmpty) ...[
                        Text(
                          review.selectedChoices.map((choice) => choice.label).join(', '),
                          style: appTextTheme(context).bodyMedium?.copyWith(
                                color: appColorScheme(context).outline,
                              ),
                        ),
                      ],
                    ],
                  ),
                ),
              );
            }),
            const SizedBox(height: 10),
          ],
        ),
        Row(
          children: [
            BlocProvider(
              create: (context) => getIt<PostReactionBarBloc>(param1: post),
              child: BlocBuilder<PostReactionBarBloc, PostReactionBarState>(
                builder: (context, state) {
                  return FadeSlideUp(
                    delay: Duration(milliseconds: 800 + (post.reviews.length * 100)),
                    child: ReactionBar(
                      likeColor: Colors.pink,
                      saveColor: Colors.amber,
                      isLiked: state.isLiked,
                      likeCount: state.likeCount,
                      commentCount: post.commentCount,
                      onCommentTap: () {
                        showCommentBottomSheet(context, postId: post.postId, postAuthorId: post.authorUserId, totalCommentCount: post.commentCount);
                      },
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
                  );
                },
              ),
            ),
            const Spacer(),
            FadeSlideUp(
              delay: Duration(milliseconds: 800 + (post.reviews.length * 100)),
              child: ShareButton(postId: post.postId),
            ),
          ],
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
                      TextSpan(text: post.authorUsername),
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
                    color: CupertinoColors.activeGreen,
                    width: 14,
                  ),
                  labelStyle: appTextTheme(context).labelMedium!.copyWith(
                        color: CupertinoColors.activeGreen,
                      ),
                  label: TimeFormatter.formatDateTimeFull(post.createdAt),
                  labelColor: CupertinoColors.activeGreen,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
