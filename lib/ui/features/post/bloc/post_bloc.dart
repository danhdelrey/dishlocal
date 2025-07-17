import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:dishlocal/core/dependencies_injection/service_locator.dart';
import 'package:dishlocal/data/categories/post/model/filter_sort_model/filter_sort_params.dart';
import 'package:dishlocal/data/categories/post/model/filter_sort_model/sort_option.dart';
import 'package:dishlocal/data/categories/post/model/post.dart';
import 'package:dishlocal/data/categories/post/repository/interface/post_repository.dart';
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
  FilterSortParams? filterSortParams,
  int? page,
  required int pageSize,
});

EventTransformer<E> throttleDroppable<E>(Duration duration) {
  return (events, mapper) {
    return droppable<E>().call(events.throttleTime(duration), mapper);
  };
}

class PostBloc extends Bloc<PostEvent, PostState> {
  final _log = Logger('PostBloc');
  final PostFetcher _postFetcher;
  final PostRepository _postRepository;
  final bool _isRecommendationFeed;
  static const _pageSize = 10;

  PostBloc(
    this._postFetcher, {
    bool isRecommendationFeed = false,
    FilterSortParams? initialFilterSortParams,
  })  : _isRecommendationFeed = isRecommendationFeed,
        _postRepository = getIt<PostRepository>(),
        super(PostState(filterSortParams: initialFilterSortParams ?? FilterSortParams.defaultParams())) {
    on<_FetchNextPageRequested>(
      _onFetchNextPageRequested,
      transformer: throttleDroppable(const Duration(milliseconds: 500)),
    );
    on<_RefreshRequested>(_onRefreshRequested);
    on<_FiltersChanged>(_onFiltersChanged);
    on<_FallbackToTrendingFeedRequested>(_onFallbackToTrendingFeedRequested);
  }

  Map<String, dynamic> _calculateCursor(List<Post> currentPosts, SortOption sortOption) {
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
        return {'mainCursor': numericValue, 'dateCursor': lastPost.createdAt};
    }
  }

    Future<void> _onFetchNextPageRequested(
    _FetchNextPageRequested event,
    Emitter<PostState> emit,
  ) async {
    // SỬA ĐỔI 1: Loại bỏ `state.isFallback` khỏi điều kiện chặn.
    // Chúng ta vẫn muốn fetch ngay cả khi đang fallback, chỉ là logic fetch sẽ khác.
    if (state.status == PostStatus.loading || !state.hasNextPage) return;

    if (state.status == PostStatus.initial) {
      emit(state.copyWith(status: PostStatus.loading));
    }

    // SỬA ĐỔI 2: Tạo một biến để giữ kết quả fetch, vì logic sẽ rẽ nhánh.
    late final Future<Either<post_failure.PostFailure, List<Post>>> fetchResult;

    // SỬA ĐỔI 3: Thêm nhánh `if` để xử lý logic khi đang ở chế độ fallback.
    if (state.isFallback) {
      // --- LOGIC TẢI TRANG KHI ĐANG FALLBACK ---
      final pageToFetch = (state.posts.length / _pageSize).floor() + 1;
      _log.info('📥 Đang tải trang fallback tiếp theo. Trang số: $pageToFetch');

      fetchResult = _postRepository.getTrendingPosts(
        page: pageToFetch,
        pageSize: _pageSize,
      );
    } else {
      // --- LOGIC TẢI TRANG GỐC (như cũ) ---
      if (_isRecommendationFeed) {
        final currentPage = (state.posts.length / _pageSize).floor() + 1;
        _log.info('📥 Đang tải trang gợi ý tiếp theo. Trang số: $currentPage');
        fetchResult = _postFetcher(page: currentPage, pageSize: _pageSize);
      } else {
        final cursorData = _calculateCursor(state.posts, state.filterSortParams.sortOption);
        _log.info('📥 Đang tải trang tiếp theo. Cursor: ${cursorData['mainCursor']}');
        final params = state.filterSortParams.copyWith(
          lastCursor: cursorData['mainCursor'],
          lastDateCursorForTieBreak: cursorData['dateCursor'],
          limit: _pageSize,
        );
        fetchResult = _postFetcher(filterSortParams: params, pageSize: _pageSize);
      }
    }

    // Logic xử lý kết quả không đổi, nhưng cần đảm bảo `isFallback` được giữ lại.
    final result = await fetchResult;
    result.fold(
      (failure) {
        _log.severe('❌ Lỗi khi tải bài viết: $failure');
        // Giữ lại isFallback flag nếu có lỗi xảy ra trong quá trình fallback
        emit(state.copyWith(status: PostStatus.failure, failure: failure, isFallback: state.isFallback));
      },
      (newPosts) {
        // Chỉ kích hoạt fallback nếu đang ở chế độ gốc và không có kết quả
        if (!state.isFallback && _isRecommendationFeed && state.posts.isEmpty && newPosts.isEmpty) {
          _log.warning('⚠️ Không tìm thấy gợi ý cho người dùng. Kích hoạt cơ chế Fallback...');
          add(const PostEvent.fallbackToTrendingFeedRequested());
          return;
        }

        final isLastPage = newPosts.length < _pageSize;
        _log.info('✅ Tải được ${newPosts.length} bài viết. isLastPage: $isLastPage');
        emit(state.copyWith(
          status: PostStatus.success,
          posts: List.of(state.posts)..addAll(newPosts),
          hasNextPage: !isLastPage,
          // SỬA ĐỔI 4: Luôn giữ lại cờ isFallback.
          // Nếu nó là true, nó sẽ vẫn là true. Nếu là false, nó vẫn là false.
          isFallback: state.isFallback,
        ));
      },
    );
  }

  Future<void> _onRefreshRequested(
    _RefreshRequested event,
    Emitter<PostState> emit,
  ) async {
    _log.info('🔄 Yêu cầu làm mới...');
    // Khi refresh, reset state về ban đầu, nhưng giữ lại bộ lọc hiện tại.
    // Cờ isFallback cũng được reset về false.
    emit(PostState(filterSortParams: state.filterSortParams));
    add(const PostEvent.fetchNextPageRequested());
  }

  Future<void> _onFiltersChanged(
    _FiltersChanged event,
    Emitter<PostState> emit,
  ) async {
    if (_isRecommendationFeed) {
      _log.warning("⚠️ Bỏ qua sự kiện FiltersChanged vì đây là feed gợi ý.");
      return;
    }
    _log.info('🔄 Bộ lọc thay đổi. Đang làm mới với bộ lọc mới...');
    emit(PostState(filterSortParams: event.newFilters));
    add(const PostEvent.fetchNextPageRequested());
  }

  Future<void> _onFallbackToTrendingFeedRequested(
    _FallbackToTrendingFeedRequested event,
    Emitter<PostState> emit,
  ) async {
    // Ngăn chặn việc gọi fallback nhiều lần nếu state đã là fallback rồi
    if (state.isFallback) return;

    _log.info('⚡️ Thực thi logic fallback: Tải feed thịnh hành...');

    // Đánh dấu là đang loading và đang ở chế độ fallback
    emit(state.copyWith(status: PostStatus.loading, isFallback: true));

    // Trang đầu tiên của feed thịnh hành
    const pageToFetch = 1;

    final result = await _postRepository.getTrendingPosts(
      page: pageToFetch,
      pageSize: _pageSize,
    );

    result.fold(
      (failure) {
        _log.severe('❌ Lỗi ngay cả khi fallback: $failure');
        emit(state.copyWith(status: PostStatus.failure, failure: failure, isFallback: true));
      },
      (newPosts) {
        final isLastPage = newPosts.length < _pageSize;
        _log.info('✅ Tải được ${newPosts.length} bài viết fallback. isLastPage: $isLastPage');

        emit(state.copyWith(
          status: PostStatus.success,
          // QUAN TRỌNG: Ghi đè danh sách bài viết bằng kết quả fallback, không phải nối thêm.
          posts: newPosts,
          hasNextPage: !isLastPage,
          isFallback: true,
        ));
      },
    );
  }
}
