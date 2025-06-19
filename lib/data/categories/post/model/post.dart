import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dishlocal/core/json_converter/timestamp_converter.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:dishlocal/data/categories/address/model/address.dart';

part 'post.freezed.dart';
part 'post.g.dart';

@freezed
abstract class Post with _$Post {
  @JsonSerializable(explicitToJson: true)
  const factory Post({
    required String postId,
    required String authorUserId,
    required String authorUsername,
    String? authorAvatarUrl,
    String? imageUrl,
    String? blurHash,
    String? dishName,
    String? diningLocationName,
    Address? address,
    int? price,
    String? insight,
    @TimestampConverter() required DateTime createdAt,
    required int likeCount,
    required int saveCount,
  }) = _Post;

  factory Post.fromJson(Map<String, dynamic> json) => _$PostFromJson(json);
}
