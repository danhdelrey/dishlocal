import 'package:dishlocal/app/theme/theme.dart';
import 'package:dishlocal/ui/widgets/element_widgets/glass_sliver_app_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SearchResultPage extends StatefulWidget {
  const SearchResultPage({super.key});

  @override
  State<SearchResultPage> createState() => _SearchResultPageState();
}

class _SearchResultPageState extends State<SearchResultPage> with SingleTickerProviderStateMixin {
  late final TabController _tabController;
  final ScrollController _mainScrollController = ScrollController();
  //late final List<PostBloc> _postBlocs;

  // BƯỚC 1: Thêm một Set để theo dõi các tab đã được khởi tạo.
  final Set<int> _initializedTabs = {};

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);

    //final postRepository = getIt<PostRepository>();

    // BƯỚC 2: Khởi tạo các BLoC nhưng KHÔNG fetch dữ liệu ngay.
    // _postBlocs = [
    //   PostBloc(postRepository.getPosts),
    //   PostBloc(postRepository.getFollowingPosts),
    // ];

    // BƯỚC 3: Fetch dữ liệu cho tab đầu tiên (tab 0) một cách tường minh.
    // if (_postBlocs.isNotEmpty) {
    //   _postBlocs[0].add(const PostEvent.fetchNextPostPageRequested());
    //   _initializedTabs.add(0);
    // }

    // BƯỚC 4: Thêm listener để xử lý việc chuyển tab.
    _tabController.addListener(_handleTabSelection);
  }

  // BƯỚC 5: Tạo hàm xử lý cho listener.
  void _handleTabSelection() {
    final index = _tabController.index;
    // Nếu tab này chưa được khởi tạo trước đó...
    if (!_initializedTabs.contains(index)) {
      // ...thì gửi event fetch và đánh dấu là đã khởi tạo.
      //_postBlocs[index].add(const PostEvent.fetchNextPostPageRequested());
      _initializedTabs.add(index);
    }
  }

  void _scrollToTopAndRefresh(int index) {
    // Logic này không thay đổi
    if (_mainScrollController.hasClients) {
      _mainScrollController.animateTo(0.0, duration: const Duration(milliseconds: 300), curve: Curves.easeOut);
    }
    final innerController = PrimaryScrollController.of(context);
    if (innerController.hasClients) {
      innerController.animateTo(0.0, duration: const Duration(milliseconds: 300), curve: Curves.easeOut);
    }
    //_postBlocs[index].add(const PostEvent.refreshRequested());
  }

  @override
  void dispose() {
    // BƯỚC 6: Đừng quên gỡ listener.
    _tabController.removeListener(_handleTabSelection);
    _tabController.dispose();
    _mainScrollController.dispose();
    // for (var bloc in _postBlocs) {
    //   bloc.close();
    // }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Toàn bộ phần UI trong build() không cần thay đổi
    return Scaffold(
      extendBody: true,
      body: NestedScrollView(
        controller: _mainScrollController,
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            GlassSliverAppBar(
              titleSpacing: 0,
              centerTitle: true,
              hasBorder: false,
              title: Row(
                children: [
                  IconButton(
                    icon: const Icon(CupertinoIcons.back),
                    onPressed: () => context.pop(),
                  ),
                  Expanded(
                    child: CupertinoSearchTextField(
                      style: appTextTheme(context).bodyMedium?.copyWith(
                            color: appColorScheme(context).onSurface,
                          ),
                    ),
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                ],
              ),
              bottom: TabBar(
                dividerColor: Colors.white.withValues(alpha: 0.1),
                controller: _tabController,
                onTap: (index) {
                  // Logic refresh-on-tap giữ nguyên
                  if (!_tabController.indexIsChanging) {
                    _scrollToTopAndRefresh(index);
                  }
                },
                tabs: const [
                  Tab(text: 'Bài viết'),
                  Tab(text: 'Người dùng'),
                ],
              ),
              floating: true,
              snap: true,
              pinned: true,
            ),
          ];
        },
        body: TabBarView(
          controller: _tabController,
          children: [
            // BlocProvider.value(
            //   value: _postBlocs[0],
            //   child: const GridPostPage(
            //     key: PageStorageKey<String>('homeForYouTab'),
            //     noItemsFoundMessage: 'Chưa có bài viết nào để hiển thị.',
            //   ),
            // ),
            // BlocProvider.value(
            //   value: _postBlocs[1],
            //   child: const GridPostPage(
            //     key: PageStorageKey<String>('homeFollowingTab'),
            //     noItemsFoundMessage: 'Bạn chưa theo dõi ai.',
            //   ),
            // ),
            Center(
              child: Text(
                'Chức năng này hiện chưa được triển khai.',
                style: appTextTheme(context).bodyLarge?.copyWith(
                      color: appColorScheme(context).onSurface,
                    ),
              ),
            ),
            Center(
              child: Text(
                'Chức năng này hiện chưa được triển khai.',
                style: appTextTheme(context).bodyLarge?.copyWith(
                      color: appColorScheme(context).onSurface,
                    ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
