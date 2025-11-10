// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'conversation_participant_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ConversationParticipantEntity {
  /// PK, FK: Tham chiếu đến `conversations.id`.
  String get conversationId;

  /// PK, FK: Tham chiếu đến `profiles.id` của người tham gia.
  String get userId;

  /// Thời điểm cuối cùng người dùng đọc tin nhắn trong cuộc trò chuyện này.
  /// Giá trị này dùng để xác định tin nhắn chưa đọc và trạng thái "Đã xem".
  @DateTimeConverter()
  DateTime? get lastReadAt;

  /// Create a copy of ConversationParticipantEntity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $ConversationParticipantEntityCopyWith<ConversationParticipantEntity>
      get copyWith => _$ConversationParticipantEntityCopyWithImpl<
              ConversationParticipantEntity>(
          this as ConversationParticipantEntity, _$identity);

  /// Serializes this ConversationParticipantEntity to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is ConversationParticipantEntity &&
            (identical(other.conversationId, conversationId) ||
                other.conversationId == conversationId) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.lastReadAt, lastReadAt) ||
                other.lastReadAt == lastReadAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, conversationId, userId, lastReadAt);

  @override
  String toString() {
    return 'ConversationParticipantEntity(conversationId: $conversationId, userId: $userId, lastReadAt: $lastReadAt)';
  }
}

/// @nodoc
abstract mixin class $ConversationParticipantEntityCopyWith<$Res> {
  factory $ConversationParticipantEntityCopyWith(
          ConversationParticipantEntity value,
          $Res Function(ConversationParticipantEntity) _then) =
      _$ConversationParticipantEntityCopyWithImpl;
  @useResult
  $Res call(
      {String conversationId,
      String userId,
      @DateTimeConverter() DateTime? lastReadAt});
}

/// @nodoc
class _$ConversationParticipantEntityCopyWithImpl<$Res>
    implements $ConversationParticipantEntityCopyWith<$Res> {
  _$ConversationParticipantEntityCopyWithImpl(this._self, this._then);

  final ConversationParticipantEntity _self;
  final $Res Function(ConversationParticipantEntity) _then;

  /// Create a copy of ConversationParticipantEntity
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? conversationId = null,
    Object? userId = null,
    Object? lastReadAt = freezed,
  }) {
    return _then(_self.copyWith(
      conversationId: null == conversationId
          ? _self.conversationId
          : conversationId // ignore: cast_nullable_to_non_nullable
              as String,
      userId: null == userId
          ? _self.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      lastReadAt: freezed == lastReadAt
          ? _self.lastReadAt
          : lastReadAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// Adds pattern-matching-related methods to [ConversationParticipantEntity].
extension ConversationParticipantEntityPatterns
    on ConversationParticipantEntity {
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
    TResult Function(_ConversationParticipantEntity value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _ConversationParticipantEntity() when $default != null:
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
    TResult Function(_ConversationParticipantEntity value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ConversationParticipantEntity():
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
    TResult? Function(_ConversationParticipantEntity value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ConversationParticipantEntity() when $default != null:
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
    TResult Function(String conversationId, String userId,
            @DateTimeConverter() DateTime? lastReadAt)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _ConversationParticipantEntity() when $default != null:
        return $default(_that.conversationId, _that.userId, _that.lastReadAt);
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
    TResult Function(String conversationId, String userId,
            @DateTimeConverter() DateTime? lastReadAt)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ConversationParticipantEntity():
        return $default(_that.conversationId, _that.userId, _that.lastReadAt);
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
    TResult? Function(String conversationId, String userId,
            @DateTimeConverter() DateTime? lastReadAt)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ConversationParticipantEntity() when $default != null:
        return $default(_that.conversationId, _that.userId, _that.lastReadAt);
      case _:
        return null;
    }
  }
}

/// @nodoc

@JsonSerializable(fieldRename: FieldRename.snake)
class _ConversationParticipantEntity implements ConversationParticipantEntity {
  const _ConversationParticipantEntity(
      {required this.conversationId,
      required this.userId,
      @DateTimeConverter() this.lastReadAt});
  factory _ConversationParticipantEntity.fromJson(Map<String, dynamic> json) =>
      _$ConversationParticipantEntityFromJson(json);

  /// PK, FK: Tham chiếu đến `conversations.id`.
  @override
  final String conversationId;

  /// PK, FK: Tham chiếu đến `profiles.id` của người tham gia.
  @override
  final String userId;

  /// Thời điểm cuối cùng người dùng đọc tin nhắn trong cuộc trò chuyện này.
  /// Giá trị này dùng để xác định tin nhắn chưa đọc và trạng thái "Đã xem".
  @override
  @DateTimeConverter()
  final DateTime? lastReadAt;

  /// Create a copy of ConversationParticipantEntity
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$ConversationParticipantEntityCopyWith<_ConversationParticipantEntity>
      get copyWith => __$ConversationParticipantEntityCopyWithImpl<
          _ConversationParticipantEntity>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$ConversationParticipantEntityToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _ConversationParticipantEntity &&
            (identical(other.conversationId, conversationId) ||
                other.conversationId == conversationId) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.lastReadAt, lastReadAt) ||
                other.lastReadAt == lastReadAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, conversationId, userId, lastReadAt);

  @override
  String toString() {
    return 'ConversationParticipantEntity(conversationId: $conversationId, userId: $userId, lastReadAt: $lastReadAt)';
  }
}

/// @nodoc
abstract mixin class _$ConversationParticipantEntityCopyWith<$Res>
    implements $ConversationParticipantEntityCopyWith<$Res> {
  factory _$ConversationParticipantEntityCopyWith(
          _ConversationParticipantEntity value,
          $Res Function(_ConversationParticipantEntity) _then) =
      __$ConversationParticipantEntityCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String conversationId,
      String userId,
      @DateTimeConverter() DateTime? lastReadAt});
}

/// @nodoc
class __$ConversationParticipantEntityCopyWithImpl<$Res>
    implements _$ConversationParticipantEntityCopyWith<$Res> {
  __$ConversationParticipantEntityCopyWithImpl(this._self, this._then);

  final _ConversationParticipantEntity _self;
  final $Res Function(_ConversationParticipantEntity) _then;

  /// Create a copy of ConversationParticipantEntity
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? conversationId = null,
    Object? userId = null,
    Object? lastReadAt = freezed,
  }) {
    return _then(_ConversationParticipantEntity(
      conversationId: null == conversationId
          ? _self.conversationId
          : conversationId // ignore: cast_nullable_to_non_nullable
              as String,
      userId: null == userId
          ? _self.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      lastReadAt: freezed == lastReadAt
          ? _self.lastReadAt
          : lastReadAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

// dart format on
