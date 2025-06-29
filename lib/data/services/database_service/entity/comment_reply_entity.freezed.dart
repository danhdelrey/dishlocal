// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'comment_reply_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$CommentReplyEntity {
  /// PK: Primary Key, định danh duy nhất của trả lời.
  String get id;

  /// FK: Foreign Key, tham chiếu đến `post_comments.id` (bình luận gốc).
  String get parentCommentId;

  /// FK: Foreign Key, tham chiếu đến `profiles.id` của tác giả trả lời.
  String get authorId;

  /// FK: Foreign Key, tham chiếu đến `profiles.id` của người được trả lời.
  /// Dùng để hiển thị tag вида "@username".
  String get replyToUserId;

  /// Nội dung của trả lời.
  String get content;

  /// (Denormalized) Số lượt thích trên trả lời này.
  int get likeCount;

  /// Thời điểm trả lời được tạo.
  @DateTimeConverter()
  DateTime get createdAt;

  /// Create a copy of CommentReplyEntity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $CommentReplyEntityCopyWith<CommentReplyEntity> get copyWith =>
      _$CommentReplyEntityCopyWithImpl<CommentReplyEntity>(
          this as CommentReplyEntity, _$identity);

  /// Serializes this CommentReplyEntity to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is CommentReplyEntity &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.parentCommentId, parentCommentId) ||
                other.parentCommentId == parentCommentId) &&
            (identical(other.authorId, authorId) ||
                other.authorId == authorId) &&
            (identical(other.replyToUserId, replyToUserId) ||
                other.replyToUserId == replyToUserId) &&
            (identical(other.content, content) || other.content == content) &&
            (identical(other.likeCount, likeCount) ||
                other.likeCount == likeCount) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, parentCommentId, authorId,
      replyToUserId, content, likeCount, createdAt);

  @override
  String toString() {
    return 'CommentReplyEntity(id: $id, parentCommentId: $parentCommentId, authorId: $authorId, replyToUserId: $replyToUserId, content: $content, likeCount: $likeCount, createdAt: $createdAt)';
  }
}

/// @nodoc
abstract mixin class $CommentReplyEntityCopyWith<$Res> {
  factory $CommentReplyEntityCopyWith(
          CommentReplyEntity value, $Res Function(CommentReplyEntity) _then) =
      _$CommentReplyEntityCopyWithImpl;
  @useResult
  $Res call(
      {String id,
      String parentCommentId,
      String authorId,
      String replyToUserId,
      String content,
      int likeCount,
      @DateTimeConverter() DateTime createdAt});
}

/// @nodoc
class _$CommentReplyEntityCopyWithImpl<$Res>
    implements $CommentReplyEntityCopyWith<$Res> {
  _$CommentReplyEntityCopyWithImpl(this._self, this._then);

  final CommentReplyEntity _self;
  final $Res Function(CommentReplyEntity) _then;

  /// Create a copy of CommentReplyEntity
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? parentCommentId = null,
    Object? authorId = null,
    Object? replyToUserId = null,
    Object? content = null,
    Object? likeCount = null,
    Object? createdAt = null,
  }) {
    return _then(_self.copyWith(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      parentCommentId: null == parentCommentId
          ? _self.parentCommentId
          : parentCommentId // ignore: cast_nullable_to_non_nullable
              as String,
      authorId: null == authorId
          ? _self.authorId
          : authorId // ignore: cast_nullable_to_non_nullable
              as String,
      replyToUserId: null == replyToUserId
          ? _self.replyToUserId
          : replyToUserId // ignore: cast_nullable_to_non_nullable
              as String,
      content: null == content
          ? _self.content
          : content // ignore: cast_nullable_to_non_nullable
              as String,
      likeCount: null == likeCount
          ? _self.likeCount
          : likeCount // ignore: cast_nullable_to_non_nullable
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
class _CommentReplyEntity implements CommentReplyEntity {
  const _CommentReplyEntity(
      {required this.id,
      required this.parentCommentId,
      required this.authorId,
      required this.replyToUserId,
      required this.content,
      this.likeCount = 0,
      @DateTimeConverter() required this.createdAt});
  factory _CommentReplyEntity.fromJson(Map<String, dynamic> json) =>
      _$CommentReplyEntityFromJson(json);

  /// PK: Primary Key, định danh duy nhất của trả lời.
  @override
  final String id;

  /// FK: Foreign Key, tham chiếu đến `post_comments.id` (bình luận gốc).
  @override
  final String parentCommentId;

  /// FK: Foreign Key, tham chiếu đến `profiles.id` của tác giả trả lời.
  @override
  final String authorId;

  /// FK: Foreign Key, tham chiếu đến `profiles.id` của người được trả lời.
  /// Dùng để hiển thị tag вида "@username".
  @override
  final String replyToUserId;

  /// Nội dung của trả lời.
  @override
  final String content;

  /// (Denormalized) Số lượt thích trên trả lời này.
  @override
  @JsonKey()
  final int likeCount;

  /// Thời điểm trả lời được tạo.
  @override
  @DateTimeConverter()
  final DateTime createdAt;

  /// Create a copy of CommentReplyEntity
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$CommentReplyEntityCopyWith<_CommentReplyEntity> get copyWith =>
      __$CommentReplyEntityCopyWithImpl<_CommentReplyEntity>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$CommentReplyEntityToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _CommentReplyEntity &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.parentCommentId, parentCommentId) ||
                other.parentCommentId == parentCommentId) &&
            (identical(other.authorId, authorId) ||
                other.authorId == authorId) &&
            (identical(other.replyToUserId, replyToUserId) ||
                other.replyToUserId == replyToUserId) &&
            (identical(other.content, content) || other.content == content) &&
            (identical(other.likeCount, likeCount) ||
                other.likeCount == likeCount) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, parentCommentId, authorId,
      replyToUserId, content, likeCount, createdAt);

  @override
  String toString() {
    return 'CommentReplyEntity(id: $id, parentCommentId: $parentCommentId, authorId: $authorId, replyToUserId: $replyToUserId, content: $content, likeCount: $likeCount, createdAt: $createdAt)';
  }
}

/// @nodoc
abstract mixin class _$CommentReplyEntityCopyWith<$Res>
    implements $CommentReplyEntityCopyWith<$Res> {
  factory _$CommentReplyEntityCopyWith(
          _CommentReplyEntity value, $Res Function(_CommentReplyEntity) _then) =
      __$CommentReplyEntityCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String id,
      String parentCommentId,
      String authorId,
      String replyToUserId,
      String content,
      int likeCount,
      @DateTimeConverter() DateTime createdAt});
}

/// @nodoc
class __$CommentReplyEntityCopyWithImpl<$Res>
    implements _$CommentReplyEntityCopyWith<$Res> {
  __$CommentReplyEntityCopyWithImpl(this._self, this._then);

  final _CommentReplyEntity _self;
  final $Res Function(_CommentReplyEntity) _then;

  /// Create a copy of CommentReplyEntity
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = null,
    Object? parentCommentId = null,
    Object? authorId = null,
    Object? replyToUserId = null,
    Object? content = null,
    Object? likeCount = null,
    Object? createdAt = null,
  }) {
    return _then(_CommentReplyEntity(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      parentCommentId: null == parentCommentId
          ? _self.parentCommentId
          : parentCommentId // ignore: cast_nullable_to_non_nullable
              as String,
      authorId: null == authorId
          ? _self.authorId
          : authorId // ignore: cast_nullable_to_non_nullable
              as String,
      replyToUserId: null == replyToUserId
          ? _self.replyToUserId
          : replyToUserId // ignore: cast_nullable_to_non_nullable
              as String,
      content: null == content
          ? _self.content
          : content // ignore: cast_nullable_to_non_nullable
              as String,
      likeCount: null == likeCount
          ? _self.likeCount
          : likeCount // ignore: cast_nullable_to_non_nullable
              as int,
      createdAt: null == createdAt
          ? _self.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

// dart format on
