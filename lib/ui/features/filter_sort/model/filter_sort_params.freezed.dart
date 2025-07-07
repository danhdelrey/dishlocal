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
  /// Các danh mục món ăn đã chọn. Mặc định là một Set rỗng.
  Set<FoodCategory> get categories;

  /// Khoảng giá đã chọn. Có thể là null nếu không chọn.
  PriceRange? get range;

  /// Tùy chọn sắp xếp. Luôn có giá trị, mặc định là sắp xếp theo ngày đăng mới nhất.
  SortOption get sortOption;

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
            const DeepCollectionEquality()
                .equals(other.categories, categories) &&
            (identical(other.range, range) || other.range == range) &&
            (identical(other.sortOption, sortOption) ||
                other.sortOption == sortOption));
  }

  @override
  int get hashCode => Object.hash(runtimeType,
      const DeepCollectionEquality().hash(categories), range, sortOption);

  @override
  String toString() {
    return 'FilterSortParams(categories: $categories, range: $range, sortOption: $sortOption)';
  }
}

/// @nodoc
abstract mixin class $FilterSortParamsCopyWith<$Res> {
  factory $FilterSortParamsCopyWith(
          FilterSortParams value, $Res Function(FilterSortParams) _then) =
      _$FilterSortParamsCopyWithImpl;
  @useResult
  $Res call(
      {Set<FoodCategory> categories, PriceRange? range, SortOption sortOption});

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
    Object? categories = null,
    Object? range = freezed,
    Object? sortOption = null,
  }) {
    return _then(_self.copyWith(
      categories: null == categories
          ? _self.categories
          : categories // ignore: cast_nullable_to_non_nullable
              as Set<FoodCategory>,
      range: freezed == range
          ? _self.range
          : range // ignore: cast_nullable_to_non_nullable
              as PriceRange?,
      sortOption: null == sortOption
          ? _self.sortOption
          : sortOption // ignore: cast_nullable_to_non_nullable
              as SortOption,
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

class _FilterSortParams implements FilterSortParams {
  const _FilterSortParams(
      {final Set<FoodCategory> categories = const {},
      this.range,
      this.sortOption = SortOption.defaultSort})
      : _categories = categories;

  /// Các danh mục món ăn đã chọn. Mặc định là một Set rỗng.
  final Set<FoodCategory> _categories;

  /// Các danh mục món ăn đã chọn. Mặc định là một Set rỗng.
  @override
  @JsonKey()
  Set<FoodCategory> get categories {
    if (_categories is EqualUnmodifiableSetView) return _categories;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableSetView(_categories);
  }

  /// Khoảng giá đã chọn. Có thể là null nếu không chọn.
  @override
  final PriceRange? range;

  /// Tùy chọn sắp xếp. Luôn có giá trị, mặc định là sắp xếp theo ngày đăng mới nhất.
  @override
  @JsonKey()
  final SortOption sortOption;

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
            const DeepCollectionEquality()
                .equals(other._categories, _categories) &&
            (identical(other.range, range) || other.range == range) &&
            (identical(other.sortOption, sortOption) ||
                other.sortOption == sortOption));
  }

  @override
  int get hashCode => Object.hash(runtimeType,
      const DeepCollectionEquality().hash(_categories), range, sortOption);

  @override
  String toString() {
    return 'FilterSortParams(categories: $categories, range: $range, sortOption: $sortOption)';
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
      {Set<FoodCategory> categories, PriceRange? range, SortOption sortOption});

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
    Object? categories = null,
    Object? range = freezed,
    Object? sortOption = null,
  }) {
    return _then(_FilterSortParams(
      categories: null == categories
          ? _self._categories
          : categories // ignore: cast_nullable_to_non_nullable
              as Set<FoodCategory>,
      range: freezed == range
          ? _self.range
          : range // ignore: cast_nullable_to_non_nullable
              as PriceRange?,
      sortOption: null == sortOption
          ? _self.sortOption
          : sortOption // ignore: cast_nullable_to_non_nullable
              as SortOption,
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
