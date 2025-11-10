// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'suggestion_result.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$SuggestionResult {
  List<String> get suggestions;

  /// Create a copy of SuggestionResult
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $SuggestionResultCopyWith<SuggestionResult> get copyWith =>
      _$SuggestionResultCopyWithImpl<SuggestionResult>(
          this as SuggestionResult, _$identity);

  /// Serializes this SuggestionResult to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is SuggestionResult &&
            const DeepCollectionEquality()
                .equals(other.suggestions, suggestions));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(suggestions));

  @override
  String toString() {
    return 'SuggestionResult(suggestions: $suggestions)';
  }
}

/// @nodoc
abstract mixin class $SuggestionResultCopyWith<$Res> {
  factory $SuggestionResultCopyWith(
          SuggestionResult value, $Res Function(SuggestionResult) _then) =
      _$SuggestionResultCopyWithImpl;
  @useResult
  $Res call({List<String> suggestions});
}

/// @nodoc
class _$SuggestionResultCopyWithImpl<$Res>
    implements $SuggestionResultCopyWith<$Res> {
  _$SuggestionResultCopyWithImpl(this._self, this._then);

  final SuggestionResult _self;
  final $Res Function(SuggestionResult) _then;

  /// Create a copy of SuggestionResult
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? suggestions = null,
  }) {
    return _then(_self.copyWith(
      suggestions: null == suggestions
          ? _self.suggestions
          : suggestions // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ));
  }
}

/// Adds pattern-matching-related methods to [SuggestionResult].
extension SuggestionResultPatterns on SuggestionResult {
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
    TResult Function(_SuggestionResult value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _SuggestionResult() when $default != null:
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
    TResult Function(_SuggestionResult value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _SuggestionResult():
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
    TResult? Function(_SuggestionResult value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _SuggestionResult() when $default != null:
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
    TResult Function(List<String> suggestions)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _SuggestionResult() when $default != null:
        return $default(_that.suggestions);
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
    TResult Function(List<String> suggestions) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _SuggestionResult():
        return $default(_that.suggestions);
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
    TResult? Function(List<String> suggestions)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _SuggestionResult() when $default != null:
        return $default(_that.suggestions);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _SuggestionResult implements SuggestionResult {
  const _SuggestionResult({final List<String> suggestions = const []})
      : _suggestions = suggestions;
  factory _SuggestionResult.fromJson(Map<String, dynamic> json) =>
      _$SuggestionResultFromJson(json);

  final List<String> _suggestions;
  @override
  @JsonKey()
  List<String> get suggestions {
    if (_suggestions is EqualUnmodifiableListView) return _suggestions;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_suggestions);
  }

  /// Create a copy of SuggestionResult
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$SuggestionResultCopyWith<_SuggestionResult> get copyWith =>
      __$SuggestionResultCopyWithImpl<_SuggestionResult>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$SuggestionResultToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _SuggestionResult &&
            const DeepCollectionEquality()
                .equals(other._suggestions, _suggestions));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(_suggestions));

  @override
  String toString() {
    return 'SuggestionResult(suggestions: $suggestions)';
  }
}

/// @nodoc
abstract mixin class _$SuggestionResultCopyWith<$Res>
    implements $SuggestionResultCopyWith<$Res> {
  factory _$SuggestionResultCopyWith(
          _SuggestionResult value, $Res Function(_SuggestionResult) _then) =
      __$SuggestionResultCopyWithImpl;
  @override
  @useResult
  $Res call({List<String> suggestions});
}

/// @nodoc
class __$SuggestionResultCopyWithImpl<$Res>
    implements _$SuggestionResultCopyWith<$Res> {
  __$SuggestionResultCopyWithImpl(this._self, this._then);

  final _SuggestionResult _self;
  final $Res Function(_SuggestionResult) _then;

  /// Create a copy of SuggestionResult
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? suggestions = null,
  }) {
    return _then(_SuggestionResult(
      suggestions: null == suggestions
          ? _self._suggestions
          : suggestions // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ));
  }
}

// dart format on
