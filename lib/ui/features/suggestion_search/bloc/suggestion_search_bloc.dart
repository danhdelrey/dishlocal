import 'package:bloc/bloc.dart';
import 'package:dishlocal/data/categories/app_user/model/app_user.dart';
import 'package:dishlocal/data/categories/app_user/repository/interface/app_user_repository.dart';
import 'package:dishlocal/data/categories/post/model/post.dart';
import 'package:dishlocal/data/categories/post/repository/interface/post_repository.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:logging/logging.dart';
import 'package:rxdart/rxdart.dart';

part 'suggestion_search_event.dart';
part 'suggestion_search_state.dart';
part 'suggestion_search_bloc.freezed.dart';

// Transformer để debounce
EventTransformer<E> debounce<E>(Duration duration) {
  return (events, mapper) => events.debounceTime(duration).switchMap(mapper);
}

@injectable
class SuggestionSearchBloc extends Bloc<SuggestionSearchEvent, SuggestionSearchState> {
  final _log = Logger('SuggestionSearchBloc');
  final PostRepository _postRepository;
  final AppUserRepository _appUserRepository;

  SuggestionSearchBloc(this._postRepository, this._appUserRepository) : super(const SuggestionSearchState()) {
    on<_QueryChanged>(
      _onQueryChanged,
      transformer: debounce(const Duration(milliseconds: 400)),
    );
  }

  Future<void> _onQueryChanged(_QueryChanged event, Emitter<SuggestionSearchState> emit) async {
    final query = event.query.trim();

    if (query.isEmpty) {
      emit(const SuggestionSearchState()); // Reset về initial
      return;
    }

    emit(const SuggestionSearchState(status: SuggestionStatus.loading));
    _log.info('🔍 Đang tìm kiếm gợi ý cho: "$query"');

    try {
      // Gọi song song để lấy gợi ý
      final postResultsFuture = _postRepository.searchPosts(query: query, hitsPerPage: 5, page: 0);
      final profileResultsFuture = _appUserRepository.searchProfiles(query: query, hitsPerPage: 3, page: 0);
      final results = await Future.wait([postResultsFuture, profileResultsFuture]);

      final postSuggestions = results[0].getOrElse(() => []) as List<Post>;
      final profileSuggestions = results[1].getOrElse(() => []) as List<AppUser>;

      final allSuggestions = [...postSuggestions, ...profileSuggestions];

      if (allSuggestions.isEmpty) {
        emit(const SuggestionSearchState(status: SuggestionStatus.empty));
      } else {
        emit(SuggestionSearchState(status: SuggestionStatus.success, suggestions: allSuggestions));
      }
    } catch (e) {
      emit(SuggestionSearchState(status: SuggestionStatus.failure, failure: e));
    }
  }
}
