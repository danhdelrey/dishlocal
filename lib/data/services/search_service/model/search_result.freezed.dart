// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'search_result.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$SearchResult {
  int? get totalPage;
  int? get totalHits;
  int? get currentPage;
  List<String> get objectIds;

  /// Create a copy of SearchResult
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $SearchResultCopyWith<SearchResult> get copyWith =>
      _$SearchResultCopyWithImpl<SearchResult>(
          this as SearchResult, _$identity);

  /// Serializes this SearchResult to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is SearchResult &&
            (identical(other.totalPage, totalPage) ||
                other.totalPage == totalPage) &&
            (identical(other.totalHits, totalHits) ||
                other.totalHits == totalHits) &&
            (identical(other.currentPage, currentPage) ||
                other.currentPage == currentPage) &&
            const DeepCollectionEquality().equals(other.objectIds, objectIds));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, totalPage, totalHits,
      currentPage, const DeepCollectionEquality().hash(objectIds));

  @override
  String toString() {
    return 'SearchResult(totalPage: $totalPage, totalHits: $totalHits, currentPage: $currentPage, objectIds: $objectIds)';
  }
}

/// @nodoc
abstract mixin class $SearchResultCopyWith<$Res> {
  factory $SearchResultCopyWith(
          SearchResult value, $Res Function(SearchResult) _then) =
      _$SearchResultCopyWithImpl;
  @useResult
  $Res call(
      {int? totalPage,
      int? totalHits,
      int? currentPage,
      List<String> objectIds});
}

/// @nodoc
class _$SearchResultCopyWithImpl<$Res> implements $SearchResultCopyWith<$Res> {
  _$SearchResultCopyWithImpl(this._self, this._then);

  final SearchResult _self;
  final $Res Function(SearchResult) _then;

  /// Create a copy of SearchResult
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? totalPage = freezed,
    Object? totalHits = freezed,
    Object? currentPage = freezed,
    Object? objectIds = null,
  }) {
    return _then(_self.copyWith(
      totalPage: freezed == totalPage
          ? _self.totalPage
          : totalPage // ignore: cast_nullable_to_non_nullable
              as int?,
      totalHits: freezed == totalHits
          ? _self.totalHits
          : totalHits // ignore: cast_nullable_to_non_nullable
              as int?,
      currentPage: freezed == currentPage
          ? _self.currentPage
          : currentPage // ignore: cast_nullable_to_non_nullable
              as int?,
      objectIds: null == objectIds
          ? _self.objectIds
          : objectIds // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ));
  }
}

/// Adds pattern-matching-related methods to [SearchResult].
extension SearchResultPatterns on SearchResult {
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
    TResult Function(_SearchResult value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _SearchResult() when $default != null:
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
    TResult Function(_SearchResult value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _SearchResult():
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
    TResult? Function(_SearchResult value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _SearchResult() when $default != null:
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
    TResult Function(int? totalPage, int? totalHits, int? currentPage,
            List<String> objectIds)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _SearchResult() when $default != null:
        return $default(_that.totalPage, _that.totalHits, _that.currentPage,
            _that.objectIds);
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
    TResult Function(int? totalPage, int? totalHits, int? currentPage,
            List<String> objectIds)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _SearchResult():
        return $default(_that.totalPage, _that.totalHits, _that.currentPage,
            _that.objectIds);
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
    TResult? Function(int? totalPage, int? totalHits, int? currentPage,
            List<String> objectIds)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _SearchResult() when $default != null:
        return $default(_that.totalPage, _that.totalHits, _that.currentPage,
            _that.objectIds);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _SearchResult implements SearchResult {
  const _SearchResult(
      {this.totalPage,
      this.totalHits,
      this.currentPage,
      final List<String> objectIds = const []})
      : _objectIds = objectIds;
  factory _SearchResult.fromJson(Map<String, dynamic> json) =>
      _$SearchResultFromJson(json);

  @override
  final int? totalPage;
  @override
  final int? totalHits;
  @override
  final int? currentPage;
  final List<String> _objectIds;
  @override
  @JsonKey()
  List<String> get objectIds {
    if (_objectIds is EqualUnmodifiableListView) return _objectIds;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_objectIds);
  }

  /// Create a copy of SearchResult
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$SearchResultCopyWith<_SearchResult> get copyWith =>
      __$SearchResultCopyWithImpl<_SearchResult>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$SearchResultToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _SearchResult &&
            (identical(other.totalPage, totalPage) ||
                other.totalPage == totalPage) &&
            (identical(other.totalHits, totalHits) ||
                other.totalHits == totalHits) &&
            (identical(other.currentPage, currentPage) ||
                other.currentPage == currentPage) &&
            const DeepCollectionEquality()
                .equals(other._objectIds, _objectIds));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, totalPage, totalHits,
      currentPage, const DeepCollectionEquality().hash(_objectIds));

  @override
  String toString() {
    return 'SearchResult(totalPage: $totalPage, totalHits: $totalHits, currentPage: $currentPage, objectIds: $objectIds)';
  }
}

/// @nodoc
abstract mixin class _$SearchResultCopyWith<$Res>
    implements $SearchResultCopyWith<$Res> {
  factory _$SearchResultCopyWith(
          _SearchResult value, $Res Function(_SearchResult) _then) =
      __$SearchResultCopyWithImpl;
  @override
  @useResult
  $Res call(
      {int? totalPage,
      int? totalHits,
      int? currentPage,
      List<String> objectIds});
}

/// @nodoc
class __$SearchResultCopyWithImpl<$Res>
    implements _$SearchResultCopyWith<$Res> {
  __$SearchResultCopyWithImpl(this._self, this._then);

  final _SearchResult _self;
  final $Res Function(_SearchResult) _then;

  /// Create a copy of SearchResult
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? totalPage = freezed,
    Object? totalHits = freezed,
    Object? currentPage = freezed,
    Object? objectIds = null,
  }) {
    return _then(_SearchResult(
      totalPage: freezed == totalPage
          ? _self.totalPage
          : totalPage // ignore: cast_nullable_to_non_nullable
              as int?,
      totalHits: freezed == totalHits
          ? _self.totalHits
          : totalHits // ignore: cast_nullable_to_non_nullable
              as int?,
      currentPage: freezed == currentPage
          ? _self.currentPage
          : currentPage // ignore: cast_nullable_to_non_nullable
              as int?,
      objectIds: null == objectIds
          ? _self._objectIds
          : objectIds // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ));
  }
}

// dart format on
