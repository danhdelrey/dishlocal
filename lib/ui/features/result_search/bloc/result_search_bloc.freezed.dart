// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'result_search_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ResultSearchEvent {
  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is ResultSearchEvent);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'ResultSearchEvent()';
  }
}

/// @nodoc
class $ResultSearchEventCopyWith<$Res> {
  $ResultSearchEventCopyWith(
      ResultSearchEvent _, $Res Function(ResultSearchEvent) __);
}

/// @nodoc

class _SearchStarted implements ResultSearchEvent {
  const _SearchStarted({required this.query});

  final String query;

  /// Create a copy of ResultSearchEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$SearchStartedCopyWith<_SearchStarted> get copyWith =>
      __$SearchStartedCopyWithImpl<_SearchStarted>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _SearchStarted &&
            (identical(other.query, query) || other.query == query));
  }

  @override
  int get hashCode => Object.hash(runtimeType, query);

  @override
  String toString() {
    return 'ResultSearchEvent.searchStarted(query: $query)';
  }
}

/// @nodoc
abstract mixin class _$SearchStartedCopyWith<$Res>
    implements $ResultSearchEventCopyWith<$Res> {
  factory _$SearchStartedCopyWith(
          _SearchStarted value, $Res Function(_SearchStarted) _then) =
      __$SearchStartedCopyWithImpl;
  @useResult
  $Res call({String query});
}

/// @nodoc
class __$SearchStartedCopyWithImpl<$Res>
    implements _$SearchStartedCopyWith<$Res> {
  __$SearchStartedCopyWithImpl(this._self, this._then);

  final _SearchStarted _self;
  final $Res Function(_SearchStarted) _then;

  /// Create a copy of ResultSearchEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? query = null,
  }) {
    return _then(_SearchStarted(
      query: null == query
          ? _self.query
          : query // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _NextPageRequested implements ResultSearchEvent {
  const _NextPageRequested();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _NextPageRequested);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'ResultSearchEvent.nextPageRequested()';
  }
}

/// @nodoc

class _SearchTypeChanged implements ResultSearchEvent {
  const _SearchTypeChanged({required this.searchType});

  final SearchType searchType;

  /// Create a copy of ResultSearchEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$SearchTypeChangedCopyWith<_SearchTypeChanged> get copyWith =>
      __$SearchTypeChangedCopyWithImpl<_SearchTypeChanged>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _SearchTypeChanged &&
            (identical(other.searchType, searchType) ||
                other.searchType == searchType));
  }

  @override
  int get hashCode => Object.hash(runtimeType, searchType);

  @override
  String toString() {
    return 'ResultSearchEvent.searchTypeChanged(searchType: $searchType)';
  }
}

/// @nodoc
abstract mixin class _$SearchTypeChangedCopyWith<$Res>
    implements $ResultSearchEventCopyWith<$Res> {
  factory _$SearchTypeChangedCopyWith(
          _SearchTypeChanged value, $Res Function(_SearchTypeChanged) _then) =
      __$SearchTypeChangedCopyWithImpl;
  @useResult
  $Res call({SearchType searchType});
}

/// @nodoc
class __$SearchTypeChangedCopyWithImpl<$Res>
    implements _$SearchTypeChangedCopyWith<$Res> {
  __$SearchTypeChangedCopyWithImpl(this._self, this._then);

  final _SearchTypeChanged _self;
  final $Res Function(_SearchTypeChanged) _then;

  /// Create a copy of ResultSearchEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? searchType = null,
  }) {
    return _then(_SearchTypeChanged(
      searchType: null == searchType
          ? _self.searchType
          : searchType // ignore: cast_nullable_to_non_nullable
              as SearchType,
    ));
  }
}

/// @nodoc

class _FiltersChanged implements ResultSearchEvent {
  const _FiltersChanged({required this.newFilters});

  final FilterSortParams newFilters;

  /// Create a copy of ResultSearchEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$FiltersChangedCopyWith<_FiltersChanged> get copyWith =>
      __$FiltersChangedCopyWithImpl<_FiltersChanged>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _FiltersChanged &&
            (identical(other.newFilters, newFilters) ||
                other.newFilters == newFilters));
  }

  @override
  int get hashCode => Object.hash(runtimeType, newFilters);

  @override
  String toString() {
    return 'ResultSearchEvent.filtersChanged(newFilters: $newFilters)';
  }
}

/// @nodoc
abstract mixin class _$FiltersChangedCopyWith<$Res>
    implements $ResultSearchEventCopyWith<$Res> {
  factory _$FiltersChangedCopyWith(
          _FiltersChanged value, $Res Function(_FiltersChanged) _then) =
      __$FiltersChangedCopyWithImpl;
  @useResult
  $Res call({FilterSortParams newFilters});

  $FilterSortParamsCopyWith<$Res> get newFilters;
}

/// @nodoc
class __$FiltersChangedCopyWithImpl<$Res>
    implements _$FiltersChangedCopyWith<$Res> {
  __$FiltersChangedCopyWithImpl(this._self, this._then);

  final _FiltersChanged _self;
  final $Res Function(_FiltersChanged) _then;

  /// Create a copy of ResultSearchEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? newFilters = null,
  }) {
    return _then(_FiltersChanged(
      newFilters: null == newFilters
          ? _self.newFilters
          : newFilters // ignore: cast_nullable_to_non_nullable
              as FilterSortParams,
    ));
  }

  /// Create a copy of ResultSearchEvent
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $FilterSortParamsCopyWith<$Res> get newFilters {
    return $FilterSortParamsCopyWith<$Res>(_self.newFilters, (value) {
      return _then(_self.copyWith(newFilters: value));
    });
  }
}

/// @nodoc
mixin _$ResultSearchState {
  SearchStatus get status;
  SearchType get searchType;
  String get query;
  List<dynamic> get results;
  int get currentPage;
  bool get hasNextPage;
  FilterSortParams get filterParams;
  Object? get failure;

  /// Create a copy of ResultSearchState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $ResultSearchStateCopyWith<ResultSearchState> get copyWith =>
      _$ResultSearchStateCopyWithImpl<ResultSearchState>(
          this as ResultSearchState, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is ResultSearchState &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.searchType, searchType) ||
                other.searchType == searchType) &&
            (identical(other.query, query) || other.query == query) &&
            const DeepCollectionEquality().equals(other.results, results) &&
            (identical(other.currentPage, currentPage) ||
                other.currentPage == currentPage) &&
            (identical(other.hasNextPage, hasNextPage) ||
                other.hasNextPage == hasNextPage) &&
            (identical(other.filterParams, filterParams) ||
                other.filterParams == filterParams) &&
            const DeepCollectionEquality().equals(other.failure, failure));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      status,
      searchType,
      query,
      const DeepCollectionEquality().hash(results),
      currentPage,
      hasNextPage,
      filterParams,
      const DeepCollectionEquality().hash(failure));

  @override
  String toString() {
    return 'ResultSearchState(status: $status, searchType: $searchType, query: $query, results: $results, currentPage: $currentPage, hasNextPage: $hasNextPage, filterParams: $filterParams, failure: $failure)';
  }
}

/// @nodoc
abstract mixin class $ResultSearchStateCopyWith<$Res> {
  factory $ResultSearchStateCopyWith(
          ResultSearchState value, $Res Function(ResultSearchState) _then) =
      _$ResultSearchStateCopyWithImpl;
  @useResult
  $Res call(
      {SearchStatus status,
      SearchType searchType,
      String query,
      List<dynamic> results,
      int currentPage,
      bool hasNextPage,
      FilterSortParams filterParams,
      Object? failure});

  $FilterSortParamsCopyWith<$Res> get filterParams;
}

/// @nodoc
class _$ResultSearchStateCopyWithImpl<$Res>
    implements $ResultSearchStateCopyWith<$Res> {
  _$ResultSearchStateCopyWithImpl(this._self, this._then);

  final ResultSearchState _self;
  final $Res Function(ResultSearchState) _then;

  /// Create a copy of ResultSearchState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? searchType = null,
    Object? query = null,
    Object? results = null,
    Object? currentPage = null,
    Object? hasNextPage = null,
    Object? filterParams = null,
    Object? failure = freezed,
  }) {
    return _then(_self.copyWith(
      status: null == status
          ? _self.status
          : status // ignore: cast_nullable_to_non_nullable
              as SearchStatus,
      searchType: null == searchType
          ? _self.searchType
          : searchType // ignore: cast_nullable_to_non_nullable
              as SearchType,
      query: null == query
          ? _self.query
          : query // ignore: cast_nullable_to_non_nullable
              as String,
      results: null == results
          ? _self.results
          : results // ignore: cast_nullable_to_non_nullable
              as List<dynamic>,
      currentPage: null == currentPage
          ? _self.currentPage
          : currentPage // ignore: cast_nullable_to_non_nullable
              as int,
      hasNextPage: null == hasNextPage
          ? _self.hasNextPage
          : hasNextPage // ignore: cast_nullable_to_non_nullable
              as bool,
      filterParams: null == filterParams
          ? _self.filterParams
          : filterParams // ignore: cast_nullable_to_non_nullable
              as FilterSortParams,
      failure: freezed == failure ? _self.failure : failure,
    ));
  }

  /// Create a copy of ResultSearchState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $FilterSortParamsCopyWith<$Res> get filterParams {
    return $FilterSortParamsCopyWith<$Res>(_self.filterParams, (value) {
      return _then(_self.copyWith(filterParams: value));
    });
  }
}

/// @nodoc

class _ResultSearchState implements ResultSearchState {
  const _ResultSearchState(
      {this.status = SearchStatus.initial,
      this.searchType = SearchType.posts,
      this.query = '',
      final List<dynamic> results = const [],
      this.currentPage = 0,
      this.hasNextPage = true,
      this.filterParams = const FilterSortParams(),
      this.failure})
      : _results = results;

  @override
  @JsonKey()
  final SearchStatus status;
  @override
  @JsonKey()
  final SearchType searchType;
  @override
  @JsonKey()
  final String query;
  final List<dynamic> _results;
  @override
  @JsonKey()
  List<dynamic> get results {
    if (_results is EqualUnmodifiableListView) return _results;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_results);
  }

  @override
  @JsonKey()
  final int currentPage;
  @override
  @JsonKey()
  final bool hasNextPage;
  @override
  @JsonKey()
  final FilterSortParams filterParams;
  @override
  final Object? failure;

  /// Create a copy of ResultSearchState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$ResultSearchStateCopyWith<_ResultSearchState> get copyWith =>
      __$ResultSearchStateCopyWithImpl<_ResultSearchState>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _ResultSearchState &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.searchType, searchType) ||
                other.searchType == searchType) &&
            (identical(other.query, query) || other.query == query) &&
            const DeepCollectionEquality().equals(other._results, _results) &&
            (identical(other.currentPage, currentPage) ||
                other.currentPage == currentPage) &&
            (identical(other.hasNextPage, hasNextPage) ||
                other.hasNextPage == hasNextPage) &&
            (identical(other.filterParams, filterParams) ||
                other.filterParams == filterParams) &&
            const DeepCollectionEquality().equals(other.failure, failure));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      status,
      searchType,
      query,
      const DeepCollectionEquality().hash(_results),
      currentPage,
      hasNextPage,
      filterParams,
      const DeepCollectionEquality().hash(failure));

  @override
  String toString() {
    return 'ResultSearchState(status: $status, searchType: $searchType, query: $query, results: $results, currentPage: $currentPage, hasNextPage: $hasNextPage, filterParams: $filterParams, failure: $failure)';
  }
}

/// @nodoc
abstract mixin class _$ResultSearchStateCopyWith<$Res>
    implements $ResultSearchStateCopyWith<$Res> {
  factory _$ResultSearchStateCopyWith(
          _ResultSearchState value, $Res Function(_ResultSearchState) _then) =
      __$ResultSearchStateCopyWithImpl;
  @override
  @useResult
  $Res call(
      {SearchStatus status,
      SearchType searchType,
      String query,
      List<dynamic> results,
      int currentPage,
      bool hasNextPage,
      FilterSortParams filterParams,
      Object? failure});

  @override
  $FilterSortParamsCopyWith<$Res> get filterParams;
}

/// @nodoc
class __$ResultSearchStateCopyWithImpl<$Res>
    implements _$ResultSearchStateCopyWith<$Res> {
  __$ResultSearchStateCopyWithImpl(this._self, this._then);

  final _ResultSearchState _self;
  final $Res Function(_ResultSearchState) _then;

  /// Create a copy of ResultSearchState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? status = null,
    Object? searchType = null,
    Object? query = null,
    Object? results = null,
    Object? currentPage = null,
    Object? hasNextPage = null,
    Object? filterParams = null,
    Object? failure = freezed,
  }) {
    return _then(_ResultSearchState(
      status: null == status
          ? _self.status
          : status // ignore: cast_nullable_to_non_nullable
              as SearchStatus,
      searchType: null == searchType
          ? _self.searchType
          : searchType // ignore: cast_nullable_to_non_nullable
              as SearchType,
      query: null == query
          ? _self.query
          : query // ignore: cast_nullable_to_non_nullable
              as String,
      results: null == results
          ? _self._results
          : results // ignore: cast_nullable_to_non_nullable
              as List<dynamic>,
      currentPage: null == currentPage
          ? _self.currentPage
          : currentPage // ignore: cast_nullable_to_non_nullable
              as int,
      hasNextPage: null == hasNextPage
          ? _self.hasNextPage
          : hasNextPage // ignore: cast_nullable_to_non_nullable
              as bool,
      filterParams: null == filterParams
          ? _self.filterParams
          : filterParams // ignore: cast_nullable_to_non_nullable
              as FilterSortParams,
      failure: freezed == failure ? _self.failure : failure,
    ));
  }

  /// Create a copy of ResultSearchState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $FilterSortParamsCopyWith<$Res> get filterParams {
    return $FilterSortParamsCopyWith<$Res>(_self.filterParams, (value) {
      return _then(_self.copyWith(filterParams: value));
    });
  }
}

// dart format on
