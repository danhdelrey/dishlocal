import 'package:bloc/bloc.dart';
import 'package:dishlocal/data/categories/post/model/post.dart';
import 'package:dishlocal/data/categories/post/repository/interface/post_repository.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:injectable/injectable.dart';
import 'package:logging/logging.dart';
import 'package:rxdart/rxdart.dart';

part 'post_search_event.dart';
part 'post_search_bloc.freezed.dart';

// State của BLoC này chính là PagingState
typedef PostSearchState = PagingState<int, Post>;

@injectable
class PostSearchBloc extends Bloc<PostSearchEvent, PostSearchState> {
  final _log = Logger('PostSearchBloc');
  final PostRepository _postRepository;
  static const int _hitsPerPage = 15;

  String _currentQuery = '';

  PostSearchBloc(this._postRepository) : super(PostSearchState()) {
    on<_SearchStarted>((event, emit) {
      _log.info('🚀 Bắt đầu tìm kiếm bài viết với query: "${event.query}"');
      _currentQuery = event.query;
      // Reset state và yêu cầu tải trang đầu tiên
      emit(PostSearchState());
      add(const PostSearchEvent.nextPageRequested());
    });

    on<_NextPageRequested>((event, emit) async {
      // Bảo vệ: Nếu query rỗng hoặc không còn trang tiếp, hoặc đang loading thì không làm gì
      if (_currentQuery.isEmpty || !state.hasNextPage || state.isLoading) return;

      emit(state.copyWith(isLoading: true));

      // --- CẢI TIẾN CÁCH TÍNH TRANG CẦN TẢI ---
      // Lấy page key cuối cùng đã tải, nếu chưa có thì là -1, sau đó +1 để ra trang tiếp theo (0).
      // Đây là cách làm chuẩn của thư viện.
      final pageToFetch = (state.keys?.last ?? -1) + 1;
      _log.info('📥 Đang tải trang bài viết số $pageToFetch...');

      final result = await _postRepository.searchPosts(
        query: _currentQuery,
        page: pageToFetch,
        hitsPerPage: _hitsPerPage,
      );

      result.fold(
        (failure) {
          _log.severe('❌ Lỗi khi tìm kiếm bài viết: $failure');
          emit(state.copyWith(error: failure, isLoading: false));
        },
        (newPosts) {
          final isLastPage = newPosts.length < _hitsPerPage;
          _log.info('✅ Tải được ${newPosts.length} bài viết. isLastPage=$isLastPage');

          // --- SỬA LỖI Ở ĐÂY ---
          emit(state.copyWith(
            // Cập nhật danh sách các trang
            pages: [...?state.pages, newPosts],
            // **FIX**: Cập nhật danh sách các key tương ứng
            keys: [...?state.keys, pageToFetch],
            // Xác định xem còn trang tiếp theo không
            hasNextPage: !isLastPage,
            isLoading: false,
            error: null, // Xóa lỗi cũ nếu có
          ));
        },
      );
    }, transformer: (events, mapper) => events.throttleTime(const Duration(milliseconds: 300)).asyncExpand(mapper));
  }
}
