// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post_review_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_PostReviewEntity _$PostReviewEntityFromJson(Map<String, dynamic> json) =>
    _PostReviewEntity(
      id: json['id'] as String,
      postId: json['post_id'] as String,
      category:
          const ReviewCategoryConverter().fromJson(json['category'] as String),
      rating: (json['rating'] as num).toInt(),
      selectedChoices: json['selected_choices'] == null
          ? const []
          : const ReviewChoiceListConverter()
              .fromJson(json['selected_choices'] as List),
      createdAt:
          const DateTimeConverter().fromJson(json['created_at'] as String),
    );

Map<String, dynamic> _$PostReviewEntityToJson(_PostReviewEntity instance) =>
    <String, dynamic>{
      'id': instance.id,
      'post_id': instance.postId,
      'category': const ReviewCategoryConverter().toJson(instance.category),
      'rating': instance.rating,
      'selected_choices':
          const ReviewChoiceListConverter().toJson(instance.selectedChoices),
      'created_at': const DateTimeConverter().toJson(instance.createdAt),
    };
