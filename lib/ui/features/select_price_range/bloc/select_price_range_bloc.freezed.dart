// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'select_price_range_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$SelectPriceRangeEvent {
  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is SelectPriceRangeEvent);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'SelectPriceRangeEvent()';
  }
}

/// @nodoc
class $SelectPriceRangeEventCopyWith<$Res> {
  $SelectPriceRangeEventCopyWith(
      SelectPriceRangeEvent _, $Res Function(SelectPriceRangeEvent) __);
}

/// @nodoc

class _Initialized implements SelectPriceRangeEvent {
  const _Initialized(
      {required final List<PriceRange> allRanges, this.initialSelection})
      : _allRanges = allRanges;

  /// Danh sách tất cả các khoảng giá có thể chọn.
  final List<PriceRange> _allRanges;

  /// Danh sách tất cả các khoảng giá có thể chọn.
  List<PriceRange> get allRanges {
    if (_allRanges is EqualUnmodifiableListView) return _allRanges;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_allRanges);
  }

  /// Khoảng giá đã được chọn sẵn ban đầu (nếu có).
  final PriceRange? initialSelection;

  /// Create a copy of SelectPriceRangeEvent
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
                .equals(other._allRanges, _allRanges) &&
            (identical(other.initialSelection, initialSelection) ||
                other.initialSelection == initialSelection));
  }

  @override
  int get hashCode => Object.hash(runtimeType,
      const DeepCollectionEquality().hash(_allRanges), initialSelection);

  @override
  String toString() {
    return 'SelectPriceRangeEvent.initialized(allRanges: $allRanges, initialSelection: $initialSelection)';
  }
}

/// @nodoc
abstract mixin class _$InitializedCopyWith<$Res>
    implements $SelectPriceRangeEventCopyWith<$Res> {
  factory _$InitializedCopyWith(
          _Initialized value, $Res Function(_Initialized) _then) =
      __$InitializedCopyWithImpl;
  @useResult
  $Res call({List<PriceRange> allRanges, PriceRange? initialSelection});
}

/// @nodoc
class __$InitializedCopyWithImpl<$Res> implements _$InitializedCopyWith<$Res> {
  __$InitializedCopyWithImpl(this._self, this._then);

  final _Initialized _self;
  final $Res Function(_Initialized) _then;

  /// Create a copy of SelectPriceRangeEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? allRanges = null,
    Object? initialSelection = freezed,
  }) {
    return _then(_Initialized(
      allRanges: null == allRanges
          ? _self._allRanges
          : allRanges // ignore: cast_nullable_to_non_nullable
              as List<PriceRange>,
      initialSelection: freezed == initialSelection
          ? _self.initialSelection
          : initialSelection // ignore: cast_nullable_to_non_nullable
              as PriceRange?,
    ));
  }
}

/// @nodoc

class _RangeToggled implements SelectPriceRangeEvent {
  const _RangeToggled(this.range);

  final PriceRange range;

  /// Create a copy of SelectPriceRangeEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$RangeToggledCopyWith<_RangeToggled> get copyWith =>
      __$RangeToggledCopyWithImpl<_RangeToggled>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _RangeToggled &&
            (identical(other.range, range) || other.range == range));
  }

  @override
  int get hashCode => Object.hash(runtimeType, range);

  @override
  String toString() {
    return 'SelectPriceRangeEvent.rangeToggled(range: $range)';
  }
}

/// @nodoc
abstract mixin class _$RangeToggledCopyWith<$Res>
    implements $SelectPriceRangeEventCopyWith<$Res> {
  factory _$RangeToggledCopyWith(
          _RangeToggled value, $Res Function(_RangeToggled) _then) =
      __$RangeToggledCopyWithImpl;
  @useResult
  $Res call({PriceRange range});
}

/// @nodoc
class __$RangeToggledCopyWithImpl<$Res>
    implements _$RangeToggledCopyWith<$Res> {
  __$RangeToggledCopyWithImpl(this._self, this._then);

  final _RangeToggled _self;
  final $Res Function(_RangeToggled) _then;

  /// Create a copy of SelectPriceRangeEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? range = null,
  }) {
    return _then(_RangeToggled(
      null == range
          ? _self.range
          : range // ignore: cast_nullable_to_non_nullable
              as PriceRange,
    ));
  }
}

/// @nodoc
mixin _$SelectPriceRangeState {
  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is SelectPriceRangeState);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'SelectPriceRangeState()';
  }
}

/// @nodoc
class $SelectPriceRangeStateCopyWith<$Res> {
  $SelectPriceRangeStateCopyWith(
      SelectPriceRangeState _, $Res Function(SelectPriceRangeState) __);
}

/// @nodoc

class SelectPriceRangeInitial implements SelectPriceRangeState {
  const SelectPriceRangeInitial();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is SelectPriceRangeInitial);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'SelectPriceRangeState.initial()';
  }
}

/// @nodoc

class SelectPriceRangeLoaded implements SelectPriceRangeState {
  const SelectPriceRangeLoaded(
      {required final List<PriceRange> allRanges, this.selectedRange})
      : _allRanges = allRanges;

  /// Danh sách tất cả các khoảng giá có thể chọn.
  final List<PriceRange> _allRanges;

  /// Danh sách tất cả các khoảng giá có thể chọn.
  List<PriceRange> get allRanges {
    if (_allRanges is EqualUnmodifiableListView) return _allRanges;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_allRanges);
  }

  /// Khoảng giá đang được chọn (có thể là null nếu không có gì được chọn).
  final PriceRange? selectedRange;

  /// Create a copy of SelectPriceRangeState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $SelectPriceRangeLoadedCopyWith<SelectPriceRangeLoaded> get copyWith =>
      _$SelectPriceRangeLoadedCopyWithImpl<SelectPriceRangeLoaded>(
          this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is SelectPriceRangeLoaded &&
            const DeepCollectionEquality()
                .equals(other._allRanges, _allRanges) &&
            (identical(other.selectedRange, selectedRange) ||
                other.selectedRange == selectedRange));
  }

  @override
  int get hashCode => Object.hash(runtimeType,
      const DeepCollectionEquality().hash(_allRanges), selectedRange);

  @override
  String toString() {
    return 'SelectPriceRangeState.loaded(allRanges: $allRanges, selectedRange: $selectedRange)';
  }
}

/// @nodoc
abstract mixin class $SelectPriceRangeLoadedCopyWith<$Res>
    implements $SelectPriceRangeStateCopyWith<$Res> {
  factory $SelectPriceRangeLoadedCopyWith(SelectPriceRangeLoaded value,
          $Res Function(SelectPriceRangeLoaded) _then) =
      _$SelectPriceRangeLoadedCopyWithImpl;
  @useResult
  $Res call({List<PriceRange> allRanges, PriceRange? selectedRange});
}

/// @nodoc
class _$SelectPriceRangeLoadedCopyWithImpl<$Res>
    implements $SelectPriceRangeLoadedCopyWith<$Res> {
  _$SelectPriceRangeLoadedCopyWithImpl(this._self, this._then);

  final SelectPriceRangeLoaded _self;
  final $Res Function(SelectPriceRangeLoaded) _then;

  /// Create a copy of SelectPriceRangeState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? allRanges = null,
    Object? selectedRange = freezed,
  }) {
    return _then(SelectPriceRangeLoaded(
      allRanges: null == allRanges
          ? _self._allRanges
          : allRanges // ignore: cast_nullable_to_non_nullable
              as List<PriceRange>,
      selectedRange: freezed == selectedRange
          ? _self.selectedRange
          : selectedRange // ignore: cast_nullable_to_non_nullable
              as PriceRange?,
    ));
  }
}

// dart format on
