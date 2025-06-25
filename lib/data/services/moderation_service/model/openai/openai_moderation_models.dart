import 'package:freezed_annotation/freezed_annotation.dart';

part 'openai_moderation_models.freezed.dart';
part 'openai_moderation_models.g.dart';

@freezed
abstract class ModerationResponse with _$ModerationResponse {
  const factory ModerationResponse({
    required String id,
    required String model,
    required List<ModerationResult> results,
  }) = _ModerationResponse;

  factory ModerationResponse.fromJson(Map<String, dynamic> json) => _$ModerationResponseFromJson(json);
}

@freezed
abstract class ModerationResult with _$ModerationResult {
  const factory ModerationResult({
    required bool flagged,
    required Categories categories,
    @JsonKey(name: 'category_scores') required CategoryScores categoryScores,
    @JsonKey(name: 'category_applied_input_types') required CategoryAppliedInputTypes categoryAppliedInputTypes,
  }) = _ModerationResult;

  factory ModerationResult.fromJson(Map<String, dynamic> json) => _$ModerationResultFromJson(json);
}

@freezed
abstract class Categories with _$Categories {
  const factory Categories({
    required bool sexual,
    @JsonKey(name: 'sexual/minors') required bool sexualMinors,
    required bool harassment,
    @JsonKey(name: 'harassment/threatening') required bool harassmentThreatening,
    required bool hate,
    @JsonKey(name: 'hate/threatening') required bool hateThreatening,
    required bool illicit,
    @JsonKey(name: 'illicit/violent') required bool illicitViolent,
    @JsonKey(name: 'self-harm') required bool selfHarm,
    @JsonKey(name: 'self-harm/intent') required bool selfHarmIntent,
    @JsonKey(name: 'self-harm/instructions') required bool selfHarmInstructions,
    required bool violence,
    @JsonKey(name: 'violence/graphic') required bool violenceGraphic,
  }) = _Categories;

  factory Categories.fromJson(Map<String, dynamic> json) => _$CategoriesFromJson(json);
}

@freezed
abstract class CategoryScores with _$CategoryScores {
  // Chúng ta không cần định nghĩa chi tiết các trường ở đây
  // vì chúng ta chỉ quan tâm đến Categories để xác định lý do.
  // Nếu bạn cần điểm số, bạn có thể thêm các trường double tương tự như Categories.
  const factory CategoryScores() = _CategoryScores;

  factory CategoryScores.fromJson(Map<String, dynamic> json) => const CategoryScores();
}

@freezed
abstract class CategoryAppliedInputTypes with _$CategoryAppliedInputTypes {
  // Tương tự CategoryScores, chúng ta sẽ truy cập động vào map này
  // thay vì định nghĩa từng trường tĩnh.
  const factory CategoryAppliedInputTypes() = _CategoryAppliedInputTypes;

  factory CategoryAppliedInputTypes.fromJson(Map<String, dynamic> json) => const CategoryAppliedInputTypes();
}
