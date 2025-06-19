import 'package:bloc/bloc.dart';
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

@injectable
class PostBloc extends Bloc<PostEvent, PagingState<DateTime?, Post>> {
  final _log = Logger('PostBloc');
  final PostRepository _postRepository;
  final AddressRepository _addressRepository;

  PostBloc(this._postRepository, this._addressRepository) : super(PagingState()) {
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

      // ✅ Tách fold ra ngoài
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

      // 🔁 Tính khoảng cách
      final postsWithDistance = await Future.wait(newPosts.map((post) async {
        final eitherDistance = await _addressRepository.calculateDistance(
          post.address?.latitude ?? 0,
          post.address?.longitude ?? 0,
        );

        final distance = eitherDistance.fold(
          (failure) {
            _log.warning('❗ Không tính được khoảng cách cho post ${post.postId}');
            return null;
          },
          (value) => value,
        );

        return post.copyWith(distance: distance);
      }));

      _log.info('✅ Tải được ${postsWithDistance.length} bài viết. isLastPage=$isLastPage');

      emit(state.copyWith(
        pages: [...?state.pages, postsWithDistance],
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
