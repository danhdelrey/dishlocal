import 'package:dishlocal/app/theme/theme.dart';
import 'package:dishlocal/core/dependencies_injection/service_locator.dart';
import 'package:dishlocal/data/categories/app_user/model/app_user.dart';
import 'package:dishlocal/data/categories/post/model/post.dart';
import 'package:dishlocal/ui/features/filter_sort/view/filters_wrap.dart';
import 'package:dishlocal/ui/features/post/view/shimmering_small_post.dart';
import 'package:dishlocal/ui/features/post/view/small_post.dart';
import 'package:dishlocal/ui/features/result_search/bloc/result_search_bloc.dart';
import 'package:dishlocal/ui/widgets/guard_widgets/connectivity_and_location_guard.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

// Widget này chỉ chịu trách nhiệm nhận 'query' và khởi tạo nội dung chính.
class SearchResultScreen extends StatelessWidget {
  final String query;
  const SearchResultScreen({super.key, required this.query});

  @override
  Widget build(BuildContext context) {
    return ConnectivityAndLocationGuard(
      builder: (context) {
        // Truyền query vào widget nội dung Stateful.
        return _SearchResultContent(query: query);
      },
    );
  }
}

// Widget nội dung chính, chứa state và logic UI.
class _SearchResultContent extends StatefulWidget {
  final String query;
  const _SearchResultContent({required this.query});

  @override
  State<_SearchResultContent> createState() => __SearchResultContentState();
}

// State này quản lý TabController và hai instance BLoC riêng biệt.
class __SearchResultContentState extends State<_SearchResultContent> with SingleTickerProviderStateMixin {
  late final TabController _tabController;
  late final ResultSearchBloc _postsSearchBloc;
  late final ResultSearchBloc _profilesSearchBloc;

  // GlobalKeys để truy cập vào scroll controllers của các tab
  final GlobalKey<_PostResultsViewState> _postsKey = GlobalKey<_PostResultsViewState>();
  final GlobalKey<_ProfileResultsViewState> _profilesKey = GlobalKey<_ProfileResultsViewState>();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);

    // 1. Khởi tạo BLoC cho tab "Bài viết".
    // BLoC mặc định searchType là 'posts', nên ta chỉ cần gửi sự kiện _SearchStarted.
    _postsSearchBloc = getIt<ResultSearchBloc>()..add(ResultSearchEvent.searchStarted(query: widget.query));

    // 2. Khởi tạo BLoC cho tab "Người dùng".
    // Dựa vào BLoC bạn cung cấp, chúng ta cần thay đổi searchType.
    // Sự kiện _SearchTypeChanged sẽ reset state và bắt đầu một tìm kiếm mới với type đúng.
    _profilesSearchBloc = getIt<ResultSearchBloc>()
      // Gửi sự kiện _SearchStarted trước để set query cho BLoC.
      ..add(ResultSearchEvent.searchStarted(query: widget.query))
      // Sau đó, gửi _SearchTypeChanged để reset và tìm kiếm lại với đúng 'profiles' type.
      // Đây là cách sử dụng đúng với BLoC đã được cung cấp.
      ..add(const ResultSearchEvent.searchTypeChanged(searchType: SearchType.profiles));
  }

  @override
  void dispose() {
    _tabController.dispose();
    // Quan trọng: Đóng cả hai BLoC khi widget bị hủy để tránh memory leak.
    _postsSearchBloc.close();
    _profilesSearchBloc.close();
    super.dispose();
  }

  void _onTabTapped(int index) {
    if (_tabController.index == index) {
      // Nếu nhấn vào tab hiện tại, scroll to top
      if (index == 0) {
        _postsKey.currentState?.scrollToTop();
      } else if (index == 1) {
        _profilesKey.currentState?.scrollToTop();
      }
    } else {
      // Nếu nhấn vào tab khác, chuyển tab bình thường
      _tabController.animateTo(index);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        leading: IconButton(
          icon: const Icon(CupertinoIcons.back),
          onPressed: () => context.pop(),
        ),
        title: Text(
          'Kết quả cho "${widget.query}"',
          style: appTextTheme(context).titleMedium,
        ),
        bottom: TabBar(
          dividerColor: Colors.white.withValues(alpha: 0.1),
          controller: _tabController,
          onTap: _onTabTapped,
          tabs: const [
            Tab(text: 'Bài viết'),
            Tab(text: 'Người dùng'),
          ],
        ),
      ),
      // TabBarView sẽ cung cấp BLoC tương ứng cho mỗi tab con.
      body: TabBarView(
        controller: _tabController,
        children: [
          // Cung cấp instance BLoC của bài viết cho view tương ứng.
          BlocProvider.value(
            value: _postsSearchBloc,
            // PageStorageKey giúp giữ trạng thái cuộn khi chuyển tab.
            child: _PostResultsView(
              key: _postsKey,
              query: widget.query,
            ),
          ),
          // Cung cấp instance BLoC của người dùng cho view tương ứng.
          BlocProvider.value(
            value: _profilesSearchBloc,
            child: _ProfileResultsView(key: _profilesKey),
          ),
        ],
      ),
    );
  }
}

// Widget hiển thị kết quả bài viết, giờ chỉ cần lắng nghe BLoC được cung cấp.
class _PostResultsView extends StatefulWidget {
  const _PostResultsView({super.key, required this.query});
  final String query;

  @override
  State<_PostResultsView> createState() => _PostResultsViewState();
}

class _PostResultsViewState extends State<_PostResultsView> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_isBottom) {
      context.read<ResultSearchBloc>().add(const ResultSearchEvent.nextPageRequested());
    }
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll - 300.0);
  }

  // Phương thức public để scroll to top
  void scrollToTop() {
    if (_scrollController.hasClients) {
      _scrollController.animateTo(
        0,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        BlocBuilder<ResultSearchBloc, ResultSearchState>(
          builder: (context, state) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 15),
              child: FiltersWrap(
                filterParams: state.filterParams,
                resultSearchBloc: context.read<ResultSearchBloc>(),
              ),
            );
          },
        ),
        Expanded(
          child: BlocBuilder<ResultSearchBloc, ResultSearchState>(
            builder: (context, state) {
              // Các trường hợp loading, empty, failure
              if (state.status == SearchStatus.loading && state.results.isEmpty) {
                return GridView.builder(
                  key: const PageStorageKey<String>('shimmer_grid'),
                  padding: const EdgeInsets.all(10.0),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10,
                    childAspectRatio: 0.75,
                  ),
                  itemCount: 8,
                  itemBuilder: (context, index) => const ShimmeringSmallPost(),
                );
              }
              if (state.status == SearchStatus.empty) {
                return Center(child: Text('Không tìm thấy bài viết nào cho "${state.query}".'));
              }
              if (state.status == SearchStatus.failure) {
                return Center(child: Text('Đã xảy ra lỗi: ${state.failure}'));
              }

              final posts = state.results.whereType<Post>().toList();

              // Hiển thị GridView với dữ liệu
              return GridView.builder(
                controller: _scrollController,
                padding: const EdgeInsets.all(10.0),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                  childAspectRatio: 0.75,
                ),
                itemCount: state.hasNextPage ? posts.length + 2 : posts.length,
                itemBuilder: (context, index) {
                  if (index >= posts.length) {
                    return const ShimmeringSmallPost();
                  }
                  final post = posts[index];
                  return SmallPost(
                    post: post,
                    onDeletePostPopBack: () {
                      // Khi xóa bài viết, cần refresh lại BLoC để cập nhật danh sách.
                      context.read<ResultSearchBloc>().add(ResultSearchEvent.searchStarted(query: widget.query));
                    },
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }
}

// Widget hiển thị kết quả người dùng, giờ chỉ cần lắng nghe BLoC được cung cấp.
class _ProfileResultsView extends StatefulWidget {
  const _ProfileResultsView({super.key});

  @override
  State<_ProfileResultsView> createState() => _ProfileResultsViewState();
}

class _ProfileResultsViewState extends State<_ProfileResultsView> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_isBottom) {
      context.read<ResultSearchBloc>().add(const ResultSearchEvent.nextPageRequested());
    }
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll - 300.0);
  }

  // Phương thức public để scroll to top
  void scrollToTop() {
    if (_scrollController.hasClients) {
      _scrollController.animateTo(
        0,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ResultSearchBloc, ResultSearchState>(
      builder: (context, state) {
        // Các trường hợp loading, empty, failure
        if (state.status == SearchStatus.loading && state.results.isEmpty) {
          return const Center(child: CircularProgressIndicator());
        }
        if (state.status == SearchStatus.empty) {
          return Center(child: Text('Không tìm thấy người dùng nào cho "${state.query}".'));
        }
        if (state.status == SearchStatus.failure) {
          return Center(child: Text('Đã xảy ra lỗi: ${state.failure}'));
        }

        final profiles = state.results.whereType<AppUser>().toList();

        // Hiển thị ListView với dữ liệu
        return ListView.builder(
          controller: _scrollController,
          itemCount: state.hasNextPage ? profiles.length + 1 : profiles.length,
          itemBuilder: (context, index) {
            if (index >= profiles.length) {
              return const Center(child: Padding(padding: EdgeInsets.all(16.0), child: CircularProgressIndicator()));
            }
            final profile = profiles[index];
            return ListTile(
              leading: CircleAvatar(
                backgroundImage: profile.photoUrl != null ? NetworkImage(profile.photoUrl!) : null,
                child: profile.photoUrl == null ? const Icon(Icons.person) : null,
              ),
              title: Text(profile.displayName ?? 'Người dùng'),
              trailing: profile.isFollowing == true ? const Text('Đang theo dõi', style: TextStyle(color: Colors.blue, fontSize: 12)) : null,
              subtitle: Text('@${profile.username}'),
              onTap: () => context.push('/search_result/profile', extra: {
                'userId': profile.userId,
              }),
            );
          },
        );
      },
    );
  }
}
