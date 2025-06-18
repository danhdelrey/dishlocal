import 'package:dishlocal/core/json_converter/date_time_converter.dart';
import 'package:dishlocal/data/categories/address/model/address.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
part 'post.g.dart';

@JsonSerializable()
class Post extends Equatable {
  final String postId;
  final String authorUserId;
  final String authorUsername;
  final String authorAvatarUrl;
  final String? imageUrl;
  final String? dishName;
  final String? diningLocationName;
  final Address? address;
  final int? price;
  final String? insight;

  @DateTimeConverter()
  final DateTime createdAt;
  final int likeCount;
  final int saveCount;

  const Post({
    required this.postId,
    required this.authorUserId,
    required this.authorUsername,
    required this.authorAvatarUrl,
    this.imageUrl,
    this.dishName,
    this.diningLocationName,
    this.address,
    this.price,
    this.insight,
    required this.createdAt,
    required this.likeCount,
    required this.saveCount,
  });


  factory Post.fromJson(Map<String, dynamic> json) => _$PostFromJson(json);
  Map<String, dynamic> toJson() => _$PostToJson(this);

  @override
  List<Object?> get props => [
        postId,
        authorUserId,
        authorUsername,
        authorAvatarUrl,
        imageUrl,
        dishName,
        diningLocationName,
        address,
        price,
        insight,
        createdAt,
        likeCount,
        saveCount,
      ];

}
