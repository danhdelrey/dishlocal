import 'package:freezed_annotation/freezed_annotation.dart';

part 'direction.freezed.dart';
part 'direction.g.dart';

// --- Model gốc (Root Model) ---
@freezed
abstract class Direction with _$Direction {
  const factory Direction({
    required List<RouteModel> routes,
    required List<WaypointModel> waypoints,
    required String code,
    required String uuid,
  }) = _Direction;

  factory Direction.fromJson(Map<String, dynamic> json) => _$DirectionFromJson(json);
}

// --- Các model con ---

@freezed
abstract class RouteModel with _$RouteModel {
  const factory RouteModel({
    @JsonKey(name: 'weight_name') required String weightName,
    required double weight,
    required double duration,
    required double distance,
    required List<LegModel> legs,
    required GeometryModel geometry,
    @JsonKey(name: 'voiceLocale') String? voiceLocale,
  }) = _RouteModel;

  factory RouteModel.fromJson(Map<String, dynamic> json) => _$RouteModelFromJson(json);
}

@freezed
abstract class WaypointModel with _$WaypointModel {
  const factory WaypointModel({
    required double distance,
    required String name,
    required List<double> location,
  }) = _WaypointModel;

  factory WaypointModel.fromJson(Map<String, dynamic> json) => _$WaypointModelFromJson(json);
}

@freezed
abstract class LegModel with _$LegModel {
  const factory LegModel({
    @JsonKey(name: 'via_waypoints') required List<dynamic> viaWaypoints,
    required AnnotationModel annotation,
    required List<AdminModel> admins,
    required double weight,
    required double duration,
    required List<StepModel> steps,
    required double distance,
    required String summary,
  }) = _LegModel;

  factory LegModel.fromJson(Map<String, dynamic> json) => _$LegModelFromJson(json);
}

@freezed
abstract class AnnotationModel with _$AnnotationModel {
  const factory AnnotationModel({
    required List<double> speed,
    required List<double> distance,
    required List<double> duration,
  }) = _AnnotationModel;

  factory AnnotationModel.fromJson(Map<String, dynamic> json) => _$AnnotationModelFromJson(json);
}

@freezed
abstract class AdminModel with _$AdminModel {
  const factory AdminModel({
    @JsonKey(name: 'iso_3166_1') required String iso31661,
  }) = _AdminModel;

  factory AdminModel.fromJson(Map<String, dynamic> json) => _$AdminModelFromJson(json);
}

@freezed
abstract class StepModel with _$StepModel {
  const factory StepModel({
    @JsonKey(name: 'bannerInstructions') required List<BannerInstructionModel> bannerInstructions,
    @JsonKey(name: 'voiceInstructions') required List<VoiceInstructionModel> voiceInstructions,
    required List<IntersectionModel> intersections,
    required ManeuverModel maneuver,
    required String name,
    required double duration,
    required double distance,
    @JsonKey(name: 'driving_side') required String drivingSide,
    required double weight,
    required String mode,
    required GeometryModel geometry,
    // `ref` có thể là null, ví dụ trong step đầu tiên không có
    String? ref,
  }) = _StepModel;

  factory StepModel.fromJson(Map<String, dynamic> json) => _$StepModelFromJson(json);
}

@freezed
abstract class GeometryModel with _$GeometryModel {
  const factory GeometryModel({
    required List<List<double>> coordinates,
    required String type,
  }) = _GeometryModel;

  factory GeometryModel.fromJson(Map<String, dynamic> json) => _$GeometryModelFromJson(json);
}

@freezed
abstract class BannerInstructionModel with _$BannerInstructionModel {
  const factory BannerInstructionModel({
    required PrimaryInstructionModel primary,
    // 'sub' không phải lúc nào cũng có, nên có thể là null
    PrimaryInstructionModel? sub,
    @JsonKey(name: 'distanceAlongGeometry') required double distanceAlongGeometry,
  }) = _BannerInstructionModel;

  factory BannerInstructionModel.fromJson(Map<String, dynamic> json) => _$BannerInstructionModelFromJson(json);
}

@freezed
abstract class PrimaryInstructionModel with _$PrimaryInstructionModel {
  const factory PrimaryInstructionModel({
    required List<ComponentModel> components,
    required String type,
    required String modifier,
    required String text,
  }) = _PrimaryInstructionModel;

  factory PrimaryInstructionModel.fromJson(Map<String, dynamic> json) => _$PrimaryInstructionModelFromJson(json);
}

@freezed
abstract class ComponentModel with _$ComponentModel {
  const factory ComponentModel({
    required String type,
    String? text,
    // 'mapbox_shield' chỉ có khi type là 'icon'
    @JsonKey(name: 'mapbox_shield') MapboxShieldModel? mapboxShield,
  }) = _ComponentModel;

  factory ComponentModel.fromJson(Map<String, dynamic> json) => _$ComponentModelFromJson(json);
}

@freezed
abstract class MapboxShieldModel with _$MapboxShieldModel {
  const factory MapboxShieldModel({
    @JsonKey(name: 'text_color') required String textColor,
    required String name,
    @JsonKey(name: 'display_ref') required String displayRef,
    @JsonKey(name: 'base_url') required String baseUrl,
  }) = _MapboxShieldModel;

  factory MapboxShieldModel.fromJson(Map<String, dynamic> json) => _$MapboxShieldModelFromJson(json);
}

@freezed
abstract class VoiceInstructionModel with _$VoiceInstructionModel {
  const factory VoiceInstructionModel({
    @JsonKey(name: 'ssmlAnnouncement') required String ssmlAnnouncement,
    required String announcement,
    @JsonKey(name: 'distanceAlongGeometry') required double distanceAlongGeometry,
  }) = _VoiceInstructionModel;

  factory VoiceInstructionModel.fromJson(Map<String, dynamic> json) => _$VoiceInstructionModelFromJson(json);
}

@freezed
abstract class IntersectionModel with _$IntersectionModel {
  const factory IntersectionModel({
    @JsonKey(name: 'mapbox_streets_v8') MapboxStreetsV8Model? mapboxStreetsV8,
    required List<int> bearings,
    required List<bool> entry,
    @JsonKey(name: 'admin_index') required int adminIndex,
    required int out,
    @JsonKey(name: 'geometry_index') required int geometryIndex,
    required List<double> location,
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
    @JsonKey(name: 'class') required String streetClass,
  }) = _MapboxStreetsV8Model;

  factory MapboxStreetsV8Model.fromJson(Map<String, dynamic> json) => _$MapboxStreetsV8ModelFromJson(json);
}

@freezed
abstract class ManeuverModel with _$ManeuverModel {
  const factory ManeuverModel({
    required String type,
    required String instruction,
    @JsonKey(name: 'bearing_after') required int bearingAfter,
    @JsonKey(name: 'bearing_before') required int bearingBefore,
    required List<double> location,
    // `modifier` có thể là null (ví dụ ở maneuver cuối 'arrive')
    String? modifier,
  }) = _ManeuverModel;

  factory ManeuverModel.fromJson(Map<String, dynamic> json) => _$ManeuverModelFromJson(json);
}
