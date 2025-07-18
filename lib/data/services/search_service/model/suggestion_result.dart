import 'package:freezed_annotation/freezed_annotation.dart';

part 'suggestion_result.freezed.dart';
part 'suggestion_result.g.dart';

@freezed
abstract class SuggestionResult with _$SuggestionResult {
  const factory SuggestionResult({
    @Default([]) List<String> suggestions,
  }) = _SuggestionResult;

  factory SuggestionResult.fromJson(Map<String, dynamic> json) => _$SuggestionResultFromJson(json);
}
