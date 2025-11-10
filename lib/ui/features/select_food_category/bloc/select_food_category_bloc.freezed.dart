// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
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

/// Adds pattern-matching-related methods to [SelectFoodCategoryEvent].
extension SelectFoodCategoryEventPatterns on SelectFoodCategoryEvent {
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
    TResult Function(_Initialized value)? initialized,
    TResult Function(_CategoryToggled value)? categoryToggled,
    TResult Function(_AllToggled value)? allToggled,
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _Initialized() when initialized != null:
        return initialized(_that);
      case _CategoryToggled() when categoryToggled != null:
        return categoryToggled(_that);
      case _AllToggled() when allToggled != null:
        return allToggled(_that);
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
    required TResult Function(_Initialized value) initialized,
    required TResult Function(_CategoryToggled value) categoryToggled,
    required TResult Function(_AllToggled value) allToggled,
  }) {
    final _that = this;
    switch (_that) {
      case _Initialized():
        return initialized(_that);
      case _CategoryToggled():
        return categoryToggled(_that);
      case _AllToggled():
        return allToggled(_that);
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
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initialized value)? initialized,
    TResult? Function(_CategoryToggled value)? categoryToggled,
    TResult? Function(_AllToggled value)? allToggled,
  }) {
    final _that = this;
    switch (_that) {
      case _Initialized() when initialized != null:
        return initialized(_that);
      case _CategoryToggled() when categoryToggled != null:
        return categoryToggled(_that);
      case _AllToggled() when allToggled != null:
        return allToggled(_that);
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
    TResult Function(List<FoodCategory> allCategories, bool allowMultiSelect,
            Set<FoodCategory> initialSelection)?
        initialized,
    TResult Function(FoodCategory category)? categoryToggled,
    TResult Function()? allToggled,
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _Initialized() when initialized != null:
        return initialized(_that.allCategories, _that.allowMultiSelect,
            _that.initialSelection);
      case _CategoryToggled() when categoryToggled != null:
        return categoryToggled(_that.category);
      case _AllToggled() when allToggled != null:
        return allToggled();
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
    required TResult Function(List<FoodCategory> allCategories,
            bool allowMultiSelect, Set<FoodCategory> initialSelection)
        initialized,
    required TResult Function(FoodCategory category) categoryToggled,
    required TResult Function() allToggled,
  }) {
    final _that = this;
    switch (_that) {
      case _Initialized():
        return initialized(_that.allCategories, _that.allowMultiSelect,
            _that.initialSelection);
      case _CategoryToggled():
        return categoryToggled(_that.category);
      case _AllToggled():
        return allToggled();
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
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(List<FoodCategory> allCategories, bool allowMultiSelect,
            Set<FoodCategory> initialSelection)?
        initialized,
    TResult? Function(FoodCategory category)? categoryToggled,
    TResult? Function()? allToggled,
  }) {
    final _that = this;
    switch (_that) {
      case _Initialized() when initialized != null:
        return initialized(_that.allCategories, _that.allowMultiSelect,
            _that.initialSelection);
      case _CategoryToggled() when categoryToggled != null:
        return categoryToggled(_that.category);
      case _AllToggled() when allToggled != null:
        return allToggled();
      case _:
        return null;
    }
  }
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

/// Adds pattern-matching-related methods to [SelectFoodCategoryState].
extension SelectFoodCategoryStatePatterns on SelectFoodCategoryState {
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
    TResult Function(SelectFoodCategoryInitial value)? initial,
    TResult Function(SelectFoodCategoryLoaded value)? loaded,
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case SelectFoodCategoryInitial() when initial != null:
        return initial(_that);
      case SelectFoodCategoryLoaded() when loaded != null:
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
    required TResult Function(SelectFoodCategoryInitial value) initial,
    required TResult Function(SelectFoodCategoryLoaded value) loaded,
  }) {
    final _that = this;
    switch (_that) {
      case SelectFoodCategoryInitial():
        return initial(_that);
      case SelectFoodCategoryLoaded():
        return loaded(_that);
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
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(SelectFoodCategoryInitial value)? initial,
    TResult? Function(SelectFoodCategoryLoaded value)? loaded,
  }) {
    final _that = this;
    switch (_that) {
      case SelectFoodCategoryInitial() when initial != null:
        return initial(_that);
      case SelectFoodCategoryLoaded() when loaded != null:
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
    TResult Function()? initial,
    TResult Function(List<FoodCategory> allCategories,
            Set<FoodCategory> selectedCategories, bool allowMultiSelect)?
        loaded,
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case SelectFoodCategoryInitial() when initial != null:
        return initial();
      case SelectFoodCategoryLoaded() when loaded != null:
        return loaded(_that.allCategories, _that.selectedCategories,
            _that.allowMultiSelect);
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
    required TResult Function() initial,
    required TResult Function(List<FoodCategory> allCategories,
            Set<FoodCategory> selectedCategories, bool allowMultiSelect)
        loaded,
  }) {
    final _that = this;
    switch (_that) {
      case SelectFoodCategoryInitial():
        return initial();
      case SelectFoodCategoryLoaded():
        return loaded(_that.allCategories, _that.selectedCategories,
            _that.allowMultiSelect);
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
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function(List<FoodCategory> allCategories,
            Set<FoodCategory> selectedCategories, bool allowMultiSelect)?
        loaded,
  }) {
    final _that = this;
    switch (_that) {
      case SelectFoodCategoryInitial() when initial != null:
        return initial();
      case SelectFoodCategoryLoaded() when loaded != null:
        return loaded(_that.allCategories, _that.selectedCategories,
            _that.allowMultiSelect);
      case _:
        return null;
    }
  }
}

/// @nodoc

class SelectFoodCategoryInitial implements SelectFoodCategoryState {
  const SelectFoodCategoryInitial();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is SelectFoodCategoryInitial);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'SelectFoodCategoryState.initial()';
  }
}

/// @nodoc

class SelectFoodCategoryLoaded implements SelectFoodCategoryState {
  const SelectFoodCategoryLoaded(
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
  $SelectFoodCategoryLoadedCopyWith<SelectFoodCategoryLoaded> get copyWith =>
      _$SelectFoodCategoryLoadedCopyWithImpl<SelectFoodCategoryLoaded>(
          this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is SelectFoodCategoryLoaded &&
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
abstract mixin class $SelectFoodCategoryLoadedCopyWith<$Res>
    implements $SelectFoodCategoryStateCopyWith<$Res> {
  factory $SelectFoodCategoryLoadedCopyWith(SelectFoodCategoryLoaded value,
          $Res Function(SelectFoodCategoryLoaded) _then) =
      _$SelectFoodCategoryLoadedCopyWithImpl;
  @useResult
  $Res call(
      {List<FoodCategory> allCategories,
      Set<FoodCategory> selectedCategories,
      bool allowMultiSelect});
}

/// @nodoc
class _$SelectFoodCategoryLoadedCopyWithImpl<$Res>
    implements $SelectFoodCategoryLoadedCopyWith<$Res> {
  _$SelectFoodCategoryLoadedCopyWithImpl(this._self, this._then);

  final SelectFoodCategoryLoaded _self;
  final $Res Function(SelectFoodCategoryLoaded) _then;

  /// Create a copy of SelectFoodCategoryState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? allCategories = null,
    Object? selectedCategories = null,
    Object? allowMultiSelect = null,
  }) {
    return _then(SelectFoodCategoryLoaded(
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
