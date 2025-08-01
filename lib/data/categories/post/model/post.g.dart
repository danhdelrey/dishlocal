// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Post _$PostFromJson(Map<String, dynamic> json) => _Post(
      postId: json['postId'] as String,
      authorUserId: json['authorUserId'] as String,
      authorUsername: json['authorUsername'] as String,
      authorAvatarUrl: json['authorAvatarUrl'] as String?,
      imageUrl: json['imageUrl'] as String?,
      blurHash: json['blurHash'] as String?,
      dishName: json['dishName'] as String?,
      diningLocationName: json['diningLocationName'] as String?,
      address: json['address'] == null
          ? null
          : Address.fromJson(json['address'] as Map<String, dynamic>),
      distance: (json['distance'] as num?)?.toDouble(),
      price: (json['price'] as num?)?.toInt(),
      insight: json['insight'] as String?,
      createdAt: DateTime.parse(json['createdAt'] as String),
      likeCount: (json['likeCount'] as num).toInt(),
      saveCount: (json['saveCount'] as num).toInt(),
      isLiked: json['isLiked'] as bool,
      isSaved: json['isSaved'] as bool,
      commentCount: (json['commentCount'] as num).toInt(),
      foodCategory: const FoodCategoryConverter()
          .fromJson(json['foodCategory'] as String?),
      reviews: (json['reviews'] as List<dynamic>?)
              ?.map((e) => ReviewItem.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      score: (json['score'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$PostToJson(_Post instance) => <String, dynamic>{
      'postId': instance.postId,
      'authorUserId': instance.authorUserId,
      'authorUsername': instance.authorUsername,
      'authorAvatarUrl': instance.authorAvatarUrl,
      'imageUrl': instance.imageUrl,
      'blurHash': instance.blurHash,
      'dishName': instance.dishName,
      'diningLocationName': instance.diningLocationName,
      'address': instance.address?.toJson(),
      'distance': instance.distance,
      'price': instance.price,
      'insight': instance.insight,
      'createdAt': instance.createdAt.toIso8601String(),
      'likeCount': instance.likeCount,
      'saveCount': instance.saveCount,
      'isLiked': instance.isLiked,
      'isSaved': instance.isSaved,
      'commentCount': instance.commentCount,
      'foodCategory':
          const FoodCategoryConverter().toJson(instance.foodCategory),
      'reviews': instance.reviews.map((e) => e.toJson()).toList(),
      'score': instance.score,
    };
