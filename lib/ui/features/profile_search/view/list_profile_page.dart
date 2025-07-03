import 'package:dishlocal/data/categories/app_user/model/app_user.dart';
import 'package:flutter/material.dart';
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
                    title: Text(user.displayName ?? user.username!),
                    subtitle: Text('@${user.username}'),
                    onTap: () {
                      // TODO: Điều hướng đến trang cá nhân
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

// Widget shimmer cho một item profile
class ShimmeringProfileListItem extends StatelessWidget {
  const ShimmeringProfileListItem({super.key});

  @override
  Widget build(BuildContext context) {
    // Tương tự ShimmeringSmallPost, nhưng dùng cho ListTile
    return const ListTile(
      leading: CircleAvatar(backgroundColor: Colors.grey),
      title: SizedBox(
        height: 16.0,
        child: DecoratedBox(decoration: BoxDecoration(color: Colors.grey)),
      ),
      subtitle: SizedBox(
        height: 12.0,
        child: DecoratedBox(decoration: BoxDecoration(color: Colors.grey)),
      ),
    );
  }
}
