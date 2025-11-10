// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'unread_badge_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$UnreadBadgeState {
  int get totalUnreadCount;
  List<Conversation> get conversations;
  bool get isLoading;

  /// Create a copy of UnreadBadgeState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $UnreadBadgeStateCopyWith<UnreadBadgeState> get copyWith =>
      _$UnreadBadgeStateCopyWithImpl<UnreadBadgeState>(
          this as UnreadBadgeState, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is UnreadBadgeState &&
            (identical(other.totalUnreadCount, totalUnreadCount) ||
                other.totalUnreadCount == totalUnreadCount) &&
            const DeepCollectionEquality()
                .equals(other.conversations, conversations) &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading));
  }

  @override
  int get hashCode => Object.hash(runtimeType, totalUnreadCount,
      const DeepCollectionEquality().hash(conversations), isLoading);

  @override
  String toString() {
    return 'UnreadBadgeState(totalUnreadCount: $totalUnreadCount, conversations: $conversations, isLoading: $isLoading)';
  }
}

/// @nodoc
abstract mixin class $UnreadBadgeStateCopyWith<$Res> {
  factory $UnreadBadgeStateCopyWith(
          UnreadBadgeState value, $Res Function(UnreadBadgeState) _then) =
      _$UnreadBadgeStateCopyWithImpl;
  @useResult
  $Res call(
      {int totalUnreadCount, List<Conversation> conversations, bool isLoading});
}

/// @nodoc
class _$UnreadBadgeStateCopyWithImpl<$Res>
    implements $UnreadBadgeStateCopyWith<$Res> {
  _$UnreadBadgeStateCopyWithImpl(this._self, this._then);

  final UnreadBadgeState _self;
  final $Res Function(UnreadBadgeState) _then;

  /// Create a copy of UnreadBadgeState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? totalUnreadCount = null,
    Object? conversations = null,
    Object? isLoading = null,
  }) {
    return _then(_self.copyWith(
      totalUnreadCount: null == totalUnreadCount
          ? _self.totalUnreadCount
          : totalUnreadCount // ignore: cast_nullable_to_non_nullable
              as int,
      conversations: null == conversations
          ? _self.conversations
          : conversations // ignore: cast_nullable_to_non_nullable
              as List<Conversation>,
      isLoading: null == isLoading
          ? _self.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// Adds pattern-matching-related methods to [UnreadBadgeState].
extension UnreadBadgeStatePatterns on UnreadBadgeState {
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
    TResult Function(_UnreadBadgeState value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _UnreadBadgeState() when $default != null:
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
    TResult Function(_UnreadBadgeState value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _UnreadBadgeState():
        return $default(_that);
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
    TResult? Function(_UnreadBadgeState value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _UnreadBadgeState() when $default != null:
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
    TResult Function(int totalUnreadCount, List<Conversation> conversations,
            bool isLoading)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _UnreadBadgeState() when $default != null:
        return $default(
            _that.totalUnreadCount, _that.conversations, _that.isLoading);
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
    TResult Function(int totalUnreadCount, List<Conversation> conversations,
            bool isLoading)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _UnreadBadgeState():
        return $default(
            _that.totalUnreadCount, _that.conversations, _that.isLoading);
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
    TResult? Function(int totalUnreadCount, List<Conversation> conversations,
            bool isLoading)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _UnreadBadgeState() when $default != null:
        return $default(
            _that.totalUnreadCount, _that.conversations, _that.isLoading);
      case _:
        return null;
    }
  }
}

/// @nodoc

class _UnreadBadgeState implements UnreadBadgeState {
  const _UnreadBadgeState(
      {this.totalUnreadCount = 0,
      final List<Conversation> conversations = const [],
      this.isLoading = true})
      : _conversations = conversations;

  @override
  @JsonKey()
  final int totalUnreadCount;
  final List<Conversation> _conversations;
  @override
  @JsonKey()
  List<Conversation> get conversations {
    if (_conversations is EqualUnmodifiableListView) return _conversations;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_conversations);
  }

  @override
  @JsonKey()
  final bool isLoading;

  /// Create a copy of UnreadBadgeState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$UnreadBadgeStateCopyWith<_UnreadBadgeState> get copyWith =>
      __$UnreadBadgeStateCopyWithImpl<_UnreadBadgeState>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _UnreadBadgeState &&
            (identical(other.totalUnreadCount, totalUnreadCount) ||
                other.totalUnreadCount == totalUnreadCount) &&
            const DeepCollectionEquality()
                .equals(other._conversations, _conversations) &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading));
  }

  @override
  int get hashCode => Object.hash(runtimeType, totalUnreadCount,
      const DeepCollectionEquality().hash(_conversations), isLoading);

  @override
  String toString() {
    return 'UnreadBadgeState(totalUnreadCount: $totalUnreadCount, conversations: $conversations, isLoading: $isLoading)';
  }
}

/// @nodoc
abstract mixin class _$UnreadBadgeStateCopyWith<$Res>
    implements $UnreadBadgeStateCopyWith<$Res> {
  factory _$UnreadBadgeStateCopyWith(
          _UnreadBadgeState value, $Res Function(_UnreadBadgeState) _then) =
      __$UnreadBadgeStateCopyWithImpl;
  @override
  @useResult
  $Res call(
      {int totalUnreadCount, List<Conversation> conversations, bool isLoading});
}

/// @nodoc
class __$UnreadBadgeStateCopyWithImpl<$Res>
    implements _$UnreadBadgeStateCopyWith<$Res> {
  __$UnreadBadgeStateCopyWithImpl(this._self, this._then);

  final _UnreadBadgeState _self;
  final $Res Function(_UnreadBadgeState) _then;

  /// Create a copy of UnreadBadgeState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? totalUnreadCount = null,
    Object? conversations = null,
    Object? isLoading = null,
  }) {
    return _then(_UnreadBadgeState(
      totalUnreadCount: null == totalUnreadCount
          ? _self.totalUnreadCount
          : totalUnreadCount // ignore: cast_nullable_to_non_nullable
              as int,
      conversations: null == conversations
          ? _self._conversations
          : conversations // ignore: cast_nullable_to_non_nullable
              as List<Conversation>,
      isLoading: null == isLoading
          ? _self.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

// dart format on
