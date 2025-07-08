// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'sort_option.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$SortOption {
  SortField get field;
  SortDirection get direction;

  /// Create a copy of SortOption
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $SortOptionCopyWith<SortOption> get copyWith =>
      _$SortOptionCopyWithImpl<SortOption>(this as SortOption, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is SortOption &&
            (identical(other.field, field) || other.field == field) &&
            (identical(other.direction, direction) ||
                other.direction == direction));
  }

  @override
  int get hashCode => Object.hash(runtimeType, field, direction);

  @override
  String toString() {
    return 'SortOption(field: $field, direction: $direction)';
  }
}

/// @nodoc
abstract mixin class $SortOptionCopyWith<$Res> {
  factory $SortOptionCopyWith(
          SortOption value, $Res Function(SortOption) _then) =
      _$SortOptionCopyWithImpl;
  @useResult
  $Res call({SortField field, SortDirection direction});
}

/// @nodoc
class _$SortOptionCopyWithImpl<$Res> implements $SortOptionCopyWith<$Res> {
  _$SortOptionCopyWithImpl(this._self, this._then);

  final SortOption _self;
  final $Res Function(SortOption) _then;

  /// Create a copy of SortOption
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? field = null,
    Object? direction = null,
  }) {
    return _then(_self.copyWith(
      field: null == field
          ? _self.field
          : field // ignore: cast_nullable_to_non_nullable
              as SortField,
      direction: null == direction
          ? _self.direction
          : direction // ignore: cast_nullable_to_non_nullable
              as SortDirection,
    ));
  }
}

/// @nodoc

class _SortOption extends SortOption {
  const _SortOption({required this.field, required this.direction}) : super._();

  @override
  final SortField field;
  @override
  final SortDirection direction;

  /// Create a copy of SortOption
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$SortOptionCopyWith<_SortOption> get copyWith =>
      __$SortOptionCopyWithImpl<_SortOption>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _SortOption &&
            (identical(other.field, field) || other.field == field) &&
            (identical(other.direction, direction) ||
                other.direction == direction));
  }

  @override
  int get hashCode => Object.hash(runtimeType, field, direction);

  @override
  String toString() {
    return 'SortOption(field: $field, direction: $direction)';
  }
}

/// @nodoc
abstract mixin class _$SortOptionCopyWith<$Res>
    implements $SortOptionCopyWith<$Res> {
  factory _$SortOptionCopyWith(
          _SortOption value, $Res Function(_SortOption) _then) =
      __$SortOptionCopyWithImpl;
  @override
  @useResult
  $Res call({SortField field, SortDirection direction});
}

/// @nodoc
class __$SortOptionCopyWithImpl<$Res> implements _$SortOptionCopyWith<$Res> {
  __$SortOptionCopyWithImpl(this._self, this._then);

  final _SortOption _self;
  final $Res Function(_SortOption) _then;

  /// Create a copy of SortOption
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? field = null,
    Object? direction = null,
  }) {
    return _then(_SortOption(
      field: null == field
          ? _self.field
          : field // ignore: cast_nullable_to_non_nullable
              as SortField,
      direction: null == direction
          ? _self.direction
          : direction // ignore: cast_nullable_to_non_nullable
              as SortDirection,
    ));
  }
}

// dart format on
