import 'package:freezed_annotation/freezed_annotation.dart';
part 'search_result.freezed.dart';
part 'search_result.g.dart';

@freezed
abstract class SearchResult with _$SearchResult {
  const factory SearchResult({
    int? totalPage,
    int? totalHits,
    int? currentPage,
    @Default([]) List<String> objectIds,

  }) = _SearchResult;

  factory SearchResult.fromJson(Map<String, dynamic> json) =>
      _$SearchResultFromJson(json);
}