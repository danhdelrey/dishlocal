// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'map_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$MapEvent {
  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is MapEvent);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'MapEvent()';
  }
}

/// @nodoc
class $MapEventCopyWith<$Res> {
  $MapEventCopyWith(MapEvent _, $Res Function(MapEvent) __);
}

/// @nodoc

class _NavigationStarted implements MapEvent {
  const _NavigationStarted({required final List<double> destinationCoordinates})
      : _destinationCoordinates = destinationCoordinates;

  final List<double> _destinationCoordinates;
  List<double> get destinationCoordinates {
    if (_destinationCoordinates is EqualUnmodifiableListView)
      return _destinationCoordinates;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_destinationCoordinates);
  }

  /// Create a copy of MapEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$NavigationStartedCopyWith<_NavigationStarted> get copyWith =>
      __$NavigationStartedCopyWithImpl<_NavigationStarted>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _NavigationStarted &&
            const DeepCollectionEquality().equals(
                other._destinationCoordinates, _destinationCoordinates));
  }

  @override
  int get hashCode => Object.hash(runtimeType,
      const DeepCollectionEquality().hash(_destinationCoordinates));

  @override
  String toString() {
    return 'MapEvent.navigationStarted(destinationCoordinates: $destinationCoordinates)';
  }
}

/// @nodoc
abstract mixin class _$NavigationStartedCopyWith<$Res>
    implements $MapEventCopyWith<$Res> {
  factory _$NavigationStartedCopyWith(
          _NavigationStarted value, $Res Function(_NavigationStarted) _then) =
      __$NavigationStartedCopyWithImpl;
  @useResult
  $Res call({List<double> destinationCoordinates});
}

/// @nodoc
class __$NavigationStartedCopyWithImpl<$Res>
    implements _$NavigationStartedCopyWith<$Res> {
  __$NavigationStartedCopyWithImpl(this._self, this._then);

  final _NavigationStarted _self;
  final $Res Function(_NavigationStarted) _then;

  /// Create a copy of MapEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? destinationCoordinates = null,
  }) {
    return _then(_NavigationStarted(
      destinationCoordinates: null == destinationCoordinates
          ? _self._destinationCoordinates
          : destinationCoordinates // ignore: cast_nullable_to_non_nullable
              as List<double>,
    ));
  }
}

/// @nodoc

class _LocationUpdated implements MapEvent {
  const _LocationUpdated({required this.userLocation});

  final LocationData userLocation;

  /// Create a copy of MapEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$LocationUpdatedCopyWith<_LocationUpdated> get copyWith =>
      __$LocationUpdatedCopyWithImpl<_LocationUpdated>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _LocationUpdated &&
            (identical(other.userLocation, userLocation) ||
                other.userLocation == userLocation));
  }

  @override
  int get hashCode => Object.hash(runtimeType, userLocation);

  @override
  String toString() {
    return 'MapEvent.locationUpdated(userLocation: $userLocation)';
  }
}

/// @nodoc
abstract mixin class _$LocationUpdatedCopyWith<$Res>
    implements $MapEventCopyWith<$Res> {
  factory _$LocationUpdatedCopyWith(
          _LocationUpdated value, $Res Function(_LocationUpdated) _then) =
      __$LocationUpdatedCopyWithImpl;
  @useResult
  $Res call({LocationData userLocation});

  $LocationDataCopyWith<$Res> get userLocation;
}

/// @nodoc
class __$LocationUpdatedCopyWithImpl<$Res>
    implements _$LocationUpdatedCopyWith<$Res> {
  __$LocationUpdatedCopyWithImpl(this._self, this._then);

  final _LocationUpdated _self;
  final $Res Function(_LocationUpdated) _then;

  /// Create a copy of MapEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? userLocation = null,
  }) {
    return _then(_LocationUpdated(
      userLocation: null == userLocation
          ? _self.userLocation
          : userLocation // ignore: cast_nullable_to_non_nullable
              as LocationData,
    ));
  }

  /// Create a copy of MapEvent
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $LocationDataCopyWith<$Res> get userLocation {
    return $LocationDataCopyWith<$Res>(_self.userLocation, (value) {
      return _then(_self.copyWith(userLocation: value));
    });
  }
}

/// @nodoc

class _LocationStreamFailed implements MapEvent {
  const _LocationStreamFailed({required this.failure});

  final DirectionFailure failure;

  /// Create a copy of MapEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$LocationStreamFailedCopyWith<_LocationStreamFailed> get copyWith =>
      __$LocationStreamFailedCopyWithImpl<_LocationStreamFailed>(
          this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _LocationStreamFailed &&
            (identical(other.failure, failure) || other.failure == failure));
  }

  @override
  int get hashCode => Object.hash(runtimeType, failure);

  @override
  String toString() {
    return 'MapEvent.locationStreamFailed(failure: $failure)';
  }
}

/// @nodoc
abstract mixin class _$LocationStreamFailedCopyWith<$Res>
    implements $MapEventCopyWith<$Res> {
  factory _$LocationStreamFailedCopyWith(_LocationStreamFailed value,
          $Res Function(_LocationStreamFailed) _then) =
      __$LocationStreamFailedCopyWithImpl;
  @useResult
  $Res call({DirectionFailure failure});
}

/// @nodoc
class __$LocationStreamFailedCopyWithImpl<$Res>
    implements _$LocationStreamFailedCopyWith<$Res> {
  __$LocationStreamFailedCopyWithImpl(this._self, this._then);

  final _LocationStreamFailed _self;
  final $Res Function(_LocationStreamFailed) _then;

  /// Create a copy of MapEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? failure = null,
  }) {
    return _then(_LocationStreamFailed(
      failure: null == failure
          ? _self.failure
          : failure // ignore: cast_nullable_to_non_nullable
              as DirectionFailure,
    ));
  }
}

/// @nodoc
mixin _$MapState {
  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is MapState);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'MapState()';
  }
}

/// @nodoc
class $MapStateCopyWith<$Res> {
  $MapStateCopyWith(MapState _, $Res Function(MapState) __);
}

/// @nodoc

class _Initial implements MapState {
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
    return 'MapState.initial()';
  }
}

/// @nodoc

class _Loading implements MapState {
  const _Loading();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _Loading);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'MapState.loading()';
  }
}

/// @nodoc

class _Success implements MapState {
  const _Success({required this.direction, required this.userLocation});

  final Direction direction;
  final LocationData userLocation;

  /// Create a copy of MapState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$SuccessCopyWith<_Success> get copyWith =>
      __$SuccessCopyWithImpl<_Success>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Success &&
            (identical(other.direction, direction) ||
                other.direction == direction) &&
            (identical(other.userLocation, userLocation) ||
                other.userLocation == userLocation));
  }

  @override
  int get hashCode => Object.hash(runtimeType, direction, userLocation);

  @override
  String toString() {
    return 'MapState.success(direction: $direction, userLocation: $userLocation)';
  }
}

/// @nodoc
abstract mixin class _$SuccessCopyWith<$Res>
    implements $MapStateCopyWith<$Res> {
  factory _$SuccessCopyWith(_Success value, $Res Function(_Success) _then) =
      __$SuccessCopyWithImpl;
  @useResult
  $Res call({Direction direction, LocationData userLocation});

  $DirectionCopyWith<$Res> get direction;
  $LocationDataCopyWith<$Res> get userLocation;
}

/// @nodoc
class __$SuccessCopyWithImpl<$Res> implements _$SuccessCopyWith<$Res> {
  __$SuccessCopyWithImpl(this._self, this._then);

  final _Success _self;
  final $Res Function(_Success) _then;

  /// Create a copy of MapState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? direction = null,
    Object? userLocation = null,
  }) {
    return _then(_Success(
      direction: null == direction
          ? _self.direction
          : direction // ignore: cast_nullable_to_non_nullable
              as Direction,
      userLocation: null == userLocation
          ? _self.userLocation
          : userLocation // ignore: cast_nullable_to_non_nullable
              as LocationData,
    ));
  }

  /// Create a copy of MapState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $DirectionCopyWith<$Res> get direction {
    return $DirectionCopyWith<$Res>(_self.direction, (value) {
      return _then(_self.copyWith(direction: value));
    });
  }

  /// Create a copy of MapState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $LocationDataCopyWith<$Res> get userLocation {
    return $LocationDataCopyWith<$Res>(_self.userLocation, (value) {
      return _then(_self.copyWith(userLocation: value));
    });
  }
}

/// @nodoc

class _Failure implements MapState {
  const _Failure({required this.failure});

  final DirectionFailure failure;

  /// Create a copy of MapState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$FailureCopyWith<_Failure> get copyWith =>
      __$FailureCopyWithImpl<_Failure>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Failure &&
            (identical(other.failure, failure) || other.failure == failure));
  }

  @override
  int get hashCode => Object.hash(runtimeType, failure);

  @override
  String toString() {
    return 'MapState.failure(failure: $failure)';
  }
}

/// @nodoc
abstract mixin class _$FailureCopyWith<$Res>
    implements $MapStateCopyWith<$Res> {
  factory _$FailureCopyWith(_Failure value, $Res Function(_Failure) _then) =
      __$FailureCopyWithImpl;
  @useResult
  $Res call({DirectionFailure failure});
}

/// @nodoc
class __$FailureCopyWithImpl<$Res> implements _$FailureCopyWith<$Res> {
  __$FailureCopyWithImpl(this._self, this._then);

  final _Failure _self;
  final $Res Function(_Failure) _then;

  /// Create a copy of MapState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? failure = null,
  }) {
    return _then(_Failure(
      failure: null == failure
          ? _self.failure
          : failure // ignore: cast_nullable_to_non_nullable
              as DirectionFailure,
    ));
  }
}

// dart format on
