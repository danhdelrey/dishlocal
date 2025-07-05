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

class _RouteRequested implements MapEvent {
  const _RouteRequested(
      {required final List<List<double>> coordinates,
      this.profile = 'driving-traffic'})
      : _coordinates = coordinates;

  final List<List<double>> _coordinates;
  List<List<double>> get coordinates {
    if (_coordinates is EqualUnmodifiableListView) return _coordinates;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_coordinates);
  }

  @JsonKey()
  final String profile;

  /// Create a copy of MapEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$RouteRequestedCopyWith<_RouteRequested> get copyWith =>
      __$RouteRequestedCopyWithImpl<_RouteRequested>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _RouteRequested &&
            const DeepCollectionEquality()
                .equals(other._coordinates, _coordinates) &&
            (identical(other.profile, profile) || other.profile == profile));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(_coordinates), profile);

  @override
  String toString() {
    return 'MapEvent.routeRequested(coordinates: $coordinates, profile: $profile)';
  }
}

/// @nodoc
abstract mixin class _$RouteRequestedCopyWith<$Res>
    implements $MapEventCopyWith<$Res> {
  factory _$RouteRequestedCopyWith(
          _RouteRequested value, $Res Function(_RouteRequested) _then) =
      __$RouteRequestedCopyWithImpl;
  @useResult
  $Res call({List<List<double>> coordinates, String profile});
}

/// @nodoc
class __$RouteRequestedCopyWithImpl<$Res>
    implements _$RouteRequestedCopyWith<$Res> {
  __$RouteRequestedCopyWithImpl(this._self, this._then);

  final _RouteRequested _self;
  final $Res Function(_RouteRequested) _then;

  /// Create a copy of MapEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? coordinates = null,
    Object? profile = null,
  }) {
    return _then(_RouteRequested(
      coordinates: null == coordinates
          ? _self._coordinates
          : coordinates // ignore: cast_nullable_to_non_nullable
              as List<List<double>>,
      profile: null == profile
          ? _self.profile
          : profile // ignore: cast_nullable_to_non_nullable
              as String,
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

class _LocationUpdated implements MapEvent {
  const _LocationUpdated({required this.locationData});

  final LocationData locationData;

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
            (identical(other.locationData, locationData) ||
                other.locationData == locationData));
  }

  @override
  int get hashCode => Object.hash(runtimeType, locationData);

  @override
  String toString() {
    return 'MapEvent.locationUpdated(locationData: $locationData)';
  }
}

/// @nodoc
abstract mixin class _$LocationUpdatedCopyWith<$Res>
    implements $MapEventCopyWith<$Res> {
  factory _$LocationUpdatedCopyWith(
          _LocationUpdated value, $Res Function(_LocationUpdated) _then) =
      __$LocationUpdatedCopyWithImpl;
  @useResult
  $Res call({LocationData locationData});

  $LocationDataCopyWith<$Res> get locationData;
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
    Object? locationData = null,
  }) {
    return _then(_LocationUpdated(
      locationData: null == locationData
          ? _self.locationData
          : locationData // ignore: cast_nullable_to_non_nullable
              as LocationData,
    ));
  }

  /// Create a copy of MapEvent
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $LocationDataCopyWith<$Res> get locationData {
    return $LocationDataCopyWith<$Res>(_self.locationData, (value) {
      return _then(_self.copyWith(locationData: value));
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

class _LoadInProgress implements MapState {
  const _LoadInProgress();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _LoadInProgress);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'MapState.loadInProgress()';
  }
}

/// @nodoc

class _LoadSuccess implements MapState {
  const _LoadSuccess({required this.direction, required this.currentLocation});

  final Direction direction;
  final LocationData? currentLocation;

  /// Create a copy of MapState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$LoadSuccessCopyWith<_LoadSuccess> get copyWith =>
      __$LoadSuccessCopyWithImpl<_LoadSuccess>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _LoadSuccess &&
            (identical(other.direction, direction) ||
                other.direction == direction) &&
            (identical(other.currentLocation, currentLocation) ||
                other.currentLocation == currentLocation));
  }

  @override
  int get hashCode => Object.hash(runtimeType, direction, currentLocation);

  @override
  String toString() {
    return 'MapState.loadSuccess(direction: $direction, currentLocation: $currentLocation)';
  }
}

/// @nodoc
abstract mixin class _$LoadSuccessCopyWith<$Res>
    implements $MapStateCopyWith<$Res> {
  factory _$LoadSuccessCopyWith(
          _LoadSuccess value, $Res Function(_LoadSuccess) _then) =
      __$LoadSuccessCopyWithImpl;
  @useResult
  $Res call({Direction direction, LocationData? currentLocation});

  $DirectionCopyWith<$Res> get direction;
  $LocationDataCopyWith<$Res>? get currentLocation;
}

/// @nodoc
class __$LoadSuccessCopyWithImpl<$Res> implements _$LoadSuccessCopyWith<$Res> {
  __$LoadSuccessCopyWithImpl(this._self, this._then);

  final _LoadSuccess _self;
  final $Res Function(_LoadSuccess) _then;

  /// Create a copy of MapState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? direction = null,
    Object? currentLocation = freezed,
  }) {
    return _then(_LoadSuccess(
      direction: null == direction
          ? _self.direction
          : direction // ignore: cast_nullable_to_non_nullable
              as Direction,
      currentLocation: freezed == currentLocation
          ? _self.currentLocation
          : currentLocation // ignore: cast_nullable_to_non_nullable
              as LocationData?,
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
  $LocationDataCopyWith<$Res>? get currentLocation {
    if (_self.currentLocation == null) {
      return null;
    }

    return $LocationDataCopyWith<$Res>(_self.currentLocation!, (value) {
      return _then(_self.copyWith(currentLocation: value));
    });
  }
}

/// @nodoc

class _LoadFailure implements MapState {
  const _LoadFailure({required this.failure});

  final DirectionFailure failure;

  /// Create a copy of MapState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$LoadFailureCopyWith<_LoadFailure> get copyWith =>
      __$LoadFailureCopyWithImpl<_LoadFailure>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _LoadFailure &&
            (identical(other.failure, failure) || other.failure == failure));
  }

  @override
  int get hashCode => Object.hash(runtimeType, failure);

  @override
  String toString() {
    return 'MapState.loadFailure(failure: $failure)';
  }
}

/// @nodoc
abstract mixin class _$LoadFailureCopyWith<$Res>
    implements $MapStateCopyWith<$Res> {
  factory _$LoadFailureCopyWith(
          _LoadFailure value, $Res Function(_LoadFailure) _then) =
      __$LoadFailureCopyWithImpl;
  @useResult
  $Res call({DirectionFailure failure});
}

/// @nodoc
class __$LoadFailureCopyWithImpl<$Res> implements _$LoadFailureCopyWith<$Res> {
  __$LoadFailureCopyWithImpl(this._self, this._then);

  final _LoadFailure _self;
  final $Res Function(_LoadFailure) _then;

  /// Create a copy of MapState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? failure = null,
  }) {
    return _then(_LoadFailure(
      failure: null == failure
          ? _self.failure
          : failure // ignore: cast_nullable_to_non_nullable
              as DirectionFailure,
    ));
  }
}

/// @nodoc

class _Navigation implements MapState {
  const _Navigation({required this.direction, required this.currentLocation});

  final Direction direction;
  final LocationData currentLocation;

  /// Create a copy of MapState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$NavigationCopyWith<_Navigation> get copyWith =>
      __$NavigationCopyWithImpl<_Navigation>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Navigation &&
            (identical(other.direction, direction) ||
                other.direction == direction) &&
            (identical(other.currentLocation, currentLocation) ||
                other.currentLocation == currentLocation));
  }

  @override
  int get hashCode => Object.hash(runtimeType, direction, currentLocation);

  @override
  String toString() {
    return 'MapState.navigation(direction: $direction, currentLocation: $currentLocation)';
  }
}

/// @nodoc
abstract mixin class _$NavigationCopyWith<$Res>
    implements $MapStateCopyWith<$Res> {
  factory _$NavigationCopyWith(
          _Navigation value, $Res Function(_Navigation) _then) =
      __$NavigationCopyWithImpl;
  @useResult
  $Res call({Direction direction, LocationData currentLocation});

  $DirectionCopyWith<$Res> get direction;
  $LocationDataCopyWith<$Res> get currentLocation;
}

/// @nodoc
class __$NavigationCopyWithImpl<$Res> implements _$NavigationCopyWith<$Res> {
  __$NavigationCopyWithImpl(this._self, this._then);

  final _Navigation _self;
  final $Res Function(_Navigation) _then;

  /// Create a copy of MapState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? direction = null,
    Object? currentLocation = null,
  }) {
    return _then(_Navigation(
      direction: null == direction
          ? _self.direction
          : direction // ignore: cast_nullable_to_non_nullable
              as Direction,
      currentLocation: null == currentLocation
          ? _self.currentLocation
          : currentLocation // ignore: cast_nullable_to_non_nullable
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
  $LocationDataCopyWith<$Res> get currentLocation {
    return $LocationDataCopyWith<$Res>(_self.currentLocation, (value) {
      return _then(_self.copyWith(currentLocation: value));
    });
  }
}

// dart format on
