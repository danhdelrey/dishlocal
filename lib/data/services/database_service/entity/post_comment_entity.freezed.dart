// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'post_comment_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$PostCommentEntity {
  /// PK: Primary Key, định danh duy nhất của bình luận.
  String get id;

  /// FK: Foreign Key, tham chiếu đến `posts.id` mà bình luận này thuộc về.
  String get postId;

  /// FK: Foreign Key, tham chiếu đến `profiles.id` của tác giả bình luận.
  String get authorId;

  /// Nội dung của bình luận.
  String get content;

  /// (Denormalized) Số lượt thích trên bình luận này.
  int get likeCount;

  /// (Denormalized) Số lượt trả lời cho bình luận này.
  int get replyCount;

  /// Thời điểm bình luận được tạo.
  @DateTimeConverter()
  DateTime get createdAt;

  /// Create a copy of PostCommentEntity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $PostCommentEntityCopyWith<PostCommentEntity> get copyWith =>
      _$PostCommentEntityCopyWithImpl<PostCommentEntity>(
          this as PostCommentEntity, _$identity);

  /// Serializes this PostCommentEntity to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is PostCommentEntity &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.postId, postId) || other.postId == postId) &&
            (identical(other.authorId, authorId) ||
                other.authorId == authorId) &&
            (identical(other.content, content) || other.content == content) &&
            (identical(other.likeCount, likeCount) ||
                other.likeCount == likeCount) &&
            (identical(other.replyCount, replyCount) ||
                other.replyCount == replyCount) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, postId, authorId, content,
      likeCount, replyCount, createdAt);

  @override
  String toString() {
    return 'PostCommentEntity(id: $id, postId: $postId, authorId: $authorId, content: $content, likeCount: $likeCount, replyCount: $replyCount, createdAt: $createdAt)';
  }
}

/// @nodoc
abstract mixin class $PostCommentEntityCopyWith<$Res> {
  factory $PostCommentEntityCopyWith(
          PostCommentEntity value, $Res Function(PostCommentEntity) _then) =
      _$PostCommentEntityCopyWithImpl;
  @useResult
  $Res call(
      {String id,
      String postId,
      String authorId,
      String content,
      int likeCount,
      int replyCount,
      @DateTimeConverter() DateTime createdAt});
}

/// @nodoc
class _$PostCommentEntityCopyWithImpl<$Res>
    implements $PostCommentEntityCopyWith<$Res> {
  _$PostCommentEntityCopyWithImpl(this._self, this._then);

  final PostCommentEntity _self;
  final $Res Function(PostCommentEntity) _then;

  /// Create a copy of PostCommentEntity
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? postId = null,
    Object? authorId = null,
    Object? content = null,
    Object? likeCount = null,
    Object? replyCount = null,
    Object? createdAt = null,
  }) {
    return _then(_self.copyWith(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      postId: null == postId
          ? _self.postId
          : postId // ignore: cast_nullable_to_non_nullable
              as String,
      authorId: null == authorId
          ? _self.authorId
          : authorId // ignore: cast_nullable_to_non_nullable
              as String,
      content: null == content
          ? _self.content
          : content // ignore: cast_nullable_to_non_nullable
              as String,
      likeCount: null == likeCount
          ? _self.likeCount
          : likeCount // ignore: cast_nullable_to_non_nullable
              as int,
      replyCount: null == replyCount
          ? _self.replyCount
          : replyCount // ignore: cast_nullable_to_non_nullable
              as int,
      createdAt: null == createdAt
          ? _self.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc

@JsonSerializable(fieldRename: FieldRename.snake)
class _PostCommentEntity implements PostCommentEntity {
  const _PostCommentEntity(
      {required this.id,
      required this.postId,
      required this.authorId,
      required this.content,
      this.likeCount = 0,
      this.replyCount = 0,
      @DateTimeConverter() required this.createdAt});
  factory _PostCommentEntity.fromJson(Map<String, dynamic> json) =>
      _$PostCommentEntityFromJson(json);

  /// PK: Primary Key, định danh duy nhất của bình luận.
  @override
  final String id;

  /// FK: Foreign Key, tham chiếu đến `posts.id` mà bình luận này thuộc về.
  @override
  final String postId;

  /// FK: Foreign Key, tham chiếu đến `profiles.id` của tác giả bình luận.
  @override
  final String authorId;

  /// Nội dung của bình luận.
  @override
  final String content;

  /// (Denormalized) Số lượt thích trên bình luận này.
  @override
  @JsonKey()
  final int likeCount;

  /// (Denormalized) Số lượt trả lời cho bình luận này.
  @override
  @JsonKey()
  final int replyCount;

  /// Thời điểm bình luận được tạo.
  @override
  @DateTimeConverter()
  final DateTime createdAt;

  /// Create a copy of PostCommentEntity
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$PostCommentEntityCopyWith<_PostCommentEntity> get copyWith =>
      __$PostCommentEntityCopyWithImpl<_PostCommentEntity>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$PostCommentEntityToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _PostCommentEntity &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.postId, postId) || other.postId == postId) &&
            (identical(other.authorId, authorId) ||
                other.authorId == authorId) &&
            (identical(other.content, content) || other.content == content) &&
            (identical(other.likeCount, likeCount) ||
                other.likeCount == likeCount) &&
            (identical(other.replyCount, replyCount) ||
                other.replyCount == replyCount) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, postId, authorId, content,
      likeCount, replyCount, createdAt);

  @override
  String toString() {
    return 'PostCommentEntity(id: $id, postId: $postId, authorId: $authorId, content: $content, likeCount: $likeCount, replyCount: $replyCount, createdAt: $createdAt)';
  }
}

/// @nodoc
abstract mixin class _$PostCommentEntityCopyWith<$Res>
    implements $PostCommentEntityCopyWith<$Res> {
  factory _$PostCommentEntityCopyWith(
          _PostCommentEntity value, $Res Function(_PostCommentEntity) _then) =
      __$PostCommentEntityCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String id,
      String postId,
      String authorId,
      String content,
      int likeCount,
      int replyCount,
      @DateTimeConverter() DateTime createdAt});
}

/// @nodoc
class __$PostCommentEntityCopyWithImpl<$Res>
    implements _$PostCommentEntityCopyWith<$Res> {
  __$PostCommentEntityCopyWithImpl(this._self, this._then);

  final _PostCommentEntity _self;
  final $Res Function(_PostCommentEntity) _then;

  /// Create a copy of PostCommentEntity
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = null,
    Object? postId = null,
    Object? authorId = null,
    Object? content = null,
    Object? likeCount = null,
    Object? replyCount = null,
    Object? createdAt = null,
  }) {
    return _then(_PostCommentEntity(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      postId: null == postId
          ? _self.postId
          : postId // ignore: cast_nullable_to_non_nullable
              as String,
      authorId: null == authorId
          ? _self.authorId
          : authorId // ignore: cast_nullable_to_non_nullable
              as String,
      content: null == content
          ? _self.content
          : content // ignore: cast_nullable_to_non_nullable
              as String,
      likeCount: null == likeCount
          ? _self.likeCount
          : likeCount // ignore: cast_nullable_to_non_nullable
              as int,
      replyCount: null == replyCount
          ? _self.replyCount
          : replyCount // ignore: cast_nullable_to_non_nullable
              as int,
      createdAt: null == createdAt
          ? _self.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

// dart format on
