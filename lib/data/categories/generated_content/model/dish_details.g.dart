// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dish_details.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_DishDetails _$DishDetailsFromJson(Map<String, dynamic> json) => _DishDetails(
      overview: json['overview'] as String,
      mainIngredients: (json['mainIngredients'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      preparation: json['preparation'] as String,
      origin: json['origin'] as String,
      flavorProfile: json['flavorProfile'] as String,
      usage: json['usage'] as String,
    );

Map<String, dynamic> _$DishDetailsToJson(_DishDetails instance) =>
    <String, dynamic>{
      'overview': instance.overview,
      'mainIngredients': instance.mainIngredients,
      'preparation': instance.preparation,
      'origin': instance.origin,
      'flavorProfile': instance.flavorProfile,
      'usage': instance.usage,
    };
