import 'package:freezed_annotation/freezed_annotation.dart';

part 'direction.freezed.dart';
part 'direction.g.dart';

// --- Model gốc (Root Model) ---
@freezed
abstract class Direction with _$Direction {
  const factory Direction({
    List<RouteModel>? routes,
    List<WaypointModel>? waypoints,
    String? code,
    String? uuid,
  }) = _Direction;

  factory Direction.fromJson(Map<String, dynamic> json) => _$DirectionFromJson(json);
}

// --- Các model con ---

@freezed
abstract class RouteModel with _$RouteModel {
  const factory RouteModel({
    @JsonKey(name: 'weight_name') String? weightName,
    double? weight,
    double? duration,
    double? distance,
    List<LegModel>? legs,
    GeometryModel? geometry,
    @JsonKey(name: 'voiceLocale') String? voiceLocale,
  }) = _RouteModel;

  factory RouteModel.fromJson(Map<String, dynamic> json) => _$RouteModelFromJson(json);
}

@freezed
abstract class WaypointModel with _$WaypointModel {
  const factory WaypointModel({
    double? distance,
    String? name,
    List<double>? location,
  }) = _WaypointModel;

  factory WaypointModel.fromJson(Map<String, dynamic> json) => _$WaypointModelFromJson(json);
}

@freezed
abstract class LegModel with _$LegModel {
  const factory LegModel({
    @JsonKey(name: 'via_waypoints') List<dynamic>? viaWaypoints,
    AnnotationModel? annotation,
    List<AdminModel>? admins,
    double? weight,
    double? duration,
    List<StepModel>? steps,
    double? distance,
    String? summary,
  }) = _LegModel;

  factory LegModel.fromJson(Map<String, dynamic> json) => _$LegModelFromJson(json);
}

@freezed
abstract class AnnotationModel with _$AnnotationModel {
  const factory AnnotationModel({
    List<double>? speed,
    List<double>? distance,
    List<double>? duration,
  }) = _AnnotationModel;

  factory AnnotationModel.fromJson(Map<String, dynamic> json) => _$AnnotationModelFromJson(json);
}

@freezed
abstract class AdminModel with _$AdminModel {
  const factory AdminModel({
    @JsonKey(name: 'iso_3166_1') String? iso31661,
  }) = _AdminModel;

  factory AdminModel.fromJson(Map<String, dynamic> json) => _$AdminModelFromJson(json);
}

@freezed
abstract class StepModel with _$StepModel {
  const factory StepModel({
    @JsonKey(name: 'bannerInstructions') List<BannerInstructionModel>? bannerInstructions,
    @JsonKey(name: 'voiceInstructions') List<VoiceInstructionModel>? voiceInstructions,
    List<IntersectionModel>? intersections,
    ManeuverModel? maneuver,
    String? name,
    double? duration,
    double? distance,
    @JsonKey(name: 'driving_side') String? drivingSide,
    double? weight,
    String? mode,
    GeometryModel? geometry,
    // `ref` có thể là null, ví dụ trong step đầu tiên không có
    String? ref,
  }) = _StepModel;

  factory StepModel.fromJson(Map<String, dynamic> json) => _$StepModelFromJson(json);
}

@freezed
abstract class GeometryModel with _$GeometryModel {
  const factory GeometryModel({
    List<List<double>>? coordinates,
    String? type,
  }) = _GeometryModel;

  factory GeometryModel.fromJson(Map<String, dynamic> json) => _$GeometryModelFromJson(json);
}

@freezed
abstract class BannerInstructionModel with _$BannerInstructionModel {
  const factory BannerInstructionModel({
    PrimaryInstructionModel? primary,
    // 'sub' không phải lúc nào cũng có, nên có thể là null
    PrimaryInstructionModel? sub,
    @JsonKey(name: 'distanceAlongGeometry') double? distanceAlongGeometry,
  }) = _BannerInstructionModel;

  factory BannerInstructionModel.fromJson(Map<String, dynamic> json) => _$BannerInstructionModelFromJson(json);
}

@freezed
abstract class PrimaryInstructionModel with _$PrimaryInstructionModel {
  const factory PrimaryInstructionModel({
    List<ComponentModel>? components,
    String? type,
    String? modifier,
    String? text,
  }) = _PrimaryInstructionModel;

  factory PrimaryInstructionModel.fromJson(Map<String, dynamic> json) => _$PrimaryInstructionModelFromJson(json);
}

@freezed
abstract class ComponentModel with _$ComponentModel {
  const factory ComponentModel({
    String? type,
    String? text,
    // 'mapbox_shield' chỉ có khi type là 'icon'
    @JsonKey(name: 'mapbox_shield') MapboxShieldModel? mapboxShield,
  }) = _ComponentModel;

  factory ComponentModel.fromJson(Map<String, dynamic> json) => _$ComponentModelFromJson(json);
}

@freezed
abstract class MapboxShieldModel with _$MapboxShieldModel {
  const factory MapboxShieldModel({
    @JsonKey(name: 'text_color') String? textColor,
    String? name,
    @JsonKey(name: 'display_ref') String? displayRef,
    @JsonKey(name: 'base_url') String? baseUrl,
  }) = _MapboxShieldModel;

  factory MapboxShieldModel.fromJson(Map<String, dynamic> json) => _$MapboxShieldModelFromJson(json);
}

@freezed
abstract class VoiceInstructionModel with _$VoiceInstructionModel {
  const factory VoiceInstructionModel({
    @JsonKey(name: 'ssmlAnnouncement') String? ssmlAnnouncement,
    String? announcement,
    @JsonKey(name: 'distanceAlongGeometry') double? distanceAlongGeometry,
  }) = _VoiceInstructionModel;

  factory VoiceInstructionModel.fromJson(Map<String, dynamic> json) => _$VoiceInstructionModelFromJson(json);
}

@freezed
abstract class IntersectionModel with _$IntersectionModel {
  const factory IntersectionModel({
    @JsonKey(name: 'mapbox_streets_v8') MapboxStreetsV8Model? mapboxStreetsV8,
    List<int>? bearings,
    List<bool>? entry,
    @JsonKey(name: 'admin_index') int? adminIndex,
    int? out,
    @JsonKey(name: 'geometry_index') int? geometryIndex,
    List<double>? location,
    // Các thuộc tính dưới đây không phải lúc nào cũng có
    @JsonKey(name: 'in') int? inIndex,
    double? duration,
    @JsonKey(name: 'turn_weight') double? turnWeight,
    @JsonKey(name: 'turn_duration') double? turnDuration,
    double? weight,
  }) = _IntersectionModel;

  factory IntersectionModel.fromJson(Map<String, dynamic> json) => _$IntersectionModelFromJson(json);
}

@freezed
abstract class MapboxStreetsV8Model with _$MapboxStreetsV8Model {
  const factory MapboxStreetsV8Model({
    @JsonKey(name: 'class') String? streetClass,
  }) = _MapboxStreetsV8Model;

  factory MapboxStreetsV8Model.fromJson(Map<String, dynamic> json) => _$MapboxStreetsV8ModelFromJson(json);
}

@freezed
abstract class ManeuverModel with _$ManeuverModel {
  const factory ManeuverModel({
    String? type,
    String? instruction,
    @JsonKey(name: 'bearing_after') int? bearingAfter,
    @JsonKey(name: 'bearing_before') int? bearingBefore,
    List<double>? location,
    // `modifier` có thể là null (ví dụ ở maneuver cuối 'arrive')
    String? modifier,
  }) = _ManeuverModel;

  factory ManeuverModel.fromJson(Map<String, dynamic> json) => _$ManeuverModelFromJson(json);
}
