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
      this.profile,
      this.optimized = false})
      : _coordinates = coordinates;

  final List<List<double>> _coordinates;
  List<List<double>> get coordinates {
    if (_coordinates is EqualUnmodifiableListView) return _coordinates;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_coordinates);
  }

  final String? profile;
  @JsonKey()
  final bool optimized;

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
            (identical(other.profile, profile) || other.profile == profile) &&
            (identical(other.optimized, optimized) ||
                other.optimized == optimized));
  }

  @override
  int get hashCode => Object.hash(runtimeType,
      const DeepCollectionEquality().hash(_coordinates), profile, optimized);

  @override
  String toString() {
    return 'MapEvent.routeRequested(coordinates: $coordinates, profile: $profile, optimized: $optimized)';
  }
}

/// @nodoc
abstract mixin class _$RouteRequestedCopyWith<$Res>
    implements $MapEventCopyWith<$Res> {
  factory _$RouteRequestedCopyWith(
          _RouteRequested value, $Res Function(_RouteRequested) _then) =
      __$RouteRequestedCopyWithImpl;
  @useResult
  $Res call({List<List<double>> coordinates, String? profile, bool optimized});
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
    Object? profile = freezed,
    Object? optimized = null,
  }) {
    return _then(_RouteRequested(
      coordinates: null == coordinates
          ? _self._coordinates
          : coordinates // ignore: cast_nullable_to_non_nullable
              as List<List<double>>,
      profile: freezed == profile
          ? _self.profile
          : profile // ignore: cast_nullable_to_non_nullable
              as String?,
      optimized: null == optimized
          ? _self.optimized
          : optimized // ignore: cast_nullable_to_non_nullable
              as bool,
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

class _NavigationStopped implements MapEvent {
  const _NavigationStopped();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _NavigationStopped);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'MapEvent.navigationStopped()';
  }
}

/// @nodoc

class _LocationUpdated implements MapEvent {
  const _LocationUpdated(this.locationUpdate);

  final Either<DirectionFailure, LocationData> locationUpdate;

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
            (identical(other.locationUpdate, locationUpdate) ||
                other.locationUpdate == locationUpdate));
  }

  @override
  int get hashCode => Object.hash(runtimeType, locationUpdate);

  @override
  String toString() {
    return 'MapEvent.locationUpdated(locationUpdate: $locationUpdate)';
  }
}

/// @nodoc
abstract mixin class _$LocationUpdatedCopyWith<$Res>
    implements $MapEventCopyWith<$Res> {
  factory _$LocationUpdatedCopyWith(
          _LocationUpdated value, $Res Function(_LocationUpdated) _then) =
      __$LocationUpdatedCopyWithImpl;
  @useResult
  $Res call({Either<DirectionFailure, LocationData> locationUpdate});
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
    Object? locationUpdate = null,
  }) {
    return _then(_LocationUpdated(
      null == locationUpdate
          ? _self.locationUpdate
          : locationUpdate // ignore: cast_nullable_to_non_nullable
              as Either<DirectionFailure, LocationData>,
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

class Initial implements MapState {
  const Initial();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is Initial);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'MapState.initial()';
  }
}

/// @nodoc

class LoadInProgress implements MapState {
  const LoadInProgress();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is LoadInProgress);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'MapState.loadInProgress()';
  }
}

/// @nodoc

class LoadFailure implements MapState {
  const LoadFailure(this.failure);

  final DirectionFailure failure;

  /// Create a copy of MapState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $LoadFailureCopyWith<LoadFailure> get copyWith =>
      _$LoadFailureCopyWithImpl<LoadFailure>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is LoadFailure &&
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
abstract mixin class $LoadFailureCopyWith<$Res>
    implements $MapStateCopyWith<$Res> {
  factory $LoadFailureCopyWith(
          LoadFailure value, $Res Function(LoadFailure) _then) =
      _$LoadFailureCopyWithImpl;
  @useResult
  $Res call({DirectionFailure failure});
}

/// @nodoc
class _$LoadFailureCopyWithImpl<$Res> implements $LoadFailureCopyWith<$Res> {
  _$LoadFailureCopyWithImpl(this._self, this._then);

  final LoadFailure _self;
  final $Res Function(LoadFailure) _then;

  /// Create a copy of MapState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? failure = null,
  }) {
    return _then(LoadFailure(
      null == failure
          ? _self.failure
          : failure // ignore: cast_nullable_to_non_nullable
              as DirectionFailure,
    ));
  }
}

/// @nodoc

class Preview implements MapState {
  const Preview(this.direction);

  final Direction direction;

  /// Create a copy of MapState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $PreviewCopyWith<Preview> get copyWith =>
      _$PreviewCopyWithImpl<Preview>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is Preview &&
            (identical(other.direction, direction) ||
                other.direction == direction));
  }

  @override
  int get hashCode => Object.hash(runtimeType, direction);

  @override
  String toString() {
    return 'MapState.preview(direction: $direction)';
  }
}

/// @nodoc
abstract mixin class $PreviewCopyWith<$Res> implements $MapStateCopyWith<$Res> {
  factory $PreviewCopyWith(Preview value, $Res Function(Preview) _then) =
      _$PreviewCopyWithImpl;
  @useResult
  $Res call({Direction direction});

  $DirectionCopyWith<$Res> get direction;
}

/// @nodoc
class _$PreviewCopyWithImpl<$Res> implements $PreviewCopyWith<$Res> {
  _$PreviewCopyWithImpl(this._self, this._then);

  final Preview _self;
  final $Res Function(Preview) _then;

  /// Create a copy of MapState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? direction = null,
  }) {
    return _then(Preview(
      null == direction
          ? _self.direction
          : direction // ignore: cast_nullable_to_non_nullable
              as Direction,
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
}

/// @nodoc

class Navigating implements MapState {
  const Navigating({required this.direction, required this.currentLocation});

  final Direction direction;
  final LocationData currentLocation;

  /// Create a copy of MapState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $NavigatingCopyWith<Navigating> get copyWith =>
      _$NavigatingCopyWithImpl<Navigating>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is Navigating &&
            (identical(other.direction, direction) ||
                other.direction == direction) &&
            (identical(other.currentLocation, currentLocation) ||
                other.currentLocation == currentLocation));
  }

  @override
  int get hashCode => Object.hash(runtimeType, direction, currentLocation);

  @override
  String toString() {
    return 'MapState.navigating(direction: $direction, currentLocation: $currentLocation)';
  }
}

/// @nodoc
abstract mixin class $NavigatingCopyWith<$Res>
    implements $MapStateCopyWith<$Res> {
  factory $NavigatingCopyWith(
          Navigating value, $Res Function(Navigating) _then) =
      _$NavigatingCopyWithImpl;
  @useResult
  $Res call({Direction direction, LocationData currentLocation});

  $DirectionCopyWith<$Res> get direction;
  $LocationDataCopyWith<$Res> get currentLocation;
}

/// @nodoc
class _$NavigatingCopyWithImpl<$Res> implements $NavigatingCopyWith<$Res> {
  _$NavigatingCopyWithImpl(this._self, this._then);

  final Navigating _self;
  final $Res Function(Navigating) _then;

  /// Create a copy of MapState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? direction = null,
    Object? currentLocation = null,
  }) {
    return _then(Navigating(
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
