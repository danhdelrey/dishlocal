// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'openai_moderation_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ModerationResponse _$ModerationResponseFromJson(Map<String, dynamic> json) =>
    _ModerationResponse(
      id: json['id'] as String,
      model: json['model'] as String,
      results: (json['results'] as List<dynamic>)
          .map((e) => ModerationResult.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ModerationResponseToJson(_ModerationResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'model': instance.model,
      'results': instance.results,
    };

_ModerationResult _$ModerationResultFromJson(Map<String, dynamic> json) =>
    _ModerationResult(
      flagged: json['flagged'] as bool,
      categories:
          Categories.fromJson(json['categories'] as Map<String, dynamic>),
      categoryScores: CategoryScores.fromJson(
          json['category_scores'] as Map<String, dynamic>),
      categoryAppliedInputTypes: CategoryAppliedInputTypes.fromJson(
          json['category_applied_input_types'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ModerationResultToJson(_ModerationResult instance) =>
    <String, dynamic>{
      'flagged': instance.flagged,
      'categories': instance.categories,
      'category_scores': instance.categoryScores,
      'category_applied_input_types': instance.categoryAppliedInputTypes,
    };

_Categories _$CategoriesFromJson(Map<String, dynamic> json) => _Categories(
      sexual: json['sexual'] as bool,
      sexualMinors: json['sexual/minors'] as bool,
      harassment: json['harassment'] as bool,
      harassmentThreatening: json['harassment/threatening'] as bool,
      hate: json['hate'] as bool,
      hateThreatening: json['hate/threatening'] as bool,
      illicit: json['illicit'] as bool,
      illicitViolent: json['illicit/violent'] as bool,
      selfHarm: json['self-harm'] as bool,
      selfHarmIntent: json['self-harm/intent'] as bool,
      selfHarmInstructions: json['self-harm/instructions'] as bool,
      violence: json['violence'] as bool,
      violenceGraphic: json['violence/graphic'] as bool,
    );

Map<String, dynamic> _$CategoriesToJson(_Categories instance) =>
    <String, dynamic>{
      'sexual': instance.sexual,
      'sexual/minors': instance.sexualMinors,
      'harassment': instance.harassment,
      'harassment/threatening': instance.harassmentThreatening,
      'hate': instance.hate,
      'hate/threatening': instance.hateThreatening,
      'illicit': instance.illicit,
      'illicit/violent': instance.illicitViolent,
      'self-harm': instance.selfHarm,
      'self-harm/intent': instance.selfHarmIntent,
      'self-harm/instructions': instance.selfHarmInstructions,
      'violence': instance.violence,
      'violence/graphic': instance.violenceGraphic,
    };

_CategoryScores _$CategoryScoresFromJson(Map<String, dynamic> json) =>
    _CategoryScores();

Map<String, dynamic> _$CategoryScoresToJson(_CategoryScores instance) =>
    <String, dynamic>{};

_CategoryAppliedInputTypes _$CategoryAppliedInputTypesFromJson(
        Map<String, dynamic> json) =>
    _CategoryAppliedInputTypes();

Map<String, dynamic> _$CategoryAppliedInputTypesToJson(
        _CategoryAppliedInputTypes instance) =>
    <String, dynamic>{};
