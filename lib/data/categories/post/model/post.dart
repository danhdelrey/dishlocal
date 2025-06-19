import 'package:dishlocal/core/json_converter/timestamp_converter.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:dishlocal/data/categories/address/model/address.dart';
import 'package:dishlocal/core/json_converter/date_time_converter.dart';

part 'post.freezed.dart';
part 'post.g.dart';

@freezed
abstract class Post with _$Post {
  const factory Post({
    required String postId,
    required String authorUserId,
    required String authorUsername,
    String? authorAvatarUrl,
    String? imageUrl,
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
