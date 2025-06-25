import 'package:dishlocal/app/theme/custom_colors.dart';
import 'package:dishlocal/core/dependencies_injection/service_locator.dart';
import 'package:dishlocal/data/categories/post/repository/interface/post_repository.dart';
import 'package:dishlocal/ui/features/post/bloc/post_bloc.dart';
import 'package:dishlocal/ui/features/post/view/grid_post_page.dart';
import 'package:dishlocal/ui/widgets/element_widgets/glass_sliver_app_bar.dart';
import 'package:dishlocal/ui/widgets/guard_widgets/connectivity_and_location_guard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// BƯỚC 1: HomePage giờ trở thành một "Container" đơn giản, có thể là StatelessWidget.
/// Nhiệm vụ duy nhất của nó là gọi Guard.
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    // Khi Guard xác nhận điều kiện OK, nó sẽ tạo ra _HomePageContent.
    // Chỉ khi đó, initState của _HomePageContent mới được gọi.
    return ConnectivityAndLocationGuard(
      builder: (context) => const _HomePageContent(),
    );
  }
}

/// BƯỚC 2: Tạo một StatefulWidget riêng để chứa toàn bộ logic và giao diện của trang.
class _HomePageContent extends StatefulWidget {
  const _HomePageContent();

  @override
  State<_HomePageContent> createState() => _HomePageContentState();
}

/// BƯỚC 3: Di chuyển toàn bộ State logic từ HomePage cũ vào đây.
class _HomePageContentState extends State<_HomePageContent> with SingleTickerProviderStateMixin {
  late final TabController _tabController;
  final ScrollController _mainScrollController = ScrollController();
  late final List<PostBloc> _postBlocs;

  // BƯỚC 1: Thêm một Set để theo dõi các tab đã được khởi tạo.
  final Set<int> _initializedTabs = {};

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);

    final postRepository = getIt<PostRepository>();

    // BƯỚC 2: Khởi tạo các BLoC nhưng KHÔNG fetch dữ liệu ngay.
    _postBlocs = [
      PostBloc(postRepository.getPosts),
      PostBloc(postRepository.getFollowingPosts),
    ];

    // BƯỚC 3: Fetch dữ liệu cho tab đầu tiên (tab 0) một cách tường minh.
    if (_postBlocs.isNotEmpty) {
      _postBlocs[0].add(const PostEvent.fetchNextPostPageRequested());
      _initializedTabs.add(0);
    }

    // BƯỚC 4: Thêm listener để xử lý việc chuyển tab.
    _tabController.addListener(_handleTabSelection);
  }

  // BƯỚC 5: Tạo hàm xử lý cho listener.
  void _handleTabSelection() {
    final index = _tabController.index;
    // Nếu tab này chưa được khởi tạo trước đó...
    if (!_initializedTabs.contains(index)) {
      // ...thì gửi event fetch và đánh dấu là đã khởi tạo.
      _postBlocs[index].add(const PostEvent.fetchNextPostPageRequested());
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
    _postBlocs[index].add(const PostEvent.refreshRequested());
  }

  @override
  void dispose() {
    // BƯỚC 6: Đừng quên gỡ listener.
    _tabController.removeListener(_handleTabSelection);
    _tabController.dispose();
    _mainScrollController.dispose();
    for (var bloc in _postBlocs) {
      bloc.close();
    }
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
              centerTitle: true,
              hasBorder: false,
              title: ShaderMask(
                shaderCallback: (bounds) => primaryGradient.createShader(Rect.fromLTWH(0, 0, bounds.width, bounds.height)),
                child: const Text(
                  'DishLocal',
                  style: TextStyle(fontFamily: 'SFProDisplay', fontWeight: FontWeight.w700, fontSize: 24),
                ),
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
                  Tab(text: 'Dành cho bạn'),
                  Tab(text: 'Đang theo dõi'),
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
            BlocProvider.value(
              value: _postBlocs[0],
              child: const GridPostPage(
                key: PageStorageKey<String>('homeForYouTab'),
                noItemsFoundMessage: 'Chưa có bài viết nào để hiển thị.',
              ),
            ),
            BlocProvider.value(
              value: _postBlocs[1],
              child: const GridPostPage(
                key: PageStorageKey<String>('homeFollowingTab'),
                noItemsFoundMessage: 'Bạn chưa theo dõi ai.',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
