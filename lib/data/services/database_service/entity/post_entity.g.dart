// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_PostEntity _$PostEntityFromJson(Map<String, dynamic> json) => _PostEntity(
      id: json['id'] as String,
      authorId: json['author_id'] as String,
      imageUrl: json['image_url'] as String?,
      blurHash: json['blur_hash'] as String?,
      dishName: json['dish_name'] as String?,
      locationName: json['location_name'] as String?,
      locationAddress: json['location_address'] as String?,
      latitude: (json['latitude'] as num?)?.toDouble(),
      longitude: (json['longitude'] as num?)?.toDouble(),
      price: (json['price'] as num?)?.toInt(),
      insight: json['insight'] as String?,
      likeCount: (json['like_count'] as num?)?.toInt() ?? 0,
      saveCount: (json['save_count'] as num?)?.toInt() ?? 0,
      commentCount: (json['comment_count'] as num?)?.toInt() ?? 0,
      foodCategory: const FoodCategoryConverter()
          .fromJson(json['food_category'] as String?),
      reviews: (json['reviews'] as List<dynamic>?)
              ?.map((e) => PostReviewEntity.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      createdAt: const DateTimeConverter().fromJson(json['created_at']),
    );

Map<String, dynamic> _$PostEntityToJson(_PostEntity instance) =>
    <String, dynamic>{
      'id': instance.id,
      'author_id': instance.authorId,
      'image_url': instance.imageUrl,
      'blur_hash': instance.blurHash,
      'dish_name': instance.dishName,
      'location_name': instance.locationName,
      'location_address': instance.locationAddress,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'price': instance.price,
      'insight': instance.insight,
      'like_count': instance.likeCount,
      'save_count': instance.saveCount,
      'comment_count': instance.commentCount,
      'food_category':
          const FoodCategoryConverter().toJson(instance.foodCategory),
    };
