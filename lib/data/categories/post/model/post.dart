import 'package:dishlocal/core/json_converter/date_time_converter.dart';
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
    double? distance,
    int? price,
    String? insight,
    @DateTimeConverter() required DateTime createdAt,
    required int likeCount,
    required int saveCount,
    required bool isLiked,
    required bool isSaved,
    required int commentCount,
  }) = _Post;

  factory Post.fromJson(Map<String, dynamic> json) => _$PostFromJson(json);
}
