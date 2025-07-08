part of 'suggestion_search_bloc.dart';

@freezed
sealed class SuggestionSearchEvent with _$SuggestionSearchEvent {
  /// Được gọi mỗi khi query trong text field thay đổi.
  const factory SuggestionSearchEvent.queryChanged({required String query}) = _QueryChanged;
}
