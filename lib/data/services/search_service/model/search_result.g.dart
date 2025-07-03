// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_SearchResult _$SearchResultFromJson(Map<String, dynamic> json) =>
    _SearchResult(
      totalPage: (json['totalPage'] as num?)?.toInt(),
      totalHits: (json['totalHits'] as num?)?.toInt(),
      currentPage: (json['currentPage'] as num?)?.toInt(),
      objectIds: (json['objectIds'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
    );

Map<String, dynamic> _$SearchResultToJson(_SearchResult instance) =>
    <String, dynamic>{
      'totalPage': instance.totalPage,
      'totalHits': instance.totalHits,
      'currentPage': instance.currentPage,
      'objectIds': instance.objectIds,
    };
