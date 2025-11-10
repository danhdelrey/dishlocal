// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'follower_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$FollowerEntity {
  /// FK: Người được theo dõi.
  String get userId;

  /// FK: Người đi theo dõi.
  String get followerId;

  /// Thời điểm mối quan hệ được tạo.
  @DateTimeConverter()
  DateTime get createdAt;

  /// Create a copy of FollowerEntity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $FollowerEntityCopyWith<FollowerEntity> get copyWith =>
      _$FollowerEntityCopyWithImpl<FollowerEntity>(
          this as FollowerEntity, _$identity);

  /// Serializes this FollowerEntity to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is FollowerEntity &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.followerId, followerId) ||
                other.followerId == followerId) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, userId, followerId, createdAt);

  @override
  String toString() {
    return 'FollowerEntity(userId: $userId, followerId: $followerId, createdAt: $createdAt)';
  }
}

/// @nodoc
abstract mixin class $FollowerEntityCopyWith<$Res> {
  factory $FollowerEntityCopyWith(
          FollowerEntity value, $Res Function(FollowerEntity) _then) =
      _$FollowerEntityCopyWithImpl;
  @useResult
  $Res call(
      {String userId,
      String followerId,
      @DateTimeConverter() DateTime createdAt});
}

/// @nodoc
class _$FollowerEntityCopyWithImpl<$Res>
    implements $FollowerEntityCopyWith<$Res> {
  _$FollowerEntityCopyWithImpl(this._self, this._then);

  final FollowerEntity _self;
  final $Res Function(FollowerEntity) _then;

  /// Create a copy of FollowerEntity
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userId = null,
    Object? followerId = null,
    Object? createdAt = null,
  }) {
    return _then(_self.copyWith(
      userId: null == userId
          ? _self.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      followerId: null == followerId
          ? _self.followerId
          : followerId // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: null == createdAt
          ? _self.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// Adds pattern-matching-related methods to [FollowerEntity].
extension FollowerEntityPatterns on FollowerEntity {
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
    TResult Function(_FollowerEntity value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _FollowerEntity() when $default != null:
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
    TResult Function(_FollowerEntity value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _FollowerEntity():
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
    TResult? Function(_FollowerEntity value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _FollowerEntity() when $default != null:
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
    TResult Function(String userId, String followerId,
            @DateTimeConverter() DateTime createdAt)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _FollowerEntity() when $default != null:
        return $default(_that.userId, _that.followerId, _that.createdAt);
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
    TResult Function(String userId, String followerId,
            @DateTimeConverter() DateTime createdAt)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _FollowerEntity():
        return $default(_that.userId, _that.followerId, _that.createdAt);
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
    TResult? Function(String userId, String followerId,
            @DateTimeConverter() DateTime createdAt)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _FollowerEntity() when $default != null:
        return $default(_that.userId, _that.followerId, _that.createdAt);
      case _:
        return null;
    }
  }
}

/// @nodoc

@JsonSerializable(fieldRename: FieldRename.snake)
class _FollowerEntity implements FollowerEntity {
  const _FollowerEntity(
      {required this.userId,
      required this.followerId,
      @DateTimeConverter() required this.createdAt});
  factory _FollowerEntity.fromJson(Map<String, dynamic> json) =>
      _$FollowerEntityFromJson(json);

  /// FK: Người được theo dõi.
  @override
  final String userId;

  /// FK: Người đi theo dõi.
  @override
  final String followerId;

  /// Thời điểm mối quan hệ được tạo.
  @override
  @DateTimeConverter()
  final DateTime createdAt;

  /// Create a copy of FollowerEntity
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$FollowerEntityCopyWith<_FollowerEntity> get copyWith =>
      __$FollowerEntityCopyWithImpl<_FollowerEntity>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$FollowerEntityToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _FollowerEntity &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.followerId, followerId) ||
                other.followerId == followerId) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, userId, followerId, createdAt);

  @override
  String toString() {
    return 'FollowerEntity(userId: $userId, followerId: $followerId, createdAt: $createdAt)';
  }
}

/// @nodoc
abstract mixin class _$FollowerEntityCopyWith<$Res>
    implements $FollowerEntityCopyWith<$Res> {
  factory _$FollowerEntityCopyWith(
          _FollowerEntity value, $Res Function(_FollowerEntity) _then) =
      __$FollowerEntityCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String userId,
      String followerId,
      @DateTimeConverter() DateTime createdAt});
}

/// @nodoc
class __$FollowerEntityCopyWithImpl<$Res>
    implements _$FollowerEntityCopyWith<$Res> {
  __$FollowerEntityCopyWithImpl(this._self, this._then);

  final _FollowerEntity _self;
  final $Res Function(_FollowerEntity) _then;

  /// Create a copy of FollowerEntity
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? userId = null,
    Object? followerId = null,
    Object? createdAt = null,
  }) {
    return _then(_FollowerEntity(
      userId: null == userId
          ? _self.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      followerId: null == followerId
          ? _self.followerId
          : followerId // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: null == createdAt
          ? _self.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

// dart format on
