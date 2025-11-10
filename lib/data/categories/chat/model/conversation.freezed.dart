// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'conversation.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Conversation {
  String get conversationId;
  AppUser get otherParticipant;
  String? get lastMessageContent;
  @DateTimeConverter()
  DateTime? get lastMessageCreatedAt;
  String? get lastMessageSenderId;
  String? get lastMessageSharedPostId;
  int get unreadCount;
  String? get lastMessageType;

  /// Create a copy of Conversation
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $ConversationCopyWith<Conversation> get copyWith =>
      _$ConversationCopyWithImpl<Conversation>(
          this as Conversation, _$identity);

  /// Serializes this Conversation to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is Conversation &&
            (identical(other.conversationId, conversationId) ||
                other.conversationId == conversationId) &&
            (identical(other.otherParticipant, otherParticipant) ||
                other.otherParticipant == otherParticipant) &&
            (identical(other.lastMessageContent, lastMessageContent) ||
                other.lastMessageContent == lastMessageContent) &&
            (identical(other.lastMessageCreatedAt, lastMessageCreatedAt) ||
                other.lastMessageCreatedAt == lastMessageCreatedAt) &&
            (identical(other.lastMessageSenderId, lastMessageSenderId) ||
                other.lastMessageSenderId == lastMessageSenderId) &&
            (identical(
                    other.lastMessageSharedPostId, lastMessageSharedPostId) ||
                other.lastMessageSharedPostId == lastMessageSharedPostId) &&
            (identical(other.unreadCount, unreadCount) ||
                other.unreadCount == unreadCount) &&
            (identical(other.lastMessageType, lastMessageType) ||
                other.lastMessageType == lastMessageType));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      conversationId,
      otherParticipant,
      lastMessageContent,
      lastMessageCreatedAt,
      lastMessageSenderId,
      lastMessageSharedPostId,
      unreadCount,
      lastMessageType);

  @override
  String toString() {
    return 'Conversation(conversationId: $conversationId, otherParticipant: $otherParticipant, lastMessageContent: $lastMessageContent, lastMessageCreatedAt: $lastMessageCreatedAt, lastMessageSenderId: $lastMessageSenderId, lastMessageSharedPostId: $lastMessageSharedPostId, unreadCount: $unreadCount, lastMessageType: $lastMessageType)';
  }
}

/// @nodoc
abstract mixin class $ConversationCopyWith<$Res> {
  factory $ConversationCopyWith(
          Conversation value, $Res Function(Conversation) _then) =
      _$ConversationCopyWithImpl;
  @useResult
  $Res call(
      {String conversationId,
      AppUser otherParticipant,
      String? lastMessageContent,
      @DateTimeConverter() DateTime? lastMessageCreatedAt,
      String? lastMessageSenderId,
      String? lastMessageSharedPostId,
      int unreadCount,
      String? lastMessageType});

  $AppUserCopyWith<$Res> get otherParticipant;
}

/// @nodoc
class _$ConversationCopyWithImpl<$Res> implements $ConversationCopyWith<$Res> {
  _$ConversationCopyWithImpl(this._self, this._then);

  final Conversation _self;
  final $Res Function(Conversation) _then;

  /// Create a copy of Conversation
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? conversationId = null,
    Object? otherParticipant = null,
    Object? lastMessageContent = freezed,
    Object? lastMessageCreatedAt = freezed,
    Object? lastMessageSenderId = freezed,
    Object? lastMessageSharedPostId = freezed,
    Object? unreadCount = null,
    Object? lastMessageType = freezed,
  }) {
    return _then(_self.copyWith(
      conversationId: null == conversationId
          ? _self.conversationId
          : conversationId // ignore: cast_nullable_to_non_nullable
              as String,
      otherParticipant: null == otherParticipant
          ? _self.otherParticipant
          : otherParticipant // ignore: cast_nullable_to_non_nullable
              as AppUser,
      lastMessageContent: freezed == lastMessageContent
          ? _self.lastMessageContent
          : lastMessageContent // ignore: cast_nullable_to_non_nullable
              as String?,
      lastMessageCreatedAt: freezed == lastMessageCreatedAt
          ? _self.lastMessageCreatedAt
          : lastMessageCreatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      lastMessageSenderId: freezed == lastMessageSenderId
          ? _self.lastMessageSenderId
          : lastMessageSenderId // ignore: cast_nullable_to_non_nullable
              as String?,
      lastMessageSharedPostId: freezed == lastMessageSharedPostId
          ? _self.lastMessageSharedPostId
          : lastMessageSharedPostId // ignore: cast_nullable_to_non_nullable
              as String?,
      unreadCount: null == unreadCount
          ? _self.unreadCount
          : unreadCount // ignore: cast_nullable_to_non_nullable
              as int,
      lastMessageType: freezed == lastMessageType
          ? _self.lastMessageType
          : lastMessageType // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }

  /// Create a copy of Conversation
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $AppUserCopyWith<$Res> get otherParticipant {
    return $AppUserCopyWith<$Res>(_self.otherParticipant, (value) {
      return _then(_self.copyWith(otherParticipant: value));
    });
  }
}

/// Adds pattern-matching-related methods to [Conversation].
extension ConversationPatterns on Conversation {
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
    TResult Function(_Conversation value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _Conversation() when $default != null:
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
    TResult Function(_Conversation value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Conversation():
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
    TResult? Function(_Conversation value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Conversation() when $default != null:
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
    TResult Function(
            String conversationId,
            AppUser otherParticipant,
            String? lastMessageContent,
            @DateTimeConverter() DateTime? lastMessageCreatedAt,
            String? lastMessageSenderId,
            String? lastMessageSharedPostId,
            int unreadCount,
            String? lastMessageType)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _Conversation() when $default != null:
        return $default(
            _that.conversationId,
            _that.otherParticipant,
            _that.lastMessageContent,
            _that.lastMessageCreatedAt,
            _that.lastMessageSenderId,
            _that.lastMessageSharedPostId,
            _that.unreadCount,
            _that.lastMessageType);
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
    TResult Function(
            String conversationId,
            AppUser otherParticipant,
            String? lastMessageContent,
            @DateTimeConverter() DateTime? lastMessageCreatedAt,
            String? lastMessageSenderId,
            String? lastMessageSharedPostId,
            int unreadCount,
            String? lastMessageType)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Conversation():
        return $default(
            _that.conversationId,
            _that.otherParticipant,
            _that.lastMessageContent,
            _that.lastMessageCreatedAt,
            _that.lastMessageSenderId,
            _that.lastMessageSharedPostId,
            _that.unreadCount,
            _that.lastMessageType);
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
    TResult? Function(
            String conversationId,
            AppUser otherParticipant,
            String? lastMessageContent,
            @DateTimeConverter() DateTime? lastMessageCreatedAt,
            String? lastMessageSenderId,
            String? lastMessageSharedPostId,
            int unreadCount,
            String? lastMessageType)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Conversation() when $default != null:
        return $default(
            _that.conversationId,
            _that.otherParticipant,
            _that.lastMessageContent,
            _that.lastMessageCreatedAt,
            _that.lastMessageSenderId,
            _that.lastMessageSharedPostId,
            _that.unreadCount,
            _that.lastMessageType);
      case _:
        return null;
    }
  }
}

/// @nodoc

@JsonSerializable(fieldRename: FieldRename.snake)
class _Conversation implements Conversation {
  const _Conversation(
      {required this.conversationId,
      required this.otherParticipant,
      this.lastMessageContent,
      @DateTimeConverter() this.lastMessageCreatedAt,
      this.lastMessageSenderId,
      this.lastMessageSharedPostId,
      this.unreadCount = 0,
      this.lastMessageType});
  factory _Conversation.fromJson(Map<String, dynamic> json) =>
      _$ConversationFromJson(json);

  @override
  final String conversationId;
  @override
  final AppUser otherParticipant;
  @override
  final String? lastMessageContent;
  @override
  @DateTimeConverter()
  final DateTime? lastMessageCreatedAt;
  @override
  final String? lastMessageSenderId;
  @override
  final String? lastMessageSharedPostId;
  @override
  @JsonKey()
  final int unreadCount;
  @override
  final String? lastMessageType;

  /// Create a copy of Conversation
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$ConversationCopyWith<_Conversation> get copyWith =>
      __$ConversationCopyWithImpl<_Conversation>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$ConversationToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Conversation &&
            (identical(other.conversationId, conversationId) ||
                other.conversationId == conversationId) &&
            (identical(other.otherParticipant, otherParticipant) ||
                other.otherParticipant == otherParticipant) &&
            (identical(other.lastMessageContent, lastMessageContent) ||
                other.lastMessageContent == lastMessageContent) &&
            (identical(other.lastMessageCreatedAt, lastMessageCreatedAt) ||
                other.lastMessageCreatedAt == lastMessageCreatedAt) &&
            (identical(other.lastMessageSenderId, lastMessageSenderId) ||
                other.lastMessageSenderId == lastMessageSenderId) &&
            (identical(
                    other.lastMessageSharedPostId, lastMessageSharedPostId) ||
                other.lastMessageSharedPostId == lastMessageSharedPostId) &&
            (identical(other.unreadCount, unreadCount) ||
                other.unreadCount == unreadCount) &&
            (identical(other.lastMessageType, lastMessageType) ||
                other.lastMessageType == lastMessageType));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      conversationId,
      otherParticipant,
      lastMessageContent,
      lastMessageCreatedAt,
      lastMessageSenderId,
      lastMessageSharedPostId,
      unreadCount,
      lastMessageType);

  @override
  String toString() {
    return 'Conversation(conversationId: $conversationId, otherParticipant: $otherParticipant, lastMessageContent: $lastMessageContent, lastMessageCreatedAt: $lastMessageCreatedAt, lastMessageSenderId: $lastMessageSenderId, lastMessageSharedPostId: $lastMessageSharedPostId, unreadCount: $unreadCount, lastMessageType: $lastMessageType)';
  }
}

/// @nodoc
abstract mixin class _$ConversationCopyWith<$Res>
    implements $ConversationCopyWith<$Res> {
  factory _$ConversationCopyWith(
          _Conversation value, $Res Function(_Conversation) _then) =
      __$ConversationCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String conversationId,
      AppUser otherParticipant,
      String? lastMessageContent,
      @DateTimeConverter() DateTime? lastMessageCreatedAt,
      String? lastMessageSenderId,
      String? lastMessageSharedPostId,
      int unreadCount,
      String? lastMessageType});

  @override
  $AppUserCopyWith<$Res> get otherParticipant;
}

/// @nodoc
class __$ConversationCopyWithImpl<$Res>
    implements _$ConversationCopyWith<$Res> {
  __$ConversationCopyWithImpl(this._self, this._then);

  final _Conversation _self;
  final $Res Function(_Conversation) _then;

  /// Create a copy of Conversation
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? conversationId = null,
    Object? otherParticipant = null,
    Object? lastMessageContent = freezed,
    Object? lastMessageCreatedAt = freezed,
    Object? lastMessageSenderId = freezed,
    Object? lastMessageSharedPostId = freezed,
    Object? unreadCount = null,
    Object? lastMessageType = freezed,
  }) {
    return _then(_Conversation(
      conversationId: null == conversationId
          ? _self.conversationId
          : conversationId // ignore: cast_nullable_to_non_nullable
              as String,
      otherParticipant: null == otherParticipant
          ? _self.otherParticipant
          : otherParticipant // ignore: cast_nullable_to_non_nullable
              as AppUser,
      lastMessageContent: freezed == lastMessageContent
          ? _self.lastMessageContent
          : lastMessageContent // ignore: cast_nullable_to_non_nullable
              as String?,
      lastMessageCreatedAt: freezed == lastMessageCreatedAt
          ? _self.lastMessageCreatedAt
          : lastMessageCreatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      lastMessageSenderId: freezed == lastMessageSenderId
          ? _self.lastMessageSenderId
          : lastMessageSenderId // ignore: cast_nullable_to_non_nullable
              as String?,
      lastMessageSharedPostId: freezed == lastMessageSharedPostId
          ? _self.lastMessageSharedPostId
          : lastMessageSharedPostId // ignore: cast_nullable_to_non_nullable
              as String?,
      unreadCount: null == unreadCount
          ? _self.unreadCount
          : unreadCount // ignore: cast_nullable_to_non_nullable
              as int,
      lastMessageType: freezed == lastMessageType
          ? _self.lastMessageType
          : lastMessageType // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }

  /// Create a copy of Conversation
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $AppUserCopyWith<$Res> get otherParticipant {
    return $AppUserCopyWith<$Res>(_self.otherParticipant, (value) {
      return _then(_self.copyWith(otherParticipant: value));
    });
  }
}

// dart format on
