// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'conversation_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ConversationEntity {
  /// PK: Primary Key, định danh duy nhất của cuộc trò chuyện.
  String get id;

  /// Thời điểm cuộc trò chuyện được tạo.
  @DateTimeConverter()
  DateTime get createdAt;

  /// (Denormalized) Thời điểm của tin nhắn cuối cùng trong cuộc trò chuyện.
  /// Dùng để sắp xếp danh sách chat một cách hiệu quả.
  @DateTimeConverter()
  DateTime? get lastMessageAt;

  /// Create a copy of ConversationEntity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $ConversationEntityCopyWith<ConversationEntity> get copyWith =>
      _$ConversationEntityCopyWithImpl<ConversationEntity>(
          this as ConversationEntity, _$identity);

  /// Serializes this ConversationEntity to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is ConversationEntity &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.lastMessageAt, lastMessageAt) ||
                other.lastMessageAt == lastMessageAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, createdAt, lastMessageAt);

  @override
  String toString() {
    return 'ConversationEntity(id: $id, createdAt: $createdAt, lastMessageAt: $lastMessageAt)';
  }
}

/// @nodoc
abstract mixin class $ConversationEntityCopyWith<$Res> {
  factory $ConversationEntityCopyWith(
          ConversationEntity value, $Res Function(ConversationEntity) _then) =
      _$ConversationEntityCopyWithImpl;
  @useResult
  $Res call(
      {String id,
      @DateTimeConverter() DateTime createdAt,
      @DateTimeConverter() DateTime? lastMessageAt});
}

/// @nodoc
class _$ConversationEntityCopyWithImpl<$Res>
    implements $ConversationEntityCopyWith<$Res> {
  _$ConversationEntityCopyWithImpl(this._self, this._then);

  final ConversationEntity _self;
  final $Res Function(ConversationEntity) _then;

  /// Create a copy of ConversationEntity
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? createdAt = null,
    Object? lastMessageAt = freezed,
  }) {
    return _then(_self.copyWith(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: null == createdAt
          ? _self.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      lastMessageAt: freezed == lastMessageAt
          ? _self.lastMessageAt
          : lastMessageAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// Adds pattern-matching-related methods to [ConversationEntity].
extension ConversationEntityPatterns on ConversationEntity {
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
    TResult Function(_ConversationEntity value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _ConversationEntity() when $default != null:
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
    TResult Function(_ConversationEntity value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ConversationEntity():
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
    TResult? Function(_ConversationEntity value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ConversationEntity() when $default != null:
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
    TResult Function(String id, @DateTimeConverter() DateTime createdAt,
            @DateTimeConverter() DateTime? lastMessageAt)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _ConversationEntity() when $default != null:
        return $default(_that.id, _that.createdAt, _that.lastMessageAt);
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
    TResult Function(String id, @DateTimeConverter() DateTime createdAt,
            @DateTimeConverter() DateTime? lastMessageAt)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ConversationEntity():
        return $default(_that.id, _that.createdAt, _that.lastMessageAt);
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
    TResult? Function(String id, @DateTimeConverter() DateTime createdAt,
            @DateTimeConverter() DateTime? lastMessageAt)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ConversationEntity() when $default != null:
        return $default(_that.id, _that.createdAt, _that.lastMessageAt);
      case _:
        return null;
    }
  }
}

/// @nodoc

@JsonSerializable(fieldRename: FieldRename.snake)
class _ConversationEntity implements ConversationEntity {
  const _ConversationEntity(
      {required this.id,
      @DateTimeConverter() required this.createdAt,
      @DateTimeConverter() this.lastMessageAt});
  factory _ConversationEntity.fromJson(Map<String, dynamic> json) =>
      _$ConversationEntityFromJson(json);

  /// PK: Primary Key, định danh duy nhất của cuộc trò chuyện.
  @override
  final String id;

  /// Thời điểm cuộc trò chuyện được tạo.
  @override
  @DateTimeConverter()
  final DateTime createdAt;

  /// (Denormalized) Thời điểm của tin nhắn cuối cùng trong cuộc trò chuyện.
  /// Dùng để sắp xếp danh sách chat một cách hiệu quả.
  @override
  @DateTimeConverter()
  final DateTime? lastMessageAt;

  /// Create a copy of ConversationEntity
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$ConversationEntityCopyWith<_ConversationEntity> get copyWith =>
      __$ConversationEntityCopyWithImpl<_ConversationEntity>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$ConversationEntityToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _ConversationEntity &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.lastMessageAt, lastMessageAt) ||
                other.lastMessageAt == lastMessageAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, createdAt, lastMessageAt);

  @override
  String toString() {
    return 'ConversationEntity(id: $id, createdAt: $createdAt, lastMessageAt: $lastMessageAt)';
  }
}

/// @nodoc
abstract mixin class _$ConversationEntityCopyWith<$Res>
    implements $ConversationEntityCopyWith<$Res> {
  factory _$ConversationEntityCopyWith(
          _ConversationEntity value, $Res Function(_ConversationEntity) _then) =
      __$ConversationEntityCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String id,
      @DateTimeConverter() DateTime createdAt,
      @DateTimeConverter() DateTime? lastMessageAt});
}

/// @nodoc
class __$ConversationEntityCopyWithImpl<$Res>
    implements _$ConversationEntityCopyWith<$Res> {
  __$ConversationEntityCopyWithImpl(this._self, this._then);

  final _ConversationEntity _self;
  final $Res Function(_ConversationEntity) _then;

  /// Create a copy of ConversationEntity
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = null,
    Object? createdAt = null,
    Object? lastMessageAt = freezed,
  }) {
    return _then(_ConversationEntity(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: null == createdAt
          ? _self.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      lastMessageAt: freezed == lastMessageAt
          ? _self.lastMessageAt
          : lastMessageAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

// dart format on
