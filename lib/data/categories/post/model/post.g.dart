// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Post _$PostFromJson(Map<String, dynamic> json) => Post(
      postId: json['postId'] as String,
      address: Address.fromJson(json['address'] as Map<String, dynamic>),
      dishName: json['dishName'] as String,
      imageUrl: json['imageUrl'] as String,
      price: (json['price'] as num).toInt(),
    );

Map<String, dynamic> _$PostToJson(Post instance) => <String, dynamic>{
      'postId': instance.postId,
      'imageUrl': instance.imageUrl,
      'dishName': instance.dishName,
      'address': instance.address,
      'price': instance.price,
    };
