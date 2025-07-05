// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'direction.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Direction {
  List<RouteModel> get routes;
  List<WaypointModel> get waypoints;
  String get code;
  String get uuid;

  /// Create a copy of Direction
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $DirectionCopyWith<Direction> get copyWith =>
      _$DirectionCopyWithImpl<Direction>(this as Direction, _$identity);

  /// Serializes this Direction to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is Direction &&
            const DeepCollectionEquality().equals(other.routes, routes) &&
            const DeepCollectionEquality().equals(other.waypoints, waypoints) &&
            (identical(other.code, code) || other.code == code) &&
            (identical(other.uuid, uuid) || other.uuid == uuid));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(routes),
      const DeepCollectionEquality().hash(waypoints),
      code,
      uuid);

  @override
  String toString() {
    return 'Direction(routes: $routes, waypoints: $waypoints, code: $code, uuid: $uuid)';
  }
}

/// @nodoc
abstract mixin class $DirectionCopyWith<$Res> {
  factory $DirectionCopyWith(Direction value, $Res Function(Direction) _then) =
      _$DirectionCopyWithImpl;
  @useResult
  $Res call(
      {List<RouteModel> routes,
      List<WaypointModel> waypoints,
      String code,
      String uuid});
}

/// @nodoc
class _$DirectionCopyWithImpl<$Res> implements $DirectionCopyWith<$Res> {
  _$DirectionCopyWithImpl(this._self, this._then);

  final Direction _self;
  final $Res Function(Direction) _then;

  /// Create a copy of Direction
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? routes = null,
    Object? waypoints = null,
    Object? code = null,
    Object? uuid = null,
  }) {
    return _then(_self.copyWith(
      routes: null == routes
          ? _self.routes
          : routes // ignore: cast_nullable_to_non_nullable
              as List<RouteModel>,
      waypoints: null == waypoints
          ? _self.waypoints
          : waypoints // ignore: cast_nullable_to_non_nullable
              as List<WaypointModel>,
      code: null == code
          ? _self.code
          : code // ignore: cast_nullable_to_non_nullable
              as String,
      uuid: null == uuid
          ? _self.uuid
          : uuid // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _Direction implements Direction {
  const _Direction(
      {required final List<RouteModel> routes,
      required final List<WaypointModel> waypoints,
      required this.code,
      required this.uuid})
      : _routes = routes,
        _waypoints = waypoints;
  factory _Direction.fromJson(Map<String, dynamic> json) =>
      _$DirectionFromJson(json);

  final List<RouteModel> _routes;
  @override
  List<RouteModel> get routes {
    if (_routes is EqualUnmodifiableListView) return _routes;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_routes);
  }

  final List<WaypointModel> _waypoints;
  @override
  List<WaypointModel> get waypoints {
    if (_waypoints is EqualUnmodifiableListView) return _waypoints;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_waypoints);
  }

  @override
  final String code;
  @override
  final String uuid;

  /// Create a copy of Direction
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$DirectionCopyWith<_Direction> get copyWith =>
      __$DirectionCopyWithImpl<_Direction>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$DirectionToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Direction &&
            const DeepCollectionEquality().equals(other._routes, _routes) &&
            const DeepCollectionEquality()
                .equals(other._waypoints, _waypoints) &&
            (identical(other.code, code) || other.code == code) &&
            (identical(other.uuid, uuid) || other.uuid == uuid));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_routes),
      const DeepCollectionEquality().hash(_waypoints),
      code,
      uuid);

  @override
  String toString() {
    return 'Direction(routes: $routes, waypoints: $waypoints, code: $code, uuid: $uuid)';
  }
}

/// @nodoc
abstract mixin class _$DirectionCopyWith<$Res>
    implements $DirectionCopyWith<$Res> {
  factory _$DirectionCopyWith(
          _Direction value, $Res Function(_Direction) _then) =
      __$DirectionCopyWithImpl;
  @override
  @useResult
  $Res call(
      {List<RouteModel> routes,
      List<WaypointModel> waypoints,
      String code,
      String uuid});
}

/// @nodoc
class __$DirectionCopyWithImpl<$Res> implements _$DirectionCopyWith<$Res> {
  __$DirectionCopyWithImpl(this._self, this._then);

  final _Direction _self;
  final $Res Function(_Direction) _then;

  /// Create a copy of Direction
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? routes = null,
    Object? waypoints = null,
    Object? code = null,
    Object? uuid = null,
  }) {
    return _then(_Direction(
      routes: null == routes
          ? _self._routes
          : routes // ignore: cast_nullable_to_non_nullable
              as List<RouteModel>,
      waypoints: null == waypoints
          ? _self._waypoints
          : waypoints // ignore: cast_nullable_to_non_nullable
              as List<WaypointModel>,
      code: null == code
          ? _self.code
          : code // ignore: cast_nullable_to_non_nullable
              as String,
      uuid: null == uuid
          ? _self.uuid
          : uuid // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
mixin _$RouteModel {
  @JsonKey(name: 'weight_name')
  String get weightName;
  double get weight;
  double get duration;
  double get distance;
  List<LegModel> get legs;
  GeometryModel get geometry;
  @JsonKey(name: 'voiceLocale')
  String? get voiceLocale;

  /// Create a copy of RouteModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $RouteModelCopyWith<RouteModel> get copyWith =>
      _$RouteModelCopyWithImpl<RouteModel>(this as RouteModel, _$identity);

  /// Serializes this RouteModel to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is RouteModel &&
            (identical(other.weightName, weightName) ||
                other.weightName == weightName) &&
            (identical(other.weight, weight) || other.weight == weight) &&
            (identical(other.duration, duration) ||
                other.duration == duration) &&
            (identical(other.distance, distance) ||
                other.distance == distance) &&
            const DeepCollectionEquality().equals(other.legs, legs) &&
            (identical(other.geometry, geometry) ||
                other.geometry == geometry) &&
            (identical(other.voiceLocale, voiceLocale) ||
                other.voiceLocale == voiceLocale));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      weightName,
      weight,
      duration,
      distance,
      const DeepCollectionEquality().hash(legs),
      geometry,
      voiceLocale);

  @override
  String toString() {
    return 'RouteModel(weightName: $weightName, weight: $weight, duration: $duration, distance: $distance, legs: $legs, geometry: $geometry, voiceLocale: $voiceLocale)';
  }
}

/// @nodoc
abstract mixin class $RouteModelCopyWith<$Res> {
  factory $RouteModelCopyWith(
          RouteModel value, $Res Function(RouteModel) _then) =
      _$RouteModelCopyWithImpl;
  @useResult
  $Res call(
      {@JsonKey(name: 'weight_name') String weightName,
      double weight,
      double duration,
      double distance,
      List<LegModel> legs,
      GeometryModel geometry,
      @JsonKey(name: 'voiceLocale') String? voiceLocale});

  $GeometryModelCopyWith<$Res> get geometry;
}

/// @nodoc
class _$RouteModelCopyWithImpl<$Res> implements $RouteModelCopyWith<$Res> {
  _$RouteModelCopyWithImpl(this._self, this._then);

  final RouteModel _self;
  final $Res Function(RouteModel) _then;

  /// Create a copy of RouteModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? weightName = null,
    Object? weight = null,
    Object? duration = null,
    Object? distance = null,
    Object? legs = null,
    Object? geometry = null,
    Object? voiceLocale = freezed,
  }) {
    return _then(_self.copyWith(
      weightName: null == weightName
          ? _self.weightName
          : weightName // ignore: cast_nullable_to_non_nullable
              as String,
      weight: null == weight
          ? _self.weight
          : weight // ignore: cast_nullable_to_non_nullable
              as double,
      duration: null == duration
          ? _self.duration
          : duration // ignore: cast_nullable_to_non_nullable
              as double,
      distance: null == distance
          ? _self.distance
          : distance // ignore: cast_nullable_to_non_nullable
              as double,
      legs: null == legs
          ? _self.legs
          : legs // ignore: cast_nullable_to_non_nullable
              as List<LegModel>,
      geometry: null == geometry
          ? _self.geometry
          : geometry // ignore: cast_nullable_to_non_nullable
              as GeometryModel,
      voiceLocale: freezed == voiceLocale
          ? _self.voiceLocale
          : voiceLocale // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }

  /// Create a copy of RouteModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $GeometryModelCopyWith<$Res> get geometry {
    return $GeometryModelCopyWith<$Res>(_self.geometry, (value) {
      return _then(_self.copyWith(geometry: value));
    });
  }
}

/// @nodoc
@JsonSerializable()
class _RouteModel implements RouteModel {
  const _RouteModel(
      {@JsonKey(name: 'weight_name') required this.weightName,
      required this.weight,
      required this.duration,
      required this.distance,
      required final List<LegModel> legs,
      required this.geometry,
      @JsonKey(name: 'voiceLocale') this.voiceLocale})
      : _legs = legs;
  factory _RouteModel.fromJson(Map<String, dynamic> json) =>
      _$RouteModelFromJson(json);

  @override
  @JsonKey(name: 'weight_name')
  final String weightName;
  @override
  final double weight;
  @override
  final double duration;
  @override
  final double distance;
  final List<LegModel> _legs;
  @override
  List<LegModel> get legs {
    if (_legs is EqualUnmodifiableListView) return _legs;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_legs);
  }

  @override
  final GeometryModel geometry;
  @override
  @JsonKey(name: 'voiceLocale')
  final String? voiceLocale;

  /// Create a copy of RouteModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$RouteModelCopyWith<_RouteModel> get copyWith =>
      __$RouteModelCopyWithImpl<_RouteModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$RouteModelToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _RouteModel &&
            (identical(other.weightName, weightName) ||
                other.weightName == weightName) &&
            (identical(other.weight, weight) || other.weight == weight) &&
            (identical(other.duration, duration) ||
                other.duration == duration) &&
            (identical(other.distance, distance) ||
                other.distance == distance) &&
            const DeepCollectionEquality().equals(other._legs, _legs) &&
            (identical(other.geometry, geometry) ||
                other.geometry == geometry) &&
            (identical(other.voiceLocale, voiceLocale) ||
                other.voiceLocale == voiceLocale));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      weightName,
      weight,
      duration,
      distance,
      const DeepCollectionEquality().hash(_legs),
      geometry,
      voiceLocale);

  @override
  String toString() {
    return 'RouteModel(weightName: $weightName, weight: $weight, duration: $duration, distance: $distance, legs: $legs, geometry: $geometry, voiceLocale: $voiceLocale)';
  }
}

/// @nodoc
abstract mixin class _$RouteModelCopyWith<$Res>
    implements $RouteModelCopyWith<$Res> {
  factory _$RouteModelCopyWith(
          _RouteModel value, $Res Function(_RouteModel) _then) =
      __$RouteModelCopyWithImpl;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'weight_name') String weightName,
      double weight,
      double duration,
      double distance,
      List<LegModel> legs,
      GeometryModel geometry,
      @JsonKey(name: 'voiceLocale') String? voiceLocale});

  @override
  $GeometryModelCopyWith<$Res> get geometry;
}

/// @nodoc
class __$RouteModelCopyWithImpl<$Res> implements _$RouteModelCopyWith<$Res> {
  __$RouteModelCopyWithImpl(this._self, this._then);

  final _RouteModel _self;
  final $Res Function(_RouteModel) _then;

  /// Create a copy of RouteModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? weightName = null,
    Object? weight = null,
    Object? duration = null,
    Object? distance = null,
    Object? legs = null,
    Object? geometry = null,
    Object? voiceLocale = freezed,
  }) {
    return _then(_RouteModel(
      weightName: null == weightName
          ? _self.weightName
          : weightName // ignore: cast_nullable_to_non_nullable
              as String,
      weight: null == weight
          ? _self.weight
          : weight // ignore: cast_nullable_to_non_nullable
              as double,
      duration: null == duration
          ? _self.duration
          : duration // ignore: cast_nullable_to_non_nullable
              as double,
      distance: null == distance
          ? _self.distance
          : distance // ignore: cast_nullable_to_non_nullable
              as double,
      legs: null == legs
          ? _self._legs
          : legs // ignore: cast_nullable_to_non_nullable
              as List<LegModel>,
      geometry: null == geometry
          ? _self.geometry
          : geometry // ignore: cast_nullable_to_non_nullable
              as GeometryModel,
      voiceLocale: freezed == voiceLocale
          ? _self.voiceLocale
          : voiceLocale // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }

  /// Create a copy of RouteModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $GeometryModelCopyWith<$Res> get geometry {
    return $GeometryModelCopyWith<$Res>(_self.geometry, (value) {
      return _then(_self.copyWith(geometry: value));
    });
  }
}

/// @nodoc
mixin _$WaypointModel {
  double get distance;
  String get name;
  List<double> get location;

  /// Create a copy of WaypointModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $WaypointModelCopyWith<WaypointModel> get copyWith =>
      _$WaypointModelCopyWithImpl<WaypointModel>(
          this as WaypointModel, _$identity);

  /// Serializes this WaypointModel to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is WaypointModel &&
            (identical(other.distance, distance) ||
                other.distance == distance) &&
            (identical(other.name, name) || other.name == name) &&
            const DeepCollectionEquality().equals(other.location, location));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, distance, name,
      const DeepCollectionEquality().hash(location));

  @override
  String toString() {
    return 'WaypointModel(distance: $distance, name: $name, location: $location)';
  }
}

/// @nodoc
abstract mixin class $WaypointModelCopyWith<$Res> {
  factory $WaypointModelCopyWith(
          WaypointModel value, $Res Function(WaypointModel) _then) =
      _$WaypointModelCopyWithImpl;
  @useResult
  $Res call({double distance, String name, List<double> location});
}

/// @nodoc
class _$WaypointModelCopyWithImpl<$Res>
    implements $WaypointModelCopyWith<$Res> {
  _$WaypointModelCopyWithImpl(this._self, this._then);

  final WaypointModel _self;
  final $Res Function(WaypointModel) _then;

  /// Create a copy of WaypointModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? distance = null,
    Object? name = null,
    Object? location = null,
  }) {
    return _then(_self.copyWith(
      distance: null == distance
          ? _self.distance
          : distance // ignore: cast_nullable_to_non_nullable
              as double,
      name: null == name
          ? _self.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      location: null == location
          ? _self.location
          : location // ignore: cast_nullable_to_non_nullable
              as List<double>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _WaypointModel implements WaypointModel {
  const _WaypointModel(
      {required this.distance,
      required this.name,
      required final List<double> location})
      : _location = location;
  factory _WaypointModel.fromJson(Map<String, dynamic> json) =>
      _$WaypointModelFromJson(json);

  @override
  final double distance;
  @override
  final String name;
  final List<double> _location;
  @override
  List<double> get location {
    if (_location is EqualUnmodifiableListView) return _location;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_location);
  }

  /// Create a copy of WaypointModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$WaypointModelCopyWith<_WaypointModel> get copyWith =>
      __$WaypointModelCopyWithImpl<_WaypointModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$WaypointModelToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _WaypointModel &&
            (identical(other.distance, distance) ||
                other.distance == distance) &&
            (identical(other.name, name) || other.name == name) &&
            const DeepCollectionEquality().equals(other._location, _location));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, distance, name,
      const DeepCollectionEquality().hash(_location));

  @override
  String toString() {
    return 'WaypointModel(distance: $distance, name: $name, location: $location)';
  }
}

/// @nodoc
abstract mixin class _$WaypointModelCopyWith<$Res>
    implements $WaypointModelCopyWith<$Res> {
  factory _$WaypointModelCopyWith(
          _WaypointModel value, $Res Function(_WaypointModel) _then) =
      __$WaypointModelCopyWithImpl;
  @override
  @useResult
  $Res call({double distance, String name, List<double> location});
}

/// @nodoc
class __$WaypointModelCopyWithImpl<$Res>
    implements _$WaypointModelCopyWith<$Res> {
  __$WaypointModelCopyWithImpl(this._self, this._then);

  final _WaypointModel _self;
  final $Res Function(_WaypointModel) _then;

  /// Create a copy of WaypointModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? distance = null,
    Object? name = null,
    Object? location = null,
  }) {
    return _then(_WaypointModel(
      distance: null == distance
          ? _self.distance
          : distance // ignore: cast_nullable_to_non_nullable
              as double,
      name: null == name
          ? _self.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      location: null == location
          ? _self._location
          : location // ignore: cast_nullable_to_non_nullable
              as List<double>,
    ));
  }
}

/// @nodoc
mixin _$LegModel {
  @JsonKey(name: 'via_waypoints')
  List<dynamic> get viaWaypoints;
  AnnotationModel get annotation;
  List<AdminModel> get admins;
  double get weight;
  double get duration;
  List<StepModel> get steps;
  double get distance;
  String get summary;

  /// Create a copy of LegModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $LegModelCopyWith<LegModel> get copyWith =>
      _$LegModelCopyWithImpl<LegModel>(this as LegModel, _$identity);

  /// Serializes this LegModel to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is LegModel &&
            const DeepCollectionEquality()
                .equals(other.viaWaypoints, viaWaypoints) &&
            (identical(other.annotation, annotation) ||
                other.annotation == annotation) &&
            const DeepCollectionEquality().equals(other.admins, admins) &&
            (identical(other.weight, weight) || other.weight == weight) &&
            (identical(other.duration, duration) ||
                other.duration == duration) &&
            const DeepCollectionEquality().equals(other.steps, steps) &&
            (identical(other.distance, distance) ||
                other.distance == distance) &&
            (identical(other.summary, summary) || other.summary == summary));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(viaWaypoints),
      annotation,
      const DeepCollectionEquality().hash(admins),
      weight,
      duration,
      const DeepCollectionEquality().hash(steps),
      distance,
      summary);

  @override
  String toString() {
    return 'LegModel(viaWaypoints: $viaWaypoints, annotation: $annotation, admins: $admins, weight: $weight, duration: $duration, steps: $steps, distance: $distance, summary: $summary)';
  }
}

/// @nodoc
abstract mixin class $LegModelCopyWith<$Res> {
  factory $LegModelCopyWith(LegModel value, $Res Function(LegModel) _then) =
      _$LegModelCopyWithImpl;
  @useResult
  $Res call(
      {@JsonKey(name: 'via_waypoints') List<dynamic> viaWaypoints,
      AnnotationModel annotation,
      List<AdminModel> admins,
      double weight,
      double duration,
      List<StepModel> steps,
      double distance,
      String summary});

  $AnnotationModelCopyWith<$Res> get annotation;
}

/// @nodoc
class _$LegModelCopyWithImpl<$Res> implements $LegModelCopyWith<$Res> {
  _$LegModelCopyWithImpl(this._self, this._then);

  final LegModel _self;
  final $Res Function(LegModel) _then;

  /// Create a copy of LegModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? viaWaypoints = null,
    Object? annotation = null,
    Object? admins = null,
    Object? weight = null,
    Object? duration = null,
    Object? steps = null,
    Object? distance = null,
    Object? summary = null,
  }) {
    return _then(_self.copyWith(
      viaWaypoints: null == viaWaypoints
          ? _self.viaWaypoints
          : viaWaypoints // ignore: cast_nullable_to_non_nullable
              as List<dynamic>,
      annotation: null == annotation
          ? _self.annotation
          : annotation // ignore: cast_nullable_to_non_nullable
              as AnnotationModel,
      admins: null == admins
          ? _self.admins
          : admins // ignore: cast_nullable_to_non_nullable
              as List<AdminModel>,
      weight: null == weight
          ? _self.weight
          : weight // ignore: cast_nullable_to_non_nullable
              as double,
      duration: null == duration
          ? _self.duration
          : duration // ignore: cast_nullable_to_non_nullable
              as double,
      steps: null == steps
          ? _self.steps
          : steps // ignore: cast_nullable_to_non_nullable
              as List<StepModel>,
      distance: null == distance
          ? _self.distance
          : distance // ignore: cast_nullable_to_non_nullable
              as double,
      summary: null == summary
          ? _self.summary
          : summary // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }

  /// Create a copy of LegModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $AnnotationModelCopyWith<$Res> get annotation {
    return $AnnotationModelCopyWith<$Res>(_self.annotation, (value) {
      return _then(_self.copyWith(annotation: value));
    });
  }
}

/// @nodoc
@JsonSerializable()
class _LegModel implements LegModel {
  const _LegModel(
      {@JsonKey(name: 'via_waypoints')
      required final List<dynamic> viaWaypoints,
      required this.annotation,
      required final List<AdminModel> admins,
      required this.weight,
      required this.duration,
      required final List<StepModel> steps,
      required this.distance,
      required this.summary})
      : _viaWaypoints = viaWaypoints,
        _admins = admins,
        _steps = steps;
  factory _LegModel.fromJson(Map<String, dynamic> json) =>
      _$LegModelFromJson(json);

  final List<dynamic> _viaWaypoints;
  @override
  @JsonKey(name: 'via_waypoints')
  List<dynamic> get viaWaypoints {
    if (_viaWaypoints is EqualUnmodifiableListView) return _viaWaypoints;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_viaWaypoints);
  }

  @override
  final AnnotationModel annotation;
  final List<AdminModel> _admins;
  @override
  List<AdminModel> get admins {
    if (_admins is EqualUnmodifiableListView) return _admins;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_admins);
  }

  @override
  final double weight;
  @override
  final double duration;
  final List<StepModel> _steps;
  @override
  List<StepModel> get steps {
    if (_steps is EqualUnmodifiableListView) return _steps;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_steps);
  }

  @override
  final double distance;
  @override
  final String summary;

  /// Create a copy of LegModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$LegModelCopyWith<_LegModel> get copyWith =>
      __$LegModelCopyWithImpl<_LegModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$LegModelToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _LegModel &&
            const DeepCollectionEquality()
                .equals(other._viaWaypoints, _viaWaypoints) &&
            (identical(other.annotation, annotation) ||
                other.annotation == annotation) &&
            const DeepCollectionEquality().equals(other._admins, _admins) &&
            (identical(other.weight, weight) || other.weight == weight) &&
            (identical(other.duration, duration) ||
                other.duration == duration) &&
            const DeepCollectionEquality().equals(other._steps, _steps) &&
            (identical(other.distance, distance) ||
                other.distance == distance) &&
            (identical(other.summary, summary) || other.summary == summary));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_viaWaypoints),
      annotation,
      const DeepCollectionEquality().hash(_admins),
      weight,
      duration,
      const DeepCollectionEquality().hash(_steps),
      distance,
      summary);

  @override
  String toString() {
    return 'LegModel(viaWaypoints: $viaWaypoints, annotation: $annotation, admins: $admins, weight: $weight, duration: $duration, steps: $steps, distance: $distance, summary: $summary)';
  }
}

/// @nodoc
abstract mixin class _$LegModelCopyWith<$Res>
    implements $LegModelCopyWith<$Res> {
  factory _$LegModelCopyWith(_LegModel value, $Res Function(_LegModel) _then) =
      __$LegModelCopyWithImpl;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'via_waypoints') List<dynamic> viaWaypoints,
      AnnotationModel annotation,
      List<AdminModel> admins,
      double weight,
      double duration,
      List<StepModel> steps,
      double distance,
      String summary});

  @override
  $AnnotationModelCopyWith<$Res> get annotation;
}

/// @nodoc
class __$LegModelCopyWithImpl<$Res> implements _$LegModelCopyWith<$Res> {
  __$LegModelCopyWithImpl(this._self, this._then);

  final _LegModel _self;
  final $Res Function(_LegModel) _then;

  /// Create a copy of LegModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? viaWaypoints = null,
    Object? annotation = null,
    Object? admins = null,
    Object? weight = null,
    Object? duration = null,
    Object? steps = null,
    Object? distance = null,
    Object? summary = null,
  }) {
    return _then(_LegModel(
      viaWaypoints: null == viaWaypoints
          ? _self._viaWaypoints
          : viaWaypoints // ignore: cast_nullable_to_non_nullable
              as List<dynamic>,
      annotation: null == annotation
          ? _self.annotation
          : annotation // ignore: cast_nullable_to_non_nullable
              as AnnotationModel,
      admins: null == admins
          ? _self._admins
          : admins // ignore: cast_nullable_to_non_nullable
              as List<AdminModel>,
      weight: null == weight
          ? _self.weight
          : weight // ignore: cast_nullable_to_non_nullable
              as double,
      duration: null == duration
          ? _self.duration
          : duration // ignore: cast_nullable_to_non_nullable
              as double,
      steps: null == steps
          ? _self._steps
          : steps // ignore: cast_nullable_to_non_nullable
              as List<StepModel>,
      distance: null == distance
          ? _self.distance
          : distance // ignore: cast_nullable_to_non_nullable
              as double,
      summary: null == summary
          ? _self.summary
          : summary // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }

  /// Create a copy of LegModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $AnnotationModelCopyWith<$Res> get annotation {
    return $AnnotationModelCopyWith<$Res>(_self.annotation, (value) {
      return _then(_self.copyWith(annotation: value));
    });
  }
}

/// @nodoc
mixin _$AnnotationModel {
  List<double> get speed;
  List<double> get distance;
  List<double> get duration;

  /// Create a copy of AnnotationModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $AnnotationModelCopyWith<AnnotationModel> get copyWith =>
      _$AnnotationModelCopyWithImpl<AnnotationModel>(
          this as AnnotationModel, _$identity);

  /// Serializes this AnnotationModel to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is AnnotationModel &&
            const DeepCollectionEquality().equals(other.speed, speed) &&
            const DeepCollectionEquality().equals(other.distance, distance) &&
            const DeepCollectionEquality().equals(other.duration, duration));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(speed),
      const DeepCollectionEquality().hash(distance),
      const DeepCollectionEquality().hash(duration));

  @override
  String toString() {
    return 'AnnotationModel(speed: $speed, distance: $distance, duration: $duration)';
  }
}

/// @nodoc
abstract mixin class $AnnotationModelCopyWith<$Res> {
  factory $AnnotationModelCopyWith(
          AnnotationModel value, $Res Function(AnnotationModel) _then) =
      _$AnnotationModelCopyWithImpl;
  @useResult
  $Res call({List<double> speed, List<double> distance, List<double> duration});
}

/// @nodoc
class _$AnnotationModelCopyWithImpl<$Res>
    implements $AnnotationModelCopyWith<$Res> {
  _$AnnotationModelCopyWithImpl(this._self, this._then);

  final AnnotationModel _self;
  final $Res Function(AnnotationModel) _then;

  /// Create a copy of AnnotationModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? speed = null,
    Object? distance = null,
    Object? duration = null,
  }) {
    return _then(_self.copyWith(
      speed: null == speed
          ? _self.speed
          : speed // ignore: cast_nullable_to_non_nullable
              as List<double>,
      distance: null == distance
          ? _self.distance
          : distance // ignore: cast_nullable_to_non_nullable
              as List<double>,
      duration: null == duration
          ? _self.duration
          : duration // ignore: cast_nullable_to_non_nullable
              as List<double>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _AnnotationModel implements AnnotationModel {
  const _AnnotationModel(
      {required final List<double> speed,
      required final List<double> distance,
      required final List<double> duration})
      : _speed = speed,
        _distance = distance,
        _duration = duration;
  factory _AnnotationModel.fromJson(Map<String, dynamic> json) =>
      _$AnnotationModelFromJson(json);

  final List<double> _speed;
  @override
  List<double> get speed {
    if (_speed is EqualUnmodifiableListView) return _speed;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_speed);
  }

  final List<double> _distance;
  @override
  List<double> get distance {
    if (_distance is EqualUnmodifiableListView) return _distance;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_distance);
  }

  final List<double> _duration;
  @override
  List<double> get duration {
    if (_duration is EqualUnmodifiableListView) return _duration;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_duration);
  }

  /// Create a copy of AnnotationModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$AnnotationModelCopyWith<_AnnotationModel> get copyWith =>
      __$AnnotationModelCopyWithImpl<_AnnotationModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$AnnotationModelToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _AnnotationModel &&
            const DeepCollectionEquality().equals(other._speed, _speed) &&
            const DeepCollectionEquality().equals(other._distance, _distance) &&
            const DeepCollectionEquality().equals(other._duration, _duration));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_speed),
      const DeepCollectionEquality().hash(_distance),
      const DeepCollectionEquality().hash(_duration));

  @override
  String toString() {
    return 'AnnotationModel(speed: $speed, distance: $distance, duration: $duration)';
  }
}

/// @nodoc
abstract mixin class _$AnnotationModelCopyWith<$Res>
    implements $AnnotationModelCopyWith<$Res> {
  factory _$AnnotationModelCopyWith(
          _AnnotationModel value, $Res Function(_AnnotationModel) _then) =
      __$AnnotationModelCopyWithImpl;
  @override
  @useResult
  $Res call({List<double> speed, List<double> distance, List<double> duration});
}

/// @nodoc
class __$AnnotationModelCopyWithImpl<$Res>
    implements _$AnnotationModelCopyWith<$Res> {
  __$AnnotationModelCopyWithImpl(this._self, this._then);

  final _AnnotationModel _self;
  final $Res Function(_AnnotationModel) _then;

  /// Create a copy of AnnotationModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? speed = null,
    Object? distance = null,
    Object? duration = null,
  }) {
    return _then(_AnnotationModel(
      speed: null == speed
          ? _self._speed
          : speed // ignore: cast_nullable_to_non_nullable
              as List<double>,
      distance: null == distance
          ? _self._distance
          : distance // ignore: cast_nullable_to_non_nullable
              as List<double>,
      duration: null == duration
          ? _self._duration
          : duration // ignore: cast_nullable_to_non_nullable
              as List<double>,
    ));
  }
}

/// @nodoc
mixin _$AdminModel {
  @JsonKey(name: 'iso_3166_1')
  String get iso31661;

  /// Create a copy of AdminModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $AdminModelCopyWith<AdminModel> get copyWith =>
      _$AdminModelCopyWithImpl<AdminModel>(this as AdminModel, _$identity);

  /// Serializes this AdminModel to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is AdminModel &&
            (identical(other.iso31661, iso31661) ||
                other.iso31661 == iso31661));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, iso31661);

  @override
  String toString() {
    return 'AdminModel(iso31661: $iso31661)';
  }
}

/// @nodoc
abstract mixin class $AdminModelCopyWith<$Res> {
  factory $AdminModelCopyWith(
          AdminModel value, $Res Function(AdminModel) _then) =
      _$AdminModelCopyWithImpl;
  @useResult
  $Res call({@JsonKey(name: 'iso_3166_1') String iso31661});
}

/// @nodoc
class _$AdminModelCopyWithImpl<$Res> implements $AdminModelCopyWith<$Res> {
  _$AdminModelCopyWithImpl(this._self, this._then);

  final AdminModel _self;
  final $Res Function(AdminModel) _then;

  /// Create a copy of AdminModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? iso31661 = null,
  }) {
    return _then(_self.copyWith(
      iso31661: null == iso31661
          ? _self.iso31661
          : iso31661 // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _AdminModel implements AdminModel {
  const _AdminModel({@JsonKey(name: 'iso_3166_1') required this.iso31661});
  factory _AdminModel.fromJson(Map<String, dynamic> json) =>
      _$AdminModelFromJson(json);

  @override
  @JsonKey(name: 'iso_3166_1')
  final String iso31661;

  /// Create a copy of AdminModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$AdminModelCopyWith<_AdminModel> get copyWith =>
      __$AdminModelCopyWithImpl<_AdminModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$AdminModelToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _AdminModel &&
            (identical(other.iso31661, iso31661) ||
                other.iso31661 == iso31661));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, iso31661);

  @override
  String toString() {
    return 'AdminModel(iso31661: $iso31661)';
  }
}

/// @nodoc
abstract mixin class _$AdminModelCopyWith<$Res>
    implements $AdminModelCopyWith<$Res> {
  factory _$AdminModelCopyWith(
          _AdminModel value, $Res Function(_AdminModel) _then) =
      __$AdminModelCopyWithImpl;
  @override
  @useResult
  $Res call({@JsonKey(name: 'iso_3166_1') String iso31661});
}

/// @nodoc
class __$AdminModelCopyWithImpl<$Res> implements _$AdminModelCopyWith<$Res> {
  __$AdminModelCopyWithImpl(this._self, this._then);

  final _AdminModel _self;
  final $Res Function(_AdminModel) _then;

  /// Create a copy of AdminModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? iso31661 = null,
  }) {
    return _then(_AdminModel(
      iso31661: null == iso31661
          ? _self.iso31661
          : iso31661 // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
mixin _$StepModel {
  @JsonKey(name: 'bannerInstructions')
  List<BannerInstructionModel> get bannerInstructions;
  @JsonKey(name: 'voiceInstructions')
  List<VoiceInstructionModel> get voiceInstructions;
  List<IntersectionModel> get intersections;
  ManeuverModel get maneuver;
  String get name;
  double get duration;
  double get distance;
  @JsonKey(name: 'driving_side')
  String get drivingSide;
  double get weight;
  String get mode;
  GeometryModel
      get geometry; // `ref` có thể là null, ví dụ trong step đầu tiên không có
  String? get ref;

  /// Create a copy of StepModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $StepModelCopyWith<StepModel> get copyWith =>
      _$StepModelCopyWithImpl<StepModel>(this as StepModel, _$identity);

  /// Serializes this StepModel to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is StepModel &&
            const DeepCollectionEquality()
                .equals(other.bannerInstructions, bannerInstructions) &&
            const DeepCollectionEquality()
                .equals(other.voiceInstructions, voiceInstructions) &&
            const DeepCollectionEquality()
                .equals(other.intersections, intersections) &&
            (identical(other.maneuver, maneuver) ||
                other.maneuver == maneuver) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.duration, duration) ||
                other.duration == duration) &&
            (identical(other.distance, distance) ||
                other.distance == distance) &&
            (identical(other.drivingSide, drivingSide) ||
                other.drivingSide == drivingSide) &&
            (identical(other.weight, weight) || other.weight == weight) &&
            (identical(other.mode, mode) || other.mode == mode) &&
            (identical(other.geometry, geometry) ||
                other.geometry == geometry) &&
            (identical(other.ref, ref) || other.ref == ref));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(bannerInstructions),
      const DeepCollectionEquality().hash(voiceInstructions),
      const DeepCollectionEquality().hash(intersections),
      maneuver,
      name,
      duration,
      distance,
      drivingSide,
      weight,
      mode,
      geometry,
      ref);

  @override
  String toString() {
    return 'StepModel(bannerInstructions: $bannerInstructions, voiceInstructions: $voiceInstructions, intersections: $intersections, maneuver: $maneuver, name: $name, duration: $duration, distance: $distance, drivingSide: $drivingSide, weight: $weight, mode: $mode, geometry: $geometry, ref: $ref)';
  }
}

/// @nodoc
abstract mixin class $StepModelCopyWith<$Res> {
  factory $StepModelCopyWith(StepModel value, $Res Function(StepModel) _then) =
      _$StepModelCopyWithImpl;
  @useResult
  $Res call(
      {@JsonKey(name: 'bannerInstructions')
      List<BannerInstructionModel> bannerInstructions,
      @JsonKey(name: 'voiceInstructions')
      List<VoiceInstructionModel> voiceInstructions,
      List<IntersectionModel> intersections,
      ManeuverModel maneuver,
      String name,
      double duration,
      double distance,
      @JsonKey(name: 'driving_side') String drivingSide,
      double weight,
      String mode,
      GeometryModel geometry,
      String? ref});

  $ManeuverModelCopyWith<$Res> get maneuver;
  $GeometryModelCopyWith<$Res> get geometry;
}

/// @nodoc
class _$StepModelCopyWithImpl<$Res> implements $StepModelCopyWith<$Res> {
  _$StepModelCopyWithImpl(this._self, this._then);

  final StepModel _self;
  final $Res Function(StepModel) _then;

  /// Create a copy of StepModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? bannerInstructions = null,
    Object? voiceInstructions = null,
    Object? intersections = null,
    Object? maneuver = null,
    Object? name = null,
    Object? duration = null,
    Object? distance = null,
    Object? drivingSide = null,
    Object? weight = null,
    Object? mode = null,
    Object? geometry = null,
    Object? ref = freezed,
  }) {
    return _then(_self.copyWith(
      bannerInstructions: null == bannerInstructions
          ? _self.bannerInstructions
          : bannerInstructions // ignore: cast_nullable_to_non_nullable
              as List<BannerInstructionModel>,
      voiceInstructions: null == voiceInstructions
          ? _self.voiceInstructions
          : voiceInstructions // ignore: cast_nullable_to_non_nullable
              as List<VoiceInstructionModel>,
      intersections: null == intersections
          ? _self.intersections
          : intersections // ignore: cast_nullable_to_non_nullable
              as List<IntersectionModel>,
      maneuver: null == maneuver
          ? _self.maneuver
          : maneuver // ignore: cast_nullable_to_non_nullable
              as ManeuverModel,
      name: null == name
          ? _self.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      duration: null == duration
          ? _self.duration
          : duration // ignore: cast_nullable_to_non_nullable
              as double,
      distance: null == distance
          ? _self.distance
          : distance // ignore: cast_nullable_to_non_nullable
              as double,
      drivingSide: null == drivingSide
          ? _self.drivingSide
          : drivingSide // ignore: cast_nullable_to_non_nullable
              as String,
      weight: null == weight
          ? _self.weight
          : weight // ignore: cast_nullable_to_non_nullable
              as double,
      mode: null == mode
          ? _self.mode
          : mode // ignore: cast_nullable_to_non_nullable
              as String,
      geometry: null == geometry
          ? _self.geometry
          : geometry // ignore: cast_nullable_to_non_nullable
              as GeometryModel,
      ref: freezed == ref
          ? _self.ref
          : ref // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }

  /// Create a copy of StepModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ManeuverModelCopyWith<$Res> get maneuver {
    return $ManeuverModelCopyWith<$Res>(_self.maneuver, (value) {
      return _then(_self.copyWith(maneuver: value));
    });
  }

  /// Create a copy of StepModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $GeometryModelCopyWith<$Res> get geometry {
    return $GeometryModelCopyWith<$Res>(_self.geometry, (value) {
      return _then(_self.copyWith(geometry: value));
    });
  }
}

/// @nodoc
@JsonSerializable()
class _StepModel implements StepModel {
  const _StepModel(
      {@JsonKey(name: 'bannerInstructions')
      required final List<BannerInstructionModel> bannerInstructions,
      @JsonKey(name: 'voiceInstructions')
      required final List<VoiceInstructionModel> voiceInstructions,
      required final List<IntersectionModel> intersections,
      required this.maneuver,
      required this.name,
      required this.duration,
      required this.distance,
      @JsonKey(name: 'driving_side') required this.drivingSide,
      required this.weight,
      required this.mode,
      required this.geometry,
      this.ref})
      : _bannerInstructions = bannerInstructions,
        _voiceInstructions = voiceInstructions,
        _intersections = intersections;
  factory _StepModel.fromJson(Map<String, dynamic> json) =>
      _$StepModelFromJson(json);

  final List<BannerInstructionModel> _bannerInstructions;
  @override
  @JsonKey(name: 'bannerInstructions')
  List<BannerInstructionModel> get bannerInstructions {
    if (_bannerInstructions is EqualUnmodifiableListView)
      return _bannerInstructions;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_bannerInstructions);
  }

  final List<VoiceInstructionModel> _voiceInstructions;
  @override
  @JsonKey(name: 'voiceInstructions')
  List<VoiceInstructionModel> get voiceInstructions {
    if (_voiceInstructions is EqualUnmodifiableListView)
      return _voiceInstructions;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_voiceInstructions);
  }

  final List<IntersectionModel> _intersections;
  @override
  List<IntersectionModel> get intersections {
    if (_intersections is EqualUnmodifiableListView) return _intersections;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_intersections);
  }

  @override
  final ManeuverModel maneuver;
  @override
  final String name;
  @override
  final double duration;
  @override
  final double distance;
  @override
  @JsonKey(name: 'driving_side')
  final String drivingSide;
  @override
  final double weight;
  @override
  final String mode;
  @override
  final GeometryModel geometry;
// `ref` có thể là null, ví dụ trong step đầu tiên không có
  @override
  final String? ref;

  /// Create a copy of StepModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$StepModelCopyWith<_StepModel> get copyWith =>
      __$StepModelCopyWithImpl<_StepModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$StepModelToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _StepModel &&
            const DeepCollectionEquality()
                .equals(other._bannerInstructions, _bannerInstructions) &&
            const DeepCollectionEquality()
                .equals(other._voiceInstructions, _voiceInstructions) &&
            const DeepCollectionEquality()
                .equals(other._intersections, _intersections) &&
            (identical(other.maneuver, maneuver) ||
                other.maneuver == maneuver) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.duration, duration) ||
                other.duration == duration) &&
            (identical(other.distance, distance) ||
                other.distance == distance) &&
            (identical(other.drivingSide, drivingSide) ||
                other.drivingSide == drivingSide) &&
            (identical(other.weight, weight) || other.weight == weight) &&
            (identical(other.mode, mode) || other.mode == mode) &&
            (identical(other.geometry, geometry) ||
                other.geometry == geometry) &&
            (identical(other.ref, ref) || other.ref == ref));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_bannerInstructions),
      const DeepCollectionEquality().hash(_voiceInstructions),
      const DeepCollectionEquality().hash(_intersections),
      maneuver,
      name,
      duration,
      distance,
      drivingSide,
      weight,
      mode,
      geometry,
      ref);

  @override
  String toString() {
    return 'StepModel(bannerInstructions: $bannerInstructions, voiceInstructions: $voiceInstructions, intersections: $intersections, maneuver: $maneuver, name: $name, duration: $duration, distance: $distance, drivingSide: $drivingSide, weight: $weight, mode: $mode, geometry: $geometry, ref: $ref)';
  }
}

/// @nodoc
abstract mixin class _$StepModelCopyWith<$Res>
    implements $StepModelCopyWith<$Res> {
  factory _$StepModelCopyWith(
          _StepModel value, $Res Function(_StepModel) _then) =
      __$StepModelCopyWithImpl;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'bannerInstructions')
      List<BannerInstructionModel> bannerInstructions,
      @JsonKey(name: 'voiceInstructions')
      List<VoiceInstructionModel> voiceInstructions,
      List<IntersectionModel> intersections,
      ManeuverModel maneuver,
      String name,
      double duration,
      double distance,
      @JsonKey(name: 'driving_side') String drivingSide,
      double weight,
      String mode,
      GeometryModel geometry,
      String? ref});

  @override
  $ManeuverModelCopyWith<$Res> get maneuver;
  @override
  $GeometryModelCopyWith<$Res> get geometry;
}

/// @nodoc
class __$StepModelCopyWithImpl<$Res> implements _$StepModelCopyWith<$Res> {
  __$StepModelCopyWithImpl(this._self, this._then);

  final _StepModel _self;
  final $Res Function(_StepModel) _then;

  /// Create a copy of StepModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? bannerInstructions = null,
    Object? voiceInstructions = null,
    Object? intersections = null,
    Object? maneuver = null,
    Object? name = null,
    Object? duration = null,
    Object? distance = null,
    Object? drivingSide = null,
    Object? weight = null,
    Object? mode = null,
    Object? geometry = null,
    Object? ref = freezed,
  }) {
    return _then(_StepModel(
      bannerInstructions: null == bannerInstructions
          ? _self._bannerInstructions
          : bannerInstructions // ignore: cast_nullable_to_non_nullable
              as List<BannerInstructionModel>,
      voiceInstructions: null == voiceInstructions
          ? _self._voiceInstructions
          : voiceInstructions // ignore: cast_nullable_to_non_nullable
              as List<VoiceInstructionModel>,
      intersections: null == intersections
          ? _self._intersections
          : intersections // ignore: cast_nullable_to_non_nullable
              as List<IntersectionModel>,
      maneuver: null == maneuver
          ? _self.maneuver
          : maneuver // ignore: cast_nullable_to_non_nullable
              as ManeuverModel,
      name: null == name
          ? _self.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      duration: null == duration
          ? _self.duration
          : duration // ignore: cast_nullable_to_non_nullable
              as double,
      distance: null == distance
          ? _self.distance
          : distance // ignore: cast_nullable_to_non_nullable
              as double,
      drivingSide: null == drivingSide
          ? _self.drivingSide
          : drivingSide // ignore: cast_nullable_to_non_nullable
              as String,
      weight: null == weight
          ? _self.weight
          : weight // ignore: cast_nullable_to_non_nullable
              as double,
      mode: null == mode
          ? _self.mode
          : mode // ignore: cast_nullable_to_non_nullable
              as String,
      geometry: null == geometry
          ? _self.geometry
          : geometry // ignore: cast_nullable_to_non_nullable
              as GeometryModel,
      ref: freezed == ref
          ? _self.ref
          : ref // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }

  /// Create a copy of StepModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ManeuverModelCopyWith<$Res> get maneuver {
    return $ManeuverModelCopyWith<$Res>(_self.maneuver, (value) {
      return _then(_self.copyWith(maneuver: value));
    });
  }

  /// Create a copy of StepModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $GeometryModelCopyWith<$Res> get geometry {
    return $GeometryModelCopyWith<$Res>(_self.geometry, (value) {
      return _then(_self.copyWith(geometry: value));
    });
  }
}

/// @nodoc
mixin _$GeometryModel {
  List<List<double>> get coordinates;
  String get type;

  /// Create a copy of GeometryModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $GeometryModelCopyWith<GeometryModel> get copyWith =>
      _$GeometryModelCopyWithImpl<GeometryModel>(
          this as GeometryModel, _$identity);

  /// Serializes this GeometryModel to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is GeometryModel &&
            const DeepCollectionEquality()
                .equals(other.coordinates, coordinates) &&
            (identical(other.type, type) || other.type == type));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(coordinates), type);

  @override
  String toString() {
    return 'GeometryModel(coordinates: $coordinates, type: $type)';
  }
}

/// @nodoc
abstract mixin class $GeometryModelCopyWith<$Res> {
  factory $GeometryModelCopyWith(
          GeometryModel value, $Res Function(GeometryModel) _then) =
      _$GeometryModelCopyWithImpl;
  @useResult
  $Res call({List<List<double>> coordinates, String type});
}

/// @nodoc
class _$GeometryModelCopyWithImpl<$Res>
    implements $GeometryModelCopyWith<$Res> {
  _$GeometryModelCopyWithImpl(this._self, this._then);

  final GeometryModel _self;
  final $Res Function(GeometryModel) _then;

  /// Create a copy of GeometryModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? coordinates = null,
    Object? type = null,
  }) {
    return _then(_self.copyWith(
      coordinates: null == coordinates
          ? _self.coordinates
          : coordinates // ignore: cast_nullable_to_non_nullable
              as List<List<double>>,
      type: null == type
          ? _self.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _GeometryModel implements GeometryModel {
  const _GeometryModel(
      {required final List<List<double>> coordinates, required this.type})
      : _coordinates = coordinates;
  factory _GeometryModel.fromJson(Map<String, dynamic> json) =>
      _$GeometryModelFromJson(json);

  final List<List<double>> _coordinates;
  @override
  List<List<double>> get coordinates {
    if (_coordinates is EqualUnmodifiableListView) return _coordinates;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_coordinates);
  }

  @override
  final String type;

  /// Create a copy of GeometryModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$GeometryModelCopyWith<_GeometryModel> get copyWith =>
      __$GeometryModelCopyWithImpl<_GeometryModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$GeometryModelToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _GeometryModel &&
            const DeepCollectionEquality()
                .equals(other._coordinates, _coordinates) &&
            (identical(other.type, type) || other.type == type));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(_coordinates), type);

  @override
  String toString() {
    return 'GeometryModel(coordinates: $coordinates, type: $type)';
  }
}

/// @nodoc
abstract mixin class _$GeometryModelCopyWith<$Res>
    implements $GeometryModelCopyWith<$Res> {
  factory _$GeometryModelCopyWith(
          _GeometryModel value, $Res Function(_GeometryModel) _then) =
      __$GeometryModelCopyWithImpl;
  @override
  @useResult
  $Res call({List<List<double>> coordinates, String type});
}

/// @nodoc
class __$GeometryModelCopyWithImpl<$Res>
    implements _$GeometryModelCopyWith<$Res> {
  __$GeometryModelCopyWithImpl(this._self, this._then);

  final _GeometryModel _self;
  final $Res Function(_GeometryModel) _then;

  /// Create a copy of GeometryModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? coordinates = null,
    Object? type = null,
  }) {
    return _then(_GeometryModel(
      coordinates: null == coordinates
          ? _self._coordinates
          : coordinates // ignore: cast_nullable_to_non_nullable
              as List<List<double>>,
      type: null == type
          ? _self.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
mixin _$BannerInstructionModel {
  PrimaryInstructionModel
      get primary; // 'sub' không phải lúc nào cũng có, nên có thể là null
  PrimaryInstructionModel? get sub;
  @JsonKey(name: 'distanceAlongGeometry')
  double get distanceAlongGeometry;

  /// Create a copy of BannerInstructionModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $BannerInstructionModelCopyWith<BannerInstructionModel> get copyWith =>
      _$BannerInstructionModelCopyWithImpl<BannerInstructionModel>(
          this as BannerInstructionModel, _$identity);

  /// Serializes this BannerInstructionModel to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is BannerInstructionModel &&
            (identical(other.primary, primary) || other.primary == primary) &&
            (identical(other.sub, sub) || other.sub == sub) &&
            (identical(other.distanceAlongGeometry, distanceAlongGeometry) ||
                other.distanceAlongGeometry == distanceAlongGeometry));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, primary, sub, distanceAlongGeometry);

  @override
  String toString() {
    return 'BannerInstructionModel(primary: $primary, sub: $sub, distanceAlongGeometry: $distanceAlongGeometry)';
  }
}

/// @nodoc
abstract mixin class $BannerInstructionModelCopyWith<$Res> {
  factory $BannerInstructionModelCopyWith(BannerInstructionModel value,
          $Res Function(BannerInstructionModel) _then) =
      _$BannerInstructionModelCopyWithImpl;
  @useResult
  $Res call(
      {PrimaryInstructionModel primary,
      PrimaryInstructionModel? sub,
      @JsonKey(name: 'distanceAlongGeometry') double distanceAlongGeometry});

  $PrimaryInstructionModelCopyWith<$Res> get primary;
  $PrimaryInstructionModelCopyWith<$Res>? get sub;
}

/// @nodoc
class _$BannerInstructionModelCopyWithImpl<$Res>
    implements $BannerInstructionModelCopyWith<$Res> {
  _$BannerInstructionModelCopyWithImpl(this._self, this._then);

  final BannerInstructionModel _self;
  final $Res Function(BannerInstructionModel) _then;

  /// Create a copy of BannerInstructionModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? primary = null,
    Object? sub = freezed,
    Object? distanceAlongGeometry = null,
  }) {
    return _then(_self.copyWith(
      primary: null == primary
          ? _self.primary
          : primary // ignore: cast_nullable_to_non_nullable
              as PrimaryInstructionModel,
      sub: freezed == sub
          ? _self.sub
          : sub // ignore: cast_nullable_to_non_nullable
              as PrimaryInstructionModel?,
      distanceAlongGeometry: null == distanceAlongGeometry
          ? _self.distanceAlongGeometry
          : distanceAlongGeometry // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }

  /// Create a copy of BannerInstructionModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $PrimaryInstructionModelCopyWith<$Res> get primary {
    return $PrimaryInstructionModelCopyWith<$Res>(_self.primary, (value) {
      return _then(_self.copyWith(primary: value));
    });
  }

  /// Create a copy of BannerInstructionModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $PrimaryInstructionModelCopyWith<$Res>? get sub {
    if (_self.sub == null) {
      return null;
    }

    return $PrimaryInstructionModelCopyWith<$Res>(_self.sub!, (value) {
      return _then(_self.copyWith(sub: value));
    });
  }
}

/// @nodoc
@JsonSerializable()
class _BannerInstructionModel implements BannerInstructionModel {
  const _BannerInstructionModel(
      {required this.primary,
      this.sub,
      @JsonKey(name: 'distanceAlongGeometry')
      required this.distanceAlongGeometry});
  factory _BannerInstructionModel.fromJson(Map<String, dynamic> json) =>
      _$BannerInstructionModelFromJson(json);

  @override
  final PrimaryInstructionModel primary;
// 'sub' không phải lúc nào cũng có, nên có thể là null
  @override
  final PrimaryInstructionModel? sub;
  @override
  @JsonKey(name: 'distanceAlongGeometry')
  final double distanceAlongGeometry;

  /// Create a copy of BannerInstructionModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$BannerInstructionModelCopyWith<_BannerInstructionModel> get copyWith =>
      __$BannerInstructionModelCopyWithImpl<_BannerInstructionModel>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$BannerInstructionModelToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _BannerInstructionModel &&
            (identical(other.primary, primary) || other.primary == primary) &&
            (identical(other.sub, sub) || other.sub == sub) &&
            (identical(other.distanceAlongGeometry, distanceAlongGeometry) ||
                other.distanceAlongGeometry == distanceAlongGeometry));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, primary, sub, distanceAlongGeometry);

  @override
  String toString() {
    return 'BannerInstructionModel(primary: $primary, sub: $sub, distanceAlongGeometry: $distanceAlongGeometry)';
  }
}

/// @nodoc
abstract mixin class _$BannerInstructionModelCopyWith<$Res>
    implements $BannerInstructionModelCopyWith<$Res> {
  factory _$BannerInstructionModelCopyWith(_BannerInstructionModel value,
          $Res Function(_BannerInstructionModel) _then) =
      __$BannerInstructionModelCopyWithImpl;
  @override
  @useResult
  $Res call(
      {PrimaryInstructionModel primary,
      PrimaryInstructionModel? sub,
      @JsonKey(name: 'distanceAlongGeometry') double distanceAlongGeometry});

  @override
  $PrimaryInstructionModelCopyWith<$Res> get primary;
  @override
  $PrimaryInstructionModelCopyWith<$Res>? get sub;
}

/// @nodoc
class __$BannerInstructionModelCopyWithImpl<$Res>
    implements _$BannerInstructionModelCopyWith<$Res> {
  __$BannerInstructionModelCopyWithImpl(this._self, this._then);

  final _BannerInstructionModel _self;
  final $Res Function(_BannerInstructionModel) _then;

  /// Create a copy of BannerInstructionModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? primary = null,
    Object? sub = freezed,
    Object? distanceAlongGeometry = null,
  }) {
    return _then(_BannerInstructionModel(
      primary: null == primary
          ? _self.primary
          : primary // ignore: cast_nullable_to_non_nullable
              as PrimaryInstructionModel,
      sub: freezed == sub
          ? _self.sub
          : sub // ignore: cast_nullable_to_non_nullable
              as PrimaryInstructionModel?,
      distanceAlongGeometry: null == distanceAlongGeometry
          ? _self.distanceAlongGeometry
          : distanceAlongGeometry // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }

  /// Create a copy of BannerInstructionModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $PrimaryInstructionModelCopyWith<$Res> get primary {
    return $PrimaryInstructionModelCopyWith<$Res>(_self.primary, (value) {
      return _then(_self.copyWith(primary: value));
    });
  }

  /// Create a copy of BannerInstructionModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $PrimaryInstructionModelCopyWith<$Res>? get sub {
    if (_self.sub == null) {
      return null;
    }

    return $PrimaryInstructionModelCopyWith<$Res>(_self.sub!, (value) {
      return _then(_self.copyWith(sub: value));
    });
  }
}

/// @nodoc
mixin _$PrimaryInstructionModel {
  List<ComponentModel> get components;
  String get type;
  String get modifier;
  String get text;

  /// Create a copy of PrimaryInstructionModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $PrimaryInstructionModelCopyWith<PrimaryInstructionModel> get copyWith =>
      _$PrimaryInstructionModelCopyWithImpl<PrimaryInstructionModel>(
          this as PrimaryInstructionModel, _$identity);

  /// Serializes this PrimaryInstructionModel to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is PrimaryInstructionModel &&
            const DeepCollectionEquality()
                .equals(other.components, components) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.modifier, modifier) ||
                other.modifier == modifier) &&
            (identical(other.text, text) || other.text == text));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType,
      const DeepCollectionEquality().hash(components), type, modifier, text);

  @override
  String toString() {
    return 'PrimaryInstructionModel(components: $components, type: $type, modifier: $modifier, text: $text)';
  }
}

/// @nodoc
abstract mixin class $PrimaryInstructionModelCopyWith<$Res> {
  factory $PrimaryInstructionModelCopyWith(PrimaryInstructionModel value,
          $Res Function(PrimaryInstructionModel) _then) =
      _$PrimaryInstructionModelCopyWithImpl;
  @useResult
  $Res call(
      {List<ComponentModel> components,
      String type,
      String modifier,
      String text});
}

/// @nodoc
class _$PrimaryInstructionModelCopyWithImpl<$Res>
    implements $PrimaryInstructionModelCopyWith<$Res> {
  _$PrimaryInstructionModelCopyWithImpl(this._self, this._then);

  final PrimaryInstructionModel _self;
  final $Res Function(PrimaryInstructionModel) _then;

  /// Create a copy of PrimaryInstructionModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? components = null,
    Object? type = null,
    Object? modifier = null,
    Object? text = null,
  }) {
    return _then(_self.copyWith(
      components: null == components
          ? _self.components
          : components // ignore: cast_nullable_to_non_nullable
              as List<ComponentModel>,
      type: null == type
          ? _self.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      modifier: null == modifier
          ? _self.modifier
          : modifier // ignore: cast_nullable_to_non_nullable
              as String,
      text: null == text
          ? _self.text
          : text // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _PrimaryInstructionModel implements PrimaryInstructionModel {
  const _PrimaryInstructionModel(
      {required final List<ComponentModel> components,
      required this.type,
      required this.modifier,
      required this.text})
      : _components = components;
  factory _PrimaryInstructionModel.fromJson(Map<String, dynamic> json) =>
      _$PrimaryInstructionModelFromJson(json);

  final List<ComponentModel> _components;
  @override
  List<ComponentModel> get components {
    if (_components is EqualUnmodifiableListView) return _components;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_components);
  }

  @override
  final String type;
  @override
  final String modifier;
  @override
  final String text;

  /// Create a copy of PrimaryInstructionModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$PrimaryInstructionModelCopyWith<_PrimaryInstructionModel> get copyWith =>
      __$PrimaryInstructionModelCopyWithImpl<_PrimaryInstructionModel>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$PrimaryInstructionModelToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _PrimaryInstructionModel &&
            const DeepCollectionEquality()
                .equals(other._components, _components) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.modifier, modifier) ||
                other.modifier == modifier) &&
            (identical(other.text, text) || other.text == text));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType,
      const DeepCollectionEquality().hash(_components), type, modifier, text);

  @override
  String toString() {
    return 'PrimaryInstructionModel(components: $components, type: $type, modifier: $modifier, text: $text)';
  }
}

/// @nodoc
abstract mixin class _$PrimaryInstructionModelCopyWith<$Res>
    implements $PrimaryInstructionModelCopyWith<$Res> {
  factory _$PrimaryInstructionModelCopyWith(_PrimaryInstructionModel value,
          $Res Function(_PrimaryInstructionModel) _then) =
      __$PrimaryInstructionModelCopyWithImpl;
  @override
  @useResult
  $Res call(
      {List<ComponentModel> components,
      String type,
      String modifier,
      String text});
}

/// @nodoc
class __$PrimaryInstructionModelCopyWithImpl<$Res>
    implements _$PrimaryInstructionModelCopyWith<$Res> {
  __$PrimaryInstructionModelCopyWithImpl(this._self, this._then);

  final _PrimaryInstructionModel _self;
  final $Res Function(_PrimaryInstructionModel) _then;

  /// Create a copy of PrimaryInstructionModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? components = null,
    Object? type = null,
    Object? modifier = null,
    Object? text = null,
  }) {
    return _then(_PrimaryInstructionModel(
      components: null == components
          ? _self._components
          : components // ignore: cast_nullable_to_non_nullable
              as List<ComponentModel>,
      type: null == type
          ? _self.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      modifier: null == modifier
          ? _self.modifier
          : modifier // ignore: cast_nullable_to_non_nullable
              as String,
      text: null == text
          ? _self.text
          : text // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
mixin _$ComponentModel {
  String get type;
  String? get text; // 'mapbox_shield' chỉ có khi type là 'icon'
  @JsonKey(name: 'mapbox_shield')
  MapboxShieldModel? get mapboxShield;

  /// Create a copy of ComponentModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $ComponentModelCopyWith<ComponentModel> get copyWith =>
      _$ComponentModelCopyWithImpl<ComponentModel>(
          this as ComponentModel, _$identity);

  /// Serializes this ComponentModel to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is ComponentModel &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.text, text) || other.text == text) &&
            (identical(other.mapboxShield, mapboxShield) ||
                other.mapboxShield == mapboxShield));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, type, text, mapboxShield);

  @override
  String toString() {
    return 'ComponentModel(type: $type, text: $text, mapboxShield: $mapboxShield)';
  }
}

/// @nodoc
abstract mixin class $ComponentModelCopyWith<$Res> {
  factory $ComponentModelCopyWith(
          ComponentModel value, $Res Function(ComponentModel) _then) =
      _$ComponentModelCopyWithImpl;
  @useResult
  $Res call(
      {String type,
      String? text,
      @JsonKey(name: 'mapbox_shield') MapboxShieldModel? mapboxShield});

  $MapboxShieldModelCopyWith<$Res>? get mapboxShield;
}

/// @nodoc
class _$ComponentModelCopyWithImpl<$Res>
    implements $ComponentModelCopyWith<$Res> {
  _$ComponentModelCopyWithImpl(this._self, this._then);

  final ComponentModel _self;
  final $Res Function(ComponentModel) _then;

  /// Create a copy of ComponentModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? type = null,
    Object? text = freezed,
    Object? mapboxShield = freezed,
  }) {
    return _then(_self.copyWith(
      type: null == type
          ? _self.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      text: freezed == text
          ? _self.text
          : text // ignore: cast_nullable_to_non_nullable
              as String?,
      mapboxShield: freezed == mapboxShield
          ? _self.mapboxShield
          : mapboxShield // ignore: cast_nullable_to_non_nullable
              as MapboxShieldModel?,
    ));
  }

  /// Create a copy of ComponentModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $MapboxShieldModelCopyWith<$Res>? get mapboxShield {
    if (_self.mapboxShield == null) {
      return null;
    }

    return $MapboxShieldModelCopyWith<$Res>(_self.mapboxShield!, (value) {
      return _then(_self.copyWith(mapboxShield: value));
    });
  }
}

/// @nodoc
@JsonSerializable()
class _ComponentModel implements ComponentModel {
  const _ComponentModel(
      {required this.type,
      this.text,
      @JsonKey(name: 'mapbox_shield') this.mapboxShield});
  factory _ComponentModel.fromJson(Map<String, dynamic> json) =>
      _$ComponentModelFromJson(json);

  @override
  final String type;
  @override
  final String? text;
// 'mapbox_shield' chỉ có khi type là 'icon'
  @override
  @JsonKey(name: 'mapbox_shield')
  final MapboxShieldModel? mapboxShield;

  /// Create a copy of ComponentModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$ComponentModelCopyWith<_ComponentModel> get copyWith =>
      __$ComponentModelCopyWithImpl<_ComponentModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$ComponentModelToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _ComponentModel &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.text, text) || other.text == text) &&
            (identical(other.mapboxShield, mapboxShield) ||
                other.mapboxShield == mapboxShield));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, type, text, mapboxShield);

  @override
  String toString() {
    return 'ComponentModel(type: $type, text: $text, mapboxShield: $mapboxShield)';
  }
}

/// @nodoc
abstract mixin class _$ComponentModelCopyWith<$Res>
    implements $ComponentModelCopyWith<$Res> {
  factory _$ComponentModelCopyWith(
          _ComponentModel value, $Res Function(_ComponentModel) _then) =
      __$ComponentModelCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String type,
      String? text,
      @JsonKey(name: 'mapbox_shield') MapboxShieldModel? mapboxShield});

  @override
  $MapboxShieldModelCopyWith<$Res>? get mapboxShield;
}

/// @nodoc
class __$ComponentModelCopyWithImpl<$Res>
    implements _$ComponentModelCopyWith<$Res> {
  __$ComponentModelCopyWithImpl(this._self, this._then);

  final _ComponentModel _self;
  final $Res Function(_ComponentModel) _then;

  /// Create a copy of ComponentModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? type = null,
    Object? text = freezed,
    Object? mapboxShield = freezed,
  }) {
    return _then(_ComponentModel(
      type: null == type
          ? _self.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      text: freezed == text
          ? _self.text
          : text // ignore: cast_nullable_to_non_nullable
              as String?,
      mapboxShield: freezed == mapboxShield
          ? _self.mapboxShield
          : mapboxShield // ignore: cast_nullable_to_non_nullable
              as MapboxShieldModel?,
    ));
  }

  /// Create a copy of ComponentModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $MapboxShieldModelCopyWith<$Res>? get mapboxShield {
    if (_self.mapboxShield == null) {
      return null;
    }

    return $MapboxShieldModelCopyWith<$Res>(_self.mapboxShield!, (value) {
      return _then(_self.copyWith(mapboxShield: value));
    });
  }
}

/// @nodoc
mixin _$MapboxShieldModel {
  @JsonKey(name: 'text_color')
  String get textColor;
  String get name;
  @JsonKey(name: 'display_ref')
  String get displayRef;
  @JsonKey(name: 'base_url')
  String get baseUrl;

  /// Create a copy of MapboxShieldModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $MapboxShieldModelCopyWith<MapboxShieldModel> get copyWith =>
      _$MapboxShieldModelCopyWithImpl<MapboxShieldModel>(
          this as MapboxShieldModel, _$identity);

  /// Serializes this MapboxShieldModel to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is MapboxShieldModel &&
            (identical(other.textColor, textColor) ||
                other.textColor == textColor) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.displayRef, displayRef) ||
                other.displayRef == displayRef) &&
            (identical(other.baseUrl, baseUrl) || other.baseUrl == baseUrl));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, textColor, name, displayRef, baseUrl);

  @override
  String toString() {
    return 'MapboxShieldModel(textColor: $textColor, name: $name, displayRef: $displayRef, baseUrl: $baseUrl)';
  }
}

/// @nodoc
abstract mixin class $MapboxShieldModelCopyWith<$Res> {
  factory $MapboxShieldModelCopyWith(
          MapboxShieldModel value, $Res Function(MapboxShieldModel) _then) =
      _$MapboxShieldModelCopyWithImpl;
  @useResult
  $Res call(
      {@JsonKey(name: 'text_color') String textColor,
      String name,
      @JsonKey(name: 'display_ref') String displayRef,
      @JsonKey(name: 'base_url') String baseUrl});
}

/// @nodoc
class _$MapboxShieldModelCopyWithImpl<$Res>
    implements $MapboxShieldModelCopyWith<$Res> {
  _$MapboxShieldModelCopyWithImpl(this._self, this._then);

  final MapboxShieldModel _self;
  final $Res Function(MapboxShieldModel) _then;

  /// Create a copy of MapboxShieldModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? textColor = null,
    Object? name = null,
    Object? displayRef = null,
    Object? baseUrl = null,
  }) {
    return _then(_self.copyWith(
      textColor: null == textColor
          ? _self.textColor
          : textColor // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _self.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      displayRef: null == displayRef
          ? _self.displayRef
          : displayRef // ignore: cast_nullable_to_non_nullable
              as String,
      baseUrl: null == baseUrl
          ? _self.baseUrl
          : baseUrl // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _MapboxShieldModel implements MapboxShieldModel {
  const _MapboxShieldModel(
      {@JsonKey(name: 'text_color') required this.textColor,
      required this.name,
      @JsonKey(name: 'display_ref') required this.displayRef,
      @JsonKey(name: 'base_url') required this.baseUrl});
  factory _MapboxShieldModel.fromJson(Map<String, dynamic> json) =>
      _$MapboxShieldModelFromJson(json);

  @override
  @JsonKey(name: 'text_color')
  final String textColor;
  @override
  final String name;
  @override
  @JsonKey(name: 'display_ref')
  final String displayRef;
  @override
  @JsonKey(name: 'base_url')
  final String baseUrl;

  /// Create a copy of MapboxShieldModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$MapboxShieldModelCopyWith<_MapboxShieldModel> get copyWith =>
      __$MapboxShieldModelCopyWithImpl<_MapboxShieldModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$MapboxShieldModelToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _MapboxShieldModel &&
            (identical(other.textColor, textColor) ||
                other.textColor == textColor) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.displayRef, displayRef) ||
                other.displayRef == displayRef) &&
            (identical(other.baseUrl, baseUrl) || other.baseUrl == baseUrl));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, textColor, name, displayRef, baseUrl);

  @override
  String toString() {
    return 'MapboxShieldModel(textColor: $textColor, name: $name, displayRef: $displayRef, baseUrl: $baseUrl)';
  }
}

/// @nodoc
abstract mixin class _$MapboxShieldModelCopyWith<$Res>
    implements $MapboxShieldModelCopyWith<$Res> {
  factory _$MapboxShieldModelCopyWith(
          _MapboxShieldModel value, $Res Function(_MapboxShieldModel) _then) =
      __$MapboxShieldModelCopyWithImpl;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'text_color') String textColor,
      String name,
      @JsonKey(name: 'display_ref') String displayRef,
      @JsonKey(name: 'base_url') String baseUrl});
}

/// @nodoc
class __$MapboxShieldModelCopyWithImpl<$Res>
    implements _$MapboxShieldModelCopyWith<$Res> {
  __$MapboxShieldModelCopyWithImpl(this._self, this._then);

  final _MapboxShieldModel _self;
  final $Res Function(_MapboxShieldModel) _then;

  /// Create a copy of MapboxShieldModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? textColor = null,
    Object? name = null,
    Object? displayRef = null,
    Object? baseUrl = null,
  }) {
    return _then(_MapboxShieldModel(
      textColor: null == textColor
          ? _self.textColor
          : textColor // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _self.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      displayRef: null == displayRef
          ? _self.displayRef
          : displayRef // ignore: cast_nullable_to_non_nullable
              as String,
      baseUrl: null == baseUrl
          ? _self.baseUrl
          : baseUrl // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
mixin _$VoiceInstructionModel {
  @JsonKey(name: 'ssmlAnnouncement')
  String get ssmlAnnouncement;
  String get announcement;
  @JsonKey(name: 'distanceAlongGeometry')
  double get distanceAlongGeometry;

  /// Create a copy of VoiceInstructionModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $VoiceInstructionModelCopyWith<VoiceInstructionModel> get copyWith =>
      _$VoiceInstructionModelCopyWithImpl<VoiceInstructionModel>(
          this as VoiceInstructionModel, _$identity);

  /// Serializes this VoiceInstructionModel to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is VoiceInstructionModel &&
            (identical(other.ssmlAnnouncement, ssmlAnnouncement) ||
                other.ssmlAnnouncement == ssmlAnnouncement) &&
            (identical(other.announcement, announcement) ||
                other.announcement == announcement) &&
            (identical(other.distanceAlongGeometry, distanceAlongGeometry) ||
                other.distanceAlongGeometry == distanceAlongGeometry));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, ssmlAnnouncement, announcement, distanceAlongGeometry);

  @override
  String toString() {
    return 'VoiceInstructionModel(ssmlAnnouncement: $ssmlAnnouncement, announcement: $announcement, distanceAlongGeometry: $distanceAlongGeometry)';
  }
}

/// @nodoc
abstract mixin class $VoiceInstructionModelCopyWith<$Res> {
  factory $VoiceInstructionModelCopyWith(VoiceInstructionModel value,
          $Res Function(VoiceInstructionModel) _then) =
      _$VoiceInstructionModelCopyWithImpl;
  @useResult
  $Res call(
      {@JsonKey(name: 'ssmlAnnouncement') String ssmlAnnouncement,
      String announcement,
      @JsonKey(name: 'distanceAlongGeometry') double distanceAlongGeometry});
}

/// @nodoc
class _$VoiceInstructionModelCopyWithImpl<$Res>
    implements $VoiceInstructionModelCopyWith<$Res> {
  _$VoiceInstructionModelCopyWithImpl(this._self, this._then);

  final VoiceInstructionModel _self;
  final $Res Function(VoiceInstructionModel) _then;

  /// Create a copy of VoiceInstructionModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? ssmlAnnouncement = null,
    Object? announcement = null,
    Object? distanceAlongGeometry = null,
  }) {
    return _then(_self.copyWith(
      ssmlAnnouncement: null == ssmlAnnouncement
          ? _self.ssmlAnnouncement
          : ssmlAnnouncement // ignore: cast_nullable_to_non_nullable
              as String,
      announcement: null == announcement
          ? _self.announcement
          : announcement // ignore: cast_nullable_to_non_nullable
              as String,
      distanceAlongGeometry: null == distanceAlongGeometry
          ? _self.distanceAlongGeometry
          : distanceAlongGeometry // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _VoiceInstructionModel implements VoiceInstructionModel {
  const _VoiceInstructionModel(
      {@JsonKey(name: 'ssmlAnnouncement') required this.ssmlAnnouncement,
      required this.announcement,
      @JsonKey(name: 'distanceAlongGeometry')
      required this.distanceAlongGeometry});
  factory _VoiceInstructionModel.fromJson(Map<String, dynamic> json) =>
      _$VoiceInstructionModelFromJson(json);

  @override
  @JsonKey(name: 'ssmlAnnouncement')
  final String ssmlAnnouncement;
  @override
  final String announcement;
  @override
  @JsonKey(name: 'distanceAlongGeometry')
  final double distanceAlongGeometry;

  /// Create a copy of VoiceInstructionModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$VoiceInstructionModelCopyWith<_VoiceInstructionModel> get copyWith =>
      __$VoiceInstructionModelCopyWithImpl<_VoiceInstructionModel>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$VoiceInstructionModelToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _VoiceInstructionModel &&
            (identical(other.ssmlAnnouncement, ssmlAnnouncement) ||
                other.ssmlAnnouncement == ssmlAnnouncement) &&
            (identical(other.announcement, announcement) ||
                other.announcement == announcement) &&
            (identical(other.distanceAlongGeometry, distanceAlongGeometry) ||
                other.distanceAlongGeometry == distanceAlongGeometry));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, ssmlAnnouncement, announcement, distanceAlongGeometry);

  @override
  String toString() {
    return 'VoiceInstructionModel(ssmlAnnouncement: $ssmlAnnouncement, announcement: $announcement, distanceAlongGeometry: $distanceAlongGeometry)';
  }
}

/// @nodoc
abstract mixin class _$VoiceInstructionModelCopyWith<$Res>
    implements $VoiceInstructionModelCopyWith<$Res> {
  factory _$VoiceInstructionModelCopyWith(_VoiceInstructionModel value,
          $Res Function(_VoiceInstructionModel) _then) =
      __$VoiceInstructionModelCopyWithImpl;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'ssmlAnnouncement') String ssmlAnnouncement,
      String announcement,
      @JsonKey(name: 'distanceAlongGeometry') double distanceAlongGeometry});
}

/// @nodoc
class __$VoiceInstructionModelCopyWithImpl<$Res>
    implements _$VoiceInstructionModelCopyWith<$Res> {
  __$VoiceInstructionModelCopyWithImpl(this._self, this._then);

  final _VoiceInstructionModel _self;
  final $Res Function(_VoiceInstructionModel) _then;

  /// Create a copy of VoiceInstructionModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? ssmlAnnouncement = null,
    Object? announcement = null,
    Object? distanceAlongGeometry = null,
  }) {
    return _then(_VoiceInstructionModel(
      ssmlAnnouncement: null == ssmlAnnouncement
          ? _self.ssmlAnnouncement
          : ssmlAnnouncement // ignore: cast_nullable_to_non_nullable
              as String,
      announcement: null == announcement
          ? _self.announcement
          : announcement // ignore: cast_nullable_to_non_nullable
              as String,
      distanceAlongGeometry: null == distanceAlongGeometry
          ? _self.distanceAlongGeometry
          : distanceAlongGeometry // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc
mixin _$IntersectionModel {
  @JsonKey(name: 'mapbox_streets_v8')
  MapboxStreetsV8Model? get mapboxStreetsV8;
  List<int> get bearings;
  List<bool> get entry;
  @JsonKey(name: 'admin_index')
  int get adminIndex;
  int? get out;
  @JsonKey(name: 'geometry_index')
  int get geometryIndex;
  List<double>
      get location; // Các thuộc tính dưới đây không phải lúc nào cũng có
  @JsonKey(name: 'in')
  int? get inIndex;
  double? get duration;
  @JsonKey(name: 'turn_weight')
  double? get turnWeight;
  @JsonKey(name: 'turn_duration')
  double? get turnDuration;
  double? get weight;

  /// Create a copy of IntersectionModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $IntersectionModelCopyWith<IntersectionModel> get copyWith =>
      _$IntersectionModelCopyWithImpl<IntersectionModel>(
          this as IntersectionModel, _$identity);

  /// Serializes this IntersectionModel to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is IntersectionModel &&
            (identical(other.mapboxStreetsV8, mapboxStreetsV8) ||
                other.mapboxStreetsV8 == mapboxStreetsV8) &&
            const DeepCollectionEquality().equals(other.bearings, bearings) &&
            const DeepCollectionEquality().equals(other.entry, entry) &&
            (identical(other.adminIndex, adminIndex) ||
                other.adminIndex == adminIndex) &&
            (identical(other.out, out) || other.out == out) &&
            (identical(other.geometryIndex, geometryIndex) ||
                other.geometryIndex == geometryIndex) &&
            const DeepCollectionEquality().equals(other.location, location) &&
            (identical(other.inIndex, inIndex) || other.inIndex == inIndex) &&
            (identical(other.duration, duration) ||
                other.duration == duration) &&
            (identical(other.turnWeight, turnWeight) ||
                other.turnWeight == turnWeight) &&
            (identical(other.turnDuration, turnDuration) ||
                other.turnDuration == turnDuration) &&
            (identical(other.weight, weight) || other.weight == weight));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      mapboxStreetsV8,
      const DeepCollectionEquality().hash(bearings),
      const DeepCollectionEquality().hash(entry),
      adminIndex,
      out,
      geometryIndex,
      const DeepCollectionEquality().hash(location),
      inIndex,
      duration,
      turnWeight,
      turnDuration,
      weight);

  @override
  String toString() {
    return 'IntersectionModel(mapboxStreetsV8: $mapboxStreetsV8, bearings: $bearings, entry: $entry, adminIndex: $adminIndex, out: $out, geometryIndex: $geometryIndex, location: $location, inIndex: $inIndex, duration: $duration, turnWeight: $turnWeight, turnDuration: $turnDuration, weight: $weight)';
  }
}

/// @nodoc
abstract mixin class $IntersectionModelCopyWith<$Res> {
  factory $IntersectionModelCopyWith(
          IntersectionModel value, $Res Function(IntersectionModel) _then) =
      _$IntersectionModelCopyWithImpl;
  @useResult
  $Res call(
      {@JsonKey(name: 'mapbox_streets_v8')
      MapboxStreetsV8Model? mapboxStreetsV8,
      List<int> bearings,
      List<bool> entry,
      @JsonKey(name: 'admin_index') int adminIndex,
      int? out,
      @JsonKey(name: 'geometry_index') int geometryIndex,
      List<double> location,
      @JsonKey(name: 'in') int? inIndex,
      double? duration,
      @JsonKey(name: 'turn_weight') double? turnWeight,
      @JsonKey(name: 'turn_duration') double? turnDuration,
      double? weight});

  $MapboxStreetsV8ModelCopyWith<$Res>? get mapboxStreetsV8;
}

/// @nodoc
class _$IntersectionModelCopyWithImpl<$Res>
    implements $IntersectionModelCopyWith<$Res> {
  _$IntersectionModelCopyWithImpl(this._self, this._then);

  final IntersectionModel _self;
  final $Res Function(IntersectionModel) _then;

  /// Create a copy of IntersectionModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? mapboxStreetsV8 = freezed,
    Object? bearings = null,
    Object? entry = null,
    Object? adminIndex = null,
    Object? out = freezed,
    Object? geometryIndex = null,
    Object? location = null,
    Object? inIndex = freezed,
    Object? duration = freezed,
    Object? turnWeight = freezed,
    Object? turnDuration = freezed,
    Object? weight = freezed,
  }) {
    return _then(_self.copyWith(
      mapboxStreetsV8: freezed == mapboxStreetsV8
          ? _self.mapboxStreetsV8
          : mapboxStreetsV8 // ignore: cast_nullable_to_non_nullable
              as MapboxStreetsV8Model?,
      bearings: null == bearings
          ? _self.bearings
          : bearings // ignore: cast_nullable_to_non_nullable
              as List<int>,
      entry: null == entry
          ? _self.entry
          : entry // ignore: cast_nullable_to_non_nullable
              as List<bool>,
      adminIndex: null == adminIndex
          ? _self.adminIndex
          : adminIndex // ignore: cast_nullable_to_non_nullable
              as int,
      out: freezed == out
          ? _self.out
          : out // ignore: cast_nullable_to_non_nullable
              as int?,
      geometryIndex: null == geometryIndex
          ? _self.geometryIndex
          : geometryIndex // ignore: cast_nullable_to_non_nullable
              as int,
      location: null == location
          ? _self.location
          : location // ignore: cast_nullable_to_non_nullable
              as List<double>,
      inIndex: freezed == inIndex
          ? _self.inIndex
          : inIndex // ignore: cast_nullable_to_non_nullable
              as int?,
      duration: freezed == duration
          ? _self.duration
          : duration // ignore: cast_nullable_to_non_nullable
              as double?,
      turnWeight: freezed == turnWeight
          ? _self.turnWeight
          : turnWeight // ignore: cast_nullable_to_non_nullable
              as double?,
      turnDuration: freezed == turnDuration
          ? _self.turnDuration
          : turnDuration // ignore: cast_nullable_to_non_nullable
              as double?,
      weight: freezed == weight
          ? _self.weight
          : weight // ignore: cast_nullable_to_non_nullable
              as double?,
    ));
  }

  /// Create a copy of IntersectionModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $MapboxStreetsV8ModelCopyWith<$Res>? get mapboxStreetsV8 {
    if (_self.mapboxStreetsV8 == null) {
      return null;
    }

    return $MapboxStreetsV8ModelCopyWith<$Res>(_self.mapboxStreetsV8!, (value) {
      return _then(_self.copyWith(mapboxStreetsV8: value));
    });
  }
}

/// @nodoc
@JsonSerializable()
class _IntersectionModel implements IntersectionModel {
  const _IntersectionModel(
      {@JsonKey(name: 'mapbox_streets_v8') this.mapboxStreetsV8,
      required final List<int> bearings,
      required final List<bool> entry,
      @JsonKey(name: 'admin_index') required this.adminIndex,
      this.out,
      @JsonKey(name: 'geometry_index') required this.geometryIndex,
      required final List<double> location,
      @JsonKey(name: 'in') this.inIndex,
      this.duration,
      @JsonKey(name: 'turn_weight') this.turnWeight,
      @JsonKey(name: 'turn_duration') this.turnDuration,
      this.weight})
      : _bearings = bearings,
        _entry = entry,
        _location = location;
  factory _IntersectionModel.fromJson(Map<String, dynamic> json) =>
      _$IntersectionModelFromJson(json);

  @override
  @JsonKey(name: 'mapbox_streets_v8')
  final MapboxStreetsV8Model? mapboxStreetsV8;
  final List<int> _bearings;
  @override
  List<int> get bearings {
    if (_bearings is EqualUnmodifiableListView) return _bearings;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_bearings);
  }

  final List<bool> _entry;
  @override
  List<bool> get entry {
    if (_entry is EqualUnmodifiableListView) return _entry;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_entry);
  }

  @override
  @JsonKey(name: 'admin_index')
  final int adminIndex;
  @override
  final int? out;
  @override
  @JsonKey(name: 'geometry_index')
  final int geometryIndex;
  final List<double> _location;
  @override
  List<double> get location {
    if (_location is EqualUnmodifiableListView) return _location;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_location);
  }

// Các thuộc tính dưới đây không phải lúc nào cũng có
  @override
  @JsonKey(name: 'in')
  final int? inIndex;
  @override
  final double? duration;
  @override
  @JsonKey(name: 'turn_weight')
  final double? turnWeight;
  @override
  @JsonKey(name: 'turn_duration')
  final double? turnDuration;
  @override
  final double? weight;

  /// Create a copy of IntersectionModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$IntersectionModelCopyWith<_IntersectionModel> get copyWith =>
      __$IntersectionModelCopyWithImpl<_IntersectionModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$IntersectionModelToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _IntersectionModel &&
            (identical(other.mapboxStreetsV8, mapboxStreetsV8) ||
                other.mapboxStreetsV8 == mapboxStreetsV8) &&
            const DeepCollectionEquality().equals(other._bearings, _bearings) &&
            const DeepCollectionEquality().equals(other._entry, _entry) &&
            (identical(other.adminIndex, adminIndex) ||
                other.adminIndex == adminIndex) &&
            (identical(other.out, out) || other.out == out) &&
            (identical(other.geometryIndex, geometryIndex) ||
                other.geometryIndex == geometryIndex) &&
            const DeepCollectionEquality().equals(other._location, _location) &&
            (identical(other.inIndex, inIndex) || other.inIndex == inIndex) &&
            (identical(other.duration, duration) ||
                other.duration == duration) &&
            (identical(other.turnWeight, turnWeight) ||
                other.turnWeight == turnWeight) &&
            (identical(other.turnDuration, turnDuration) ||
                other.turnDuration == turnDuration) &&
            (identical(other.weight, weight) || other.weight == weight));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      mapboxStreetsV8,
      const DeepCollectionEquality().hash(_bearings),
      const DeepCollectionEquality().hash(_entry),
      adminIndex,
      out,
      geometryIndex,
      const DeepCollectionEquality().hash(_location),
      inIndex,
      duration,
      turnWeight,
      turnDuration,
      weight);

  @override
  String toString() {
    return 'IntersectionModel(mapboxStreetsV8: $mapboxStreetsV8, bearings: $bearings, entry: $entry, adminIndex: $adminIndex, out: $out, geometryIndex: $geometryIndex, location: $location, inIndex: $inIndex, duration: $duration, turnWeight: $turnWeight, turnDuration: $turnDuration, weight: $weight)';
  }
}

/// @nodoc
abstract mixin class _$IntersectionModelCopyWith<$Res>
    implements $IntersectionModelCopyWith<$Res> {
  factory _$IntersectionModelCopyWith(
          _IntersectionModel value, $Res Function(_IntersectionModel) _then) =
      __$IntersectionModelCopyWithImpl;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'mapbox_streets_v8')
      MapboxStreetsV8Model? mapboxStreetsV8,
      List<int> bearings,
      List<bool> entry,
      @JsonKey(name: 'admin_index') int adminIndex,
      int? out,
      @JsonKey(name: 'geometry_index') int geometryIndex,
      List<double> location,
      @JsonKey(name: 'in') int? inIndex,
      double? duration,
      @JsonKey(name: 'turn_weight') double? turnWeight,
      @JsonKey(name: 'turn_duration') double? turnDuration,
      double? weight});

  @override
  $MapboxStreetsV8ModelCopyWith<$Res>? get mapboxStreetsV8;
}

/// @nodoc
class __$IntersectionModelCopyWithImpl<$Res>
    implements _$IntersectionModelCopyWith<$Res> {
  __$IntersectionModelCopyWithImpl(this._self, this._then);

  final _IntersectionModel _self;
  final $Res Function(_IntersectionModel) _then;

  /// Create a copy of IntersectionModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? mapboxStreetsV8 = freezed,
    Object? bearings = null,
    Object? entry = null,
    Object? adminIndex = null,
    Object? out = freezed,
    Object? geometryIndex = null,
    Object? location = null,
    Object? inIndex = freezed,
    Object? duration = freezed,
    Object? turnWeight = freezed,
    Object? turnDuration = freezed,
    Object? weight = freezed,
  }) {
    return _then(_IntersectionModel(
      mapboxStreetsV8: freezed == mapboxStreetsV8
          ? _self.mapboxStreetsV8
          : mapboxStreetsV8 // ignore: cast_nullable_to_non_nullable
              as MapboxStreetsV8Model?,
      bearings: null == bearings
          ? _self._bearings
          : bearings // ignore: cast_nullable_to_non_nullable
              as List<int>,
      entry: null == entry
          ? _self._entry
          : entry // ignore: cast_nullable_to_non_nullable
              as List<bool>,
      adminIndex: null == adminIndex
          ? _self.adminIndex
          : adminIndex // ignore: cast_nullable_to_non_nullable
              as int,
      out: freezed == out
          ? _self.out
          : out // ignore: cast_nullable_to_non_nullable
              as int?,
      geometryIndex: null == geometryIndex
          ? _self.geometryIndex
          : geometryIndex // ignore: cast_nullable_to_non_nullable
              as int,
      location: null == location
          ? _self._location
          : location // ignore: cast_nullable_to_non_nullable
              as List<double>,
      inIndex: freezed == inIndex
          ? _self.inIndex
          : inIndex // ignore: cast_nullable_to_non_nullable
              as int?,
      duration: freezed == duration
          ? _self.duration
          : duration // ignore: cast_nullable_to_non_nullable
              as double?,
      turnWeight: freezed == turnWeight
          ? _self.turnWeight
          : turnWeight // ignore: cast_nullable_to_non_nullable
              as double?,
      turnDuration: freezed == turnDuration
          ? _self.turnDuration
          : turnDuration // ignore: cast_nullable_to_non_nullable
              as double?,
      weight: freezed == weight
          ? _self.weight
          : weight // ignore: cast_nullable_to_non_nullable
              as double?,
    ));
  }

  /// Create a copy of IntersectionModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $MapboxStreetsV8ModelCopyWith<$Res>? get mapboxStreetsV8 {
    if (_self.mapboxStreetsV8 == null) {
      return null;
    }

    return $MapboxStreetsV8ModelCopyWith<$Res>(_self.mapboxStreetsV8!, (value) {
      return _then(_self.copyWith(mapboxStreetsV8: value));
    });
  }
}

/// @nodoc
mixin _$MapboxStreetsV8Model {
  @JsonKey(name: 'class')
  String get streetClass;

  /// Create a copy of MapboxStreetsV8Model
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $MapboxStreetsV8ModelCopyWith<MapboxStreetsV8Model> get copyWith =>
      _$MapboxStreetsV8ModelCopyWithImpl<MapboxStreetsV8Model>(
          this as MapboxStreetsV8Model, _$identity);

  /// Serializes this MapboxStreetsV8Model to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is MapboxStreetsV8Model &&
            (identical(other.streetClass, streetClass) ||
                other.streetClass == streetClass));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, streetClass);

  @override
  String toString() {
    return 'MapboxStreetsV8Model(streetClass: $streetClass)';
  }
}

/// @nodoc
abstract mixin class $MapboxStreetsV8ModelCopyWith<$Res> {
  factory $MapboxStreetsV8ModelCopyWith(MapboxStreetsV8Model value,
          $Res Function(MapboxStreetsV8Model) _then) =
      _$MapboxStreetsV8ModelCopyWithImpl;
  @useResult
  $Res call({@JsonKey(name: 'class') String streetClass});
}

/// @nodoc
class _$MapboxStreetsV8ModelCopyWithImpl<$Res>
    implements $MapboxStreetsV8ModelCopyWith<$Res> {
  _$MapboxStreetsV8ModelCopyWithImpl(this._self, this._then);

  final MapboxStreetsV8Model _self;
  final $Res Function(MapboxStreetsV8Model) _then;

  /// Create a copy of MapboxStreetsV8Model
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? streetClass = null,
  }) {
    return _then(_self.copyWith(
      streetClass: null == streetClass
          ? _self.streetClass
          : streetClass // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _MapboxStreetsV8Model implements MapboxStreetsV8Model {
  const _MapboxStreetsV8Model(
      {@JsonKey(name: 'class') required this.streetClass});
  factory _MapboxStreetsV8Model.fromJson(Map<String, dynamic> json) =>
      _$MapboxStreetsV8ModelFromJson(json);

  @override
  @JsonKey(name: 'class')
  final String streetClass;

  /// Create a copy of MapboxStreetsV8Model
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$MapboxStreetsV8ModelCopyWith<_MapboxStreetsV8Model> get copyWith =>
      __$MapboxStreetsV8ModelCopyWithImpl<_MapboxStreetsV8Model>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$MapboxStreetsV8ModelToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _MapboxStreetsV8Model &&
            (identical(other.streetClass, streetClass) ||
                other.streetClass == streetClass));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, streetClass);

  @override
  String toString() {
    return 'MapboxStreetsV8Model(streetClass: $streetClass)';
  }
}

/// @nodoc
abstract mixin class _$MapboxStreetsV8ModelCopyWith<$Res>
    implements $MapboxStreetsV8ModelCopyWith<$Res> {
  factory _$MapboxStreetsV8ModelCopyWith(_MapboxStreetsV8Model value,
          $Res Function(_MapboxStreetsV8Model) _then) =
      __$MapboxStreetsV8ModelCopyWithImpl;
  @override
  @useResult
  $Res call({@JsonKey(name: 'class') String streetClass});
}

/// @nodoc
class __$MapboxStreetsV8ModelCopyWithImpl<$Res>
    implements _$MapboxStreetsV8ModelCopyWith<$Res> {
  __$MapboxStreetsV8ModelCopyWithImpl(this._self, this._then);

  final _MapboxStreetsV8Model _self;
  final $Res Function(_MapboxStreetsV8Model) _then;

  /// Create a copy of MapboxStreetsV8Model
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? streetClass = null,
  }) {
    return _then(_MapboxStreetsV8Model(
      streetClass: null == streetClass
          ? _self.streetClass
          : streetClass // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
mixin _$ManeuverModel {
  String get type;
  String get instruction;
  @JsonKey(name: 'bearing_after')
  int get bearingAfter;
  @JsonKey(name: 'bearing_before')
  int get bearingBefore;
  List<double>
      get location; // `modifier` có thể là null (ví dụ ở maneuver cuối 'arrive')
  String? get modifier;

  /// Create a copy of ManeuverModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $ManeuverModelCopyWith<ManeuverModel> get copyWith =>
      _$ManeuverModelCopyWithImpl<ManeuverModel>(
          this as ManeuverModel, _$identity);

  /// Serializes this ManeuverModel to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is ManeuverModel &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.instruction, instruction) ||
                other.instruction == instruction) &&
            (identical(other.bearingAfter, bearingAfter) ||
                other.bearingAfter == bearingAfter) &&
            (identical(other.bearingBefore, bearingBefore) ||
                other.bearingBefore == bearingBefore) &&
            const DeepCollectionEquality().equals(other.location, location) &&
            (identical(other.modifier, modifier) ||
                other.modifier == modifier));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, type, instruction, bearingAfter,
      bearingBefore, const DeepCollectionEquality().hash(location), modifier);

  @override
  String toString() {
    return 'ManeuverModel(type: $type, instruction: $instruction, bearingAfter: $bearingAfter, bearingBefore: $bearingBefore, location: $location, modifier: $modifier)';
  }
}

/// @nodoc
abstract mixin class $ManeuverModelCopyWith<$Res> {
  factory $ManeuverModelCopyWith(
          ManeuverModel value, $Res Function(ManeuverModel) _then) =
      _$ManeuverModelCopyWithImpl;
  @useResult
  $Res call(
      {String type,
      String instruction,
      @JsonKey(name: 'bearing_after') int bearingAfter,
      @JsonKey(name: 'bearing_before') int bearingBefore,
      List<double> location,
      String? modifier});
}

/// @nodoc
class _$ManeuverModelCopyWithImpl<$Res>
    implements $ManeuverModelCopyWith<$Res> {
  _$ManeuverModelCopyWithImpl(this._self, this._then);

  final ManeuverModel _self;
  final $Res Function(ManeuverModel) _then;

  /// Create a copy of ManeuverModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? type = null,
    Object? instruction = null,
    Object? bearingAfter = null,
    Object? bearingBefore = null,
    Object? location = null,
    Object? modifier = freezed,
  }) {
    return _then(_self.copyWith(
      type: null == type
          ? _self.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      instruction: null == instruction
          ? _self.instruction
          : instruction // ignore: cast_nullable_to_non_nullable
              as String,
      bearingAfter: null == bearingAfter
          ? _self.bearingAfter
          : bearingAfter // ignore: cast_nullable_to_non_nullable
              as int,
      bearingBefore: null == bearingBefore
          ? _self.bearingBefore
          : bearingBefore // ignore: cast_nullable_to_non_nullable
              as int,
      location: null == location
          ? _self.location
          : location // ignore: cast_nullable_to_non_nullable
              as List<double>,
      modifier: freezed == modifier
          ? _self.modifier
          : modifier // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _ManeuverModel implements ManeuverModel {
  const _ManeuverModel(
      {required this.type,
      required this.instruction,
      @JsonKey(name: 'bearing_after') required this.bearingAfter,
      @JsonKey(name: 'bearing_before') required this.bearingBefore,
      required final List<double> location,
      this.modifier})
      : _location = location;
  factory _ManeuverModel.fromJson(Map<String, dynamic> json) =>
      _$ManeuverModelFromJson(json);

  @override
  final String type;
  @override
  final String instruction;
  @override
  @JsonKey(name: 'bearing_after')
  final int bearingAfter;
  @override
  @JsonKey(name: 'bearing_before')
  final int bearingBefore;
  final List<double> _location;
  @override
  List<double> get location {
    if (_location is EqualUnmodifiableListView) return _location;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_location);
  }

// `modifier` có thể là null (ví dụ ở maneuver cuối 'arrive')
  @override
  final String? modifier;

  /// Create a copy of ManeuverModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$ManeuverModelCopyWith<_ManeuverModel> get copyWith =>
      __$ManeuverModelCopyWithImpl<_ManeuverModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$ManeuverModelToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _ManeuverModel &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.instruction, instruction) ||
                other.instruction == instruction) &&
            (identical(other.bearingAfter, bearingAfter) ||
                other.bearingAfter == bearingAfter) &&
            (identical(other.bearingBefore, bearingBefore) ||
                other.bearingBefore == bearingBefore) &&
            const DeepCollectionEquality().equals(other._location, _location) &&
            (identical(other.modifier, modifier) ||
                other.modifier == modifier));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, type, instruction, bearingAfter,
      bearingBefore, const DeepCollectionEquality().hash(_location), modifier);

  @override
  String toString() {
    return 'ManeuverModel(type: $type, instruction: $instruction, bearingAfter: $bearingAfter, bearingBefore: $bearingBefore, location: $location, modifier: $modifier)';
  }
}

/// @nodoc
abstract mixin class _$ManeuverModelCopyWith<$Res>
    implements $ManeuverModelCopyWith<$Res> {
  factory _$ManeuverModelCopyWith(
          _ManeuverModel value, $Res Function(_ManeuverModel) _then) =
      __$ManeuverModelCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String type,
      String instruction,
      @JsonKey(name: 'bearing_after') int bearingAfter,
      @JsonKey(name: 'bearing_before') int bearingBefore,
      List<double> location,
      String? modifier});
}

/// @nodoc
class __$ManeuverModelCopyWithImpl<$Res>
    implements _$ManeuverModelCopyWith<$Res> {
  __$ManeuverModelCopyWithImpl(this._self, this._then);

  final _ManeuverModel _self;
  final $Res Function(_ManeuverModel) _then;

  /// Create a copy of ManeuverModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? type = null,
    Object? instruction = null,
    Object? bearingAfter = null,
    Object? bearingBefore = null,
    Object? location = null,
    Object? modifier = freezed,
  }) {
    return _then(_ManeuverModel(
      type: null == type
          ? _self.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      instruction: null == instruction
          ? _self.instruction
          : instruction // ignore: cast_nullable_to_non_nullable
              as String,
      bearingAfter: null == bearingAfter
          ? _self.bearingAfter
          : bearingAfter // ignore: cast_nullable_to_non_nullable
              as int,
      bearingBefore: null == bearingBefore
          ? _self.bearingBefore
          : bearingBefore // ignore: cast_nullable_to_non_nullable
              as int,
      location: null == location
          ? _self._location
          : location // ignore: cast_nullable_to_non_nullable
              as List<double>,
      modifier: freezed == modifier
          ? _self.modifier
          : modifier // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

// dart format on
