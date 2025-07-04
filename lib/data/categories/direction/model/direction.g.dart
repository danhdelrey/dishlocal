// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'direction.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Direction _$DirectionFromJson(Map<String, dynamic> json) => _Direction(
      routes: (json['routes'] as List<dynamic>)
          .map((e) => RouteModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      waypoints: (json['waypoints'] as List<dynamic>)
          .map((e) => WaypointModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      code: json['code'] as String,
      uuid: json['uuid'] as String,
    );

Map<String, dynamic> _$DirectionToJson(_Direction instance) =>
    <String, dynamic>{
      'routes': instance.routes,
      'waypoints': instance.waypoints,
      'code': instance.code,
      'uuid': instance.uuid,
    };

_RouteModel _$RouteModelFromJson(Map<String, dynamic> json) => _RouteModel(
      weightName: json['weight_name'] as String,
      weight: (json['weight'] as num).toDouble(),
      duration: (json['duration'] as num).toDouble(),
      distance: (json['distance'] as num).toDouble(),
      legs: (json['legs'] as List<dynamic>)
          .map((e) => LegModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      geometry:
          GeometryModel.fromJson(json['geometry'] as Map<String, dynamic>),
      voiceLocale: json['voiceLocale'] as String?,
    );

Map<String, dynamic> _$RouteModelToJson(_RouteModel instance) =>
    <String, dynamic>{
      'weight_name': instance.weightName,
      'weight': instance.weight,
      'duration': instance.duration,
      'distance': instance.distance,
      'legs': instance.legs,
      'geometry': instance.geometry,
      'voiceLocale': instance.voiceLocale,
    };

_WaypointModel _$WaypointModelFromJson(Map<String, dynamic> json) =>
    _WaypointModel(
      distance: (json['distance'] as num).toDouble(),
      name: json['name'] as String,
      location: (json['location'] as List<dynamic>)
          .map((e) => (e as num).toDouble())
          .toList(),
    );

Map<String, dynamic> _$WaypointModelToJson(_WaypointModel instance) =>
    <String, dynamic>{
      'distance': instance.distance,
      'name': instance.name,
      'location': instance.location,
    };

_LegModel _$LegModelFromJson(Map<String, dynamic> json) => _LegModel(
      viaWaypoints: json['via_waypoints'] as List<dynamic>,
      annotation:
          AnnotationModel.fromJson(json['annotation'] as Map<String, dynamic>),
      admins: (json['admins'] as List<dynamic>)
          .map((e) => AdminModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      weight: (json['weight'] as num).toDouble(),
      duration: (json['duration'] as num).toDouble(),
      steps: (json['steps'] as List<dynamic>)
          .map((e) => StepModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      distance: (json['distance'] as num).toDouble(),
      summary: json['summary'] as String,
    );

Map<String, dynamic> _$LegModelToJson(_LegModel instance) => <String, dynamic>{
      'via_waypoints': instance.viaWaypoints,
      'annotation': instance.annotation,
      'admins': instance.admins,
      'weight': instance.weight,
      'duration': instance.duration,
      'steps': instance.steps,
      'distance': instance.distance,
      'summary': instance.summary,
    };

_AnnotationModel _$AnnotationModelFromJson(Map<String, dynamic> json) =>
    _AnnotationModel(
      speed: (json['speed'] as List<dynamic>)
          .map((e) => (e as num).toDouble())
          .toList(),
      distance: (json['distance'] as List<dynamic>)
          .map((e) => (e as num).toDouble())
          .toList(),
      duration: (json['duration'] as List<dynamic>)
          .map((e) => (e as num).toDouble())
          .toList(),
    );

Map<String, dynamic> _$AnnotationModelToJson(_AnnotationModel instance) =>
    <String, dynamic>{
      'speed': instance.speed,
      'distance': instance.distance,
      'duration': instance.duration,
    };

_AdminModel _$AdminModelFromJson(Map<String, dynamic> json) => _AdminModel(
      iso31661: json['iso_3166_1'] as String,
    );

Map<String, dynamic> _$AdminModelToJson(_AdminModel instance) =>
    <String, dynamic>{
      'iso_3166_1': instance.iso31661,
    };

_StepModel _$StepModelFromJson(Map<String, dynamic> json) => _StepModel(
      bannerInstructions: (json['bannerInstructions'] as List<dynamic>)
          .map(
              (e) => BannerInstructionModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      voiceInstructions: (json['voiceInstructions'] as List<dynamic>)
          .map((e) => VoiceInstructionModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      intersections: (json['intersections'] as List<dynamic>)
          .map((e) => IntersectionModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      maneuver:
          ManeuverModel.fromJson(json['maneuver'] as Map<String, dynamic>),
      name: json['name'] as String,
      duration: (json['duration'] as num).toDouble(),
      distance: (json['distance'] as num).toDouble(),
      drivingSide: json['driving_side'] as String,
      weight: (json['weight'] as num).toDouble(),
      mode: json['mode'] as String,
      geometry:
          GeometryModel.fromJson(json['geometry'] as Map<String, dynamic>),
      ref: json['ref'] as String?,
    );

Map<String, dynamic> _$StepModelToJson(_StepModel instance) =>
    <String, dynamic>{
      'bannerInstructions': instance.bannerInstructions,
      'voiceInstructions': instance.voiceInstructions,
      'intersections': instance.intersections,
      'maneuver': instance.maneuver,
      'name': instance.name,
      'duration': instance.duration,
      'distance': instance.distance,
      'driving_side': instance.drivingSide,
      'weight': instance.weight,
      'mode': instance.mode,
      'geometry': instance.geometry,
      'ref': instance.ref,
    };

_GeometryModel _$GeometryModelFromJson(Map<String, dynamic> json) =>
    _GeometryModel(
      coordinates: (json['coordinates'] as List<dynamic>)
          .map((e) =>
              (e as List<dynamic>).map((e) => (e as num).toDouble()).toList())
          .toList(),
      type: json['type'] as String,
    );

Map<String, dynamic> _$GeometryModelToJson(_GeometryModel instance) =>
    <String, dynamic>{
      'coordinates': instance.coordinates,
      'type': instance.type,
    };

_BannerInstructionModel _$BannerInstructionModelFromJson(
        Map<String, dynamic> json) =>
    _BannerInstructionModel(
      primary: PrimaryInstructionModel.fromJson(
          json['primary'] as Map<String, dynamic>),
      sub: json['sub'] == null
          ? null
          : PrimaryInstructionModel.fromJson(
              json['sub'] as Map<String, dynamic>),
      distanceAlongGeometry: (json['distanceAlongGeometry'] as num).toDouble(),
    );

Map<String, dynamic> _$BannerInstructionModelToJson(
        _BannerInstructionModel instance) =>
    <String, dynamic>{
      'primary': instance.primary,
      'sub': instance.sub,
      'distanceAlongGeometry': instance.distanceAlongGeometry,
    };

_PrimaryInstructionModel _$PrimaryInstructionModelFromJson(
        Map<String, dynamic> json) =>
    _PrimaryInstructionModel(
      components: (json['components'] as List<dynamic>)
          .map((e) => ComponentModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      type: json['type'] as String,
      modifier: json['modifier'] as String,
      text: json['text'] as String,
    );

Map<String, dynamic> _$PrimaryInstructionModelToJson(
        _PrimaryInstructionModel instance) =>
    <String, dynamic>{
      'components': instance.components,
      'type': instance.type,
      'modifier': instance.modifier,
      'text': instance.text,
    };

_ComponentModel _$ComponentModelFromJson(Map<String, dynamic> json) =>
    _ComponentModel(
      type: json['type'] as String,
      text: json['text'] as String?,
      mapboxShield: json['mapbox_shield'] == null
          ? null
          : MapboxShieldModel.fromJson(
              json['mapbox_shield'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ComponentModelToJson(_ComponentModel instance) =>
    <String, dynamic>{
      'type': instance.type,
      'text': instance.text,
      'mapbox_shield': instance.mapboxShield,
    };

_MapboxShieldModel _$MapboxShieldModelFromJson(Map<String, dynamic> json) =>
    _MapboxShieldModel(
      textColor: json['text_color'] as String,
      name: json['name'] as String,
      displayRef: json['display_ref'] as String,
      baseUrl: json['base_url'] as String,
    );

Map<String, dynamic> _$MapboxShieldModelToJson(_MapboxShieldModel instance) =>
    <String, dynamic>{
      'text_color': instance.textColor,
      'name': instance.name,
      'display_ref': instance.displayRef,
      'base_url': instance.baseUrl,
    };

_VoiceInstructionModel _$VoiceInstructionModelFromJson(
        Map<String, dynamic> json) =>
    _VoiceInstructionModel(
      ssmlAnnouncement: json['ssmlAnnouncement'] as String,
      announcement: json['announcement'] as String,
      distanceAlongGeometry: (json['distanceAlongGeometry'] as num).toDouble(),
    );

Map<String, dynamic> _$VoiceInstructionModelToJson(
        _VoiceInstructionModel instance) =>
    <String, dynamic>{
      'ssmlAnnouncement': instance.ssmlAnnouncement,
      'announcement': instance.announcement,
      'distanceAlongGeometry': instance.distanceAlongGeometry,
    };

_IntersectionModel _$IntersectionModelFromJson(Map<String, dynamic> json) =>
    _IntersectionModel(
      mapboxStreetsV8: json['mapbox_streets_v8'] == null
          ? null
          : MapboxStreetsV8Model.fromJson(
              json['mapbox_streets_v8'] as Map<String, dynamic>),
      bearings: (json['bearings'] as List<dynamic>)
          .map((e) => (e as num).toInt())
          .toList(),
      entry: (json['entry'] as List<dynamic>).map((e) => e as bool).toList(),
      adminIndex: (json['admin_index'] as num).toInt(),
      out: (json['out'] as num).toInt(),
      geometryIndex: (json['geometry_index'] as num).toInt(),
      location: (json['location'] as List<dynamic>)
          .map((e) => (e as num).toDouble())
          .toList(),
      inIndex: (json['in'] as num?)?.toInt(),
      duration: (json['duration'] as num?)?.toDouble(),
      turnWeight: (json['turn_weight'] as num?)?.toDouble(),
      turnDuration: (json['turn_duration'] as num?)?.toDouble(),
      weight: (json['weight'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$IntersectionModelToJson(_IntersectionModel instance) =>
    <String, dynamic>{
      'mapbox_streets_v8': instance.mapboxStreetsV8,
      'bearings': instance.bearings,
      'entry': instance.entry,
      'admin_index': instance.adminIndex,
      'out': instance.out,
      'geometry_index': instance.geometryIndex,
      'location': instance.location,
      'in': instance.inIndex,
      'duration': instance.duration,
      'turn_weight': instance.turnWeight,
      'turn_duration': instance.turnDuration,
      'weight': instance.weight,
    };

_MapboxStreetsV8Model _$MapboxStreetsV8ModelFromJson(
        Map<String, dynamic> json) =>
    _MapboxStreetsV8Model(
      streetClass: json['class'] as String,
    );

Map<String, dynamic> _$MapboxStreetsV8ModelToJson(
        _MapboxStreetsV8Model instance) =>
    <String, dynamic>{
      'class': instance.streetClass,
    };

_ManeuverModel _$ManeuverModelFromJson(Map<String, dynamic> json) =>
    _ManeuverModel(
      type: json['type'] as String,
      instruction: json['instruction'] as String,
      bearingAfter: (json['bearing_after'] as num).toInt(),
      bearingBefore: (json['bearing_before'] as num).toInt(),
      location: (json['location'] as List<dynamic>)
          .map((e) => (e as num).toDouble())
          .toList(),
      modifier: json['modifier'] as String?,
    );

Map<String, dynamic> _$ManeuverModelToJson(_ManeuverModel instance) =>
    <String, dynamic>{
      'type': instance.type,
      'instruction': instance.instruction,
      'bearing_after': instance.bearingAfter,
      'bearing_before': instance.bearingBefore,
      'location': instance.location,
      'modifier': instance.modifier,
    };
