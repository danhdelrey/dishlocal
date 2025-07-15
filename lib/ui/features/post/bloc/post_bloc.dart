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

typedef PostFetcher = Future<Either<post_failure.PostFailure, List<Post>>> Function({
  // Tham số cho các feed thông thường (dùng cursor)
  FilterSortParams? filterSortParams,
  // Tham số cho feed gợi ý (dùng số trang)
  int? page,
  required int pageSize,
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
  final bool _isRecommendationFeed; // <-- THÊM CỜ MỚI
  static const _pageSize = 10;

  /// Constructor mới, nhận thêm một cờ để xác định loại feed
  PostBloc(
    this._postFetcher, {
    bool isRecommendationFeed = false, // Mặc định là feed thông thường
    FilterSortParams? initialFilterSortParams, // Cho phép truyền vào bộ lọc ban đầu
  })  : _isRecommendationFeed = isRecommendationFeed,
        super(PostState(filterSortParams: initialFilterSortParams ?? FilterSortParams.defaultParams())) {
    on<_FetchNextPageRequested>(
      _onFetchNextPageRequested,
      transformer: throttleDroppable(const Duration(milliseconds: 500)),
    );
    on<_RefreshRequested>(_onRefreshRequested);
    on<_FiltersChanged>(_onFiltersChanged);
  }

  /// Helper để tính toán con trỏ (cursor) cho các feed THÔNG THƯỜNG
  Map<String, dynamic> _calculateCursor(List<Post> currentPosts, SortOption sortOption) {
    // Logic này không thay đổi
    if (currentPosts.isEmpty) {
      return {'mainCursor': null, 'dateCursor': null};
    }
    final lastPost = currentPosts.last;

    switch (sortOption.field) {
      case SortField.datePosted:
        return {'mainCursor': lastPost.createdAt, 'dateCursor': null};
      case SortField.likes:
      case SortField.comments:
      case SortField.saves:
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
    if (state.status == PostStatus.loading || !state.hasNextPage) return;

    if (state.status == PostStatus.initial) {
      emit(state.copyWith(status: PostStatus.loading));
    }

    // --- LOGIC PHÂN NHÁNH QUAN TRỌNG ---
    final Future<Either<post_failure.PostFailure, List<Post>>> fetchResult;

    if (_isRecommendationFeed) {
      // --- LUỒNG DÀNH CHO FEED GỢI Ý (DÙNG SỐ TRANG) ---
      // Tính toán trang hiện tại dựa trên số lượng bài viết đã có
      final currentPage = (state.posts.length / _pageSize).floor() + 1;
      _log.info('📥 Đang tải trang gợi ý tiếp theo. Trang số: $currentPage');
      fetchResult = _postFetcher(page: currentPage, pageSize: _pageSize);
    } else {
      // --- LUỒNG DÀNH CHO FEED THÔNG THƯỜNG (DÙNG CURSOR) ---
      final cursorData = _calculateCursor(state.posts, state.filterSortParams.sortOption);
      _log.info('📥 Đang tải trang tiếp theo. Cursor: ${cursorData['mainCursor']}');

      final params = state.filterSortParams.copyWith(
        lastCursor: cursorData['mainCursor'],
        lastDateCursorForTieBreak: cursorData['dateCursor'],
        limit: _pageSize,
      );
      fetchResult = _postFetcher(filterSortParams: params, pageSize: _pageSize);
    }

    // --- PHẦN XỬ LÝ KẾT QUẢ (GIỮ NGUYÊN) ---
    final result = await fetchResult;
    result.fold(
      (failure) {
        _log.severe('❌ Lỗi khi tải bài viết: $failure');
        emit(state.copyWith(status: PostStatus.failure, failure: failure));
      },
      (newPosts) {
        final isLastPage = newPosts.length < _pageSize;
        _log.info('✅ Tải được ${newPosts.length} bài viết. isLastPage: $isLastPage');
        emit(state.copyWith(
          status: PostStatus.success,
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
    // Khi refresh, reset mọi thứ về trạng thái ban đầu, chỉ giữ lại bộ lọc
    // Chú ý: Feed gợi ý không có bộ lọc, nên nó sẽ dùng giá trị mặc định.
    emit(PostState(filterSortParams: state.filterSortParams));
    add(const PostEvent.fetchNextPageRequested());
  }

  Future<void> _onFiltersChanged(
    _FiltersChanged event,
    Emitter<PostState> emit,
  ) async {
    // Bộ lọc chỉ có ý nghĩa với feed thông thường.
    if (_isRecommendationFeed) {
      _log.warning("⚠️ Bỏ qua sự kiện FiltersChanged vì đây là feed gợi ý.");
      return;
    }
    _log.info('🔄 Bộ lọc thay đổi. Đang làm mới với bộ lọc mới...');
    emit(PostState(filterSortParams: event.newFilters));
    add(const PostEvent.fetchNextPageRequested());
  }
}
