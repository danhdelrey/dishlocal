// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'comment_reply.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$CommentReply {
  /// ID duy nhất của trả lời.
  String get replyId;

  /// ID của người dùng đã viết trả lời.
  String get authorUserId;

  /// Tên người dùng của tác giả trả lời.
  String get authorUsername;

  /// URL ảnh đại diện của tác giả trả lời.
  String? get authorAvatarUrl;

  /// ID của người dùng được trả lời.
  String get replyToUserId;

  /// Tên người dùng của người được trả lời (để hiển thị "@username").
  String get replyToUsername;

  /// Nội dung văn bản của trả lời.
  String get content;

  /// Thời điểm trả lời được tạo.
  @DateTimeConverter()
  DateTime get createdAt;

  /// Số lượt thích của trả lời.
  int get likeCount;

  /// Cờ cho biết người dùng hiện tại có thích trả lời này hay không.
  /// Giá trị này được tính toán trong hàm RPC.
  bool get isLiked;

  /// Create a copy of CommentReply
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $CommentReplyCopyWith<CommentReply> get copyWith =>
      _$CommentReplyCopyWithImpl<CommentReply>(
          this as CommentReply, _$identity);

  /// Serializes this CommentReply to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is CommentReply &&
            (identical(other.replyId, replyId) || other.replyId == replyId) &&
            (identical(other.authorUserId, authorUserId) ||
                other.authorUserId == authorUserId) &&
            (identical(other.authorUsername, authorUsername) ||
                other.authorUsername == authorUsername) &&
            (identical(other.authorAvatarUrl, authorAvatarUrl) ||
                other.authorAvatarUrl == authorAvatarUrl) &&
            (identical(other.replyToUserId, replyToUserId) ||
                other.replyToUserId == replyToUserId) &&
            (identical(other.replyToUsername, replyToUsername) ||
                other.replyToUsername == replyToUsername) &&
            (identical(other.content, content) || other.content == content) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.likeCount, likeCount) ||
                other.likeCount == likeCount) &&
            (identical(other.isLiked, isLiked) || other.isLiked == isLiked));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      replyId,
      authorUserId,
      authorUsername,
      authorAvatarUrl,
      replyToUserId,
      replyToUsername,
      content,
      createdAt,
      likeCount,
      isLiked);

  @override
  String toString() {
    return 'CommentReply(replyId: $replyId, authorUserId: $authorUserId, authorUsername: $authorUsername, authorAvatarUrl: $authorAvatarUrl, replyToUserId: $replyToUserId, replyToUsername: $replyToUsername, content: $content, createdAt: $createdAt, likeCount: $likeCount, isLiked: $isLiked)';
  }
}

/// @nodoc
abstract mixin class $CommentReplyCopyWith<$Res> {
  factory $CommentReplyCopyWith(
          CommentReply value, $Res Function(CommentReply) _then) =
      _$CommentReplyCopyWithImpl;
  @useResult
  $Res call(
      {String replyId,
      String authorUserId,
      String authorUsername,
      String? authorAvatarUrl,
      String replyToUserId,
      String replyToUsername,
      String content,
      @DateTimeConverter() DateTime createdAt,
      int likeCount,
      bool isLiked});
}

/// @nodoc
class _$CommentReplyCopyWithImpl<$Res> implements $CommentReplyCopyWith<$Res> {
  _$CommentReplyCopyWithImpl(this._self, this._then);

  final CommentReply _self;
  final $Res Function(CommentReply) _then;

  /// Create a copy of CommentReply
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? replyId = null,
    Object? authorUserId = null,
    Object? authorUsername = null,
    Object? authorAvatarUrl = freezed,
    Object? replyToUserId = null,
    Object? replyToUsername = null,
    Object? content = null,
    Object? createdAt = null,
    Object? likeCount = null,
    Object? isLiked = null,
  }) {
    return _then(_self.copyWith(
      replyId: null == replyId
          ? _self.replyId
          : replyId // ignore: cast_nullable_to_non_nullable
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
      replyToUserId: null == replyToUserId
          ? _self.replyToUserId
          : replyToUserId // ignore: cast_nullable_to_non_nullable
              as String,
      replyToUsername: null == replyToUsername
          ? _self.replyToUsername
          : replyToUsername // ignore: cast_nullable_to_non_nullable
              as String,
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
      isLiked: null == isLiked
          ? _self.isLiked
          : isLiked // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

@JsonSerializable(explicitToJson: true)
class _CommentReply implements CommentReply {
  const _CommentReply(
      {required this.replyId,
      required this.authorUserId,
      required this.authorUsername,
      this.authorAvatarUrl,
      required this.replyToUserId,
      required this.replyToUsername,
      required this.content,
      @DateTimeConverter() required this.createdAt,
      required this.likeCount,
      required this.isLiked});
  factory _CommentReply.fromJson(Map<String, dynamic> json) =>
      _$CommentReplyFromJson(json);

  /// ID duy nhất của trả lời.
  @override
  final String replyId;

  /// ID của người dùng đã viết trả lời.
  @override
  final String authorUserId;

  /// Tên người dùng của tác giả trả lời.
  @override
  final String authorUsername;

  /// URL ảnh đại diện của tác giả trả lời.
  @override
  final String? authorAvatarUrl;

  /// ID của người dùng được trả lời.
  @override
  final String replyToUserId;

  /// Tên người dùng của người được trả lời (để hiển thị "@username").
  @override
  final String replyToUsername;

  /// Nội dung văn bản của trả lời.
  @override
  final String content;

  /// Thời điểm trả lời được tạo.
  @override
  @DateTimeConverter()
  final DateTime createdAt;

  /// Số lượt thích của trả lời.
  @override
  final int likeCount;

  /// Cờ cho biết người dùng hiện tại có thích trả lời này hay không.
  /// Giá trị này được tính toán trong hàm RPC.
  @override
  final bool isLiked;

  /// Create a copy of CommentReply
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$CommentReplyCopyWith<_CommentReply> get copyWith =>
      __$CommentReplyCopyWithImpl<_CommentReply>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$CommentReplyToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _CommentReply &&
            (identical(other.replyId, replyId) || other.replyId == replyId) &&
            (identical(other.authorUserId, authorUserId) ||
                other.authorUserId == authorUserId) &&
            (identical(other.authorUsername, authorUsername) ||
                other.authorUsername == authorUsername) &&
            (identical(other.authorAvatarUrl, authorAvatarUrl) ||
                other.authorAvatarUrl == authorAvatarUrl) &&
            (identical(other.replyToUserId, replyToUserId) ||
                other.replyToUserId == replyToUserId) &&
            (identical(other.replyToUsername, replyToUsername) ||
                other.replyToUsername == replyToUsername) &&
            (identical(other.content, content) || other.content == content) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.likeCount, likeCount) ||
                other.likeCount == likeCount) &&
            (identical(other.isLiked, isLiked) || other.isLiked == isLiked));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      replyId,
      authorUserId,
      authorUsername,
      authorAvatarUrl,
      replyToUserId,
      replyToUsername,
      content,
      createdAt,
      likeCount,
      isLiked);

  @override
  String toString() {
    return 'CommentReply(replyId: $replyId, authorUserId: $authorUserId, authorUsername: $authorUsername, authorAvatarUrl: $authorAvatarUrl, replyToUserId: $replyToUserId, replyToUsername: $replyToUsername, content: $content, createdAt: $createdAt, likeCount: $likeCount, isLiked: $isLiked)';
  }
}

/// @nodoc
abstract mixin class _$CommentReplyCopyWith<$Res>
    implements $CommentReplyCopyWith<$Res> {
  factory _$CommentReplyCopyWith(
          _CommentReply value, $Res Function(_CommentReply) _then) =
      __$CommentReplyCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String replyId,
      String authorUserId,
      String authorUsername,
      String? authorAvatarUrl,
      String replyToUserId,
      String replyToUsername,
      String content,
      @DateTimeConverter() DateTime createdAt,
      int likeCount,
      bool isLiked});
}

/// @nodoc
class __$CommentReplyCopyWithImpl<$Res>
    implements _$CommentReplyCopyWith<$Res> {
  __$CommentReplyCopyWithImpl(this._self, this._then);

  final _CommentReply _self;
  final $Res Function(_CommentReply) _then;

  /// Create a copy of CommentReply
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? replyId = null,
    Object? authorUserId = null,
    Object? authorUsername = null,
    Object? authorAvatarUrl = freezed,
    Object? replyToUserId = null,
    Object? replyToUsername = null,
    Object? content = null,
    Object? createdAt = null,
    Object? likeCount = null,
    Object? isLiked = null,
  }) {
    return _then(_CommentReply(
      replyId: null == replyId
          ? _self.replyId
          : replyId // ignore: cast_nullable_to_non_nullable
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
      replyToUserId: null == replyToUserId
          ? _self.replyToUserId
          : replyToUserId // ignore: cast_nullable_to_non_nullable
              as String,
      replyToUsername: null == replyToUsername
          ? _self.replyToUsername
          : replyToUsername // ignore: cast_nullable_to_non_nullable
              as String,
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
      isLiked: null == isLiked
          ? _self.isLiked
          : isLiked // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

// dart format on
