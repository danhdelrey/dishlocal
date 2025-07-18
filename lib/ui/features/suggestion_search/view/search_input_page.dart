import 'package:dishlocal/app/config/main_shell.dart';
import 'package:dishlocal/app/theme/theme.dart';
import 'package:dishlocal/core/dependencies_injection/service_locator.dart';
import 'package:dishlocal/data/categories/app_user/model/app_user.dart';
import 'package:dishlocal/data/categories/post/model/post.dart';
import 'package:dishlocal/ui/features/suggestion_search/bloc/suggestion_search_bloc.dart';
import 'package:dishlocal/ui/widgets/guard_widgets/connectivity_and_location_guard.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class SearchInputPage extends StatefulWidget {
  const SearchInputPage({super.key});

  @override
  State<SearchInputPage> createState() => _SearchInputPageState();
}

class _SearchInputPageState extends State<SearchInputPage> {
  // BLoC này chỉ dùng cho việc lấy gợi ý
  late final SuggestionSearchBloc _suggestionBloc;
  final _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _suggestionBloc = getIt<SuggestionSearchBloc>();
    _searchController.addListener(_onQueryChanged);
  }

  void _onQueryChanged() {
    _suggestionBloc.add(SuggestionSearchEvent.queryChanged(query: _searchController.text));
  }

  void _navigateToResultScreen(String query) {
    final trimmedQuery = query.trim();
    if (trimmedQuery.isNotEmpty) {
      // Ẩn bàn phím trước khi điều hướng để tránh lỗi UI
      FocusScope.of(context).unfocus();
      context.pushReplacement('/search_result', extra: {'query': query});
    } else {
      ScaffoldMessenger.of(context)
        ..clearSnackBars()
        ..showSnackBar(
          const SnackBar(content: Text('Vui lòng nhập từ khóa tìm kiếm')),
        );
    }
  }

  @override
  void dispose() {
    _searchController.removeListener(_onQueryChanged);

    _searchController.dispose();
    _suggestionBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _suggestionBloc,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.transparent,
          elevation: 0,
          centerTitle: false,
          titleSpacing: 0,
          title: Row(
            children: [
              IconButton(
                icon: const Icon(CupertinoIcons.back),
                onPressed: () {
                  // Đóng bàn phím và trở về trang trước
                  FocusScope.of(context).unfocus();
                  context.pop();
                },
              ),
              Expanded(
                child: CupertinoSearchTextField(
                  controller: _searchController,
                  placeholder: 'Tìm kiếm bài viết, người dùng...',
                  autofocus: true,
                  style: appTextTheme(context).bodyMedium?.copyWith(
                        color: appColorScheme(context).onSurface,
                      ),
                  onSubmitted: _navigateToResultScreen,
                ),
              ),
              const SizedBox(
                width: 10,
              ),
            ],
          ),
        ),
        body: BlocBuilder<SuggestionSearchBloc, SuggestionSearchState>(
          builder: (context, state) {
            switch (state.status) {
              case SuggestionStatus.loading:
                // Hiển thị loading indicator
                return const LinearProgressIndicator(minHeight: 2);

              case SuggestionStatus.success:
                // Hiển thị danh sách khi có gợi ý
                return _buildSuggestionList(state.suggestions);

              case SuggestionStatus.empty:
                // Có thể hiển thị một thông báo nhẹ nhàng hoặc không gì cả
                // return const Center(child: Text("Không có gợi ý nào."));
                return const SizedBox.shrink(); // Ẩn đi để không làm phiền người dùng

              case SuggestionStatus.failure:
              case SuggestionStatus.initial:
                // Không hiển thị gì cho các trạng thái này
                return const SizedBox.shrink();
            }
          },
        ),
      ),
    );
  }

  Widget _buildSuggestionList(List<String> suggestions) {
    return ListView.builder(
      itemCount: suggestions.length,
      itemBuilder: (context, index) {
        final suggestion = suggestions[index];

        return ListTile(
          contentPadding: const EdgeInsets.symmetric(horizontal: 16),
          leading: Icon(CupertinoIcons.search, size: 20, color: appColorScheme(context).outline),
          title: Text(
            suggestion,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: appTextTheme(context).bodyMedium?.copyWith(
                  color: appColorScheme(context).onSurface,
                ),
          ),
          onTap: () {
            _navigateToResultScreen(suggestion);
          },
        );
      },
    );
  }
}
