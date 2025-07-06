// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'select_food_category_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$SelectFoodCategoryEvent {
  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is SelectFoodCategoryEvent);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'SelectFoodCategoryEvent()';
  }
}

/// @nodoc
class $SelectFoodCategoryEventCopyWith<$Res> {
  $SelectFoodCategoryEventCopyWith(
      SelectFoodCategoryEvent _, $Res Function(SelectFoodCategoryEvent) __);
}

/// @nodoc

class _Initialized implements SelectFoodCategoryEvent {
  const _Initialized(
      {required final List<FoodCategory> allCategories,
      required this.allowMultiSelect,
      final Set<FoodCategory> initialSelection = const {}})
      : _allCategories = allCategories,
        _initialSelection = initialSelection;

  final List<FoodCategory> _allCategories;
  List<FoodCategory> get allCategories {
    if (_allCategories is EqualUnmodifiableListView) return _allCategories;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_allCategories);
  }

  final bool allowMultiSelect;
// Các mục đã được chọn sẵn ban đầu (nếu có)
  final Set<FoodCategory> _initialSelection;
// Các mục đã được chọn sẵn ban đầu (nếu có)
  @JsonKey()
  Set<FoodCategory> get initialSelection {
    if (_initialSelection is EqualUnmodifiableSetView) return _initialSelection;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableSetView(_initialSelection);
  }

  /// Create a copy of SelectFoodCategoryEvent
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
            const DeepCollectionEquality()
                .equals(other._allCategories, _allCategories) &&
            (identical(other.allowMultiSelect, allowMultiSelect) ||
                other.allowMultiSelect == allowMultiSelect) &&
            const DeepCollectionEquality()
                .equals(other._initialSelection, _initialSelection));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_allCategories),
      allowMultiSelect,
      const DeepCollectionEquality().hash(_initialSelection));

  @override
  String toString() {
    return 'SelectFoodCategoryEvent.initialized(allCategories: $allCategories, allowMultiSelect: $allowMultiSelect, initialSelection: $initialSelection)';
  }
}

/// @nodoc
abstract mixin class _$InitializedCopyWith<$Res>
    implements $SelectFoodCategoryEventCopyWith<$Res> {
  factory _$InitializedCopyWith(
          _Initialized value, $Res Function(_Initialized) _then) =
      __$InitializedCopyWithImpl;
  @useResult
  $Res call(
      {List<FoodCategory> allCategories,
      bool allowMultiSelect,
      Set<FoodCategory> initialSelection});
}

/// @nodoc
class __$InitializedCopyWithImpl<$Res> implements _$InitializedCopyWith<$Res> {
  __$InitializedCopyWithImpl(this._self, this._then);

  final _Initialized _self;
  final $Res Function(_Initialized) _then;

  /// Create a copy of SelectFoodCategoryEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? allCategories = null,
    Object? allowMultiSelect = null,
    Object? initialSelection = null,
  }) {
    return _then(_Initialized(
      allCategories: null == allCategories
          ? _self._allCategories
          : allCategories // ignore: cast_nullable_to_non_nullable
              as List<FoodCategory>,
      allowMultiSelect: null == allowMultiSelect
          ? _self.allowMultiSelect
          : allowMultiSelect // ignore: cast_nullable_to_non_nullable
              as bool,
      initialSelection: null == initialSelection
          ? _self._initialSelection
          : initialSelection // ignore: cast_nullable_to_non_nullable
              as Set<FoodCategory>,
    ));
  }
}

/// @nodoc

class _CategoryToggled implements SelectFoodCategoryEvent {
  const _CategoryToggled(this.category);

  final FoodCategory category;

  /// Create a copy of SelectFoodCategoryEvent
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
    return 'SelectFoodCategoryEvent.categoryToggled(category: $category)';
  }
}

/// @nodoc
abstract mixin class _$CategoryToggledCopyWith<$Res>
    implements $SelectFoodCategoryEventCopyWith<$Res> {
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

  /// Create a copy of SelectFoodCategoryEvent
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

class _AllToggled implements SelectFoodCategoryEvent {
  const _AllToggled();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _AllToggled);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'SelectFoodCategoryEvent.allToggled()';
  }
}

/// @nodoc
mixin _$SelectFoodCategoryState {
  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is SelectFoodCategoryState);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'SelectFoodCategoryState()';
  }
}

/// @nodoc
class $SelectFoodCategoryStateCopyWith<$Res> {
  $SelectFoodCategoryStateCopyWith(
      SelectFoodCategoryState _, $Res Function(SelectFoodCategoryState) __);
}

/// @nodoc

class _Initial implements SelectFoodCategoryState {
  const _Initial();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _Initial);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'SelectFoodCategoryState.initial()';
  }
}

/// @nodoc

class _Loaded implements SelectFoodCategoryState {
  const _Loaded(
      {required final List<FoodCategory> allCategories,
      required final Set<FoodCategory> selectedCategories,
      required this.allowMultiSelect})
      : _allCategories = allCategories,
        _selectedCategories = selectedCategories;

  /// Danh sách tất cả các danh mục có thể chọn.
  final List<FoodCategory> _allCategories;

  /// Danh sách tất cả các danh mục có thể chọn.
  List<FoodCategory> get allCategories {
    if (_allCategories is EqualUnmodifiableListView) return _allCategories;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_allCategories);
  }

  /// Tập hợp các danh mục đang được chọn.
  final Set<FoodCategory> _selectedCategories;

  /// Tập hợp các danh mục đang được chọn.
  Set<FoodCategory> get selectedCategories {
    if (_selectedCategories is EqualUnmodifiableSetView)
      return _selectedCategories;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableSetView(_selectedCategories);
  }

  /// Chế độ cho phép chọn nhiều hay không.
  final bool allowMultiSelect;

  /// Create a copy of SelectFoodCategoryState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$LoadedCopyWith<_Loaded> get copyWith =>
      __$LoadedCopyWithImpl<_Loaded>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Loaded &&
            const DeepCollectionEquality()
                .equals(other._allCategories, _allCategories) &&
            const DeepCollectionEquality()
                .equals(other._selectedCategories, _selectedCategories) &&
            (identical(other.allowMultiSelect, allowMultiSelect) ||
                other.allowMultiSelect == allowMultiSelect));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_allCategories),
      const DeepCollectionEquality().hash(_selectedCategories),
      allowMultiSelect);

  @override
  String toString() {
    return 'SelectFoodCategoryState.loaded(allCategories: $allCategories, selectedCategories: $selectedCategories, allowMultiSelect: $allowMultiSelect)';
  }
}

/// @nodoc
abstract mixin class _$LoadedCopyWith<$Res>
    implements $SelectFoodCategoryStateCopyWith<$Res> {
  factory _$LoadedCopyWith(_Loaded value, $Res Function(_Loaded) _then) =
      __$LoadedCopyWithImpl;
  @useResult
  $Res call(
      {List<FoodCategory> allCategories,
      Set<FoodCategory> selectedCategories,
      bool allowMultiSelect});
}

/// @nodoc
class __$LoadedCopyWithImpl<$Res> implements _$LoadedCopyWith<$Res> {
  __$LoadedCopyWithImpl(this._self, this._then);

  final _Loaded _self;
  final $Res Function(_Loaded) _then;

  /// Create a copy of SelectFoodCategoryState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? allCategories = null,
    Object? selectedCategories = null,
    Object? allowMultiSelect = null,
  }) {
    return _then(_Loaded(
      allCategories: null == allCategories
          ? _self._allCategories
          : allCategories // ignore: cast_nullable_to_non_nullable
              as List<FoodCategory>,
      selectedCategories: null == selectedCategories
          ? _self._selectedCategories
          : selectedCategories // ignore: cast_nullable_to_non_nullable
              as Set<FoodCategory>,
      allowMultiSelect: null == allowMultiSelect
          ? _self.allowMultiSelect
          : allowMultiSelect // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

// dart format on
