import 'package:bloc/bloc.dart';
import 'package:dishlocal/data/categories/app_user/model/app_user.dart';
import 'package:dishlocal/data/categories/app_user/repository/interface/app_user_repository.dart';
import 'package:dishlocal/data/categories/post/model/post.dart';
import 'package:dishlocal/data/categories/post/repository/interface/post_repository.dart';
import 'package:dishlocal/data/services/search_service/interface/search_service.dart';
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
  // THÊM MỚI: Inject SearchService
  final SearchService _searchService;

  SuggestionSearchBloc(this._searchService) // <-- Sửa constructor
      : super(const SuggestionSearchState()) {
    on<_QueryChanged>(_onQueryChanged, transformer: debounce(const Duration(milliseconds: 400)));
  }

  Future<void> _onQueryChanged(_QueryChanged event, Emitter<SuggestionSearchState> emit) async {
    final query = event.query.trim();
    _log.info('➡️ [BLoC] Nhận event QueryChanged: "$query"'); // LOG KHI NHẬN EVENT

    if (query.isEmpty) {
      _log.info('⬅️ [BLoC] Query rỗng, emit initial state.');
      emit(const SuggestionSearchState());
      return;
    }

    emit(const SuggestionSearchState(status: SuggestionStatus.loading));
    _log.info('⏳ [BLoC] Emit state LOADING.');

    try {
      final result = await _searchService.getSuggestions(query: query);

      // LOG KẾT QUẢ TỪ SERVICE TRƯỚC KHI EMIT
      _log.info('💡 [BLoC] Nhận được ${result.suggestions.length} gợi ý từ Service.');

      if (result.suggestions.isEmpty) {
        emit(const SuggestionSearchState(status: SuggestionStatus.empty));
        _log.info('⬅️ [BLoC] Emit state EMPTY.');
      } else {
        emit(SuggestionSearchState(
          status: SuggestionStatus.success,
          suggestions: result.suggestions,
        ));
        _log.info('⬅️ [BLoC] Emit state SUCCESS.');
      }
    } catch (e) {
      _log.severe('❌ [BLoC] Lỗi khi xử lý _onQueryChanged', e);
      emit(const SuggestionSearchState(status: SuggestionStatus.failure));
    }
  }
}
