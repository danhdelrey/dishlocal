import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:dishlocal/data/categories/address/repository/interface/address_repository.dart';
import 'package:dishlocal/data/categories/post/model/post.dart';
import 'package:dishlocal/data/categories/post/repository/interface/post_repository.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:injectable/injectable.dart';
import 'package:logging/logging.dart';

import '../../../../data/categories/post/failure/post_failure.dart' as post_failure;

part 'post_event.dart';
part 'post_bloc.freezed.dart';

/// Định nghĩa một kiểu hàm chung cho việc lấy một trang bài viết.
/// Bất kỳ hàm nào có chữ ký này đều có thể được sử dụng bởi PostBloc.
typedef PostFetcher = Future<Either<post_failure.PostFailure, List<Post>>> Function({
  required int limit,
  DateTime? startAfter,
});

class PostBloc extends Bloc<PostEvent, PagingState<DateTime?, Post>> {
  final _log = Logger('PostBloc');
  // THAY ĐỔI 1: Thay vì PostRepository, chúng ta dùng PostFetcher
  final PostFetcher _postFetcher;

  // THAY ĐỔI 2: Constructor giờ nhận vào một hàm fetcher
  PostBloc(this._postFetcher) : super(PagingState()) {
    on<_FetchNextPostPageRequested>((event, emit) async {
      if (state.isLoading || !state.hasNextPage) {
        _log.warning('⚠️ Bỏ qua fetch: isLoading=${state.isLoading}, hasNextPage=${state.hasNextPage}');
        return;
      }

      emit(state.copyWith(isLoading: true));

      final lastPost = state.pages?.lastOrNull?.last;
      // Khóa phân trang có thể là createdAt cho getPosts, hoặc savedAt cho getSavedPosts.
      // Cả hai đều là DateTime.
      final pageKey = lastPost?.createdAt;

      _log.info('📥 Đang tải bài viết (startAfter: $pageKey)...');

      // THAY ĐỔI 3: Gọi hàm fetcher chung thay vì một hàm cụ thể
      final result = await _postFetcher(limit: 10, startAfter: pageKey);

      // Toàn bộ logic bên dưới giữ nguyên, không cần thay đổi gì cả!
      if (result.isLeft()) {
        final failure = result.swap().getOrElse(() => const post_failure.UnknownFailure());
        _log.severe('❌ Lỗi khi tải bài viết: $failure');
        emit(state.copyWith(
          error: failure,
          isLoading: false,
        ));
        return;
      }

      final newPosts = result.getOrElse(() => []);
      final isLastPage = newPosts.isEmpty;

      _log.info('✅ Tải được ${newPosts.length} bài viết. isLastPage=$isLastPage');

      // Lưu ý: Đối với bài viết đã lưu, bạn có thể muốn sử dụng `savedAt` làm pageKey.
      // Nếu `createdAt` vẫn hoạt động tốt thì không cần thay đổi.
      // Nếu không, bạn cần một cách để quyết định dùng field nào.
      // Tạm thời chúng ta vẫn dùng createdAt.
      emit(state.copyWith(
        pages: [...?state.pages, newPosts],
        keys: [...?state.keys, pageKey],
        hasNextPage: !isLastPage,
        isLoading: false,
      ));
    });

    on<_RefreshRequested>((event, emit) async {
      emit(PagingState()); // reset toàn bộ state
      add(const PostEvent.fetchNextPostPageRequested()); // fetch lại từ đầu
    });
  }
}
