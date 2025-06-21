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

  // Controller cho NestedScrollView chính (quản lý việc cuộn của SliverAppBar)
  final ScrollController _mainScrollController = ScrollController();

  // ScrollController cho từng tab riêng lẻ
  final List<ScrollController> _tabScrollControllers = [
    ScrollController(), // Controller cho Tab 0
    ScrollController(), // Controller cho Tab 1
  ];

  // Danh sách các BLoC cho từng tab
  late final List<PostBloc> _postBlocs;

  int _previousTabIndex = 0;
  int _currentTabIndex = 0;


  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);

    // Khởi tạo các BLoC
    final postRepository = getIt<PostRepository>();
    _postBlocs = [
      PostBloc(postRepository.getPosts)..add(const PostEvent.fetchNextPostPageRequested()),
      PostBloc(postRepository.getSavedPosts)..add(const PostEvent.fetchNextPostPageRequested()),
    ];
  }

  void _handleTabSelection() {
    // Nếu người dùng nhấn vào tab đang hoạt động
    if (!_tabController.indexIsChanging && _tabController.index == _previousTabIndex) {
      _scrollToTopAndRefresh(_tabController.index);
    }
    _previousTabIndex = _tabController.index;
  }

  void _scrollToTopAndRefresh(int index) {
    // 1. Cuộn NestedScrollView chính (SliverAppBar) về đầu
    if (_mainScrollController.hasClients) {
      _mainScrollController.animateTo(
        0.0,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
    // 2. Cuộn CustomScrollView của tab tương ứng về đầu
    if (_tabScrollControllers[index].hasClients) {
      _tabScrollControllers[index].animateTo(
        0.0,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
    // 3. Gửi sự kiện refresh đến BLoC tương ứng
    _postBlocs[index].add(const PostEvent.refreshRequested());
  }

  @override
  void dispose() {
    _tabController.removeListener(_handleTabSelection);
    _tabController.dispose();
    _mainScrollController.dispose();
    for (var controller in _tabScrollControllers) {
      controller.dispose();
    }
    for (var bloc in _postBlocs) {
      bloc.close();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ConnectivityAndLocationGuard(builder: (context) {
      // Không cần BlocProvider ở đây nữa vì chúng ta dùng BlocProvider.value bên dưới
      // Không cần DefaultTabController nữa
      return Scaffold(
        extendBody: true,
        body: NestedScrollView(
          controller: _mainScrollController, // GÁN CONTROLLER CHÍNH
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
                  onTap: (index) {
                    if (index == _currentTabIndex) {
                      _scrollToTopAndRefresh(index);
                    } else {
                      _currentTabIndex = index;
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
            controller: _tabController, // GÁN TAB CONTROLLER
            children: [
              // --- TAB 1 ---
              BlocProvider.value(
                value: _postBlocs[0],
                child: GridPostPage(
                  scrollController: _tabScrollControllers[0], // Truyền controller của tab
                  noItemsFoundMessage: 'Chưa có bài viết nào để hiển thị.',
                ),
              ),

              // --- TAB 2 ---
              BlocProvider.value(
                value: _postBlocs[1],
                child: GridPostPage(
                  scrollController: _tabScrollControllers[1], // Truyền controller của tab
                  noItemsFoundMessage: 'Bạn chưa theo dõi ai.', // Hoặc 'chưa lưu bài viết nào'
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
