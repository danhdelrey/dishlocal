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
class PostBloc extends Bloc<PostEvent, PagingState> {
  final _log = Logger('PostBloc');
  final PostRepository _postRepository;
  PostBloc(this._postRepository) : super(PagingState()) {
    on<_FetchNextPostPageRequested>((event, emit) async {
      if (state.isLoading) return;

      emit(state.copyWith(isLoading: true, error: null));

      try {
        // Lấy khóa mới: createdAt của post cuối cùng trong page cuối
        final lastPost = state.pages?.lastOrNull?.last as Post?;
        final newKey = lastPost?.createdAt;

        final result = await _postRepository.getPosts(limit: 10, startAfter: newKey);

        result.fold(
          (failure) {
            emit(state.copyWith(
              error: failure,
              isLoading: false,
            ));
          },
          (newPosts) {
            final isLastPage = newPosts.isEmpty;

            emit(state.copyWith(
              pages: [...?state.pages, newPosts],
              hasNextPage: !isLastPage,
              isLoading: false,
            ));
          },
        );
      } catch (error) {
        emit(state.copyWith(
          error: error,
          isLoading: false,
        ));
      }
    });
  }
}
