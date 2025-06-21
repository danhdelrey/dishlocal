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

/// BƯỚC 1: HomePage giờ trở thành một "Container" đơn giản, có thể là StatelessWidget.
/// Nhiệm vụ duy nhất của nó là gọi Guard.
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    // Khi Guard xác nhận điều kiện OK, nó sẽ tạo ra _HomePageContent.
    // Chỉ khi đó, initState của _HomePageContent mới được gọi.
    return ConnectivityAndLocationGuard(
      builder: (context) => _HomePageContent(),
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

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);

    // BLoCs GIỜ ĐƯỢC KHỞI TẠO Ở ĐÂY!
    // Tại thời điểm này, chúng ta đã chắc chắn có kết nối mạng và vị trí.
    final postRepository = getIt<PostRepository>();
    _postBlocs = [
      PostBloc(postRepository.getPosts)..add(const PostEvent.fetchNextPostPageRequested()),
      PostBloc(postRepository.getFollowingPosts)..add(const PostEvent.fetchNextPostPageRequested()),
    ];
  }

  void _scrollToTopAndRefresh(int index) {
    if (_mainScrollController.hasClients) {
      _mainScrollController.animateTo(
        0.0,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }

    // Lưu ý: PrimaryScrollController.of(context) vẫn hoạt động bình thường
    // vì nó lấy context từ phương thức build của State này.
    final innerController = PrimaryScrollController.of(context);
    if (innerController.hasClients) {
      innerController.animateTo(
        0.0,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }

    _postBlocs[index].add(const PostEvent.refreshRequested());
  }

  @override
  void dispose() {
    _tabController.dispose();
    _mainScrollController.dispose();
    for (var bloc in _postBlocs) {
      bloc.close();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Giao diện Scaffold và NestedScrollView được đặt ở đây.
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
                onTap: (index) {
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
