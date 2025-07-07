// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'filter_sort_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$FilterSortEvent {
  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is FilterSortEvent);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'FilterSortEvent()';
  }
}

/// @nodoc
class $FilterSortEventCopyWith<$Res> {
  $FilterSortEventCopyWith(
      FilterSortEvent _, $Res Function(FilterSortEvent) __);
}

/// @nodoc

class _Initialized implements FilterSortEvent {
  const _Initialized({this.initialParams});

  final FilterSortParams? initialParams;

  /// Create a copy of FilterSortEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$InitializedCopyWith<_Initialized> get copyWith =>
      __$InitializedCopyWithImpl<_Initialized>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Initialized &&
            (identical(other.initialParams, initialParams) ||
                other.initialParams == initialParams));
  }

  @override
  int get hashCode => Object.hash(runtimeType, initialParams);

  @override
  String toString() {
    return 'FilterSortEvent.initialized(initialParams: $initialParams)';
  }
}

/// @nodoc
abstract mixin class _$InitializedCopyWith<$Res>
    implements $FilterSortEventCopyWith<$Res> {
  factory _$InitializedCopyWith(
          _Initialized value, $Res Function(_Initialized) _then) =
      __$InitializedCopyWithImpl;
  @useResult
  $Res call({FilterSortParams? initialParams});

  $FilterSortParamsCopyWith<$Res>? get initialParams;
}

/// @nodoc
class __$InitializedCopyWithImpl<$Res> implements _$InitializedCopyWith<$Res> {
  __$InitializedCopyWithImpl(this._self, this._then);

  final _Initialized _self;
  final $Res Function(_Initialized) _then;

  /// Create a copy of FilterSortEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? initialParams = freezed,
  }) {
    return _then(_Initialized(
      initialParams: freezed == initialParams
          ? _self.initialParams
          : initialParams // ignore: cast_nullable_to_non_nullable
              as FilterSortParams?,
    ));
  }

  /// Create a copy of FilterSortEvent
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $FilterSortParamsCopyWith<$Res>? get initialParams {
    if (_self.initialParams == null) {
      return null;
    }

    return $FilterSortParamsCopyWith<$Res>(_self.initialParams!, (value) {
      return _then(_self.copyWith(initialParams: value));
    });
  }
}

/// @nodoc

class _CategoryToggled implements FilterSortEvent {
  const _CategoryToggled(this.category);

  final FoodCategory category;

  /// Create a copy of FilterSortEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$CategoryToggledCopyWith<_CategoryToggled> get copyWith =>
      __$CategoryToggledCopyWithImpl<_CategoryToggled>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _CategoryToggled &&
            (identical(other.category, category) ||
                other.category == category));
  }

  @override
  int get hashCode => Object.hash(runtimeType, category);

  @override
  String toString() {
    return 'FilterSortEvent.categoryToggled(category: $category)';
  }
}

/// @nodoc
abstract mixin class _$CategoryToggledCopyWith<$Res>
    implements $FilterSortEventCopyWith<$Res> {
  factory _$CategoryToggledCopyWith(
          _CategoryToggled value, $Res Function(_CategoryToggled) _then) =
      __$CategoryToggledCopyWithImpl;
  @useResult
  $Res call({FoodCategory category});
}

/// @nodoc
class __$CategoryToggledCopyWithImpl<$Res>
    implements _$CategoryToggledCopyWith<$Res> {
  __$CategoryToggledCopyWithImpl(this._self, this._then);

  final _CategoryToggled _self;
  final $Res Function(_CategoryToggled) _then;

  /// Create a copy of FilterSortEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? category = null,
  }) {
    return _then(_CategoryToggled(
      null == category
          ? _self.category
          : category // ignore: cast_nullable_to_non_nullable
              as FoodCategory,
    ));
  }
}

/// @nodoc

class _AllCategoriesToggled implements FilterSortEvent {
  const _AllCategoriesToggled();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _AllCategoriesToggled);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'FilterSortEvent.allCategoriesToggled()';
  }
}

/// @nodoc

class _PriceRangeToggled implements FilterSortEvent {
  const _PriceRangeToggled(this.range);

  final PriceRange range;

  /// Create a copy of FilterSortEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$PriceRangeToggledCopyWith<_PriceRangeToggled> get copyWith =>
      __$PriceRangeToggledCopyWithImpl<_PriceRangeToggled>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _PriceRangeToggled &&
            (identical(other.range, range) || other.range == range));
  }

  @override
  int get hashCode => Object.hash(runtimeType, range);

  @override
  String toString() {
    return 'FilterSortEvent.priceRangeToggled(range: $range)';
  }
}

/// @nodoc
abstract mixin class _$PriceRangeToggledCopyWith<$Res>
    implements $FilterSortEventCopyWith<$Res> {
  factory _$PriceRangeToggledCopyWith(
          _PriceRangeToggled value, $Res Function(_PriceRangeToggled) _then) =
      __$PriceRangeToggledCopyWithImpl;
  @useResult
  $Res call({PriceRange range});
}

/// @nodoc
class __$PriceRangeToggledCopyWithImpl<$Res>
    implements _$PriceRangeToggledCopyWith<$Res> {
  __$PriceRangeToggledCopyWithImpl(this._self, this._then);

  final _PriceRangeToggled _self;
  final $Res Function(_PriceRangeToggled) _then;

  /// Create a copy of FilterSortEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? range = null,
  }) {
    return _then(_PriceRangeToggled(
      null == range
          ? _self.range
          : range // ignore: cast_nullable_to_non_nullable
              as PriceRange,
    ));
  }
}

/// @nodoc

class _SortOptionSelected implements FilterSortEvent {
  const _SortOptionSelected(this.option);

  final SortOption option;

  /// Create a copy of FilterSortEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$SortOptionSelectedCopyWith<_SortOptionSelected> get copyWith =>
      __$SortOptionSelectedCopyWithImpl<_SortOptionSelected>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _SortOptionSelected &&
            (identical(other.option, option) || other.option == option));
  }

  @override
  int get hashCode => Object.hash(runtimeType, option);

  @override
  String toString() {
    return 'FilterSortEvent.sortOptionSelected(option: $option)';
  }
}

/// @nodoc
abstract mixin class _$SortOptionSelectedCopyWith<$Res>
    implements $FilterSortEventCopyWith<$Res> {
  factory _$SortOptionSelectedCopyWith(
          _SortOptionSelected value, $Res Function(_SortOptionSelected) _then) =
      __$SortOptionSelectedCopyWithImpl;
  @useResult
  $Res call({SortOption option});

  $SortOptionCopyWith<$Res> get option;
}

/// @nodoc
class __$SortOptionSelectedCopyWithImpl<$Res>
    implements _$SortOptionSelectedCopyWith<$Res> {
  __$SortOptionSelectedCopyWithImpl(this._self, this._then);

  final _SortOptionSelected _self;
  final $Res Function(_SortOptionSelected) _then;

  /// Create a copy of FilterSortEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? option = null,
  }) {
    return _then(_SortOptionSelected(
      null == option
          ? _self.option
          : option // ignore: cast_nullable_to_non_nullable
              as SortOption,
    ));
  }

  /// Create a copy of FilterSortEvent
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $SortOptionCopyWith<$Res> get option {
    return $SortOptionCopyWith<$Res>(_self.option, (value) {
      return _then(_self.copyWith(option: value));
    });
  }
}

/// @nodoc

class _FiltersCleared implements FilterSortEvent {
  const _FiltersCleared();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _FiltersCleared);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'FilterSortEvent.filtersCleared()';
  }
}

/// @nodoc

class _FiltersSubmitted implements FilterSortEvent {
  const _FiltersSubmitted();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _FiltersSubmitted);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'FilterSortEvent.filtersSubmitted()';
  }
}

/// @nodoc
mixin _$FilterSortState {
  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is FilterSortState);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'FilterSortState()';
  }
}

/// @nodoc
class $FilterSortStateCopyWith<$Res> {
  $FilterSortStateCopyWith(
      FilterSortState _, $Res Function(FilterSortState) __);
}

/// @nodoc

class FilterSortInitial implements FilterSortState {
  const FilterSortInitial();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is FilterSortInitial);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'FilterSortState.initial()';
  }
}

/// @nodoc

class FilterSortLoaded implements FilterSortState {
  const FilterSortLoaded(
      {required final List<FoodCategory> allCategories,
      required final List<PriceRange> allRanges,
      required final List<SortOption> allSortOptions,
      required this.currentParams})
      : _allCategories = allCategories,
        _allRanges = allRanges,
        _allSortOptions = allSortOptions;

// Dữ liệu tĩnh để hiển thị các lựa chọn trên UI
  final List<FoodCategory> _allCategories;
// Dữ liệu tĩnh để hiển thị các lựa chọn trên UI
  List<FoodCategory> get allCategories {
    if (_allCategories is EqualUnmodifiableListView) return _allCategories;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_allCategories);
  }

  final List<PriceRange> _allRanges;
  List<PriceRange> get allRanges {
    if (_allRanges is EqualUnmodifiableListView) return _allRanges;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_allRanges);
  }

  final List<SortOption> _allSortOptions;
  List<SortOption> get allSortOptions {
    if (_allSortOptions is EqualUnmodifiableListView) return _allSortOptions;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_allSortOptions);
  }

// MỚI: Một đối tượng duy nhất chứa tất cả các lựa chọn hiện tại
  final FilterSortParams currentParams;

  /// Create a copy of FilterSortState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $FilterSortLoadedCopyWith<FilterSortLoaded> get copyWith =>
      _$FilterSortLoadedCopyWithImpl<FilterSortLoaded>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is FilterSortLoaded &&
            const DeepCollectionEquality()
                .equals(other._allCategories, _allCategories) &&
            const DeepCollectionEquality()
                .equals(other._allRanges, _allRanges) &&
            const DeepCollectionEquality()
                .equals(other._allSortOptions, _allSortOptions) &&
            (identical(other.currentParams, currentParams) ||
                other.currentParams == currentParams));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_allCategories),
      const DeepCollectionEquality().hash(_allRanges),
      const DeepCollectionEquality().hash(_allSortOptions),
      currentParams);

  @override
  String toString() {
    return 'FilterSortState.loaded(allCategories: $allCategories, allRanges: $allRanges, allSortOptions: $allSortOptions, currentParams: $currentParams)';
  }
}

/// @nodoc
abstract mixin class $FilterSortLoadedCopyWith<$Res>
    implements $FilterSortStateCopyWith<$Res> {
  factory $FilterSortLoadedCopyWith(
          FilterSortLoaded value, $Res Function(FilterSortLoaded) _then) =
      _$FilterSortLoadedCopyWithImpl;
  @useResult
  $Res call(
      {List<FoodCategory> allCategories,
      List<PriceRange> allRanges,
      List<SortOption> allSortOptions,
      FilterSortParams currentParams});

  $FilterSortParamsCopyWith<$Res> get currentParams;
}

/// @nodoc
class _$FilterSortLoadedCopyWithImpl<$Res>
    implements $FilterSortLoadedCopyWith<$Res> {
  _$FilterSortLoadedCopyWithImpl(this._self, this._then);

  final FilterSortLoaded _self;
  final $Res Function(FilterSortLoaded) _then;

  /// Create a copy of FilterSortState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? allCategories = null,
    Object? allRanges = null,
    Object? allSortOptions = null,
    Object? currentParams = null,
  }) {
    return _then(FilterSortLoaded(
      allCategories: null == allCategories
          ? _self._allCategories
          : allCategories // ignore: cast_nullable_to_non_nullable
              as List<FoodCategory>,
      allRanges: null == allRanges
          ? _self._allRanges
          : allRanges // ignore: cast_nullable_to_non_nullable
              as List<PriceRange>,
      allSortOptions: null == allSortOptions
          ? _self._allSortOptions
          : allSortOptions // ignore: cast_nullable_to_non_nullable
              as List<SortOption>,
      currentParams: null == currentParams
          ? _self.currentParams
          : currentParams // ignore: cast_nullable_to_non_nullable
              as FilterSortParams,
    ));
  }

  /// Create a copy of FilterSortState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $FilterSortParamsCopyWith<$Res> get currentParams {
    return $FilterSortParamsCopyWith<$Res>(_self.currentParams, (value) {
      return _then(_self.copyWith(currentParams: value));
    });
  }
}

// dart format on
