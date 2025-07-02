// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'profile_search_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ProfileSearchEvent {
  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is ProfileSearchEvent);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'ProfileSearchEvent()';
  }
}

/// @nodoc
class $ProfileSearchEventCopyWith<$Res> {
  $ProfileSearchEventCopyWith(
      ProfileSearchEvent _, $Res Function(ProfileSearchEvent) __);
}

/// @nodoc

class _SearchStarted implements ProfileSearchEvent {
  const _SearchStarted(this.query);

  final String query;

  /// Create a copy of ProfileSearchEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$SearchStartedCopyWith<_SearchStarted> get copyWith =>
      __$SearchStartedCopyWithImpl<_SearchStarted>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _SearchStarted &&
            (identical(other.query, query) || other.query == query));
  }

  @override
  int get hashCode => Object.hash(runtimeType, query);

  @override
  String toString() {
    return 'ProfileSearchEvent.searchStarted(query: $query)';
  }
}

/// @nodoc
abstract mixin class _$SearchStartedCopyWith<$Res>
    implements $ProfileSearchEventCopyWith<$Res> {
  factory _$SearchStartedCopyWith(
          _SearchStarted value, $Res Function(_SearchStarted) _then) =
      __$SearchStartedCopyWithImpl;
  @useResult
  $Res call({String query});
}

/// @nodoc
class __$SearchStartedCopyWithImpl<$Res>
    implements _$SearchStartedCopyWith<$Res> {
  __$SearchStartedCopyWithImpl(this._self, this._then);

  final _SearchStarted _self;
  final $Res Function(_SearchStarted) _then;

  /// Create a copy of ProfileSearchEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? query = null,
  }) {
    return _then(_SearchStarted(
      null == query
          ? _self.query
          : query // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _NextPageRequested implements ProfileSearchEvent {
  const _NextPageRequested();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _NextPageRequested);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'ProfileSearchEvent.nextPageRequested()';
  }
}

// dart format on
