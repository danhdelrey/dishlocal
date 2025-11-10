// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'post_comment_like_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$PostCommentLikeEntity {
  /// PK, FK: Tham chiếu đến `post_comments.id`.
  String get commentId;

  /// PK, FK: Tham chiếu đến `profiles.id` của người dùng đã thích.
  String get userId;

  /// Thời điểm lượt thích được tạo.
  @DateTimeConverter()
  DateTime get createdAt;

  /// Create a copy of PostCommentLikeEntity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $PostCommentLikeEntityCopyWith<PostCommentLikeEntity> get copyWith =>
      _$PostCommentLikeEntityCopyWithImpl<PostCommentLikeEntity>(
          this as PostCommentLikeEntity, _$identity);

  /// Serializes this PostCommentLikeEntity to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is PostCommentLikeEntity &&
            (identical(other.commentId, commentId) ||
                other.commentId == commentId) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, commentId, userId, createdAt);

  @override
  String toString() {
    return 'PostCommentLikeEntity(commentId: $commentId, userId: $userId, createdAt: $createdAt)';
  }
}

/// @nodoc
abstract mixin class $PostCommentLikeEntityCopyWith<$Res> {
  factory $PostCommentLikeEntityCopyWith(PostCommentLikeEntity value,
          $Res Function(PostCommentLikeEntity) _then) =
      _$PostCommentLikeEntityCopyWithImpl;
  @useResult
  $Res call(
      {String commentId,
      String userId,
      @DateTimeConverter() DateTime createdAt});
}

/// @nodoc
class _$PostCommentLikeEntityCopyWithImpl<$Res>
    implements $PostCommentLikeEntityCopyWith<$Res> {
  _$PostCommentLikeEntityCopyWithImpl(this._self, this._then);

  final PostCommentLikeEntity _self;
  final $Res Function(PostCommentLikeEntity) _then;

  /// Create a copy of PostCommentLikeEntity
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? commentId = null,
    Object? userId = null,
    Object? createdAt = null,
  }) {
    return _then(_self.copyWith(
      commentId: null == commentId
          ? _self.commentId
          : commentId // ignore: cast_nullable_to_non_nullable
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

/// Adds pattern-matching-related methods to [PostCommentLikeEntity].
extension PostCommentLikeEntityPatterns on PostCommentLikeEntity {
  /// A variant of `map` that fallback to returning `orElse`.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case _:
  ///     return orElse();
  /// }
  /// ```

  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(_PostCommentLikeEntity value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _PostCommentLikeEntity() when $default != null:
        return $default(_that);
      case _:
        return orElse();
    }
  }

  /// A `switch`-like method, using callbacks.
  ///
  /// Callbacks receives the raw object, upcasted.
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case final Subclass2 value:
  ///     return ...;
  /// }
  /// ```

  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(_PostCommentLikeEntity value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _PostCommentLikeEntity():
        return $default(_that);
      case _:
        throw StateError('Unexpected subclass');
    }
  }

  /// A variant of `map` that fallback to returning `null`.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case _:
  ///     return null;
  /// }
  /// ```

  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult? Function(_PostCommentLikeEntity value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _PostCommentLikeEntity() when $default != null:
        return $default(_that);
      case _:
        return null;
    }
  }

  /// A variant of `when` that fallback to an `orElse` callback.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case _:
  ///     return orElse();
  /// }
  /// ```

  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(String commentId, String userId,
            @DateTimeConverter() DateTime createdAt)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _PostCommentLikeEntity() when $default != null:
        return $default(_that.commentId, _that.userId, _that.createdAt);
      case _:
        return orElse();
    }
  }

  /// A `switch`-like method, using callbacks.
  ///
  /// As opposed to `map`, this offers destructuring.
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case Subclass2(:final field2):
  ///     return ...;
  /// }
  /// ```

  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(String commentId, String userId,
            @DateTimeConverter() DateTime createdAt)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _PostCommentLikeEntity():
        return $default(_that.commentId, _that.userId, _that.createdAt);
      case _:
        throw StateError('Unexpected subclass');
    }
  }

  /// A variant of `when` that fallback to returning `null`
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case _:
  ///     return null;
  /// }
  /// ```

  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function(String commentId, String userId,
            @DateTimeConverter() DateTime createdAt)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _PostCommentLikeEntity() when $default != null:
        return $default(_that.commentId, _that.userId, _that.createdAt);
      case _:
        return null;
    }
  }
}

/// @nodoc

@JsonSerializable(fieldRename: FieldRename.snake)
class _PostCommentLikeEntity implements PostCommentLikeEntity {
  const _PostCommentLikeEntity(
      {required this.commentId,
      required this.userId,
      @DateTimeConverter() required this.createdAt});
  factory _PostCommentLikeEntity.fromJson(Map<String, dynamic> json) =>
      _$PostCommentLikeEntityFromJson(json);

  /// PK, FK: Tham chiếu đến `post_comments.id`.
  @override
  final String commentId;

  /// PK, FK: Tham chiếu đến `profiles.id` của người dùng đã thích.
  @override
  final String userId;

  /// Thời điểm lượt thích được tạo.
  @override
  @DateTimeConverter()
  final DateTime createdAt;

  /// Create a copy of PostCommentLikeEntity
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$PostCommentLikeEntityCopyWith<_PostCommentLikeEntity> get copyWith =>
      __$PostCommentLikeEntityCopyWithImpl<_PostCommentLikeEntity>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$PostCommentLikeEntityToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _PostCommentLikeEntity &&
            (identical(other.commentId, commentId) ||
                other.commentId == commentId) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, commentId, userId, createdAt);

  @override
  String toString() {
    return 'PostCommentLikeEntity(commentId: $commentId, userId: $userId, createdAt: $createdAt)';
  }
}

/// @nodoc
abstract mixin class _$PostCommentLikeEntityCopyWith<$Res>
    implements $PostCommentLikeEntityCopyWith<$Res> {
  factory _$PostCommentLikeEntityCopyWith(_PostCommentLikeEntity value,
          $Res Function(_PostCommentLikeEntity) _then) =
      __$PostCommentLikeEntityCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String commentId,
      String userId,
      @DateTimeConverter() DateTime createdAt});
}

/// @nodoc
class __$PostCommentLikeEntityCopyWithImpl<$Res>
    implements _$PostCommentLikeEntityCopyWith<$Res> {
  __$PostCommentLikeEntityCopyWithImpl(this._self, this._then);

  final _PostCommentLikeEntity _self;
  final $Res Function(_PostCommentLikeEntity) _then;

  /// Create a copy of PostCommentLikeEntity
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? commentId = null,
    Object? userId = null,
    Object? createdAt = null,
  }) {
    return _then(_PostCommentLikeEntity(
      commentId: null == commentId
          ? _self.commentId
          : commentId // ignore: cast_nullable_to_non_nullable
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
