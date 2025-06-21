import 'package:dishlocal/app/theme/app_icons.dart';
import 'package:dishlocal/app/theme/custom_colors.dart';
import 'package:dishlocal/app/theme/theme.dart';
import 'package:dishlocal/core/dependencies_injection/service_locator.dart';
import 'package:dishlocal/data/categories/post/repository/interface/post_repository.dart';
import 'package:dishlocal/ui/features/post/bloc/post_bloc.dart';
import 'package:dishlocal/ui/features/post/view/grid_post_page.dart';
import 'package:dishlocal/ui/widgets/element_widgets/custom_badge.dart';
import 'package:dishlocal/ui/widgets/containers_widgets/glass_space.dart';
import 'package:dishlocal/ui/widgets/element_widgets/glass_sliver_app_bar.dart';
import 'package:dishlocal/ui/widgets/guard_widgets/connectivity_and_location_guard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin {
  late final TabController _tabController;
  final ScrollController _mainScrollController = ScrollController();

  // 1. LOẠI BỎ danh sách ScrollController cho từng tab
  // final List<ScrollController> _tabScrollControllers = ...

  late final List<PostBloc> _postBlocs;

  // LOẠI BỎ các biến state không cần thiết
  // int _previousTabIndex = 0;
  // int _currentTabIndex = 0;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);

    final postRepository = getIt<PostRepository>();
    _postBlocs = [
      PostBloc(postRepository.getPosts)..add(const PostEvent.fetchNextPostPageRequested()),
      PostBloc(postRepository.getSavedPosts)..add(const PostEvent.fetchNextPostPageRequested()),
    ];

    // LOẠI BỎ listener không cần thiết, chúng ta sẽ dùng onTap trực tiếp
    // _tabController.addListener(_handleTabSelection);
  }

  // LOẠI BỎ hàm _handleTabSelection
  // void _handleTabSelection() { ... }

  // 2. CẬP NHẬT hàm _scrollToTopAndRefresh
  void _scrollToTopAndRefresh(int index) {
    // a. Cuộn NestedScrollView chính (SliverAppBar) về đầu -> Giữ nguyên
    if (_mainScrollController.hasClients) {
      _mainScrollController.animateTo(
        0.0,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }

    // b. Tìm và cuộn PrimaryScrollController của tab đang hoạt động
    final innerController = PrimaryScrollController.of(context);
    if (innerController.hasClients) {
      innerController.animateTo(
        0.0,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }

    // c. Gửi sự kiện refresh đến BLoC tương ứng -> Giữ nguyên
    _postBlocs[index].add(const PostEvent.refreshRequested());
  }

  @override
  void dispose() {
    // LOẠI BỎ removeListener
    // _tabController.removeListener(_handleTabSelection);
    _tabController.dispose();
    _mainScrollController.dispose();
    // LOẠI BỎ vòng lặp dispose các controller của tab
    // for (var controller in _tabScrollControllers) { ... }
    for (var bloc in _postBlocs) {
      bloc.close();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ConnectivityAndLocationGuard(builder: (context) {
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
                    style: TextStyle(
                      fontFamily: 'SFProDisplay',
                      fontWeight: FontWeight.w700,
                      fontSize: 24,
                    ),
                  ),
                ),
                bottom: TabBar(
                  controller: _tabController,
                  // 3. CẬP NHẬT logic onTap cho đơn giản và chính xác
                  onTap: (index) {
                    // Chỉ thực hiện hành động khi người dùng nhấn vào tab đang được chọn
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
              // --- TAB 1 ---
              BlocProvider.value(
                value: _postBlocs[0],
                child: const GridPostPage(
                  // 4. THÊM PageStorageKey và LOẠI BỎ scrollController
                  key: PageStorageKey<String>('homeForYouTab'),
                  noItemsFoundMessage: 'Chưa có bài viết nào để hiển thị.',
                ),
              ),

              // --- TAB 2 ---
              BlocProvider.value(
                value: _postBlocs[1],
                child: const GridPostPage(
                  // 4. THÊM PageStorageKey và LOẠI BỎ scrollController
                  key: PageStorageKey<String>('homeFollowingTab'),
                  noItemsFoundMessage: 'Bạn chưa theo dõi ai.',
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
