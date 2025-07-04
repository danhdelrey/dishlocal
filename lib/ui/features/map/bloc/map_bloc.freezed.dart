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

class _FindRouteRequested implements MapEvent {
  const _FindRouteRequested({required this.start, required this.destination});

  final LatLng start;
  final LatLng destination;

  /// Create a copy of MapEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$FindRouteRequestedCopyWith<_FindRouteRequested> get copyWith =>
      __$FindRouteRequestedCopyWithImpl<_FindRouteRequested>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _FindRouteRequested &&
            (identical(other.start, start) || other.start == start) &&
            (identical(other.destination, destination) ||
                other.destination == destination));
  }

  @override
  int get hashCode => Object.hash(runtimeType, start, destination);

  @override
  String toString() {
    return 'MapEvent.findRouteRequested(start: $start, destination: $destination)';
  }
}

/// @nodoc
abstract mixin class _$FindRouteRequestedCopyWith<$Res>
    implements $MapEventCopyWith<$Res> {
  factory _$FindRouteRequestedCopyWith(
          _FindRouteRequested value, $Res Function(_FindRouteRequested) _then) =
      __$FindRouteRequestedCopyWithImpl;
  @useResult
  $Res call({LatLng start, LatLng destination});
}

/// @nodoc
class __$FindRouteRequestedCopyWithImpl<$Res>
    implements _$FindRouteRequestedCopyWith<$Res> {
  __$FindRouteRequestedCopyWithImpl(this._self, this._then);

  final _FindRouteRequested _self;
  final $Res Function(_FindRouteRequested) _then;

  /// Create a copy of MapEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? start = null,
    Object? destination = null,
  }) {
    return _then(_FindRouteRequested(
      start: null == start
          ? _self.start
          : start // ignore: cast_nullable_to_non_nullable
              as LatLng,
      destination: null == destination
          ? _self.destination
          : destination // ignore: cast_nullable_to_non_nullable
              as LatLng,
    ));
  }
}

/// @nodoc

class _NavigationStarted implements MapEvent {
  const _NavigationStarted();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _NavigationStarted);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'MapEvent.navigationStarted()';
  }
}

/// @nodoc

class _UserLocationUpdated implements MapEvent {
  const _UserLocationUpdated(this.newLocation);

  final LocationData newLocation;

  /// Create a copy of MapEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$UserLocationUpdatedCopyWith<_UserLocationUpdated> get copyWith =>
      __$UserLocationUpdatedCopyWithImpl<_UserLocationUpdated>(
          this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _UserLocationUpdated &&
            (identical(other.newLocation, newLocation) ||
                other.newLocation == newLocation));
  }

  @override
  int get hashCode => Object.hash(runtimeType, newLocation);

  @override
  String toString() {
    return 'MapEvent.userLocationUpdated(newLocation: $newLocation)';
  }
}

/// @nodoc
abstract mixin class _$UserLocationUpdatedCopyWith<$Res>
    implements $MapEventCopyWith<$Res> {
  factory _$UserLocationUpdatedCopyWith(_UserLocationUpdated value,
          $Res Function(_UserLocationUpdated) _then) =
      __$UserLocationUpdatedCopyWithImpl;
  @useResult
  $Res call({LocationData newLocation});

  $LocationDataCopyWith<$Res> get newLocation;
}

/// @nodoc
class __$UserLocationUpdatedCopyWithImpl<$Res>
    implements _$UserLocationUpdatedCopyWith<$Res> {
  __$UserLocationUpdatedCopyWithImpl(this._self, this._then);

  final _UserLocationUpdated _self;
  final $Res Function(_UserLocationUpdated) _then;

  /// Create a copy of MapEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? newLocation = null,
  }) {
    return _then(_UserLocationUpdated(
      null == newLocation
          ? _self.newLocation
          : newLocation // ignore: cast_nullable_to_non_nullable
              as LocationData,
    ));
  }

  /// Create a copy of MapEvent
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $LocationDataCopyWith<$Res> get newLocation {
    return $LocationDataCopyWith<$Res>(_self.newLocation, (value) {
      return _then(_self.copyWith(newLocation: value));
    });
  }
}

/// @nodoc

class _ArrivalConfirmed implements MapEvent {
  const _ArrivalConfirmed();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _ArrivalConfirmed);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'MapEvent.arrivalConfirmed()';
  }
}

/// @nodoc

class _Reset implements MapEvent {
  const _Reset();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _Reset);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'MapEvent.reset()';
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

class _RouteFinding implements MapState {
  const _RouteFinding();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _RouteFinding);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'MapState.routeFinding()';
  }
}

/// @nodoc

class _RouteFindingFailure implements MapState {
  const _RouteFindingFailure(this.failure);

  final DirectionFailure failure;

  /// Create a copy of MapState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$RouteFindingFailureCopyWith<_RouteFindingFailure> get copyWith =>
      __$RouteFindingFailureCopyWithImpl<_RouteFindingFailure>(
          this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _RouteFindingFailure &&
            const DeepCollectionEquality().equals(other.failure, failure));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(failure));

  @override
  String toString() {
    return 'MapState.routeFindingFailure(failure: $failure)';
  }
}

/// @nodoc
abstract mixin class _$RouteFindingFailureCopyWith<$Res>
    implements $MapStateCopyWith<$Res> {
  factory _$RouteFindingFailureCopyWith(_RouteFindingFailure value,
          $Res Function(_RouteFindingFailure) _then) =
      __$RouteFindingFailureCopyWithImpl;
  @useResult
  $Res call({DirectionFailure failure});
}

/// @nodoc
class __$RouteFindingFailureCopyWithImpl<$Res>
    implements _$RouteFindingFailureCopyWith<$Res> {
  __$RouteFindingFailureCopyWithImpl(this._self, this._then);

  final _RouteFindingFailure _self;
  final $Res Function(_RouteFindingFailure) _then;

  /// Create a copy of MapState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? failure = freezed,
  }) {
    return _then(_RouteFindingFailure(
      freezed == failure
          ? _self.failure
          : failure // ignore: cast_nullable_to_non_nullable
              as DirectionFailure,
    ));
  }
}

/// @nodoc

class _RouteFound implements MapState {
  const _RouteFound({required this.direction});

  final Direction direction;

  /// Create a copy of MapState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$RouteFoundCopyWith<_RouteFound> get copyWith =>
      __$RouteFoundCopyWithImpl<_RouteFound>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _RouteFound &&
            const DeepCollectionEquality().equals(other.direction, direction));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(direction));

  @override
  String toString() {
    return 'MapState.routeFound(direction: $direction)';
  }
}

/// @nodoc
abstract mixin class _$RouteFoundCopyWith<$Res>
    implements $MapStateCopyWith<$Res> {
  factory _$RouteFoundCopyWith(
          _RouteFound value, $Res Function(_RouteFound) _then) =
      __$RouteFoundCopyWithImpl;
  @useResult
  $Res call({Direction direction});
}

/// @nodoc
class __$RouteFoundCopyWithImpl<$Res> implements _$RouteFoundCopyWith<$Res> {
  __$RouteFoundCopyWithImpl(this._self, this._then);

  final _RouteFound _self;
  final $Res Function(_RouteFound) _then;

  /// Create a copy of MapState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? direction = freezed,
  }) {
    return _then(_RouteFound(
      direction: freezed == direction
          ? _self.direction
          : direction // ignore: cast_nullable_to_non_nullable
              as Direction,
    ));
  }
}

/// @nodoc

class _NavigationInProgress implements MapState {
  const _NavigationInProgress(
      {required this.direction,
      required this.userLocation,
      required this.currentStep,
      required this.distanceToNextManeuver});

  final Direction direction;
  final LocationData userLocation;
  final StepModel currentStep;
// Step hiện tại để hiển thị chỉ dẫn
  final double distanceToNextManeuver;

  /// Create a copy of MapState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$NavigationInProgressCopyWith<_NavigationInProgress> get copyWith =>
      __$NavigationInProgressCopyWithImpl<_NavigationInProgress>(
          this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _NavigationInProgress &&
            const DeepCollectionEquality().equals(other.direction, direction) &&
            (identical(other.userLocation, userLocation) ||
                other.userLocation == userLocation) &&
            const DeepCollectionEquality()
                .equals(other.currentStep, currentStep) &&
            (identical(other.distanceToNextManeuver, distanceToNextManeuver) ||
                other.distanceToNextManeuver == distanceToNextManeuver));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(direction),
      userLocation,
      const DeepCollectionEquality().hash(currentStep),
      distanceToNextManeuver);

  @override
  String toString() {
    return 'MapState.navigationInProgress(direction: $direction, userLocation: $userLocation, currentStep: $currentStep, distanceToNextManeuver: $distanceToNextManeuver)';
  }
}

/// @nodoc
abstract mixin class _$NavigationInProgressCopyWith<$Res>
    implements $MapStateCopyWith<$Res> {
  factory _$NavigationInProgressCopyWith(_NavigationInProgress value,
          $Res Function(_NavigationInProgress) _then) =
      __$NavigationInProgressCopyWithImpl;
  @useResult
  $Res call(
      {Direction direction,
      LocationData userLocation,
      StepModel currentStep,
      double distanceToNextManeuver});

  $LocationDataCopyWith<$Res> get userLocation;
}

/// @nodoc
class __$NavigationInProgressCopyWithImpl<$Res>
    implements _$NavigationInProgressCopyWith<$Res> {
  __$NavigationInProgressCopyWithImpl(this._self, this._then);

  final _NavigationInProgress _self;
  final $Res Function(_NavigationInProgress) _then;

  /// Create a copy of MapState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? direction = freezed,
    Object? userLocation = null,
    Object? currentStep = freezed,
    Object? distanceToNextManeuver = null,
  }) {
    return _then(_NavigationInProgress(
      direction: freezed == direction
          ? _self.direction
          : direction // ignore: cast_nullable_to_non_nullable
              as Direction,
      userLocation: null == userLocation
          ? _self.userLocation
          : userLocation // ignore: cast_nullable_to_non_nullable
              as LocationData,
      currentStep: freezed == currentStep
          ? _self.currentStep
          : currentStep // ignore: cast_nullable_to_non_nullable
              as StepModel,
      distanceToNextManeuver: null == distanceToNextManeuver
          ? _self.distanceToNextManeuver
          : distanceToNextManeuver // ignore: cast_nullable_to_non_nullable
              as double,
    ));
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

class _Arrived implements MapState {
  const _Arrived();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _Arrived);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'MapState.arrived()';
  }
}

/// @nodoc

class _Rerouting implements MapState {
  const _Rerouting();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _Rerouting);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'MapState.rerouting()';
  }
}

// dart format on
