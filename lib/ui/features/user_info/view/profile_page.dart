import 'package:dishlocal/app/theme/app_icons.dart';
import 'package:dishlocal/app/theme/theme.dart';
import 'package:dishlocal/core/dependencies_injection/service_locator.dart';
import 'package:dishlocal/data/categories/app_user/repository/interface/app_user_repository.dart';
import 'package:dishlocal/data/categories/post/repository/interface/post_repository.dart';
import 'package:dishlocal/ui/features/auth/view/logout_button.dart';
import 'package:dishlocal/ui/features/post/bloc/post_bloc.dart';
import 'package:dishlocal/ui/features/post/view/grid_post_page.dart';
import 'package:dishlocal/ui/features/user_info/bloc/user_info_bloc.dart';
import 'package:dishlocal/ui/features/user_info/view/profile_info.dart';
import 'package:dishlocal/ui/widgets/guard_widgets/connectivity_and_location_guard.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

/// Container đơn giản, truyền userId xuống.
class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key, this.userId});
  final String? userId;

  @override
  Widget build(BuildContext context) {
    return ConnectivityAndLocationGuard(
      builder: (context) => _ProfilePageContent(userId: userId),
    );
  }
}

/// Widget nội dung chính, chứa toàn bộ logic và giao diện.
class _ProfilePageContent extends StatefulWidget {
  const _ProfilePageContent({this.userId});
  final String? userId;

  @override
  State<_ProfilePageContent> createState() => _ProfilePageContentState();
}

/// State logic được giữ nguyên, chỉ thay đổi phần `build`.
class _ProfilePageContentState extends State<_ProfilePageContent> with SingleTickerProviderStateMixin {
  late final TabController _tabController;
  late final List<PostBloc> _postBlocs;
  late final UserInfoBloc _userInfoBloc;

  bool _isMyProfile = false;

  @override
  void initState() {
    super.initState();

    final appUserRepo = getIt<AppUserRepository>();
    final postRepository = getIt<PostRepository>();
    final currentUserId = appUserRepo.getCurrentUserId();

    _isMyProfile = widget.userId == null || widget.userId == currentUserId;

    _tabController = TabController(length: _isMyProfile ? 2 : 1, vsync: this);

    _userInfoBloc = getIt<UserInfoBloc>()..add(UserInfoRequested(userId: widget.userId));

    _postBlocs = [
      PostBloc(
        ({required params}) => postRepository.getPostsByUserId(
          userId: widget.userId,
          params: params,
        ),
      ),
      if (_isMyProfile)
        PostBloc(
          ({required params}) => postRepository.getSavedPosts(
            userId: currentUserId,
            params: params,
          ),
        ),
    ];
  }

  @override
  void dispose() {
    _tabController.dispose();
    _userInfoBloc.close();
    for (var bloc in _postBlocs) {
      bloc.close();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Cung cấp các BLoC cho cây widget
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(value: _userInfoBloc),
        // Các PostBloc sẽ được cung cấp bên trong TabBarView
      ],
      // Sử dụng Scaffold với layout Column, không dùng Sliver
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.transparent,
          surfaceTintColor: Colors.transparent,
          // Nút quay lại chỉ hiển thị khi xem trang của người khác
          leading: widget.userId != null
              ? IconButton(
                  onPressed: () => context.pop(),
                  // Dùng Icon thay vì SVG để đơn giản hóa
                  icon: const Icon(
                    Icons.arrow_back_ios_new,
                    size: 16,
                  ),
                )
              : null,
          // Title lấy từ UserInfoBloc
          title: BlocBuilder<UserInfoBloc, UserInfoState>(
            builder: (context, state) {
              if (state is UserInfoSuccess) {
                return Text(state.appUser.username ?? 'Profile');
              }
              return const SizedBox(); // Hiển thị rỗng khi đang tải
            },
          ),
          titleTextStyle: appTextTheme(context).titleMedium,
          centerTitle: true,
          // Nút Logout chỉ hiển thị ở trang của mình
          actions: [
            if (_isMyProfile) const LogoutButton(),
          ],
        ),
        body: Column(
          children: [
            // 1. Phần thông tin Profile
            const ProfileInfo(),

            // 2. Thanh TabBar
            Container(
              // Thêm một lớp Container để có thể tùy chỉnh nền nếu muốn
              color: Colors.black.withAlpha(10), // Màu nền nhẹ cho TabBar
              child: TabBar(
                controller: _tabController,
                dividerColor: Colors.white.withAlpha(25),
                tabs: [
                  const Tab(icon: Icon(Icons.grid_view_rounded)),
                  if (_isMyProfile) const Tab(icon: Icon(Icons.bookmark_rounded)),
                ],
              ),
            ),

            // 3. Nội dung các Tab
            // Bọc TabBarView trong Expanded để nó chiếm hết không gian còn lại
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  // Tab 1: Bài viết đã đăng
                  BlocProvider.value(
                    value: _postBlocs[0],
                    child: const GridPostPage(
                      key: PageStorageKey<String>('profilePosts'),
                      noItemsFoundMessage: 'Chưa có bài viết nào.',
                    ),
                  ),
                  // Tab 2: Bài viết đã lưu (chỉ tồn tại nếu là trang của mình)
                  if (_isMyProfile)
                    BlocProvider.value(
                      value: _postBlocs[1],
                      child: const GridPostPage(
                        key: PageStorageKey<String>('profileSavedPosts'),
                        noItemsFoundMessage: 'Chưa có bài viết nào được lưu.',
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

// Lớp _SliverAppBarDelegate không còn cần thiết và đã được xóa.
