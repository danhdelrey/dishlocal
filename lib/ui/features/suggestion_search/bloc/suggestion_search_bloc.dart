import 'package:bloc/bloc.dart';
import 'package:dishlocal/data/categories/app_user/model/app_user.dart';
import 'package:dishlocal/data/categories/app_user/repository/interface/app_user_repository.dart';
import 'package:dishlocal/data/categories/post/model/post.dart';
import 'package:dishlocal/data/categories/post/repository/interface/post_repository.dart';
import 'package:dishlocal/data/services/search_service/interface/search_service.dart';
import 'package:dishlocal/data/services/search_service/model/suggestion_result.dart';
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
  final SearchService _searchService;

  SuggestionSearchBloc(this._searchService) : super(const SuggestionSearchState()) {
    on<_QueryChanged>(_onQueryChanged, transformer: debounce(const Duration(milliseconds: 400)));
  }

  Future<void> _onQueryChanged(_QueryChanged event, Emitter<SuggestionSearchState> emit) async {
    final query = event.query.trim();

    if (query.isEmpty) {
      emit(const SuggestionSearchState());
      return;
    }

    emit(const SuggestionSearchState(status: SuggestionStatus.loading));
    _log.info('🔍 Đang tìm kiếm gợi ý cho: "$query"');

    try {
      // Gọi song song để lấy gợi ý từ cả hai index
      final postSuggestionsFuture = _searchService.getSuggestions(
        query: query,
        searchType: SearchableItem.posts,
        hitsPerPage: 5,
      );
      final profileSuggestionsFuture = _searchService.getSuggestions(
        query: query,
        searchType: SearchableItem.profiles,
        hitsPerPage: 3,
      );
      final results = await Future.wait([postSuggestionsFuture, profileSuggestionsFuture]);

      final allSuggestions = [...results[0].suggestions, ...results[1].suggestions];

      if (allSuggestions.isEmpty) {
        emit(const SuggestionSearchState(status: SuggestionStatus.empty));
      } else {
        // State giờ đây sẽ chứa List<Suggestion> thay vì List<dynamic>
        emit(SuggestionSearchState(status: SuggestionStatus.success, suggestions: allSuggestions));
      }
    } catch (e) {
      emit(SuggestionSearchState(status: SuggestionStatus.failure, failure: e));
    }
  }
}
