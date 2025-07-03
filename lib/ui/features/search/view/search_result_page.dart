import 'package:dishlocal/app/theme/theme.dart';
import 'package:dishlocal/core/dependencies_injection/service_locator.dart';
import 'package:dishlocal/ui/features/post/view/grid_post_page.dart';
import 'package:dishlocal/ui/features/post_search/bloc/post_search_bloc.dart';
import 'package:dishlocal/ui/features/profile_search/bloc/profile_search_bloc.dart';
import 'package:dishlocal/ui/features/profile_search/view/list_profile_page.dart';
import 'package:dishlocal/ui/widgets/element_widgets/glass_sliver_app_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

// Widget container nhận query và cung cấp BLoC
class SearchResultScreen extends StatelessWidget {
  final String query;
  const SearchResultScreen({super.key, required this.query});

  @override
  Widget build(BuildContext context) {
    // Cung cấp các BLoC cho cây widget con
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => getIt<PostSearchBloc>()),
        BlocProvider(create: (context) => getIt<ProfileSearchBloc>()),
      ],
      // _SearchResultContent sẽ nhận query và sử dụng các BLoC đã được cung cấp
      child: _SearchResultContent(query: query),
    );
  }
}

// Widget nội dung chính, chứa state và logic
class _SearchResultContent extends StatefulWidget {
  final String query;
  const _SearchResultContent({required this.query});

  @override
  State<_SearchResultContent> createState() => __SearchResultContentState();
}

class __SearchResultContentState extends State<_SearchResultContent> with SingleTickerProviderStateMixin {
  late final TabController _tabController;
  // Chúng ta không cần lưu trữ BLoCs ở đây nữa vì đã có BlocProvider
  final Set<int> _initializedTabs = {};

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);

    // Bắt đầu tìm kiếm cho tab đầu tiên (Posts)
    context.read<PostSearchBloc>().add(PostSearchEvent.searchStarted(widget.query));
    _initializedTabs.add(0);

    // Lắng nghe sự kiện chuyển tab để fetch dữ liệu cho các tab khác
    _tabController.addListener(_handleTabSelection);
  }

  void _handleTabSelection() {
    final index = _tabController.index;
    if (!_initializedTabs.contains(index)) {
      if (index == 1) {
        // Nếu chuyển đến tab 'Người dùng', bắt đầu tìm kiếm profile
        context.read<ProfileSearchBloc>().add(ProfileSearchEvent.searchStarted(widget.query));
      }
      _initializedTabs.add(index);
    }
  }

  @override
  void dispose() {
    _tabController.removeListener(_handleTabSelection);
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
                      'Kết quả cho "${widget.query}"',
                      style: appTextTheme(context).titleMedium,
                    ),
                  ),
                ],
              ),
              pinned: true,
              floating: true,
              snap: true,
              bottom: TabBar(
                dividerColor: Colors.white.withValues(alpha: 0.1),
                controller: _tabController,
                tabs: const [
                  Tab(text: 'Bài viết'),
                  Tab(text: 'Người dùng'),
                ],
              ),
            ),
          ];
        },
        body: TabBarView(
          controller: _tabController,
          children: [
            // Tab bài viết
            BlocBuilder<PostSearchBloc, PostSearchState>(
              builder: (context, state) {
                return GridPostPage(
                  pagingState: state,
                  onFetchNextPage: () => context.read<PostSearchBloc>().add(const PostSearchEvent.nextPageRequested()),
                  onRefresh: () async {
                    context.read<PostSearchBloc>().add(PostSearchEvent.searchStarted(widget.query));
                    // Đợi BLoC xử lý xong
                    await context.read<PostSearchBloc>().stream.firstWhere((s) => s.error != null || s.pages?.isNotEmpty == true);
                  },
                  noItemsFoundMessage: "Không tìm thấy bài viết nào.",
                );
              },
            ),
            // Tab người dùng
            BlocBuilder<ProfileSearchBloc, ProfileSearchState>(
              builder: (context, state) {
                return ListProfilePage(
                  pagingState: state,
                  onFetchNextPage: () => context.read<ProfileSearchBloc>().add(const ProfileSearchEvent.nextPageRequested()),
                  onRefresh: () async {
                    context.read<ProfileSearchBloc>().add(ProfileSearchEvent.searchStarted(widget.query));
                    await context.read<ProfileSearchBloc>().stream.firstWhere((s) => s.error != null || s.pages?.isNotEmpty == true);
                  },
                  noItemsFoundMessage: "Không tìm thấy người dùng nào.",
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
