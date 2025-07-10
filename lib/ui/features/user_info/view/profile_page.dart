import 'package:dishlocal/app/theme/app_icons.dart';
import 'package:dishlocal/app/theme/theme.dart';
import 'package:dishlocal/core/dependencies_injection/service_locator.dart';
import 'package:dishlocal/data/categories/app_user/repository/interface/app_user_repository.dart';
import 'package:dishlocal/data/categories/post/model/filter_sort_model/filter_sort_params.dart';
import 'package:dishlocal/data/categories/post/model/post.dart';
import 'package:dishlocal/data/categories/post/repository/interface/post_repository.dart';
import 'package:dishlocal/ui/features/auth/view/logout_button.dart';
import 'package:dishlocal/ui/features/home/view/home_page.dart';
import 'package:dishlocal/ui/features/post/bloc/post_bloc.dart';
import 'package:dishlocal/ui/features/post/view/post_grid_tab_view.dart';
import 'package:dishlocal/ui/features/post/view/small_post.dart';
import 'package:dishlocal/ui/features/user_info/bloc/user_info_bloc.dart';
import 'package:dishlocal/ui/features/user_info/view/profile_info.dart';
import 'package:dishlocal/ui/widgets/guard_widgets/connectivity_and_location_guard.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

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

class _ProfilePageContent extends StatefulWidget {
  const _ProfilePageContent({this.userId});
  final String? userId;

  @override
  State<_ProfilePageContent> createState() => _ProfilePageContentState();
}

class _ProfilePageContentState extends State<_ProfilePageContent> with TickerProviderStateMixin {
  late final TabController _tabController;
  late final List<PostBloc> _postBlocs;
  late final UserInfoBloc _userInfoBloc;

  late final ScrollController postsTabScrollController = ScrollController();
  late final ScrollController savedTabScrollController = ScrollController();

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
    postsTabScrollController.dispose();
    if (_isMyProfile) savedTabScrollController.dispose();
    _tabController.dispose();
    _userInfoBloc.close();
    for (var bloc in _postBlocs) {
      bloc.close();
    }
    super.dispose();
  }

  void _onTabTapped(int index) {
    if (_tabController.index == index) {
      // Scroll to top if tapping on current tab
      final scrollController = index == 0 ? postsTabScrollController : savedTabScrollController;
      if (scrollController.hasClients) {
        final currentOffset = scrollController.offset;
        final duration = Duration(milliseconds: (currentOffset / 2).clamp(300, 1000).round());

        scrollController.animateTo(
          0,
          duration: duration,
          curve: Curves.easeOut,
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(value: _userInfoBloc),
      ],
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () => context.push("/camera"),
          shape: const CircleBorder(),
          backgroundColor: appColorScheme(context).primary,
          child: const Icon(CupertinoIcons.add),
        ),
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          surfaceTintColor: Colors.transparent,
          elevation: 0,
          leading: widget.userId != null
              ? IconButton(
                  onPressed: () => context.pop(),
                  icon: const Icon(
                    Icons.arrow_back_ios_new,
                    size: 16,
                  ),
                )
              : null,
          title: BlocBuilder<UserInfoBloc, UserInfoState>(
            builder: (context, state) {
              if (state is UserInfoSuccess) {
                return Text(state.appUser.username ?? 'Profile');
              }
              return const SizedBox();
            },
          ),
          titleTextStyle: appTextTheme(context).titleMedium,
          centerTitle: true,
          actions: [
            if (_isMyProfile) const LogoutButton(),
          ],
        ),
        body: Column(
          children: [
            const ProfileInfo(),
            Material(
              color: Theme.of(context).scaffoldBackgroundColor,
              child: TabBar(
                controller: _tabController,
                onTap: _onTabTapped,
                tabs: [
                  const Tab(icon: Icon(Icons.grid_view_rounded)),
                  if (_isMyProfile) const Tab(icon: Icon(Icons.bookmark_rounded)),
                ],
              ),
            ),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  BlocProvider.value(
                    value: _postBlocs[0],
                    child: PostGridTabView(
                      scrollController: postsTabScrollController,
                      key: const PageStorageKey<String>('profilePosts'),
                      noItemsFoundMessage: 'Chưa có bài viết nào.',
                    ),
                  ),
                  if (_isMyProfile)
                    BlocProvider.value(
                      value: _postBlocs[1],
                      child: PostGridTabView(
                        scrollController: savedTabScrollController,
                        key: const PageStorageKey<String>('profileSavedPosts'),
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
