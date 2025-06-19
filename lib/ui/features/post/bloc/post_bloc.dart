import 'package:bloc/bloc.dart';
import 'package:dishlocal/data/categories/post/model/post.dart';
import 'package:dishlocal/data/categories/post/repository/interface/post_repository.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:injectable/injectable.dart';
import 'package:logging/logging.dart';

part 'post_event.dart';
part 'post_bloc.freezed.dart';

@injectable
class PostBloc extends Bloc<PostEvent, PagingState<DateTime?, Post>> {
  final _log = Logger('PostBloc');
  final PostRepository _postRepository;

  PostBloc(this._postRepository) : super(PagingState()) {
    on<_FetchNextPostPageRequested>((event, emit) async {
      if (state.isLoading || !state.hasNextPage) {
        _log.warning('⚠️ Bỏ qua fetch: isLoading=${state.isLoading}, hasNextPage=${state.hasNextPage}');
        return;
      }

      emit(state.copyWith(isLoading: true));

      final lastPost = state.pages?.lastOrNull?.last;
      final pageKey = lastPost?.createdAt;

      _log.info('📥 Đang tải bài viết (startAfter: $pageKey)...');

      final result = await _postRepository.getPosts(limit: 10, startAfter: pageKey);

      result.fold(
        (failure) {
          _log.severe('❌ Lỗi khi tải bài viết: $failure');
          emit(state.copyWith(
            error: failure,
            isLoading: false,
          ));
        },
        (newPosts) {
          final isLastPage = newPosts.isEmpty;

          _log.info('✅ Tải được ${newPosts.length} bài viết. isLastPage=$isLastPage');

          emit(state.copyWith(
            pages: [...?state.pages, newPosts],
            keys: [...?state.keys, pageKey], // ✅ quan trọng
            hasNextPage: !isLastPage,
            isLoading: false,
          ));
        },
      );
    });

    on<_RefreshRequested>((event, emit) async {
      emit( PagingState()); // reset toàn bộ state
      add(const PostEvent.fetchNextPostPageRequested()); // fetch lại từ đầu
    });

  }
}

