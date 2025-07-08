import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:dishlocal/data/categories/post/model/filter_sort_model/filter_sort_params.dart';
import 'package:dishlocal/data/categories/post/model/filter_sort_model/sort_option.dart';
import 'package:dishlocal/data/categories/post/model/post.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:logging/logging.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:rxdart/rxdart.dart';

import '../../../../data/categories/post/failure/post_failure.dart' as post_failure;

part 'post_event.dart';
part 'post_state.dart'; // Đổi tên file nếu bạn tách ra
part 'post_bloc.freezed.dart';

// PostFetcher bây giờ phải nhận FilterSortParams
typedef PostFetcher = Future<Either<post_failure.PostFailure, List<Post>>> Function({
  required FilterSortParams params,
});

// Helper để tránh các yêu cầu fetch bị chồng chéo
EventTransformer<E> throttleDroppable<E>(Duration duration) {
  return (events, mapper) {
    return droppable<E>().call(events.throttleTime(duration), mapper);
  };
}

class PostBloc extends Bloc<PostEvent, PostState> {
  final _log = Logger('PostBloc');
  final PostFetcher _postFetcher;
  static const _pageSize = 10;

  PostBloc(this._postFetcher) : super(PostState(filterSortParams: FilterSortParams.defaultParams())) {
    on<_FetchNextPageRequested>(
      _onFetchNextPageRequested,
      // Ngăn người dùng spam yêu cầu tải trang
      transformer: throttleDroppable(const Duration(milliseconds: 500)),
    );
    on<_RefreshRequested>(_onRefreshRequested);
    on<_FiltersChanged>(_onFiltersChanged);
  }

  /// Helper để tính toán con trỏ (cursor) cho yêu cầu tiếp theo
  Map<String, dynamic> _calculateCursor(List<Post> currentPosts, SortOption sortOption) {
    if (currentPosts.isEmpty) {
      return {'mainCursor': null, 'dateCursor': null};
    }
    final lastPost = currentPosts.last;

    switch (sortOption.field) {
      case SortField.datePosted:
        // Sắp xếp theo ngày, chỉ cần con trỏ chính
        return {'mainCursor': lastPost.createdAt, 'dateCursor': null};
      case SortField.likes:
      case SortField.comments:
      case SortField.saves:
        // Sắp xếp theo số, cần cả hai
        final numericValue = sortOption.field == SortField.likes
            ? lastPost.likeCount
            : sortOption.field == SortField.comments
                ? lastPost.commentCount
                : lastPost.saveCount;
        return {
          'mainCursor': numericValue,
          'dateCursor': lastPost.createdAt,
        };
    }
  }

  Future<void> _onFetchNextPageRequested(
    _FetchNextPageRequested event,
    Emitter<PostState> emit,
  ) async {
    // Ngăn chặn việc fetch nếu đang tải hoặc đã hết trang
    if (state.status == PostStatus.loading || !state.hasNextPage) return;

    // Nếu đây là lần tải đầu tiên (danh sách rỗng), trạng thái là initial.
    // Nếu không, vẫn giữ trạng thái success và hiển thị loading indicator ở cuối.
    if (state.status == PostStatus.initial) {
      emit(state.copyWith(status: PostStatus.loading));
    }

    final cursorData = _calculateCursor(state.posts, state.filterSortParams.sortOption);

    _log.info('📥 Đang tải trang tiếp theo. Cursor: ${cursorData['mainCursor']}, Tie-break: ${cursorData['dateCursor']}');

    final params = state.filterSortParams.copyWith(
      // Gán con trỏ vào các trường tương ứng
      lastCursor: cursorData['mainCursor'],
      lastDateCursorForTieBreak: cursorData['dateCursor'],
      limit: _pageSize,
    );

    final result = await _postFetcher(params: params);

    result.fold(
      // Trường hợp thất bại
      (failure) {
        _log.severe('❌ Lỗi khi tải bài viết: $failure');
        emit(state.copyWith(status: PostStatus.failure, failure: failure));
      },
      // Trường hợp thành công
      (newPosts) {
        final isLastPage = newPosts.length < _pageSize;
        _log.info('✅ Tải được ${newPosts.length} bài viết. isLastPage: $isLastPage');
        emit(state.copyWith(
          status: PostStatus.success,
          // Nối danh sách cũ với danh sách mới
          posts: List.of(state.posts)..addAll(newPosts),
          hasNextPage: !isLastPage,
        ));
      },
    );
  }

  Future<void> _onRefreshRequested(
    _RefreshRequested event,
    Emitter<PostState> emit,
  ) async {
    _log.info('🔄 Yêu cầu làm mới...');
    // Reset state về ban đầu, nhưng giữ lại bộ lọc hiện tại
    emit(PostState(filterSortParams: state.filterSortParams));
    // Gọi event fetch để tải lại từ đầu
    add(const PostEvent.fetchNextPageRequested());
  }

  Future<void> _onFiltersChanged(
    _FiltersChanged event,
    Emitter<PostState> emit,
  ) async {
    _log.info('🔄 Bộ lọc thay đổi. Đang làm mới với bộ lọc mới...');
    // Reset hoàn toàn state và áp dụng bộ lọc mới
    emit(PostState(filterSortParams: event.newFilters));
    // Gọi event fetch để tải lại từ đầu với bộ lọc mới
    add(const PostEvent.fetchNextPageRequested());
  }
}
