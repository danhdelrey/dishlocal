// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'comment_reply_like_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$CommentReplyLikeEntity {
  /// PK, FK: Tham chiếu đến `comment_replies.id`.
  String get replyId;

  /// PK, FK: Tham chiếu đến `profiles.id` của người dùng đã thích.
  String get userId;

  /// Thời điểm lượt thích được tạo.
  @DateTimeConverter()
  DateTime get createdAt;

  /// Create a copy of CommentReplyLikeEntity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $CommentReplyLikeEntityCopyWith<CommentReplyLikeEntity> get copyWith =>
      _$CommentReplyLikeEntityCopyWithImpl<CommentReplyLikeEntity>(
          this as CommentReplyLikeEntity, _$identity);

  /// Serializes this CommentReplyLikeEntity to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is CommentReplyLikeEntity &&
            (identical(other.replyId, replyId) || other.replyId == replyId) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, replyId, userId, createdAt);

  @override
  String toString() {
    return 'CommentReplyLikeEntity(replyId: $replyId, userId: $userId, createdAt: $createdAt)';
  }
}

/// @nodoc
abstract mixin class $CommentReplyLikeEntityCopyWith<$Res> {
  factory $CommentReplyLikeEntityCopyWith(CommentReplyLikeEntity value,
          $Res Function(CommentReplyLikeEntity) _then) =
      _$CommentReplyLikeEntityCopyWithImpl;
  @useResult
  $Res call(
      {String replyId, String userId, @DateTimeConverter() DateTime createdAt});
}

/// @nodoc
class _$CommentReplyLikeEntityCopyWithImpl<$Res>
    implements $CommentReplyLikeEntityCopyWith<$Res> {
  _$CommentReplyLikeEntityCopyWithImpl(this._self, this._then);

  final CommentReplyLikeEntity _self;
  final $Res Function(CommentReplyLikeEntity) _then;

  /// Create a copy of CommentReplyLikeEntity
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? replyId = null,
    Object? userId = null,
    Object? createdAt = null,
  }) {
    return _then(_self.copyWith(
      replyId: null == replyId
          ? _self.replyId
          : replyId // ignore: cast_nullable_to_non_nullable
              as String,
      userId: null == userId
          ? _self.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: null == createdAt
          ? _self.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc

@JsonSerializable(fieldRename: FieldRename.snake)
class _CommentReplyLikeEntity implements CommentReplyLikeEntity {
  const _CommentReplyLikeEntity(
      {required this.replyId,
      required this.userId,
      @DateTimeConverter() required this.createdAt});
  factory _CommentReplyLikeEntity.fromJson(Map<String, dynamic> json) =>
      _$CommentReplyLikeEntityFromJson(json);

  /// PK, FK: Tham chiếu đến `comment_replies.id`.
  @override
  final String replyId;

  /// PK, FK: Tham chiếu đến `profiles.id` của người dùng đã thích.
  @override
  final String userId;

  /// Thời điểm lượt thích được tạo.
  @override
  @DateTimeConverter()
  final DateTime createdAt;

  /// Create a copy of CommentReplyLikeEntity
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$CommentReplyLikeEntityCopyWith<_CommentReplyLikeEntity> get copyWith =>
      __$CommentReplyLikeEntityCopyWithImpl<_CommentReplyLikeEntity>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$CommentReplyLikeEntityToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _CommentReplyLikeEntity &&
            (identical(other.replyId, replyId) || other.replyId == replyId) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, replyId, userId, createdAt);

  @override
  String toString() {
    return 'CommentReplyLikeEntity(replyId: $replyId, userId: $userId, createdAt: $createdAt)';
  }
}

/// @nodoc
abstract mixin class _$CommentReplyLikeEntityCopyWith<$Res>
    implements $CommentReplyLikeEntityCopyWith<$Res> {
  factory _$CommentReplyLikeEntityCopyWith(_CommentReplyLikeEntity value,
          $Res Function(_CommentReplyLikeEntity) _then) =
      __$CommentReplyLikeEntityCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String replyId, String userId, @DateTimeConverter() DateTime createdAt});
}

/// @nodoc
class __$CommentReplyLikeEntityCopyWithImpl<$Res>
    implements _$CommentReplyLikeEntityCopyWith<$Res> {
  __$CommentReplyLikeEntityCopyWithImpl(this._self, this._then);

  final _CommentReplyLikeEntity _self;
  final $Res Function(_CommentReplyLikeEntity) _then;

  /// Create a copy of CommentReplyLikeEntity
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? replyId = null,
    Object? userId = null,
    Object? createdAt = null,
  }) {
    return _then(_CommentReplyLikeEntity(
      replyId: null == replyId
          ? _self.replyId
          : replyId // ignore: cast_nullable_to_non_nullable
              as String,
      userId: null == userId
          ? _self.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: null == createdAt
          ? _self.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

// dart format on
