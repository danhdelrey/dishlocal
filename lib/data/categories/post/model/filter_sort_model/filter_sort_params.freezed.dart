// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'filter_sort_params.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$FilterSortParams {
  FilterContext get context; // --- Lọc (Filtering) ---
  Set<FoodCategory> get categories;
  PriceRange? get range;
  DistanceRange? get distance; // --- Sắp xếp (Sorting) ---
  SortOption get sortOption; // --- Phân trang (Pagination) ---
  int get limit;

  /// Con trỏ của mục cuối cùng trong trang trước.
  /// Kiểu `dynamic` vì nó phụ thuộc vào trường sắp xếp
  /// (ví dụ: `DateTime` cho ngày đăng, `int` cho lượt thích).
  /// Là `null` nếu đây là yêu cầu cho trang đầu tiên.
  dynamic get lastCursor;

  /// Con trỏ phụ, chỉ dùng khi sắp xếp theo trường số (likes, comments, etc.)
  /// để phá vỡ thế hòa (tie-breaking).
  DateTime? get lastDateCursorForTieBreak;

  /// Create a copy of FilterSortParams
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $FilterSortParamsCopyWith<FilterSortParams> get copyWith =>
      _$FilterSortParamsCopyWithImpl<FilterSortParams>(
          this as FilterSortParams, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is FilterSortParams &&
            (identical(other.context, context) || other.context == context) &&
            const DeepCollectionEquality()
                .equals(other.categories, categories) &&
            (identical(other.range, range) || other.range == range) &&
            (identical(other.distance, distance) ||
                other.distance == distance) &&
            (identical(other.sortOption, sortOption) ||
                other.sortOption == sortOption) &&
            (identical(other.limit, limit) || other.limit == limit) &&
            const DeepCollectionEquality()
                .equals(other.lastCursor, lastCursor) &&
            (identical(other.lastDateCursorForTieBreak,
                    lastDateCursorForTieBreak) ||
                other.lastDateCursorForTieBreak == lastDateCursorForTieBreak));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      context,
      const DeepCollectionEquality().hash(categories),
      range,
      distance,
      sortOption,
      limit,
      const DeepCollectionEquality().hash(lastCursor),
      lastDateCursorForTieBreak);

  @override
  String toString() {
    return 'FilterSortParams(context: $context, categories: $categories, range: $range, distance: $distance, sortOption: $sortOption, limit: $limit, lastCursor: $lastCursor, lastDateCursorForTieBreak: $lastDateCursorForTieBreak)';
  }
}

/// @nodoc
abstract mixin class $FilterSortParamsCopyWith<$Res> {
  factory $FilterSortParamsCopyWith(
          FilterSortParams value, $Res Function(FilterSortParams) _then) =
      _$FilterSortParamsCopyWithImpl;
  @useResult
  $Res call(
      {FilterContext context,
      Set<FoodCategory> categories,
      PriceRange? range,
      DistanceRange? distance,
      SortOption sortOption,
      int limit,
      dynamic lastCursor,
      DateTime? lastDateCursorForTieBreak});

  $SortOptionCopyWith<$Res> get sortOption;
}

/// @nodoc
class _$FilterSortParamsCopyWithImpl<$Res>
    implements $FilterSortParamsCopyWith<$Res> {
  _$FilterSortParamsCopyWithImpl(this._self, this._then);

  final FilterSortParams _self;
  final $Res Function(FilterSortParams) _then;

  /// Create a copy of FilterSortParams
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? context = null,
    Object? categories = null,
    Object? range = freezed,
    Object? distance = freezed,
    Object? sortOption = null,
    Object? limit = null,
    Object? lastCursor = freezed,
    Object? lastDateCursorForTieBreak = freezed,
  }) {
    return _then(_self.copyWith(
      context: null == context
          ? _self.context
          : context // ignore: cast_nullable_to_non_nullable
              as FilterContext,
      categories: null == categories
          ? _self.categories
          : categories // ignore: cast_nullable_to_non_nullable
              as Set<FoodCategory>,
      range: freezed == range
          ? _self.range
          : range // ignore: cast_nullable_to_non_nullable
              as PriceRange?,
      distance: freezed == distance
          ? _self.distance
          : distance // ignore: cast_nullable_to_non_nullable
              as DistanceRange?,
      sortOption: null == sortOption
          ? _self.sortOption
          : sortOption // ignore: cast_nullable_to_non_nullable
              as SortOption,
      limit: null == limit
          ? _self.limit
          : limit // ignore: cast_nullable_to_non_nullable
              as int,
      lastCursor: freezed == lastCursor
          ? _self.lastCursor
          : lastCursor // ignore: cast_nullable_to_non_nullable
              as dynamic,
      lastDateCursorForTieBreak: freezed == lastDateCursorForTieBreak
          ? _self.lastDateCursorForTieBreak
          : lastDateCursorForTieBreak // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }

  /// Create a copy of FilterSortParams
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $SortOptionCopyWith<$Res> get sortOption {
    return $SortOptionCopyWith<$Res>(_self.sortOption, (value) {
      return _then(_self.copyWith(sortOption: value));
    });
  }
}

/// @nodoc

class _FilterSortParams extends FilterSortParams {
  const _FilterSortParams(
      {this.context = FilterContext.explore,
      final Set<FoodCategory> categories = const {},
      this.range,
      this.distance,
      this.sortOption = SortOption.defaultSort,
      this.limit = 10,
      this.lastCursor,
      this.lastDateCursorForTieBreak})
      : _categories = categories,
        super._();

  @override
  @JsonKey()
  final FilterContext context;
// --- Lọc (Filtering) ---
  final Set<FoodCategory> _categories;
// --- Lọc (Filtering) ---
  @override
  @JsonKey()
  Set<FoodCategory> get categories {
    if (_categories is EqualUnmodifiableSetView) return _categories;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableSetView(_categories);
  }

  @override
  final PriceRange? range;
  @override
  final DistanceRange? distance;
// --- Sắp xếp (Sorting) ---
  @override
  @JsonKey()
  final SortOption sortOption;
// --- Phân trang (Pagination) ---
  @override
  @JsonKey()
  final int limit;

  /// Con trỏ của mục cuối cùng trong trang trước.
  /// Kiểu `dynamic` vì nó phụ thuộc vào trường sắp xếp
  /// (ví dụ: `DateTime` cho ngày đăng, `int` cho lượt thích).
  /// Là `null` nếu đây là yêu cầu cho trang đầu tiên.
  @override
  final dynamic lastCursor;

  /// Con trỏ phụ, chỉ dùng khi sắp xếp theo trường số (likes, comments, etc.)
  /// để phá vỡ thế hòa (tie-breaking).
  @override
  final DateTime? lastDateCursorForTieBreak;

  /// Create a copy of FilterSortParams
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$FilterSortParamsCopyWith<_FilterSortParams> get copyWith =>
      __$FilterSortParamsCopyWithImpl<_FilterSortParams>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _FilterSortParams &&
            (identical(other.context, context) || other.context == context) &&
            const DeepCollectionEquality()
                .equals(other._categories, _categories) &&
            (identical(other.range, range) || other.range == range) &&
            (identical(other.distance, distance) ||
                other.distance == distance) &&
            (identical(other.sortOption, sortOption) ||
                other.sortOption == sortOption) &&
            (identical(other.limit, limit) || other.limit == limit) &&
            const DeepCollectionEquality()
                .equals(other.lastCursor, lastCursor) &&
            (identical(other.lastDateCursorForTieBreak,
                    lastDateCursorForTieBreak) ||
                other.lastDateCursorForTieBreak == lastDateCursorForTieBreak));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      context,
      const DeepCollectionEquality().hash(_categories),
      range,
      distance,
      sortOption,
      limit,
      const DeepCollectionEquality().hash(lastCursor),
      lastDateCursorForTieBreak);

  @override
  String toString() {
    return 'FilterSortParams(context: $context, categories: $categories, range: $range, distance: $distance, sortOption: $sortOption, limit: $limit, lastCursor: $lastCursor, lastDateCursorForTieBreak: $lastDateCursorForTieBreak)';
  }
}

/// @nodoc
abstract mixin class _$FilterSortParamsCopyWith<$Res>
    implements $FilterSortParamsCopyWith<$Res> {
  factory _$FilterSortParamsCopyWith(
          _FilterSortParams value, $Res Function(_FilterSortParams) _then) =
      __$FilterSortParamsCopyWithImpl;
  @override
  @useResult
  $Res call(
      {FilterContext context,
      Set<FoodCategory> categories,
      PriceRange? range,
      DistanceRange? distance,
      SortOption sortOption,
      int limit,
      dynamic lastCursor,
      DateTime? lastDateCursorForTieBreak});

  @override
  $SortOptionCopyWith<$Res> get sortOption;
}

/// @nodoc
class __$FilterSortParamsCopyWithImpl<$Res>
    implements _$FilterSortParamsCopyWith<$Res> {
  __$FilterSortParamsCopyWithImpl(this._self, this._then);

  final _FilterSortParams _self;
  final $Res Function(_FilterSortParams) _then;

  /// Create a copy of FilterSortParams
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? context = null,
    Object? categories = null,
    Object? range = freezed,
    Object? distance = freezed,
    Object? sortOption = null,
    Object? limit = null,
    Object? lastCursor = freezed,
    Object? lastDateCursorForTieBreak = freezed,
  }) {
    return _then(_FilterSortParams(
      context: null == context
          ? _self.context
          : context // ignore: cast_nullable_to_non_nullable
              as FilterContext,
      categories: null == categories
          ? _self._categories
          : categories // ignore: cast_nullable_to_non_nullable
              as Set<FoodCategory>,
      range: freezed == range
          ? _self.range
          : range // ignore: cast_nullable_to_non_nullable
              as PriceRange?,
      distance: freezed == distance
          ? _self.distance
          : distance // ignore: cast_nullable_to_non_nullable
              as DistanceRange?,
      sortOption: null == sortOption
          ? _self.sortOption
          : sortOption // ignore: cast_nullable_to_non_nullable
              as SortOption,
      limit: null == limit
          ? _self.limit
          : limit // ignore: cast_nullable_to_non_nullable
              as int,
      lastCursor: freezed == lastCursor
          ? _self.lastCursor
          : lastCursor // ignore: cast_nullable_to_non_nullable
              as dynamic,
      lastDateCursorForTieBreak: freezed == lastDateCursorForTieBreak
          ? _self.lastDateCursorForTieBreak
          : lastDateCursorForTieBreak // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }

  /// Create a copy of FilterSortParams
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $SortOptionCopyWith<$Res> get sortOption {
    return $SortOptionCopyWith<$Res>(_self.sortOption, (value) {
      return _then(_self.copyWith(sortOption: value));
    });
  }
}

// dart format on
