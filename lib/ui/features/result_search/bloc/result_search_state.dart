part of 'result_search_bloc.dart';

enum SearchStatus { initial, loading, success, failure, empty }

@freezed
sealed class ResultSearchState with _$ResultSearchState {
  const factory ResultSearchState({
    @Default(SearchStatus.initial) SearchStatus status,
    @Default(SearchType.posts) SearchType searchType,
    @Default('') String query,
    @Default([]) List<dynamic> results,
    @Default(0) int currentPage,
    @Default(true) bool hasNextPage,
    @Default(FilterSortParams()) FilterSortParams filterParams,
    Object? failure,
  }) = _ResultSearchState;
}
