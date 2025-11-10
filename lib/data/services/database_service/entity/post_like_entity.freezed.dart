// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'post_like_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$PostLikeEntity {
  /// FK: Bài post được thích.
  String get postId;

  /// FK: Người dùng đã thích bài post.
  String get userId;

  /// Thời điểm lượt thích được tạo.
  @DateTimeConverter()
  DateTime get createdAt;

  /// Create a copy of PostLikeEntity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $PostLikeEntityCopyWith<PostLikeEntity> get copyWith =>
      _$PostLikeEntityCopyWithImpl<PostLikeEntity>(
          this as PostLikeEntity, _$identity);

  /// Serializes this PostLikeEntity to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is PostLikeEntity &&
            (identical(other.postId, postId) || other.postId == postId) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, postId, userId, createdAt);

  @override
  String toString() {
    return 'PostLikeEntity(postId: $postId, userId: $userId, createdAt: $createdAt)';
  }
}

/// @nodoc
abstract mixin class $PostLikeEntityCopyWith<$Res> {
  factory $PostLikeEntityCopyWith(
          PostLikeEntity value, $Res Function(PostLikeEntity) _then) =
      _$PostLikeEntityCopyWithImpl;
  @useResult
  $Res call(
      {String postId, String userId, @DateTimeConverter() DateTime createdAt});
}

/// @nodoc
class _$PostLikeEntityCopyWithImpl<$Res>
    implements $PostLikeEntityCopyWith<$Res> {
  _$PostLikeEntityCopyWithImpl(this._self, this._then);

  final PostLikeEntity _self;
  final $Res Function(PostLikeEntity) _then;

  /// Create a copy of PostLikeEntity
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? postId = null,
    Object? userId = null,
    Object? createdAt = null,
  }) {
    return _then(_self.copyWith(
      postId: null == postId
          ? _self.postId
          : postId // ignore: cast_nullable_to_non_nullable
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

/// Adds pattern-matching-related methods to [PostLikeEntity].
extension PostLikeEntityPatterns on PostLikeEntity {
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
    TResult Function(_PostLikeEntity value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _PostLikeEntity() when $default != null:
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
    TResult Function(_PostLikeEntity value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _PostLikeEntity():
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
    TResult? Function(_PostLikeEntity value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _PostLikeEntity() when $default != null:
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
    TResult Function(String postId, String userId,
            @DateTimeConverter() DateTime createdAt)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _PostLikeEntity() when $default != null:
        return $default(_that.postId, _that.userId, _that.createdAt);
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
    TResult Function(String postId, String userId,
            @DateTimeConverter() DateTime createdAt)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _PostLikeEntity():
        return $default(_that.postId, _that.userId, _that.createdAt);
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
    TResult? Function(String postId, String userId,
            @DateTimeConverter() DateTime createdAt)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _PostLikeEntity() when $default != null:
        return $default(_that.postId, _that.userId, _that.createdAt);
      case _:
        return null;
    }
  }
}

/// @nodoc

@JsonSerializable(fieldRename: FieldRename.snake)
class _PostLikeEntity implements PostLikeEntity {
  const _PostLikeEntity(
      {required this.postId,
      required this.userId,
      @DateTimeConverter() required this.createdAt});
  factory _PostLikeEntity.fromJson(Map<String, dynamic> json) =>
      _$PostLikeEntityFromJson(json);

  /// FK: Bài post được thích.
  @override
  final String postId;

  /// FK: Người dùng đã thích bài post.
  @override
  final String userId;

  /// Thời điểm lượt thích được tạo.
  @override
  @DateTimeConverter()
  final DateTime createdAt;

  /// Create a copy of PostLikeEntity
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$PostLikeEntityCopyWith<_PostLikeEntity> get copyWith =>
      __$PostLikeEntityCopyWithImpl<_PostLikeEntity>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$PostLikeEntityToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _PostLikeEntity &&
            (identical(other.postId, postId) || other.postId == postId) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, postId, userId, createdAt);

  @override
  String toString() {
    return 'PostLikeEntity(postId: $postId, userId: $userId, createdAt: $createdAt)';
  }
}

/// @nodoc
abstract mixin class _$PostLikeEntityCopyWith<$Res>
    implements $PostLikeEntityCopyWith<$Res> {
  factory _$PostLikeEntityCopyWith(
          _PostLikeEntity value, $Res Function(_PostLikeEntity) _then) =
      __$PostLikeEntityCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String postId, String userId, @DateTimeConverter() DateTime createdAt});
}

/// @nodoc
class __$PostLikeEntityCopyWithImpl<$Res>
    implements _$PostLikeEntityCopyWith<$Res> {
  __$PostLikeEntityCopyWithImpl(this._self, this._then);

  final _PostLikeEntity _self;
  final $Res Function(_PostLikeEntity) _then;

  /// Create a copy of PostLikeEntity
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? postId = null,
    Object? userId = null,
    Object? createdAt = null,
  }) {
    return _then(_PostLikeEntity(
      postId: null == postId
          ? _self.postId
          : postId // ignore: cast_nullable_to_non_nullable
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
