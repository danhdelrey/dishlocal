// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'comment.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Comment {
  /// ID duy nhất của bình luận.
  String get commentId;

  /// ID của người dùng đã viết bình luận.
  String get authorUserId;

  /// Tên người dùng của tác giả (từ `profiles.username`).
  String get authorUsername;

  /// URL ảnh đại diện của tác giả (từ `profiles.photo_url`).
  String? get authorAvatarUrl;

  /// Nội dung văn bản của bình luận.
  String get content;

  /// Thời điểm bình luận được tạo.
  @DateTimeConverter()
  DateTime get createdAt;

  /// Số lượt thích của bình luận.
  int get likeCount;

  /// Số lượt trả lời của bình luận.
  int get replyCount;

  /// Cờ cho biết người dùng hiện tại có thích bình luận này hay không.
  /// Giá trị này được tính toán trong hàm RPC.
  bool get isLiked;

  /// Create a copy of Comment
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $CommentCopyWith<Comment> get copyWith =>
      _$CommentCopyWithImpl<Comment>(this as Comment, _$identity);

  /// Serializes this Comment to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is Comment &&
            (identical(other.commentId, commentId) ||
                other.commentId == commentId) &&
            (identical(other.authorUserId, authorUserId) ||
                other.authorUserId == authorUserId) &&
            (identical(other.authorUsername, authorUsername) ||
                other.authorUsername == authorUsername) &&
            (identical(other.authorAvatarUrl, authorAvatarUrl) ||
                other.authorAvatarUrl == authorAvatarUrl) &&
            (identical(other.content, content) || other.content == content) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.likeCount, likeCount) ||
                other.likeCount == likeCount) &&
            (identical(other.replyCount, replyCount) ||
                other.replyCount == replyCount) &&
            (identical(other.isLiked, isLiked) || other.isLiked == isLiked));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      commentId,
      authorUserId,
      authorUsername,
      authorAvatarUrl,
      content,
      createdAt,
      likeCount,
      replyCount,
      isLiked);

  @override
  String toString() {
    return 'Comment(commentId: $commentId, authorUserId: $authorUserId, authorUsername: $authorUsername, authorAvatarUrl: $authorAvatarUrl, content: $content, createdAt: $createdAt, likeCount: $likeCount, replyCount: $replyCount, isLiked: $isLiked)';
  }
}

/// @nodoc
abstract mixin class $CommentCopyWith<$Res> {
  factory $CommentCopyWith(Comment value, $Res Function(Comment) _then) =
      _$CommentCopyWithImpl;
  @useResult
  $Res call(
      {String commentId,
      String authorUserId,
      String authorUsername,
      String? authorAvatarUrl,
      String content,
      @DateTimeConverter() DateTime createdAt,
      int likeCount,
      int replyCount,
      bool isLiked});
}

/// @nodoc
class _$CommentCopyWithImpl<$Res> implements $CommentCopyWith<$Res> {
  _$CommentCopyWithImpl(this._self, this._then);

  final Comment _self;
  final $Res Function(Comment) _then;

  /// Create a copy of Comment
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? commentId = null,
    Object? authorUserId = null,
    Object? authorUsername = null,
    Object? authorAvatarUrl = freezed,
    Object? content = null,
    Object? createdAt = null,
    Object? likeCount = null,
    Object? replyCount = null,
    Object? isLiked = null,
  }) {
    return _then(_self.copyWith(
      commentId: null == commentId
          ? _self.commentId
          : commentId // ignore: cast_nullable_to_non_nullable
              as String,
      authorUserId: null == authorUserId
          ? _self.authorUserId
          : authorUserId // ignore: cast_nullable_to_non_nullable
              as String,
      authorUsername: null == authorUsername
          ? _self.authorUsername
          : authorUsername // ignore: cast_nullable_to_non_nullable
              as String,
      authorAvatarUrl: freezed == authorAvatarUrl
          ? _self.authorAvatarUrl
          : authorAvatarUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      content: null == content
          ? _self.content
          : content // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: null == createdAt
          ? _self.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      likeCount: null == likeCount
          ? _self.likeCount
          : likeCount // ignore: cast_nullable_to_non_nullable
              as int,
      replyCount: null == replyCount
          ? _self.replyCount
          : replyCount // ignore: cast_nullable_to_non_nullable
              as int,
      isLiked: null == isLiked
          ? _self.isLiked
          : isLiked // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

@JsonSerializable(explicitToJson: true)
class _Comment implements Comment {
  const _Comment(
      {required this.commentId,
      required this.authorUserId,
      required this.authorUsername,
      this.authorAvatarUrl,
      required this.content,
      @DateTimeConverter() required this.createdAt,
      required this.likeCount,
      required this.replyCount,
      required this.isLiked});
  factory _Comment.fromJson(Map<String, dynamic> json) =>
      _$CommentFromJson(json);

  /// ID duy nhất của bình luận.
  @override
  final String commentId;

  /// ID của người dùng đã viết bình luận.
  @override
  final String authorUserId;

  /// Tên người dùng của tác giả (từ `profiles.username`).
  @override
  final String authorUsername;

  /// URL ảnh đại diện của tác giả (từ `profiles.photo_url`).
  @override
  final String? authorAvatarUrl;

  /// Nội dung văn bản của bình luận.
  @override
  final String content;

  /// Thời điểm bình luận được tạo.
  @override
  @DateTimeConverter()
  final DateTime createdAt;

  /// Số lượt thích của bình luận.
  @override
  final int likeCount;

  /// Số lượt trả lời của bình luận.
  @override
  final int replyCount;

  /// Cờ cho biết người dùng hiện tại có thích bình luận này hay không.
  /// Giá trị này được tính toán trong hàm RPC.
  @override
  final bool isLiked;

  /// Create a copy of Comment
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$CommentCopyWith<_Comment> get copyWith =>
      __$CommentCopyWithImpl<_Comment>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$CommentToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Comment &&
            (identical(other.commentId, commentId) ||
                other.commentId == commentId) &&
            (identical(other.authorUserId, authorUserId) ||
                other.authorUserId == authorUserId) &&
            (identical(other.authorUsername, authorUsername) ||
                other.authorUsername == authorUsername) &&
            (identical(other.authorAvatarUrl, authorAvatarUrl) ||
                other.authorAvatarUrl == authorAvatarUrl) &&
            (identical(other.content, content) || other.content == content) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.likeCount, likeCount) ||
                other.likeCount == likeCount) &&
            (identical(other.replyCount, replyCount) ||
                other.replyCount == replyCount) &&
            (identical(other.isLiked, isLiked) || other.isLiked == isLiked));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      commentId,
      authorUserId,
      authorUsername,
      authorAvatarUrl,
      content,
      createdAt,
      likeCount,
      replyCount,
      isLiked);

  @override
  String toString() {
    return 'Comment(commentId: $commentId, authorUserId: $authorUserId, authorUsername: $authorUsername, authorAvatarUrl: $authorAvatarUrl, content: $content, createdAt: $createdAt, likeCount: $likeCount, replyCount: $replyCount, isLiked: $isLiked)';
  }
}

/// @nodoc
abstract mixin class _$CommentCopyWith<$Res> implements $CommentCopyWith<$Res> {
  factory _$CommentCopyWith(_Comment value, $Res Function(_Comment) _then) =
      __$CommentCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String commentId,
      String authorUserId,
      String authorUsername,
      String? authorAvatarUrl,
      String content,
      @DateTimeConverter() DateTime createdAt,
      int likeCount,
      int replyCount,
      bool isLiked});
}

/// @nodoc
class __$CommentCopyWithImpl<$Res> implements _$CommentCopyWith<$Res> {
  __$CommentCopyWithImpl(this._self, this._then);

  final _Comment _self;
  final $Res Function(_Comment) _then;

  /// Create a copy of Comment
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? commentId = null,
    Object? authorUserId = null,
    Object? authorUsername = null,
    Object? authorAvatarUrl = freezed,
    Object? content = null,
    Object? createdAt = null,
    Object? likeCount = null,
    Object? replyCount = null,
    Object? isLiked = null,
  }) {
    return _then(_Comment(
      commentId: null == commentId
          ? _self.commentId
          : commentId // ignore: cast_nullable_to_non_nullable
              as String,
      authorUserId: null == authorUserId
          ? _self.authorUserId
          : authorUserId // ignore: cast_nullable_to_non_nullable
              as String,
      authorUsername: null == authorUsername
          ? _self.authorUsername
          : authorUsername // ignore: cast_nullable_to_non_nullable
              as String,
      authorAvatarUrl: freezed == authorAvatarUrl
          ? _self.authorAvatarUrl
          : authorAvatarUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      content: null == content
          ? _self.content
          : content // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: null == createdAt
          ? _self.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      likeCount: null == likeCount
          ? _self.likeCount
          : likeCount // ignore: cast_nullable_to_non_nullable
              as int,
      replyCount: null == replyCount
          ? _self.replyCount
          : replyCount // ignore: cast_nullable_to_non_nullable
              as int,
      isLiked: null == isLiked
          ? _self.isLiked
          : isLiked // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

// dart format on
