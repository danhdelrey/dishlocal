import 'dart:math';

import 'package:dishlocal/app/theme/theme.dart';
import 'package:dishlocal/core/utils/number_formatter.dart';
import 'package:dishlocal/data/categories/app_user/model/app_user.dart';
import 'package:dishlocal/ui/features/user_info/view/custom_rich_text.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class ListProfilePage extends StatelessWidget {
  final PagingState<dynamic, AppUser> pagingState;
  final VoidCallback onFetchNextPage;
  final Future<void> Function() onRefresh;
  final String noItemsFoundMessage;

  const ListProfilePage({
    super.key,
    required this.pagingState,
    required this.onFetchNextPage,
    required this.onRefresh,
    this.noItemsFoundMessage = "Không tìm thấy người dùng nào.",
  });

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: onRefresh,
      child: Padding(
        padding: const EdgeInsets.only(top: 15),
        child: CustomScrollView(
          physics: const AlwaysScrollableScrollPhysics().applyTo(const BouncingScrollPhysics()),
          slivers: [
            PagedSliverList<dynamic, AppUser>(
              state: pagingState,
              fetchNextPage: onFetchNextPage,
              builderDelegate: PagedChildBuilderDelegate<AppUser>(
                itemBuilder: (context, user, index) {
                  // TODO: Thay thế bằng widget hiển thị một item người dùng của bạn
                  return ListTile(
                    leading: CircleAvatar(
                      backgroundImage: user.photoUrl != null ? NetworkImage(user.photoUrl!) : null,
                      child: user.photoUrl == null ? const Icon(Icons.person) : null,
                    ),
                    title: RichText(
                      text: TextSpan(
                        style: appTextTheme(context).labelLarge?.copyWith(
                              color: appColorScheme(context).onSurface,
                            ),
                        children: [
                          TextSpan(
                            text: user.displayName ?? user.username!,
                            style: appTextTheme(context).labelLarge?.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                          TextSpan(
                            text: ' @${user.username}',
                            style: appTextTheme(context).bodyMedium?.copyWith(
                                  color: appColorScheme(context).onSurfaceVariant,
                                ),
                          ),
                        ],
                      ),
                    ),
                    subtitle: CustomRichText(
                      label1: NumberFormatter.formatCompactNumberStable(user.followerCount),
                      description1: ' người theo dõi • ',
                      label2: NumberFormatter.formatCompactNumberStable(user.followingCount),
                      description2: ' đang theo dõi',
                    ),
                    onTap: () {
                      context.push(
                        '/search_result/profile',
                        extra: {
                          'userId': user.userId,
                        },
                      );
                    },
                  );
                },
                firstPageProgressIndicatorBuilder: (_) => Column(
                  children: List.generate(8, (_) => const ShimmeringProfileListItem()),
                ),
                noItemsFoundIndicatorBuilder: (_) => Center(child: Text(noItemsFoundMessage)),
                newPageProgressIndicatorBuilder: (_) => const ShimmeringProfileListItem(),
              ),
            ),
            const SliverToBoxAdapter(
              child: SizedBox(height: kBottomNavigationBarHeight + 15),
            ),
          ],
        ),
      ),
    );
  }
}

class ShimmeringProfileListItem extends StatefulWidget {
  const ShimmeringProfileListItem({super.key});

  @override
  State<ShimmeringProfileListItem> createState() => _ShimmeringProfileListItemState();
}

class _ShimmeringProfileListItemState extends State<ShimmeringProfileListItem> with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _opacityAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    )..repeat(reverse: true);

    _opacityAnimation = Tween<double>(begin: 0.3, end: 0.8).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final placeholderColor = appColorScheme(context).outlineVariant;

    return FadeTransition(
      opacity: _opacityAnimation,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Row(
          children: [
            CircleAvatar(backgroundColor: placeholderColor),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 10.0,
                    width: 50 + (Random().nextDouble() * 100),
                    decoration: BoxDecoration(
                      color: placeholderColor,
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    height: 10.0,
                    width: 200.0,
                    decoration: BoxDecoration(
                      color: placeholderColor,
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
