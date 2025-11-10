// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
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

/// Adds pattern-matching-related methods to [MapEvent].
extension MapEventPatterns on MapEvent {
  /// A variant of `map` that fallback to returning `orElse`.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case _:
  ///     return orElse();
  /// }
  /// ```

  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_RouteRequested value)? routeRequested,
    TResult Function(_NavigationStarted value)? navigationStarted,
    TResult Function(_NavigationStopped value)? navigationStopped,
    TResult Function(_LocationUpdated value)? locationUpdated,
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _RouteRequested() when routeRequested != null:
        return routeRequested(_that);
      case _NavigationStarted() when navigationStarted != null:
        return navigationStarted(_that);
      case _NavigationStopped() when navigationStopped != null:
        return navigationStopped(_that);
      case _LocationUpdated() when locationUpdated != null:
        return locationUpdated(_that);
      case _:
        return orElse();
    }
  }

  /// A `switch`-like method, using callbacks.
  ///
  /// Callbacks receives the raw object, upcasted.
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case final Subclass2 value:
  ///     return ...;
  /// }
  /// ```

  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_RouteRequested value) routeRequested,
    required TResult Function(_NavigationStarted value) navigationStarted,
    required TResult Function(_NavigationStopped value) navigationStopped,
    required TResult Function(_LocationUpdated value) locationUpdated,
  }) {
    final _that = this;
    switch (_that) {
      case _RouteRequested():
        return routeRequested(_that);
      case _NavigationStarted():
        return navigationStarted(_that);
      case _NavigationStopped():
        return navigationStopped(_that);
      case _LocationUpdated():
        return locationUpdated(_that);
      case _:
        throw StateError('Unexpected subclass');
    }
  }

  /// A variant of `map` that fallback to returning `null`.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case _:
  ///     return null;
  /// }
  /// ```

  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_RouteRequested value)? routeRequested,
    TResult? Function(_NavigationStarted value)? navigationStarted,
    TResult? Function(_NavigationStopped value)? navigationStopped,
    TResult? Function(_LocationUpdated value)? locationUpdated,
  }) {
    final _that = this;
    switch (_that) {
      case _RouteRequested() when routeRequested != null:
        return routeRequested(_that);
      case _NavigationStarted() when navigationStarted != null:
        return navigationStarted(_that);
      case _NavigationStopped() when navigationStopped != null:
        return navigationStopped(_that);
      case _LocationUpdated() when locationUpdated != null:
        return locationUpdated(_that);
      case _:
        return null;
    }
  }

  /// A variant of `when` that fallback to an `orElse` callback.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case _:
  ///     return orElse();
  /// }
  /// ```

  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
            List<List<double>> coordinates, String? profile, bool optimized)?
        routeRequested,
    TResult Function()? navigationStarted,
    TResult Function()? navigationStopped,
    TResult Function(Either<DirectionFailure, LocationData> locationUpdate)?
        locationUpdated,
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _RouteRequested() when routeRequested != null:
        return routeRequested(
            _that.coordinates, _that.profile, _that.optimized);
      case _NavigationStarted() when navigationStarted != null:
        return navigationStarted();
      case _NavigationStopped() when navigationStopped != null:
        return navigationStopped();
      case _LocationUpdated() when locationUpdated != null:
        return locationUpdated(_that.locationUpdate);
      case _:
        return orElse();
    }
  }

  /// A `switch`-like method, using callbacks.
  ///
  /// As opposed to `map`, this offers destructuring.
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case Subclass2(:final field2):
  ///     return ...;
  /// }
  /// ```

  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            List<List<double>> coordinates, String? profile, bool optimized)
        routeRequested,
    required TResult Function() navigationStarted,
    required TResult Function() navigationStopped,
    required TResult Function(
            Either<DirectionFailure, LocationData> locationUpdate)
        locationUpdated,
  }) {
    final _that = this;
    switch (_that) {
      case _RouteRequested():
        return routeRequested(
            _that.coordinates, _that.profile, _that.optimized);
      case _NavigationStarted():
        return navigationStarted();
      case _NavigationStopped():
        return navigationStopped();
      case _LocationUpdated():
        return locationUpdated(_that.locationUpdate);
      case _:
        throw StateError('Unexpected subclass');
    }
  }

  /// A variant of `when` that fallback to returning `null`
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case _:
  ///     return null;
  /// }
  /// ```

  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(
            List<List<double>> coordinates, String? profile, bool optimized)?
        routeRequested,
    TResult? Function()? navigationStarted,
    TResult? Function()? navigationStopped,
    TResult? Function(Either<DirectionFailure, LocationData> locationUpdate)?
        locationUpdated,
  }) {
    final _that = this;
    switch (_that) {
      case _RouteRequested() when routeRequested != null:
        return routeRequested(
            _that.coordinates, _that.profile, _that.optimized);
      case _NavigationStarted() when navigationStarted != null:
        return navigationStarted();
      case _NavigationStopped() when navigationStopped != null:
        return navigationStopped();
      case _LocationUpdated() when locationUpdated != null:
        return locationUpdated(_that.locationUpdate);
      case _:
        return null;
    }
  }
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

/// Adds pattern-matching-related methods to [MapState].
extension MapStatePatterns on MapState {
  /// A variant of `map` that fallback to returning `orElse`.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case _:
  ///     return orElse();
  /// }
  /// ```

  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Initial value)? initial,
    TResult Function(LoadInProgress value)? loadInProgress,
    TResult Function(LoadFailure value)? loadFailure,
    TResult Function(Preview value)? preview,
    TResult Function(Navigating value)? navigating,
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case Initial() when initial != null:
        return initial(_that);
      case LoadInProgress() when loadInProgress != null:
        return loadInProgress(_that);
      case LoadFailure() when loadFailure != null:
        return loadFailure(_that);
      case Preview() when preview != null:
        return preview(_that);
      case Navigating() when navigating != null:
        return navigating(_that);
      case _:
        return orElse();
    }
  }

  /// A `switch`-like method, using callbacks.
  ///
  /// Callbacks receives the raw object, upcasted.
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case final Subclass2 value:
  ///     return ...;
  /// }
  /// ```

  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Initial value) initial,
    required TResult Function(LoadInProgress value) loadInProgress,
    required TResult Function(LoadFailure value) loadFailure,
    required TResult Function(Preview value) preview,
    required TResult Function(Navigating value) navigating,
  }) {
    final _that = this;
    switch (_that) {
      case Initial():
        return initial(_that);
      case LoadInProgress():
        return loadInProgress(_that);
      case LoadFailure():
        return loadFailure(_that);
      case Preview():
        return preview(_that);
      case Navigating():
        return navigating(_that);
      case _:
        throw StateError('Unexpected subclass');
    }
  }

  /// A variant of `map` that fallback to returning `null`.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case _:
  ///     return null;
  /// }
  /// ```

  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(Initial value)? initial,
    TResult? Function(LoadInProgress value)? loadInProgress,
    TResult? Function(LoadFailure value)? loadFailure,
    TResult? Function(Preview value)? preview,
    TResult? Function(Navigating value)? navigating,
  }) {
    final _that = this;
    switch (_that) {
      case Initial() when initial != null:
        return initial(_that);
      case LoadInProgress() when loadInProgress != null:
        return loadInProgress(_that);
      case LoadFailure() when loadFailure != null:
        return loadFailure(_that);
      case Preview() when preview != null:
        return preview(_that);
      case Navigating() when navigating != null:
        return navigating(_that);
      case _:
        return null;
    }
  }

  /// A variant of `when` that fallback to an `orElse` callback.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case _:
  ///     return orElse();
  /// }
  /// ```

  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loadInProgress,
    TResult Function(DirectionFailure failure)? loadFailure,
    TResult Function(Direction direction)? preview,
    TResult Function(Direction direction, LocationData currentLocation)?
        navigating,
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case Initial() when initial != null:
        return initial();
      case LoadInProgress() when loadInProgress != null:
        return loadInProgress();
      case LoadFailure() when loadFailure != null:
        return loadFailure(_that.failure);
      case Preview() when preview != null:
        return preview(_that.direction);
      case Navigating() when navigating != null:
        return navigating(_that.direction, _that.currentLocation);
      case _:
        return orElse();
    }
  }

  /// A `switch`-like method, using callbacks.
  ///
  /// As opposed to `map`, this offers destructuring.
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case Subclass2(:final field2):
  ///     return ...;
  /// }
  /// ```

  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loadInProgress,
    required TResult Function(DirectionFailure failure) loadFailure,
    required TResult Function(Direction direction) preview,
    required TResult Function(Direction direction, LocationData currentLocation)
        navigating,
  }) {
    final _that = this;
    switch (_that) {
      case Initial():
        return initial();
      case LoadInProgress():
        return loadInProgress();
      case LoadFailure():
        return loadFailure(_that.failure);
      case Preview():
        return preview(_that.direction);
      case Navigating():
        return navigating(_that.direction, _that.currentLocation);
      case _:
        throw StateError('Unexpected subclass');
    }
  }

  /// A variant of `when` that fallback to returning `null`
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case _:
  ///     return null;
  /// }
  /// ```

  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loadInProgress,
    TResult? Function(DirectionFailure failure)? loadFailure,
    TResult? Function(Direction direction)? preview,
    TResult? Function(Direction direction, LocationData currentLocation)?
        navigating,
  }) {
    final _that = this;
    switch (_that) {
      case Initial() when initial != null:
        return initial();
      case LoadInProgress() when loadInProgress != null:
        return loadInProgress();
      case LoadFailure() when loadFailure != null:
        return loadFailure(_that.failure);
      case Preview() when preview != null:
        return preview(_that.direction);
      case Navigating() when navigating != null:
        return navigating(_that.direction, _that.currentLocation);
      case _:
        return null;
    }
  }
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
