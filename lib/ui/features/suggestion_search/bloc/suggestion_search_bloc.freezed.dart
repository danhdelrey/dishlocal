// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'suggestion_search_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$SuggestionSearchEvent {
  String get query;

  /// Create a copy of SuggestionSearchEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $SuggestionSearchEventCopyWith<SuggestionSearchEvent> get copyWith =>
      _$SuggestionSearchEventCopyWithImpl<SuggestionSearchEvent>(
          this as SuggestionSearchEvent, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is SuggestionSearchEvent &&
            (identical(other.query, query) || other.query == query));
  }

  @override
  int get hashCode => Object.hash(runtimeType, query);

  @override
  String toString() {
    return 'SuggestionSearchEvent(query: $query)';
  }
}

/// @nodoc
abstract mixin class $SuggestionSearchEventCopyWith<$Res> {
  factory $SuggestionSearchEventCopyWith(SuggestionSearchEvent value,
          $Res Function(SuggestionSearchEvent) _then) =
      _$SuggestionSearchEventCopyWithImpl;
  @useResult
  $Res call({String query});
}

/// @nodoc
class _$SuggestionSearchEventCopyWithImpl<$Res>
    implements $SuggestionSearchEventCopyWith<$Res> {
  _$SuggestionSearchEventCopyWithImpl(this._self, this._then);

  final SuggestionSearchEvent _self;
  final $Res Function(SuggestionSearchEvent) _then;

  /// Create a copy of SuggestionSearchEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? query = null,
  }) {
    return _then(_self.copyWith(
      query: null == query
          ? _self.query
          : query // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// Adds pattern-matching-related methods to [SuggestionSearchEvent].
extension SuggestionSearchEventPatterns on SuggestionSearchEvent {
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
    TResult Function(_QueryChanged value)? queryChanged,
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _QueryChanged() when queryChanged != null:
        return queryChanged(_that);
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
    required TResult Function(_QueryChanged value) queryChanged,
  }) {
    final _that = this;
    switch (_that) {
      case _QueryChanged():
        return queryChanged(_that);
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
    TResult? Function(_QueryChanged value)? queryChanged,
  }) {
    final _that = this;
    switch (_that) {
      case _QueryChanged() when queryChanged != null:
        return queryChanged(_that);
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
    TResult Function(String query)? queryChanged,
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _QueryChanged() when queryChanged != null:
        return queryChanged(_that.query);
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
    required TResult Function(String query) queryChanged,
  }) {
    final _that = this;
    switch (_that) {
      case _QueryChanged():
        return queryChanged(_that.query);
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
    TResult? Function(String query)? queryChanged,
  }) {
    final _that = this;
    switch (_that) {
      case _QueryChanged() when queryChanged != null:
        return queryChanged(_that.query);
      case _:
        return null;
    }
  }
}

/// @nodoc

class _QueryChanged implements SuggestionSearchEvent {
  const _QueryChanged({required this.query});

  @override
  final String query;

  /// Create a copy of SuggestionSearchEvent
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$QueryChangedCopyWith<_QueryChanged> get copyWith =>
      __$QueryChangedCopyWithImpl<_QueryChanged>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _QueryChanged &&
            (identical(other.query, query) || other.query == query));
  }

  @override
  int get hashCode => Object.hash(runtimeType, query);

  @override
  String toString() {
    return 'SuggestionSearchEvent.queryChanged(query: $query)';
  }
}

/// @nodoc
abstract mixin class _$QueryChangedCopyWith<$Res>
    implements $SuggestionSearchEventCopyWith<$Res> {
  factory _$QueryChangedCopyWith(
          _QueryChanged value, $Res Function(_QueryChanged) _then) =
      __$QueryChangedCopyWithImpl;
  @override
  @useResult
  $Res call({String query});
}

/// @nodoc
class __$QueryChangedCopyWithImpl<$Res>
    implements _$QueryChangedCopyWith<$Res> {
  __$QueryChangedCopyWithImpl(this._self, this._then);

  final _QueryChanged _self;
  final $Res Function(_QueryChanged) _then;

  /// Create a copy of SuggestionSearchEvent
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? query = null,
  }) {
    return _then(_QueryChanged(
      query: null == query
          ? _self.query
          : query // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
mixin _$SuggestionSearchState {
  SuggestionStatus get status;
  List<String> get suggestions; // Lưu lỗi nếu có
  Object? get failure;

  /// Create a copy of SuggestionSearchState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $SuggestionSearchStateCopyWith<SuggestionSearchState> get copyWith =>
      _$SuggestionSearchStateCopyWithImpl<SuggestionSearchState>(
          this as SuggestionSearchState, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is SuggestionSearchState &&
            (identical(other.status, status) || other.status == status) &&
            const DeepCollectionEquality()
                .equals(other.suggestions, suggestions) &&
            const DeepCollectionEquality().equals(other.failure, failure));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      status,
      const DeepCollectionEquality().hash(suggestions),
      const DeepCollectionEquality().hash(failure));

  @override
  String toString() {
    return 'SuggestionSearchState(status: $status, suggestions: $suggestions, failure: $failure)';
  }
}

/// @nodoc
abstract mixin class $SuggestionSearchStateCopyWith<$Res> {
  factory $SuggestionSearchStateCopyWith(SuggestionSearchState value,
          $Res Function(SuggestionSearchState) _then) =
      _$SuggestionSearchStateCopyWithImpl;
  @useResult
  $Res call(
      {SuggestionStatus status, List<String> suggestions, Object? failure});
}

/// @nodoc
class _$SuggestionSearchStateCopyWithImpl<$Res>
    implements $SuggestionSearchStateCopyWith<$Res> {
  _$SuggestionSearchStateCopyWithImpl(this._self, this._then);

  final SuggestionSearchState _self;
  final $Res Function(SuggestionSearchState) _then;

  /// Create a copy of SuggestionSearchState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? suggestions = null,
    Object? failure = freezed,
  }) {
    return _then(_self.copyWith(
      status: null == status
          ? _self.status
          : status // ignore: cast_nullable_to_non_nullable
              as SuggestionStatus,
      suggestions: null == suggestions
          ? _self.suggestions
          : suggestions // ignore: cast_nullable_to_non_nullable
              as List<String>,
      failure: freezed == failure ? _self.failure : failure,
    ));
  }
}

/// Adds pattern-matching-related methods to [SuggestionSearchState].
extension SuggestionSearchStatePatterns on SuggestionSearchState {
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
    TResult Function(_SuggestionSearchState value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _SuggestionSearchState() when $default != null:
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
    TResult Function(_SuggestionSearchState value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _SuggestionSearchState():
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
    TResult? Function(_SuggestionSearchState value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _SuggestionSearchState() when $default != null:
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
            SuggestionStatus status, List<String> suggestions, Object? failure)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _SuggestionSearchState() when $default != null:
        return $default(_that.status, _that.suggestions, _that.failure);
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
            SuggestionStatus status, List<String> suggestions, Object? failure)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _SuggestionSearchState():
        return $default(_that.status, _that.suggestions, _that.failure);
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
            SuggestionStatus status, List<String> suggestions, Object? failure)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _SuggestionSearchState() when $default != null:
        return $default(_that.status, _that.suggestions, _that.failure);
      case _:
        return null;
    }
  }
}

/// @nodoc

class _SuggestionSearchState implements SuggestionSearchState {
  const _SuggestionSearchState(
      {this.status = SuggestionStatus.initial,
      final List<String> suggestions = const [],
      this.failure})
      : _suggestions = suggestions;

  @override
  @JsonKey()
  final SuggestionStatus status;
  final List<String> _suggestions;
  @override
  @JsonKey()
  List<String> get suggestions {
    if (_suggestions is EqualUnmodifiableListView) return _suggestions;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_suggestions);
  }

// Lưu lỗi nếu có
  @override
  final Object? failure;

  /// Create a copy of SuggestionSearchState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$SuggestionSearchStateCopyWith<_SuggestionSearchState> get copyWith =>
      __$SuggestionSearchStateCopyWithImpl<_SuggestionSearchState>(
          this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _SuggestionSearchState &&
            (identical(other.status, status) || other.status == status) &&
            const DeepCollectionEquality()
                .equals(other._suggestions, _suggestions) &&
            const DeepCollectionEquality().equals(other.failure, failure));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      status,
      const DeepCollectionEquality().hash(_suggestions),
      const DeepCollectionEquality().hash(failure));

  @override
  String toString() {
    return 'SuggestionSearchState(status: $status, suggestions: $suggestions, failure: $failure)';
  }
}

/// @nodoc
abstract mixin class _$SuggestionSearchStateCopyWith<$Res>
    implements $SuggestionSearchStateCopyWith<$Res> {
  factory _$SuggestionSearchStateCopyWith(_SuggestionSearchState value,
          $Res Function(_SuggestionSearchState) _then) =
      __$SuggestionSearchStateCopyWithImpl;
  @override
  @useResult
  $Res call(
      {SuggestionStatus status, List<String> suggestions, Object? failure});
}

/// @nodoc
class __$SuggestionSearchStateCopyWithImpl<$Res>
    implements _$SuggestionSearchStateCopyWith<$Res> {
  __$SuggestionSearchStateCopyWithImpl(this._self, this._then);

  final _SuggestionSearchState _self;
  final $Res Function(_SuggestionSearchState) _then;

  /// Create a copy of SuggestionSearchState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? status = null,
    Object? suggestions = null,
    Object? failure = freezed,
  }) {
    return _then(_SuggestionSearchState(
      status: null == status
          ? _self.status
          : status // ignore: cast_nullable_to_non_nullable
              as SuggestionStatus,
      suggestions: null == suggestions
          ? _self._suggestions
          : suggestions // ignore: cast_nullable_to_non_nullable
              as List<String>,
      failure: freezed == failure ? _self.failure : failure,
    ));
  }
}

// dart format on
