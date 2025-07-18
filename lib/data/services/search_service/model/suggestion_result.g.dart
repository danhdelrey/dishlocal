// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'suggestion_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_SuggestionResult _$SuggestionResultFromJson(Map<String, dynamic> json) =>
    _SuggestionResult(
      suggestions: (json['suggestions'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
    );

Map<String, dynamic> _$SuggestionResultToJson(_SuggestionResult instance) =>
    <String, dynamic>{
      'suggestions': instance.suggestions,
    };
