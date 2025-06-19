import 'package:bloc/bloc.dart';
import 'package:dishlocal/data/categories/post/model/post.dart';
import 'package:dishlocal/data/categories/post/repository/interface/post_repository.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:injectable/injectable.dart';
import 'package:logging/logging.dart';

part 'post_event.dart';
part 'post_state.dart';
part 'post_bloc.freezed.dart';

@injectable
class PostBloc extends Bloc<PostEvent, PostState> {
  final _log = Logger('PostBloc');
  final PostRepository _postRepository;

  PostBloc(this._postRepository) : super(const _Initial()) {
    on<_PageRequested>(_onPageRequested);
  }

  Future<void> _onPageRequested(
    _PageRequested event,
    Emitter<PostState> emit,
  ) async {
    _log.info('🌀 Yêu cầu tải bài viết pageKey: ${event.pageKey}');

    final result = await _postRepository.getPosts(
      limit: 10,
      startAfter: event.pageKey,
    );

    result.fold(
      (failure) {
        _log.warning('❌ Lỗi khi tải bài viết: ${failure.message}');
        emit(PostState.failure(failure.message));
      },
      (_) {
        // Không cần emit gì thêm nếu load thành công (UI sẽ xử lý)
      },
    );
  }
}


