// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'suggestion_result.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Suggestion {
  /// Nội dung văn bản của gợi ý để hiển thị (ví dụ: "Phở Thìn").
  String get displayText;

  /// Loại của gợi ý (để hiển thị icon tương ứng).
  SuggestionType get type;

  /// Create a copy of Suggestion
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $SuggestionCopyWith<Suggestion> get copyWith =>
      _$SuggestionCopyWithImpl<Suggestion>(this as Suggestion, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is Suggestion &&
            (identical(other.displayText, displayText) ||
                other.displayText == displayText) &&
            (identical(other.type, type) || other.type == type));
  }

  @override
  int get hashCode => Object.hash(runtimeType, displayText, type);

  @override
  String toString() {
    return 'Suggestion(displayText: $displayText, type: $type)';
  }
}

/// @nodoc
abstract mixin class $SuggestionCopyWith<$Res> {
  factory $SuggestionCopyWith(
          Suggestion value, $Res Function(Suggestion) _then) =
      _$SuggestionCopyWithImpl;
  @useResult
  $Res call({String displayText, SuggestionType type});
}

/// @nodoc
class _$SuggestionCopyWithImpl<$Res> implements $SuggestionCopyWith<$Res> {
  _$SuggestionCopyWithImpl(this._self, this._then);

  final Suggestion _self;
  final $Res Function(Suggestion) _then;

  /// Create a copy of Suggestion
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? displayText = null,
    Object? type = null,
  }) {
    return _then(_self.copyWith(
      displayText: null == displayText
          ? _self.displayText
          : displayText // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _self.type
          : type // ignore: cast_nullable_to_non_nullable
              as SuggestionType,
    ));
  }
}

/// @nodoc

class _Suggestion implements Suggestion {
  const _Suggestion({required this.displayText, required this.type});

  /// Nội dung văn bản của gợi ý để hiển thị (ví dụ: "Phở Thìn").
  @override
  final String displayText;

  /// Loại của gợi ý (để hiển thị icon tương ứng).
  @override
  final SuggestionType type;

  /// Create a copy of Suggestion
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$SuggestionCopyWith<_Suggestion> get copyWith =>
      __$SuggestionCopyWithImpl<_Suggestion>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Suggestion &&
            (identical(other.displayText, displayText) ||
                other.displayText == displayText) &&
            (identical(other.type, type) || other.type == type));
  }

  @override
  int get hashCode => Object.hash(runtimeType, displayText, type);

  @override
  String toString() {
    return 'Suggestion(displayText: $displayText, type: $type)';
  }
}

/// @nodoc
abstract mixin class _$SuggestionCopyWith<$Res>
    implements $SuggestionCopyWith<$Res> {
  factory _$SuggestionCopyWith(
          _Suggestion value, $Res Function(_Suggestion) _then) =
      __$SuggestionCopyWithImpl;
  @override
  @useResult
  $Res call({String displayText, SuggestionType type});
}

/// @nodoc
class __$SuggestionCopyWithImpl<$Res> implements _$SuggestionCopyWith<$Res> {
  __$SuggestionCopyWithImpl(this._self, this._then);

  final _Suggestion _self;
  final $Res Function(_Suggestion) _then;

  /// Create a copy of Suggestion
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? displayText = null,
    Object? type = null,
  }) {
    return _then(_Suggestion(
      displayText: null == displayText
          ? _self.displayText
          : displayText // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _self.type
          : type // ignore: cast_nullable_to_non_nullable
              as SuggestionType,
    ));
  }
}

/// @nodoc
mixin _$SuggestionResult {
  /// Danh sách các đối tượng gợi ý.
  List<Suggestion> get suggestions;

  /// Create a copy of SuggestionResult
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $SuggestionResultCopyWith<SuggestionResult> get copyWith =>
      _$SuggestionResultCopyWithImpl<SuggestionResult>(
          this as SuggestionResult, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is SuggestionResult &&
            const DeepCollectionEquality()
                .equals(other.suggestions, suggestions));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(suggestions));

  @override
  String toString() {
    return 'SuggestionResult(suggestions: $suggestions)';
  }
}

/// @nodoc
abstract mixin class $SuggestionResultCopyWith<$Res> {
  factory $SuggestionResultCopyWith(
          SuggestionResult value, $Res Function(SuggestionResult) _then) =
      _$SuggestionResultCopyWithImpl;
  @useResult
  $Res call({List<Suggestion> suggestions});
}

/// @nodoc
class _$SuggestionResultCopyWithImpl<$Res>
    implements $SuggestionResultCopyWith<$Res> {
  _$SuggestionResultCopyWithImpl(this._self, this._then);

  final SuggestionResult _self;
  final $Res Function(SuggestionResult) _then;

  /// Create a copy of SuggestionResult
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? suggestions = null,
  }) {
    return _then(_self.copyWith(
      suggestions: null == suggestions
          ? _self.suggestions
          : suggestions // ignore: cast_nullable_to_non_nullable
              as List<Suggestion>,
    ));
  }
}

/// @nodoc

class _SuggestionResult implements SuggestionResult {
  const _SuggestionResult({final List<Suggestion> suggestions = const []})
      : _suggestions = suggestions;

  /// Danh sách các đối tượng gợi ý.
  final List<Suggestion> _suggestions;

  /// Danh sách các đối tượng gợi ý.
  @override
  @JsonKey()
  List<Suggestion> get suggestions {
    if (_suggestions is EqualUnmodifiableListView) return _suggestions;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_suggestions);
  }

  /// Create a copy of SuggestionResult
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$SuggestionResultCopyWith<_SuggestionResult> get copyWith =>
      __$SuggestionResultCopyWithImpl<_SuggestionResult>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _SuggestionResult &&
            const DeepCollectionEquality()
                .equals(other._suggestions, _suggestions));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(_suggestions));

  @override
  String toString() {
    return 'SuggestionResult(suggestions: $suggestions)';
  }
}

/// @nodoc
abstract mixin class _$SuggestionResultCopyWith<$Res>
    implements $SuggestionResultCopyWith<$Res> {
  factory _$SuggestionResultCopyWith(
          _SuggestionResult value, $Res Function(_SuggestionResult) _then) =
      __$SuggestionResultCopyWithImpl;
  @override
  @useResult
  $Res call({List<Suggestion> suggestions});
}

/// @nodoc
class __$SuggestionResultCopyWithImpl<$Res>
    implements _$SuggestionResultCopyWith<$Res> {
  __$SuggestionResultCopyWithImpl(this._self, this._then);

  final _SuggestionResult _self;
  final $Res Function(_SuggestionResult) _then;

  /// Create a copy of SuggestionResult
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? suggestions = null,
  }) {
    return _then(_SuggestionResult(
      suggestions: null == suggestions
          ? _self._suggestions
          : suggestions // ignore: cast_nullable_to_non_nullable
              as List<Suggestion>,
    ));
  }
}

// dart format on
