// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'review_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ReviewItem _$ReviewItemFromJson(Map<String, dynamic> json) => _ReviewItem(
      category: $enumDecode(_$ReviewCategoryEnumMap, json['category']),
      rating: (json['rating'] as num?)?.toInt() ?? 0,
      selectedChoices: (json['selectedChoices'] as List<dynamic>?)
              ?.map((e) => $enumDecode(_$ReviewChoiceEnumMap, e))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$ReviewItemToJson(_ReviewItem instance) =>
    <String, dynamic>{
      'category': _$ReviewCategoryEnumMap[instance.category]!,
      'rating': instance.rating,
      'selectedChoices': instance.selectedChoices
          .map((e) => _$ReviewChoiceEnumMap[e]!)
          .toList(),
    };

const _$ReviewCategoryEnumMap = {
  ReviewCategory.food: 'food',
  ReviewCategory.ambiance: 'ambiance',
  ReviewCategory.price: 'price',
  ReviewCategory.service: 'service',
};

const _$ReviewChoiceEnumMap = {
  ReviewChoice.foodDelicious: 'foodDelicious',
  ReviewChoice.foodGood: 'foodGood',
  ReviewChoice.foodAverage: 'foodAverage',
  ReviewChoice.foodSalty: 'foodSalty',
  ReviewChoice.foodBland: 'foodBland',
  ReviewChoice.foodBad: 'foodBad',
  ReviewChoice.ambianceSpacious: 'ambianceSpacious',
  ReviewChoice.ambianceCozy: 'ambianceCozy',
  ReviewChoice.ambianceBeautiful: 'ambianceBeautiful',
  ReviewChoice.ambianceCramped: 'ambianceCramped',
  ReviewChoice.ambianceNoisy: 'ambianceNoisy',
  ReviewChoice.priceCheap: 'priceCheap',
  ReviewChoice.priceReasonable: 'priceReasonable',
  ReviewChoice.priceExpensive: 'priceExpensive',
  ReviewChoice.priceVeryExpensive: 'priceVeryExpensive',
  ReviewChoice.serviceFast: 'serviceFast',
  ReviewChoice.serviceFriendly: 'serviceFriendly',
  ReviewChoice.serviceProfessional: 'serviceProfessional',
  ReviewChoice.serviceSlow: 'serviceSlow',
  ReviewChoice.serviceBadAttitude: 'serviceBadAttitude',
};
