import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:dishlocal/data/categories/app_user/model/app_user.dart';
import 'package:dishlocal/data/categories/app_user/repository/interface/app_user_repository.dart';
import 'package:dishlocal/data/categories/post/model/post.dart';
import 'package:dishlocal/data/categories/post/repository/interface/post_repository.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:logging/logging.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';

part 'search_event.dart';
part 'search_state.dart';
part 'search_bloc.freezed.dart';

@injectable
class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final _log = Logger('SearchBloc');
  final AppUserRepository _appUserRepository;
  final PostRepository _postRepository;
  static const int _hitsPerPage = 15; // Số item mỗi trang

  SearchBloc(this._appUserRepository, this._postRepository) : super(SearchState.initial()) {
    // Sử dụng transformer để tránh spam request khi kéo nhanh
    on<_NextPostPageRequested>(_onNextPostPageRequested, transformer: droppable());
    on<_NextProfilePageRequested>(_onNextProfilePageRequested, transformer: droppable());
    on<_QuerySubmitted>(_onQuerySubmitted);
    on<_Refreshed>(_onRefreshed);
  }

  Future<void> _onQuerySubmitted(_QuerySubmitted event, Emitter<SearchState> emit) async {
    _log.info('🚀 Bắt đầu phiên tìm kiếm mới với query: "${event.query}"');

    // Reset state và hiển thị loading
    emit(SearchState.initial().copyWith(
      query: event.query,
      status: SearchStatus.loading,
    ));

    try {
      // Gọi API cho trang đầu tiên của cả hai tab CÙNG LÚC
      final results = await Future.wait([
        _postRepository.searchPosts(query: event.query, page: 0, hitsPerPage: _hitsPerPage),
        _appUserRepository.searchProfiles(query: event.query, page: 0, hitsPerPage: _hitsPerPage),
      ]);

      final postResult = results[0];
      final profileResult = results[1];

      // Xử lý kết quả và cập nhật state
      postResult.fold(
        (failure) => throw failure, // Ném lỗi để khối catch bên ngoài bắt
        (posts) {
          profileResult.fold(
            (failure) => throw failure,
            (profiles) {
              _log.info('✅ Tìm kiếm ban đầu thành công. Posts: ${posts.length}, Profiles: ${profiles.length}');
              emit(state.copyWith(
                status: SearchStatus.success,
                posts: posts as List<Post>,
                profiles: profiles as List<AppUser>,
                postPage: 1, // Đã tải xong trang 0, trang tiếp theo là 1
                profilePage: 1,
                hasMorePosts: posts.length == _hitsPerPage,
                hasMoreProfiles: profiles.length == _hitsPerPage,
              ));
            },
          );
        },
      );
    } catch (e, st) {
      _log.severe('❌ Lỗi khi thực hiện tìm kiếm ban đầu', e, st);
      emit(state.copyWith(
        status: SearchStatus.failure,
        errorMessage: 'Đã xảy ra lỗi, vui lòng thử lại.',
      ));
    }
  }

  Future<void> _onNextPostPageRequested(_NextPostPageRequested event, Emitter<SearchState> emit) async {
    // Chỉ fetch khi có query, có trang tiếp và không đang loading
    if (state.query.isEmpty || !state.hasMorePosts || state.isLoadingMorePosts) return;

    _log.info('📥 Đang tải trang bài viết tiếp theo (page ${state.postPage})...');
    emit(state.copyWith(isLoadingMorePosts: true));

    final result = await _postRepository.searchPosts(
      query: state.query,
      page: state.postPage,
      hitsPerPage: _hitsPerPage,
    );

    result.fold(
      (failure) {
        _log.severe('❌ Lỗi khi tải thêm bài viết: $failure');
        // Có thể hiển thị lỗi nhỏ trên UI thay vì làm hỏng cả trang
        emit(state.copyWith(isLoadingMorePosts: false));
      },
      (newPosts) {
        _log.info('✅ Tải thêm ${newPosts.length} bài viết thành công.');
        emit(state.copyWith(
          posts: [...state.posts, ...newPosts],
          postPage: state.postPage + 1,
          hasMorePosts: newPosts.length == _hitsPerPage,
          isLoadingMorePosts: false,
        ));
      },
    );
  }

  Future<void> _onNextProfilePageRequested(_NextProfilePageRequested event, Emitter<SearchState> emit) async {
    if (state.query.isEmpty || !state.hasMoreProfiles || state.isLoadingMoreProfiles) return;

    _log.info('📥 Đang tải trang profile tiếp theo (page ${state.profilePage})...');
    emit(state.copyWith(isLoadingMoreProfiles: true));

    final result = await _appUserRepository.searchProfiles(
      query: state.query,
      page: state.profilePage,
      hitsPerPage: _hitsPerPage,
    );

    result.fold(
      (failure) {
        _log.severe('❌ Lỗi khi tải thêm profile: $failure');
        emit(state.copyWith(isLoadingMoreProfiles: false));
      },
      (newProfiles) {
        _log.info('✅ Tải thêm ${newProfiles.length} profile thành công.');
        emit(state.copyWith(
          profiles: [...state.profiles, ...newProfiles],
          profilePage: state.profilePage + 1,
          hasMoreProfiles: newProfiles.length == _hitsPerPage,
          isLoadingMoreProfiles: false,
        ));
      },
    );
  }

  Future<void> _onRefreshed(_Refreshed event, Emitter<SearchState> emit) async {
    // Nếu có query, thực hiện lại tìm kiếm từ đầu
    if (state.query.isNotEmpty) {
      add(SearchEvent.querySubmitted(state.query));
    }
  }
}
