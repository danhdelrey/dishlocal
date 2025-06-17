import 'package:dishlocal/data/categories/address/model/address.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
part 'post.g.dart';

@JsonSerializable()
class Post extends Equatable {
  final String postId;

  final String? imageUrl;
  final String? dishName;
  final Address? address;
  final int? price;

  const Post({
    required this.postId,
     this.address,
     this.dishName,
     this.imageUrl,
     this.price,
  });

  factory Post.fromJson(Map<String, dynamic> json) => _$PostFromJson(json);
  Map<String, dynamic> toJson() => _$PostToJson(this);

  @override
  List<Object?> get props => [
        postId,
        dishName,
        imageUrl,
        address,
        price,
      ];
}
