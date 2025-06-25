// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'moderation.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ModerationViolation {
  /// Loại nội dung vi phạm (văn bản hay hình ảnh).
  ModerationInputType get inputType;

  /// Danh mục vi phạm.
  ModerationCategory get category;

  /// Create a copy of ModerationViolation
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $ModerationViolationCopyWith<ModerationViolation> get copyWith =>
      _$ModerationViolationCopyWithImpl<ModerationViolation>(
          this as ModerationViolation, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is ModerationViolation &&
            (identical(other.inputType, inputType) ||
                other.inputType == inputType) &&
            (identical(other.category, category) ||
                other.category == category));
  }

  @override
  int get hashCode => Object.hash(runtimeType, inputType, category);

  @override
  String toString() {
    return 'ModerationViolation(inputType: $inputType, category: $category)';
  }
}

/// @nodoc
abstract mixin class $ModerationViolationCopyWith<$Res> {
  factory $ModerationViolationCopyWith(
          ModerationViolation value, $Res Function(ModerationViolation) _then) =
      _$ModerationViolationCopyWithImpl;
  @useResult
  $Res call({ModerationInputType inputType, ModerationCategory category});
}

/// @nodoc
class _$ModerationViolationCopyWithImpl<$Res>
    implements $ModerationViolationCopyWith<$Res> {
  _$ModerationViolationCopyWithImpl(this._self, this._then);

  final ModerationViolation _self;
  final $Res Function(ModerationViolation) _then;

  /// Create a copy of ModerationViolation
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? inputType = null,
    Object? category = null,
  }) {
    return _then(_self.copyWith(
      inputType: null == inputType
          ? _self.inputType
          : inputType // ignore: cast_nullable_to_non_nullable
              as ModerationInputType,
      category: null == category
          ? _self.category
          : category // ignore: cast_nullable_to_non_nullable
              as ModerationCategory,
    ));
  }
}

/// @nodoc

class _ModerationViolation implements ModerationViolation {
  const _ModerationViolation({required this.inputType, required this.category});

  /// Loại nội dung vi phạm (văn bản hay hình ảnh).
  @override
  final ModerationInputType inputType;

  /// Danh mục vi phạm.
  @override
  final ModerationCategory category;

  /// Create a copy of ModerationViolation
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$ModerationViolationCopyWith<_ModerationViolation> get copyWith =>
      __$ModerationViolationCopyWithImpl<_ModerationViolation>(
          this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _ModerationViolation &&
            (identical(other.inputType, inputType) ||
                other.inputType == inputType) &&
            (identical(other.category, category) ||
                other.category == category));
  }

  @override
  int get hashCode => Object.hash(runtimeType, inputType, category);

  @override
  String toString() {
    return 'ModerationViolation(inputType: $inputType, category: $category)';
  }
}

/// @nodoc
abstract mixin class _$ModerationViolationCopyWith<$Res>
    implements $ModerationViolationCopyWith<$Res> {
  factory _$ModerationViolationCopyWith(_ModerationViolation value,
          $Res Function(_ModerationViolation) _then) =
      __$ModerationViolationCopyWithImpl;
  @override
  @useResult
  $Res call({ModerationInputType inputType, ModerationCategory category});
}

/// @nodoc
class __$ModerationViolationCopyWithImpl<$Res>
    implements _$ModerationViolationCopyWith<$Res> {
  __$ModerationViolationCopyWithImpl(this._self, this._then);

  final _ModerationViolation _self;
  final $Res Function(_ModerationViolation) _then;

  /// Create a copy of ModerationViolation
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? inputType = null,
    Object? category = null,
  }) {
    return _then(_ModerationViolation(
      inputType: null == inputType
          ? _self.inputType
          : inputType // ignore: cast_nullable_to_non_nullable
              as ModerationInputType,
      category: null == category
          ? _self.category
          : category // ignore: cast_nullable_to_non_nullable
              as ModerationCategory,
    ));
  }
}

/// @nodoc
mixin _$ModerationVerdict {
  /// `true` nếu bất kỳ nội dung nào bị gắn cờ vi phạm.
  bool get isFlagged;

  /// Danh sách chi tiết các vi phạm được phát hiện.
  /// Sẽ là danh sách rỗng nếu `isFlagged` là `false`.
  List<ModerationViolation> get violations;

  /// Create a copy of ModerationVerdict
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $ModerationVerdictCopyWith<ModerationVerdict> get copyWith =>
      _$ModerationVerdictCopyWithImpl<ModerationVerdict>(
          this as ModerationVerdict, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is ModerationVerdict &&
            (identical(other.isFlagged, isFlagged) ||
                other.isFlagged == isFlagged) &&
            const DeepCollectionEquality()
                .equals(other.violations, violations));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, isFlagged, const DeepCollectionEquality().hash(violations));

  @override
  String toString() {
    return 'ModerationVerdict(isFlagged: $isFlagged, violations: $violations)';
  }
}

/// @nodoc
abstract mixin class $ModerationVerdictCopyWith<$Res> {
  factory $ModerationVerdictCopyWith(
          ModerationVerdict value, $Res Function(ModerationVerdict) _then) =
      _$ModerationVerdictCopyWithImpl;
  @useResult
  $Res call({bool isFlagged, List<ModerationViolation> violations});
}

/// @nodoc
class _$ModerationVerdictCopyWithImpl<$Res>
    implements $ModerationVerdictCopyWith<$Res> {
  _$ModerationVerdictCopyWithImpl(this._self, this._then);

  final ModerationVerdict _self;
  final $Res Function(ModerationVerdict) _then;

  /// Create a copy of ModerationVerdict
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isFlagged = null,
    Object? violations = null,
  }) {
    return _then(_self.copyWith(
      isFlagged: null == isFlagged
          ? _self.isFlagged
          : isFlagged // ignore: cast_nullable_to_non_nullable
              as bool,
      violations: null == violations
          ? _self.violations
          : violations // ignore: cast_nullable_to_non_nullable
              as List<ModerationViolation>,
    ));
  }
}

/// @nodoc

class _ModerationVerdict extends ModerationVerdict {
  const _ModerationVerdict(
      {required this.isFlagged,
      final List<ModerationViolation> violations = const []})
      : _violations = violations,
        super._();

  /// `true` nếu bất kỳ nội dung nào bị gắn cờ vi phạm.
  @override
  final bool isFlagged;

  /// Danh sách chi tiết các vi phạm được phát hiện.
  /// Sẽ là danh sách rỗng nếu `isFlagged` là `false`.
  final List<ModerationViolation> _violations;

  /// Danh sách chi tiết các vi phạm được phát hiện.
  /// Sẽ là danh sách rỗng nếu `isFlagged` là `false`.
  @override
  @JsonKey()
  List<ModerationViolation> get violations {
    if (_violations is EqualUnmodifiableListView) return _violations;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_violations);
  }

  /// Create a copy of ModerationVerdict
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$ModerationVerdictCopyWith<_ModerationVerdict> get copyWith =>
      __$ModerationVerdictCopyWithImpl<_ModerationVerdict>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _ModerationVerdict &&
            (identical(other.isFlagged, isFlagged) ||
                other.isFlagged == isFlagged) &&
            const DeepCollectionEquality()
                .equals(other._violations, _violations));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, isFlagged, const DeepCollectionEquality().hash(_violations));

  @override
  String toString() {
    return 'ModerationVerdict(isFlagged: $isFlagged, violations: $violations)';
  }
}

/// @nodoc
abstract mixin class _$ModerationVerdictCopyWith<$Res>
    implements $ModerationVerdictCopyWith<$Res> {
  factory _$ModerationVerdictCopyWith(
          _ModerationVerdict value, $Res Function(_ModerationVerdict) _then) =
      __$ModerationVerdictCopyWithImpl;
  @override
  @useResult
  $Res call({bool isFlagged, List<ModerationViolation> violations});
}

/// @nodoc
class __$ModerationVerdictCopyWithImpl<$Res>
    implements _$ModerationVerdictCopyWith<$Res> {
  __$ModerationVerdictCopyWithImpl(this._self, this._then);

  final _ModerationVerdict _self;
  final $Res Function(_ModerationVerdict) _then;

  /// Create a copy of ModerationVerdict
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? isFlagged = null,
    Object? violations = null,
  }) {
    return _then(_ModerationVerdict(
      isFlagged: null == isFlagged
          ? _self.isFlagged
          : isFlagged // ignore: cast_nullable_to_non_nullable
              as bool,
      violations: null == violations
          ? _self._violations
          : violations // ignore: cast_nullable_to_non_nullable
              as List<ModerationViolation>,
    ));
  }
}

// dart format on
