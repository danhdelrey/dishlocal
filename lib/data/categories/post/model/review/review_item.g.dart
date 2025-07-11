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
  ReviewChoice.foodFlavorful: 'foodFlavorful',
  ReviewChoice.foodFreshIngredients: 'foodFreshIngredients',
  ReviewChoice.foodBeautifulPresentation: 'foodBeautifulPresentation',
  ReviewChoice.foodGenerousPortion: 'foodGenerousPortion',
  ReviewChoice.foodUnique: 'foodUnique',
  ReviewChoice.foodBland: 'foodBland',
  ReviewChoice.foodSalty: 'foodSalty',
  ReviewChoice.foodOily: 'foodOily',
  ReviewChoice.foodTooSpicy: 'foodTooSpicy',
  ReviewChoice.foodTooSweet: 'foodTooSweet',
  ReviewChoice.foodSmallPortion: 'foodSmallPortion',
  ReviewChoice.foodNotFresh: 'foodNotFresh',
  ReviewChoice.foodServedCold: 'foodServedCold',
  ReviewChoice.ambianceSpacious: 'ambianceSpacious',
  ReviewChoice.ambianceClean: 'ambianceClean',
  ReviewChoice.ambianceBeautifulDecor: 'ambianceBeautifulDecor',
  ReviewChoice.ambianceGreatView: 'ambianceGreatView',
  ReviewChoice.ambianceCozy: 'ambianceCozy',
  ReviewChoice.ambiancePrivate: 'ambiancePrivate',
  ReviewChoice.ambianceGoodMusic: 'ambianceGoodMusic',
  ReviewChoice.ambianceEasyParking: 'ambianceEasyParking',
  ReviewChoice.ambianceAirConditioned: 'ambianceAirConditioned',
  ReviewChoice.ambianceCramped: 'ambianceCramped',
  ReviewChoice.ambianceNoisy: 'ambianceNoisy',
  ReviewChoice.ambianceNotClean: 'ambianceNotClean',
  ReviewChoice.ambianceHot: 'ambianceHot',
  ReviewChoice.ambianceHardToPark: 'ambianceHardToPark',
  ReviewChoice.ambianceBadSmell: 'ambianceBadSmell',
  ReviewChoice.priceValueForMoney: 'priceValueForMoney',
  ReviewChoice.priceAffordable: 'priceAffordable',
  ReviewChoice.priceSlightlyHigh: 'priceSlightlyHigh',
  ReviewChoice.priceExpensive: 'priceExpensive',
  ReviewChoice.priceHasPromotion: 'priceHasPromotion',
  ReviewChoice.priceHiddenFees: 'priceHiddenFees',
  ReviewChoice.priceClearMenu: 'priceClearMenu',
  ReviewChoice.serviceEnthusiastic: 'serviceEnthusiastic',
  ReviewChoice.serviceFast: 'serviceFast',
  ReviewChoice.serviceAttentive: 'serviceAttentive',
  ReviewChoice.serviceProfessional: 'serviceProfessional',
  ReviewChoice.serviceEasyBooking: 'serviceEasyBooking',
  ReviewChoice.serviceSlow: 'serviceSlow',
  ReviewChoice.serviceIndifferent: 'serviceIndifferent',
  ReviewChoice.serviceBadAttitude: 'serviceBadAttitude',
  ReviewChoice.serviceOrderMistake: 'serviceOrderMistake',
  ReviewChoice.serviceHardToBook: 'serviceHardToBook',
};
