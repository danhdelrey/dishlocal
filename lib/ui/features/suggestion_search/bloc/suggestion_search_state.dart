part of 'suggestion_search_bloc.dart';

// Trạng thái của việc tìm kiếm gợi ý
enum SuggestionStatus { initial, loading, success, failure, empty }

@freezed
sealed class SuggestionSearchState with _$SuggestionSearchState {
  const factory SuggestionSearchState({
    @Default(SuggestionStatus.initial) SuggestionStatus status,
    // Danh sách gợi ý, kiểu dynamic để chứa cả Post và AppUser
    @Default([]) List<dynamic> suggestions,
    // Lưu lỗi nếu có
    Object? failure,
  }) = _SuggestionSearchState;
}
