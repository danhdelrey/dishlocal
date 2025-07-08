part of 'suggestion_search_bloc.dart';

// Trạng thái của việc tìm kiếm gợi ý
enum SuggestionStatus { initial, loading, success, failure, empty }

@freezed
sealed class SuggestionSearchState with _$SuggestionSearchState {
  const factory SuggestionSearchState({
    @Default(SuggestionStatus.initial) SuggestionStatus status,
    @Default([]) List<String> suggestions,
    // Lưu lỗi nếu có
    Object? failure,
  }) = _SuggestionSearchState;
}
