import 'package:dishlocal/data/categories/address/model/address.dart';
import 'package:json_annotation/json_annotation.dart';
part 'post.g.dart';

@JsonSerializable()
class Post {
  final String postId;

  final String imageUrl;
  final String dishName;
  final Address address;
  final int price;

  Post({
    required this.postId,
    required this.address,
    required this.dishName,
    required this.imageUrl,
    required this.price,
  });


  factory Post.fromJson(Map<String, dynamic> json) => _$PostFromJson(json);
  Map<String, dynamic> toJson() => _$PostToJson(this);

}
