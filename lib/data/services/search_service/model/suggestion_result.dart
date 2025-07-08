import 'package:freezed_annotation/freezed_annotation.dart';

part 'suggestion_result.freezed.dart';

/// Enum để xác định loại của một gợi ý.
enum SuggestionType { post, profile }

/// Một đối tượng duy nhất đại diện cho một gợi ý tìm kiếm.
@freezed
abstract class Suggestion with _$Suggestion {
  const factory Suggestion({
    /// Nội dung văn bản của gợi ý để hiển thị (ví dụ: "Phở Thìn").
    required String displayText,

    /// Loại của gợi ý (để hiển thị icon tương ứng).
    required SuggestionType type,
  }) = _Suggestion;
}

/// Model chứa toàn bộ kết quả của một yêu cầu tìm kiếm gợi ý.
@freezed
abstract class SuggestionResult with _$SuggestionResult {
  const factory SuggestionResult({
    /// Danh sách các đối tượng gợi ý.
    @Default([]) List<Suggestion> suggestions,
  }) = _SuggestionResult;
}
