// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'conversation_list_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ConversationListState {
  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is ConversationListState);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'ConversationListState()';
  }
}

/// @nodoc
class $ConversationListStateCopyWith<$Res> {
  $ConversationListStateCopyWith(
      ConversationListState _, $Res Function(ConversationListState) __);
}

/// Adds pattern-matching-related methods to [ConversationListState].
extension ConversationListStatePatterns on ConversationListState {
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
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ConversationListLoading value)? loading,
    TResult Function(ConversationListLoaded value)? loaded,
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case ConversationListLoading() when loading != null:
        return loading(_that);
      case ConversationListLoaded() when loaded != null:
        return loaded(_that);
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
  TResult map<TResult extends Object?>({
    required TResult Function(ConversationListLoading value) loading,
    required TResult Function(ConversationListLoaded value) loaded,
  }) {
    final _that = this;
    switch (_that) {
      case ConversationListLoading():
        return loading(_that);
      case ConversationListLoaded():
        return loaded(_that);
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
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ConversationListLoading value)? loading,
    TResult? Function(ConversationListLoaded value)? loaded,
  }) {
    final _that = this;
    switch (_that) {
      case ConversationListLoading() when loading != null:
        return loading(_that);
      case ConversationListLoaded() when loaded != null:
        return loaded(_that);
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
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(List<Conversation> conversations)? loaded,
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case ConversationListLoading() when loading != null:
        return loading();
      case ConversationListLoaded() when loaded != null:
        return loaded(_that.conversations);
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
  TResult when<TResult extends Object?>({
    required TResult Function() loading,
    required TResult Function(List<Conversation> conversations) loaded,
  }) {
    final _that = this;
    switch (_that) {
      case ConversationListLoading():
        return loading();
      case ConversationListLoaded():
        return loaded(_that.conversations);
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
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loading,
    TResult? Function(List<Conversation> conversations)? loaded,
  }) {
    final _that = this;
    switch (_that) {
      case ConversationListLoading() when loading != null:
        return loading();
      case ConversationListLoaded() when loaded != null:
        return loaded(_that.conversations);
      case _:
        return null;
    }
  }
}

/// @nodoc

class ConversationListLoading implements ConversationListState {
  const ConversationListLoading();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is ConversationListLoading);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'ConversationListState.loading()';
  }
}

/// @nodoc

class ConversationListLoaded implements ConversationListState {
  const ConversationListLoaded(final List<Conversation> conversations)
      : _conversations = conversations;

  final List<Conversation> _conversations;
  List<Conversation> get conversations {
    if (_conversations is EqualUnmodifiableListView) return _conversations;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_conversations);
  }

  /// Create a copy of ConversationListState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $ConversationListLoadedCopyWith<ConversationListLoaded> get copyWith =>
      _$ConversationListLoadedCopyWithImpl<ConversationListLoaded>(
          this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is ConversationListLoaded &&
            const DeepCollectionEquality()
                .equals(other._conversations, _conversations));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(_conversations));

  @override
  String toString() {
    return 'ConversationListState.loaded(conversations: $conversations)';
  }
}

/// @nodoc
abstract mixin class $ConversationListLoadedCopyWith<$Res>
    implements $ConversationListStateCopyWith<$Res> {
  factory $ConversationListLoadedCopyWith(ConversationListLoaded value,
          $Res Function(ConversationListLoaded) _then) =
      _$ConversationListLoadedCopyWithImpl;
  @useResult
  $Res call({List<Conversation> conversations});
}

/// @nodoc
class _$ConversationListLoadedCopyWithImpl<$Res>
    implements $ConversationListLoadedCopyWith<$Res> {
  _$ConversationListLoadedCopyWithImpl(this._self, this._then);

  final ConversationListLoaded _self;
  final $Res Function(ConversationListLoaded) _then;

  /// Create a copy of ConversationListState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? conversations = null,
  }) {
    return _then(ConversationListLoaded(
      null == conversations
          ? _self._conversations
          : conversations // ignore: cast_nullable_to_non_nullable
              as List<Conversation>,
    ));
  }
}

// dart format on
