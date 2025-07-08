// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'suggestion_search_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$SuggestionSearchEvent {
  String get query;

  /// Create a copy of SuggestionSearchEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $SuggestionSearchEventCopyWith<SuggestionSearchEvent> get copyWith =>
      _$SuggestionSearchEventCopyWithImpl<SuggestionSearchEvent>(
          this as SuggestionSearchEvent, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is SuggestionSearchEvent &&
            (identical(other.query, query) || other.query == query));
  }

  @override
  int get hashCode => Object.hash(runtimeType, query);

  @override
  String toString() {
    return 'SuggestionSearchEvent(query: $query)';
  }
}

/// @nodoc
abstract mixin class $SuggestionSearchEventCopyWith<$Res> {
  factory $SuggestionSearchEventCopyWith(SuggestionSearchEvent value,
          $Res Function(SuggestionSearchEvent) _then) =
      _$SuggestionSearchEventCopyWithImpl;
  @useResult
  $Res call({String query});
}

/// @nodoc
class _$SuggestionSearchEventCopyWithImpl<$Res>
    implements $SuggestionSearchEventCopyWith<$Res> {
  _$SuggestionSearchEventCopyWithImpl(this._self, this._then);

  final SuggestionSearchEvent _self;
  final $Res Function(SuggestionSearchEvent) _then;

  /// Create a copy of SuggestionSearchEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? query = null,
  }) {
    return _then(_self.copyWith(
      query: null == query
          ? _self.query
          : query // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _QueryChanged implements SuggestionSearchEvent {
  const _QueryChanged({required this.query});

  @override
  final String query;

  /// Create a copy of SuggestionSearchEvent
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$QueryChangedCopyWith<_QueryChanged> get copyWith =>
      __$QueryChangedCopyWithImpl<_QueryChanged>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _QueryChanged &&
            (identical(other.query, query) || other.query == query));
  }

  @override
  int get hashCode => Object.hash(runtimeType, query);

  @override
  String toString() {
    return 'SuggestionSearchEvent.queryChanged(query: $query)';
  }
}

/// @nodoc
abstract mixin class _$QueryChangedCopyWith<$Res>
    implements $SuggestionSearchEventCopyWith<$Res> {
  factory _$QueryChangedCopyWith(
          _QueryChanged value, $Res Function(_QueryChanged) _then) =
      __$QueryChangedCopyWithImpl;
  @override
  @useResult
  $Res call({String query});
}

/// @nodoc
class __$QueryChangedCopyWithImpl<$Res>
    implements _$QueryChangedCopyWith<$Res> {
  __$QueryChangedCopyWithImpl(this._self, this._then);

  final _QueryChanged _self;
  final $Res Function(_QueryChanged) _then;

  /// Create a copy of SuggestionSearchEvent
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? query = null,
  }) {
    return _then(_QueryChanged(
      query: null == query
          ? _self.query
          : query // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
mixin _$SuggestionSearchState {
  SuggestionStatus
      get status; // Danh sách gợi ý, kiểu dynamic để chứa cả Post và AppUser
  List<Suggestion> get suggestions; // Lưu lỗi nếu có
  Object? get failure;

  /// Create a copy of SuggestionSearchState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $SuggestionSearchStateCopyWith<SuggestionSearchState> get copyWith =>
      _$SuggestionSearchStateCopyWithImpl<SuggestionSearchState>(
          this as SuggestionSearchState, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is SuggestionSearchState &&
            (identical(other.status, status) || other.status == status) &&
            const DeepCollectionEquality()
                .equals(other.suggestions, suggestions) &&
            const DeepCollectionEquality().equals(other.failure, failure));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      status,
      const DeepCollectionEquality().hash(suggestions),
      const DeepCollectionEquality().hash(failure));

  @override
  String toString() {
    return 'SuggestionSearchState(status: $status, suggestions: $suggestions, failure: $failure)';
  }
}

/// @nodoc
abstract mixin class $SuggestionSearchStateCopyWith<$Res> {
  factory $SuggestionSearchStateCopyWith(SuggestionSearchState value,
          $Res Function(SuggestionSearchState) _then) =
      _$SuggestionSearchStateCopyWithImpl;
  @useResult
  $Res call(
      {SuggestionStatus status, List<Suggestion> suggestions, Object? failure});
}

/// @nodoc
class _$SuggestionSearchStateCopyWithImpl<$Res>
    implements $SuggestionSearchStateCopyWith<$Res> {
  _$SuggestionSearchStateCopyWithImpl(this._self, this._then);

  final SuggestionSearchState _self;
  final $Res Function(SuggestionSearchState) _then;

  /// Create a copy of SuggestionSearchState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? suggestions = null,
    Object? failure = freezed,
  }) {
    return _then(_self.copyWith(
      status: null == status
          ? _self.status
          : status // ignore: cast_nullable_to_non_nullable
              as SuggestionStatus,
      suggestions: null == suggestions
          ? _self.suggestions
          : suggestions // ignore: cast_nullable_to_non_nullable
              as List<Suggestion>,
      failure: freezed == failure ? _self.failure : failure,
    ));
  }
}

/// @nodoc

class _SuggestionSearchState implements SuggestionSearchState {
  const _SuggestionSearchState(
      {this.status = SuggestionStatus.initial,
      final List<Suggestion> suggestions = const [],
      this.failure})
      : _suggestions = suggestions;

  @override
  @JsonKey()
  final SuggestionStatus status;
// Danh sách gợi ý, kiểu dynamic để chứa cả Post và AppUser
  final List<Suggestion> _suggestions;
// Danh sách gợi ý, kiểu dynamic để chứa cả Post và AppUser
  @override
  @JsonKey()
  List<Suggestion> get suggestions {
    if (_suggestions is EqualUnmodifiableListView) return _suggestions;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_suggestions);
  }

// Lưu lỗi nếu có
  @override
  final Object? failure;

  /// Create a copy of SuggestionSearchState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$SuggestionSearchStateCopyWith<_SuggestionSearchState> get copyWith =>
      __$SuggestionSearchStateCopyWithImpl<_SuggestionSearchState>(
          this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _SuggestionSearchState &&
            (identical(other.status, status) || other.status == status) &&
            const DeepCollectionEquality()
                .equals(other._suggestions, _suggestions) &&
            const DeepCollectionEquality().equals(other.failure, failure));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      status,
      const DeepCollectionEquality().hash(_suggestions),
      const DeepCollectionEquality().hash(failure));

  @override
  String toString() {
    return 'SuggestionSearchState(status: $status, suggestions: $suggestions, failure: $failure)';
  }
}

/// @nodoc
abstract mixin class _$SuggestionSearchStateCopyWith<$Res>
    implements $SuggestionSearchStateCopyWith<$Res> {
  factory _$SuggestionSearchStateCopyWith(_SuggestionSearchState value,
          $Res Function(_SuggestionSearchState) _then) =
      __$SuggestionSearchStateCopyWithImpl;
  @override
  @useResult
  $Res call(
      {SuggestionStatus status, List<Suggestion> suggestions, Object? failure});
}

/// @nodoc
class __$SuggestionSearchStateCopyWithImpl<$Res>
    implements _$SuggestionSearchStateCopyWith<$Res> {
  __$SuggestionSearchStateCopyWithImpl(this._self, this._then);

  final _SuggestionSearchState _self;
  final $Res Function(_SuggestionSearchState) _then;

  /// Create a copy of SuggestionSearchState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? status = null,
    Object? suggestions = null,
    Object? failure = freezed,
  }) {
    return _then(_SuggestionSearchState(
      status: null == status
          ? _self.status
          : status // ignore: cast_nullable_to_non_nullable
              as SuggestionStatus,
      suggestions: null == suggestions
          ? _self._suggestions
          : suggestions // ignore: cast_nullable_to_non_nullable
              as List<Suggestion>,
      failure: freezed == failure ? _self.failure : failure,
    ));
  }
}

// dart format on
