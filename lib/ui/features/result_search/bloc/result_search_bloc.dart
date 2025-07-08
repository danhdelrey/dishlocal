import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:dishlocal/data/categories/app_user/repository/interface/app_user_repository.dart';
import 'package:dishlocal/data/categories/post/repository/interface/post_repository.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:logging/logging.dart';

part 'result_search_event.dart';
part 'result_search_state.dart';
part 'result_search_bloc.freezed.dart';

@injectable
class ResultSearchBloc extends Bloc<ResultSearchEvent, ResultSearchState> {
  final _log = Logger('ResultSearchBloc');
  final PostRepository _postRepository;
  final AppUserRepository _appUserRepository;
  static const int _hitsPerPage = 15;

  ResultSearchBloc(this._postRepository, this._appUserRepository) : super(const ResultSearchState()) {
    on<_SearchStarted>(_onSearchStarted);
    on<_NextPageRequested>(_onNextPageRequested, transformer: droppable());
    on<_SearchTypeChanged>(_onSearchTypeChanged);
  }

  Future<void> _onSearchStarted(_SearchStarted event, Emitter<ResultSearchState> emit) async {
    emit(state.copyWith(query: event.query));
    add(const ResultSearchEvent.nextPageRequested());
  }

  Future<void> _onSearchTypeChanged(_SearchTypeChanged event, Emitter<ResultSearchState> emit) async {
    if (state.searchType == event.searchType) return;
    emit(ResultSearchState(query: state.query, searchType: event.searchType));
    add(const ResultSearchEvent.nextPageRequested());
  }

  Future<void> _onNextPageRequested(_NextPageRequested event, Emitter<ResultSearchState> emit) async {
    if (state.query.isEmpty || state.status == SearchStatus.loading || !state.hasNextPage) return;
    emit(state.copyWith(status: SearchStatus.loading));
    _log.info('📥 Đang tải trang ${state.currentPage} cho "${state.query}" (Loại: ${state.searchType})');

    try {
      List<dynamic> newItems;
      if (state.searchType == SearchType.posts) {
        final result = await _postRepository.searchPosts(
          query: state.query,
          page: state.currentPage,
          hitsPerPage: _hitsPerPage,
        );
        newItems = result.getOrElse(() => []);
      } else {
        final result = await _appUserRepository.searchProfiles(
          query: state.query,
          page: state.currentPage,
          hitsPerPage: _hitsPerPage,
        );
        final currentUserId = _appUserRepository.getCurrentUserId();
        newItems = result.getOrElse(() => []).where((user) => user.userId != currentUserId).toList();
      }

      final isLastPage = newItems.length < _hitsPerPage;
      if (state.currentPage == 0 && newItems.isEmpty) {
        emit(state.copyWith(status: SearchStatus.empty));
      } else {
        emit(state.copyWith(
          status: SearchStatus.success,
          results: List.of(state.results)..addAll(newItems),
          currentPage: state.currentPage + 1,
          hasNextPage: !isLastPage,
        ));
      }
    } catch (e) {
      emit(state.copyWith(status: SearchStatus.failure, failure: e));
    }
  }
}
