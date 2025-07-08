import 'package:dishlocal/app/theme/theme.dart';
import 'package:dishlocal/core/dependencies_injection/service_locator.dart';
import 'package:dishlocal/data/categories/app_user/model/app_user.dart';
import 'package:dishlocal/data/categories/post/model/post.dart';
import 'package:dishlocal/ui/features/post/view/grid_post_page.dart';
import 'package:dishlocal/ui/features/post/view/small_post.dart';
import 'package:dishlocal/ui/features/result_search/bloc/result_search_bloc.dart';
import 'package:dishlocal/ui/widgets/element_widgets/glass_sliver_app_bar.dart';
import 'package:dishlocal/ui/widgets/guard_widgets/connectivity_and_location_guard.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class SearchResultScreen extends StatelessWidget {
  final String query;
  const SearchResultScreen({super.key, required this.query});

  @override
  Widget build(BuildContext context) {
    // Cung cấp một ResultSearchBloc duy nhất cho toàn bộ màn hình
    return BlocProvider(
      create: (context) => getIt<ResultSearchBloc>()
        // Ngay khi BLoC được tạo, bắt đầu tìm kiếm với query được truyền vào
        ..add(ResultSearchEvent.searchStarted(query: query)),
      child:  ConnectivityAndLocationGuard(
        builder: (context) {
          return const _SearchResultContent();
        },
      ),
    );
  }
}

// Widget nội dung chính, chứa state và logic UI
class _SearchResultContent extends StatefulWidget {
  const _SearchResultContent();

  @override
  State<_SearchResultContent> createState() => __SearchResultContentState();
}

class __SearchResultContentState extends State<_SearchResultContent> with SingleTickerProviderStateMixin {
  late final TabController _tabController;
  final _postScrollController = ScrollController();
  final _profileScrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(_handleTabSelection);
    _postScrollController.addListener(_onPostScroll);
    _profileScrollController.addListener(_onProfileScroll);
  }

  void _handleTabSelection() {
    if (!_tabController.indexIsChanging) {
      final searchType = _tabController.index == 0 ? SearchType.posts : SearchType.profiles;
      context.read<ResultSearchBloc>().add(ResultSearchEvent.searchTypeChanged(searchType: searchType));
    }
  }

  void _onPostScroll() {
    if (_isBottom(_postScrollController)) {
      context.read<ResultSearchBloc>().add(const ResultSearchEvent.nextPageRequested());
    }
  }

  void _onProfileScroll() {
    if (_isBottom(_profileScrollController)) {
      context.read<ResultSearchBloc>().add(const ResultSearchEvent.nextPageRequested());
    }
  }

  bool _isBottom(ScrollController controller) {
    if (!controller.hasClients) return false;
    final maxScroll = controller.position.maxScrollExtent;
    final currentScroll = controller.offset;
    return currentScroll >= (maxScroll - 300.0);
  }

  @override
  void dispose() {
    _tabController.removeListener(_handleTabSelection);
    _tabController.dispose();
    _postScrollController.dispose();
    _profileScrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final query = context.select((ResultSearchBloc bloc) => bloc.state.query);

    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return <Widget>[
            GlassSliverAppBar(
              titleSpacing: 0,
              title: Row(
                children: [
                  IconButton(
                    icon: const Icon(CupertinoIcons.back),
                    onPressed: () => context.pop(),
                  ),
                  Expanded(
                    child: Text(
                      'Kết quả cho "$query"',
                      style: appTextTheme(context).titleMedium,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
              pinned: true,
              floating: true,
              snap: true,
              bottom: TabBar(
                dividerColor: Colors.white.withAlpha(25),
                controller: _tabController,
                tabs: const [
                  Tab(text: 'Bài viết'),
                  Tab(text: 'Người dùng'),
                ],
              ),
            ),
          ];
        },
        body: BlocBuilder<ResultSearchBloc, ResultSearchState>(
          builder: (context, state) {
            if (state.status == SearchStatus.loading && state.results.isEmpty) {
              return const Center(child: CircularProgressIndicator());
            }
            if (state.status == SearchStatus.empty) {
              return Center(child: Text('Không tìm thấy kết quả nào cho "${state.query}".'));
            }
            if (state.status == SearchStatus.failure) {
              return Center(child: Text('Đã xảy ra lỗi: ${state.failure}'));
            }

            return TabBarView(
              controller: _tabController,
              children: [
                _buildPostResults(state),
                _buildProfileResults(state),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildPostResults(ResultSearchState state) {
    if (state.searchType != SearchType.posts) {
      return const Center(child: CircularProgressIndicator());
    }

    final posts = state.results.whereType<Post>().toList();

    return GridView.builder(
      controller: _postScrollController,
      key: const PageStorageKey('search_posts_grid'),
      padding: const EdgeInsets.all(10),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
        childAspectRatio: 0.75,
      ),
      itemCount: state.hasNextPage ? posts.length + 1 : posts.length,
      itemBuilder: (context, index) {
        if (index >= posts.length) {
          return const Center(child: CircularProgressIndicator());
        }
        return SmallPost(post: posts[index], onDeletePostPopBack: () {});
      },
    );
  }

  Widget _buildProfileResults(ResultSearchState state) {
    if (state.searchType != SearchType.profiles) {
      return const Center(child: CircularProgressIndicator());
    }

    final profiles = state.results.whereType<AppUser>().toList();

    return ListView.builder(
      controller: _profileScrollController,
      key: const PageStorageKey('search_profiles_list'),
      itemCount: state.hasNextPage ? profiles.length + 1 : profiles.length,
      itemBuilder: (context, index) {
        if (index >= profiles.length) {
          return const Center(child: Padding(padding: EdgeInsets.all(16.0), child: CircularProgressIndicator()));
        }
        final profile = profiles[index];
        // Thay thế ListTile bằng widget ProfileTile của bạn để đẹp hơn
        return ListTile(
          leading: CircleAvatar(
            backgroundImage: profile.photoUrl != null ? NetworkImage(profile.photoUrl!) : null,
            child: profile.photoUrl == null ? const Icon(Icons.person) : null,
          ),
          title: Text(profile.displayName ?? 'Người dùng'),
          subtitle: Text('@${profile.username}'),
          onTap: () {
            // Điều hướng đến trang profile của người dùng này
            context.push('/profile/${profile.userId}');
          },
        );
      },
    );
  }
}
