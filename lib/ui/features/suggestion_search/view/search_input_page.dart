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
      context.push('/search_result', extra: {'query': query});
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
          titleSpacing: 0,
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: Row(
            children: [
              IconButton(
                icon: const Icon(CupertinoIcons.back),
                onPressed: () => context.pop(),
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
              const SizedBox(width: 15),
            ],
          ),
        ),
        body: BlocBuilder<SuggestionSearchBloc, SuggestionSearchState>(
          builder: (context, state) {
            // Hiển thị loading indicator nhỏ gọn ở trên cùng
            if (state.status == SuggestionStatus.loading) {
              return const LinearProgressIndicator(minHeight: 2);
            }

            // Chỉ hiển thị danh sách khi có gợi ý thành công
            if (state.status == SuggestionStatus.success) {
              return _buildSuggestionList(state.suggestions);
            }

            // Hiển thị thông báo nếu tìm kiếm rỗng
            if (state.status == SuggestionStatus.empty) {
              return const Center(child: Text("Không có gợi ý nào."));
            }

            // Không hiển thị gì cho các trạng thái khác (initial, failure)
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }

  /// Widget xây dựng danh sách gợi ý
  Widget _buildSuggestionList(List<dynamic> suggestions) {
    return ListView.separated(
      itemCount: suggestions.length,
      separatorBuilder: (context, index) => const Divider(height: 1, indent: 56),
      itemBuilder: (context, index) {
        final item = suggestions[index];
        String title = '';
        IconData iconData = Icons.help_outline;
        String? subtitle;

        // Xác định thông tin để hiển thị dựa trên kiểu của item
        if (item is Post) {
          title = item.dishName ?? 'Bài viết không tên';
          iconData = CupertinoIcons.doc_text_search;
        } else if (item is AppUser) {
          title = item.displayName ?? 'Người dùng';
          iconData = CupertinoIcons.person_fill;
          subtitle = '@${item.username}';
        }

        return ListTile(
          leading: Icon(iconData, color: appColorScheme(context).onSurfaceVariant, size: 20),
          title: Text(title, maxLines: 1, overflow: TextOverflow.ellipsis),
          subtitle: subtitle != null ? Text(subtitle) : null,
          // Khi nhấn vào một gợi ý
          onTap: () {
            // Cập nhật text field với tiêu đề của gợi ý được chọn
            _searchController.text = title;
            // Di chuyển con trỏ đến cuối
            _searchController.selection = TextSelection.fromPosition(TextPosition(offset: title.length));
            // Điều hướng đến trang kết quả
            _navigateToResultScreen(title);
          },
        );
      },
    );
  }
}
