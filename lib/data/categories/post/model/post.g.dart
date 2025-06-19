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
      createdAt:
          const TimestampConverter().fromJson(json['createdAt'] as Timestamp),
      likeCount: (json['likeCount'] as num).toInt(),
      saveCount: (json['saveCount'] as num).toInt(),
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
      'createdAt': const TimestampConverter().toJson(instance.createdAt),
      'likeCount': instance.likeCount,
      'saveCount': instance.saveCount,
    };
