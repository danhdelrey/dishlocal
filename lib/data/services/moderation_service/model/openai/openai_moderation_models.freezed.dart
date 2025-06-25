// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'openai_moderation_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ModerationResponse {
  String get id;
  String get model;
  List<ModerationResult> get results;

  /// Create a copy of ModerationResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $ModerationResponseCopyWith<ModerationResponse> get copyWith =>
      _$ModerationResponseCopyWithImpl<ModerationResponse>(
          this as ModerationResponse, _$identity);

  /// Serializes this ModerationResponse to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is ModerationResponse &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.model, model) || other.model == model) &&
            const DeepCollectionEquality().equals(other.results, results));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, id, model, const DeepCollectionEquality().hash(results));

  @override
  String toString() {
    return 'ModerationResponse(id: $id, model: $model, results: $results)';
  }
}

/// @nodoc
abstract mixin class $ModerationResponseCopyWith<$Res> {
  factory $ModerationResponseCopyWith(
          ModerationResponse value, $Res Function(ModerationResponse) _then) =
      _$ModerationResponseCopyWithImpl;
  @useResult
  $Res call({String id, String model, List<ModerationResult> results});
}

/// @nodoc
class _$ModerationResponseCopyWithImpl<$Res>
    implements $ModerationResponseCopyWith<$Res> {
  _$ModerationResponseCopyWithImpl(this._self, this._then);

  final ModerationResponse _self;
  final $Res Function(ModerationResponse) _then;

  /// Create a copy of ModerationResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? model = null,
    Object? results = null,
  }) {
    return _then(_self.copyWith(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      model: null == model
          ? _self.model
          : model // ignore: cast_nullable_to_non_nullable
              as String,
      results: null == results
          ? _self.results
          : results // ignore: cast_nullable_to_non_nullable
              as List<ModerationResult>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _ModerationResponse implements ModerationResponse {
  const _ModerationResponse(
      {required this.id,
      required this.model,
      required final List<ModerationResult> results})
      : _results = results;
  factory _ModerationResponse.fromJson(Map<String, dynamic> json) =>
      _$ModerationResponseFromJson(json);

  @override
  final String id;
  @override
  final String model;
  final List<ModerationResult> _results;
  @override
  List<ModerationResult> get results {
    if (_results is EqualUnmodifiableListView) return _results;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_results);
  }

  /// Create a copy of ModerationResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$ModerationResponseCopyWith<_ModerationResponse> get copyWith =>
      __$ModerationResponseCopyWithImpl<_ModerationResponse>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$ModerationResponseToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _ModerationResponse &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.model, model) || other.model == model) &&
            const DeepCollectionEquality().equals(other._results, _results));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, id, model, const DeepCollectionEquality().hash(_results));

  @override
  String toString() {
    return 'ModerationResponse(id: $id, model: $model, results: $results)';
  }
}

/// @nodoc
abstract mixin class _$ModerationResponseCopyWith<$Res>
    implements $ModerationResponseCopyWith<$Res> {
  factory _$ModerationResponseCopyWith(
          _ModerationResponse value, $Res Function(_ModerationResponse) _then) =
      __$ModerationResponseCopyWithImpl;
  @override
  @useResult
  $Res call({String id, String model, List<ModerationResult> results});
}

/// @nodoc
class __$ModerationResponseCopyWithImpl<$Res>
    implements _$ModerationResponseCopyWith<$Res> {
  __$ModerationResponseCopyWithImpl(this._self, this._then);

  final _ModerationResponse _self;
  final $Res Function(_ModerationResponse) _then;

  /// Create a copy of ModerationResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = null,
    Object? model = null,
    Object? results = null,
  }) {
    return _then(_ModerationResponse(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      model: null == model
          ? _self.model
          : model // ignore: cast_nullable_to_non_nullable
              as String,
      results: null == results
          ? _self._results
          : results // ignore: cast_nullable_to_non_nullable
              as List<ModerationResult>,
    ));
  }
}

/// @nodoc
mixin _$ModerationResult {
  bool get flagged;
  Categories get categories;
  @JsonKey(name: 'category_scores')
  CategoryScores get categoryScores;
  @JsonKey(name: 'category_applied_input_types')
  CategoryAppliedInputTypes get categoryAppliedInputTypes;

  /// Create a copy of ModerationResult
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $ModerationResultCopyWith<ModerationResult> get copyWith =>
      _$ModerationResultCopyWithImpl<ModerationResult>(
          this as ModerationResult, _$identity);

  /// Serializes this ModerationResult to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is ModerationResult &&
            (identical(other.flagged, flagged) || other.flagged == flagged) &&
            (identical(other.categories, categories) ||
                other.categories == categories) &&
            (identical(other.categoryScores, categoryScores) ||
                other.categoryScores == categoryScores) &&
            (identical(other.categoryAppliedInputTypes,
                    categoryAppliedInputTypes) ||
                other.categoryAppliedInputTypes == categoryAppliedInputTypes));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, flagged, categories,
      categoryScores, categoryAppliedInputTypes);

  @override
  String toString() {
    return 'ModerationResult(flagged: $flagged, categories: $categories, categoryScores: $categoryScores, categoryAppliedInputTypes: $categoryAppliedInputTypes)';
  }
}

/// @nodoc
abstract mixin class $ModerationResultCopyWith<$Res> {
  factory $ModerationResultCopyWith(
          ModerationResult value, $Res Function(ModerationResult) _then) =
      _$ModerationResultCopyWithImpl;
  @useResult
  $Res call(
      {bool flagged,
      Categories categories,
      @JsonKey(name: 'category_scores') CategoryScores categoryScores,
      @JsonKey(name: 'category_applied_input_types')
      CategoryAppliedInputTypes categoryAppliedInputTypes});

  $CategoriesCopyWith<$Res> get categories;
  $CategoryScoresCopyWith<$Res> get categoryScores;
  $CategoryAppliedInputTypesCopyWith<$Res> get categoryAppliedInputTypes;
}

/// @nodoc
class _$ModerationResultCopyWithImpl<$Res>
    implements $ModerationResultCopyWith<$Res> {
  _$ModerationResultCopyWithImpl(this._self, this._then);

  final ModerationResult _self;
  final $Res Function(ModerationResult) _then;

  /// Create a copy of ModerationResult
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? flagged = null,
    Object? categories = null,
    Object? categoryScores = null,
    Object? categoryAppliedInputTypes = null,
  }) {
    return _then(_self.copyWith(
      flagged: null == flagged
          ? _self.flagged
          : flagged // ignore: cast_nullable_to_non_nullable
              as bool,
      categories: null == categories
          ? _self.categories
          : categories // ignore: cast_nullable_to_non_nullable
              as Categories,
      categoryScores: null == categoryScores
          ? _self.categoryScores
          : categoryScores // ignore: cast_nullable_to_non_nullable
              as CategoryScores,
      categoryAppliedInputTypes: null == categoryAppliedInputTypes
          ? _self.categoryAppliedInputTypes
          : categoryAppliedInputTypes // ignore: cast_nullable_to_non_nullable
              as CategoryAppliedInputTypes,
    ));
  }

  /// Create a copy of ModerationResult
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $CategoriesCopyWith<$Res> get categories {
    return $CategoriesCopyWith<$Res>(_self.categories, (value) {
      return _then(_self.copyWith(categories: value));
    });
  }

  /// Create a copy of ModerationResult
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $CategoryScoresCopyWith<$Res> get categoryScores {
    return $CategoryScoresCopyWith<$Res>(_self.categoryScores, (value) {
      return _then(_self.copyWith(categoryScores: value));
    });
  }

  /// Create a copy of ModerationResult
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $CategoryAppliedInputTypesCopyWith<$Res> get categoryAppliedInputTypes {
    return $CategoryAppliedInputTypesCopyWith<$Res>(
        _self.categoryAppliedInputTypes, (value) {
      return _then(_self.copyWith(categoryAppliedInputTypes: value));
    });
  }
}

/// @nodoc
@JsonSerializable()
class _ModerationResult implements ModerationResult {
  const _ModerationResult(
      {required this.flagged,
      required this.categories,
      @JsonKey(name: 'category_scores') required this.categoryScores,
      @JsonKey(name: 'category_applied_input_types')
      required this.categoryAppliedInputTypes});
  factory _ModerationResult.fromJson(Map<String, dynamic> json) =>
      _$ModerationResultFromJson(json);

  @override
  final bool flagged;
  @override
  final Categories categories;
  @override
  @JsonKey(name: 'category_scores')
  final CategoryScores categoryScores;
  @override
  @JsonKey(name: 'category_applied_input_types')
  final CategoryAppliedInputTypes categoryAppliedInputTypes;

  /// Create a copy of ModerationResult
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$ModerationResultCopyWith<_ModerationResult> get copyWith =>
      __$ModerationResultCopyWithImpl<_ModerationResult>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$ModerationResultToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _ModerationResult &&
            (identical(other.flagged, flagged) || other.flagged == flagged) &&
            (identical(other.categories, categories) ||
                other.categories == categories) &&
            (identical(other.categoryScores, categoryScores) ||
                other.categoryScores == categoryScores) &&
            (identical(other.categoryAppliedInputTypes,
                    categoryAppliedInputTypes) ||
                other.categoryAppliedInputTypes == categoryAppliedInputTypes));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, flagged, categories,
      categoryScores, categoryAppliedInputTypes);

  @override
  String toString() {
    return 'ModerationResult(flagged: $flagged, categories: $categories, categoryScores: $categoryScores, categoryAppliedInputTypes: $categoryAppliedInputTypes)';
  }
}

/// @nodoc
abstract mixin class _$ModerationResultCopyWith<$Res>
    implements $ModerationResultCopyWith<$Res> {
  factory _$ModerationResultCopyWith(
          _ModerationResult value, $Res Function(_ModerationResult) _then) =
      __$ModerationResultCopyWithImpl;
  @override
  @useResult
  $Res call(
      {bool flagged,
      Categories categories,
      @JsonKey(name: 'category_scores') CategoryScores categoryScores,
      @JsonKey(name: 'category_applied_input_types')
      CategoryAppliedInputTypes categoryAppliedInputTypes});

  @override
  $CategoriesCopyWith<$Res> get categories;
  @override
  $CategoryScoresCopyWith<$Res> get categoryScores;
  @override
  $CategoryAppliedInputTypesCopyWith<$Res> get categoryAppliedInputTypes;
}

/// @nodoc
class __$ModerationResultCopyWithImpl<$Res>
    implements _$ModerationResultCopyWith<$Res> {
  __$ModerationResultCopyWithImpl(this._self, this._then);

  final _ModerationResult _self;
  final $Res Function(_ModerationResult) _then;

  /// Create a copy of ModerationResult
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? flagged = null,
    Object? categories = null,
    Object? categoryScores = null,
    Object? categoryAppliedInputTypes = null,
  }) {
    return _then(_ModerationResult(
      flagged: null == flagged
          ? _self.flagged
          : flagged // ignore: cast_nullable_to_non_nullable
              as bool,
      categories: null == categories
          ? _self.categories
          : categories // ignore: cast_nullable_to_non_nullable
              as Categories,
      categoryScores: null == categoryScores
          ? _self.categoryScores
          : categoryScores // ignore: cast_nullable_to_non_nullable
              as CategoryScores,
      categoryAppliedInputTypes: null == categoryAppliedInputTypes
          ? _self.categoryAppliedInputTypes
          : categoryAppliedInputTypes // ignore: cast_nullable_to_non_nullable
              as CategoryAppliedInputTypes,
    ));
  }

  /// Create a copy of ModerationResult
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $CategoriesCopyWith<$Res> get categories {
    return $CategoriesCopyWith<$Res>(_self.categories, (value) {
      return _then(_self.copyWith(categories: value));
    });
  }

  /// Create a copy of ModerationResult
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $CategoryScoresCopyWith<$Res> get categoryScores {
    return $CategoryScoresCopyWith<$Res>(_self.categoryScores, (value) {
      return _then(_self.copyWith(categoryScores: value));
    });
  }

  /// Create a copy of ModerationResult
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $CategoryAppliedInputTypesCopyWith<$Res> get categoryAppliedInputTypes {
    return $CategoryAppliedInputTypesCopyWith<$Res>(
        _self.categoryAppliedInputTypes, (value) {
      return _then(_self.copyWith(categoryAppliedInputTypes: value));
    });
  }
}

/// @nodoc
mixin _$Categories {
  bool get sexual;
  @JsonKey(name: 'sexual/minors')
  bool get sexualMinors;
  bool get harassment;
  @JsonKey(name: 'harassment/threatening')
  bool get harassmentThreatening;
  bool get hate;
  @JsonKey(name: 'hate/threatening')
  bool get hateThreatening;
  bool get illicit;
  @JsonKey(name: 'illicit/violent')
  bool get illicitViolent;
  @JsonKey(name: 'self-harm')
  bool get selfHarm;
  @JsonKey(name: 'self-harm/intent')
  bool get selfHarmIntent;
  @JsonKey(name: 'self-harm/instructions')
  bool get selfHarmInstructions;
  bool get violence;
  @JsonKey(name: 'violence/graphic')
  bool get violenceGraphic;

  /// Create a copy of Categories
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $CategoriesCopyWith<Categories> get copyWith =>
      _$CategoriesCopyWithImpl<Categories>(this as Categories, _$identity);

  /// Serializes this Categories to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is Categories &&
            (identical(other.sexual, sexual) || other.sexual == sexual) &&
            (identical(other.sexualMinors, sexualMinors) ||
                other.sexualMinors == sexualMinors) &&
            (identical(other.harassment, harassment) ||
                other.harassment == harassment) &&
            (identical(other.harassmentThreatening, harassmentThreatening) ||
                other.harassmentThreatening == harassmentThreatening) &&
            (identical(other.hate, hate) || other.hate == hate) &&
            (identical(other.hateThreatening, hateThreatening) ||
                other.hateThreatening == hateThreatening) &&
            (identical(other.illicit, illicit) || other.illicit == illicit) &&
            (identical(other.illicitViolent, illicitViolent) ||
                other.illicitViolent == illicitViolent) &&
            (identical(other.selfHarm, selfHarm) ||
                other.selfHarm == selfHarm) &&
            (identical(other.selfHarmIntent, selfHarmIntent) ||
                other.selfHarmIntent == selfHarmIntent) &&
            (identical(other.selfHarmInstructions, selfHarmInstructions) ||
                other.selfHarmInstructions == selfHarmInstructions) &&
            (identical(other.violence, violence) ||
                other.violence == violence) &&
            (identical(other.violenceGraphic, violenceGraphic) ||
                other.violenceGraphic == violenceGraphic));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      sexual,
      sexualMinors,
      harassment,
      harassmentThreatening,
      hate,
      hateThreatening,
      illicit,
      illicitViolent,
      selfHarm,
      selfHarmIntent,
      selfHarmInstructions,
      violence,
      violenceGraphic);

  @override
  String toString() {
    return 'Categories(sexual: $sexual, sexualMinors: $sexualMinors, harassment: $harassment, harassmentThreatening: $harassmentThreatening, hate: $hate, hateThreatening: $hateThreatening, illicit: $illicit, illicitViolent: $illicitViolent, selfHarm: $selfHarm, selfHarmIntent: $selfHarmIntent, selfHarmInstructions: $selfHarmInstructions, violence: $violence, violenceGraphic: $violenceGraphic)';
  }
}

/// @nodoc
abstract mixin class $CategoriesCopyWith<$Res> {
  factory $CategoriesCopyWith(
          Categories value, $Res Function(Categories) _then) =
      _$CategoriesCopyWithImpl;
  @useResult
  $Res call(
      {bool sexual,
      @JsonKey(name: 'sexual/minors') bool sexualMinors,
      bool harassment,
      @JsonKey(name: 'harassment/threatening') bool harassmentThreatening,
      bool hate,
      @JsonKey(name: 'hate/threatening') bool hateThreatening,
      bool illicit,
      @JsonKey(name: 'illicit/violent') bool illicitViolent,
      @JsonKey(name: 'self-harm') bool selfHarm,
      @JsonKey(name: 'self-harm/intent') bool selfHarmIntent,
      @JsonKey(name: 'self-harm/instructions') bool selfHarmInstructions,
      bool violence,
      @JsonKey(name: 'violence/graphic') bool violenceGraphic});
}

/// @nodoc
class _$CategoriesCopyWithImpl<$Res> implements $CategoriesCopyWith<$Res> {
  _$CategoriesCopyWithImpl(this._self, this._then);

  final Categories _self;
  final $Res Function(Categories) _then;

  /// Create a copy of Categories
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? sexual = null,
    Object? sexualMinors = null,
    Object? harassment = null,
    Object? harassmentThreatening = null,
    Object? hate = null,
    Object? hateThreatening = null,
    Object? illicit = null,
    Object? illicitViolent = null,
    Object? selfHarm = null,
    Object? selfHarmIntent = null,
    Object? selfHarmInstructions = null,
    Object? violence = null,
    Object? violenceGraphic = null,
  }) {
    return _then(_self.copyWith(
      sexual: null == sexual
          ? _self.sexual
          : sexual // ignore: cast_nullable_to_non_nullable
              as bool,
      sexualMinors: null == sexualMinors
          ? _self.sexualMinors
          : sexualMinors // ignore: cast_nullable_to_non_nullable
              as bool,
      harassment: null == harassment
          ? _self.harassment
          : harassment // ignore: cast_nullable_to_non_nullable
              as bool,
      harassmentThreatening: null == harassmentThreatening
          ? _self.harassmentThreatening
          : harassmentThreatening // ignore: cast_nullable_to_non_nullable
              as bool,
      hate: null == hate
          ? _self.hate
          : hate // ignore: cast_nullable_to_non_nullable
              as bool,
      hateThreatening: null == hateThreatening
          ? _self.hateThreatening
          : hateThreatening // ignore: cast_nullable_to_non_nullable
              as bool,
      illicit: null == illicit
          ? _self.illicit
          : illicit // ignore: cast_nullable_to_non_nullable
              as bool,
      illicitViolent: null == illicitViolent
          ? _self.illicitViolent
          : illicitViolent // ignore: cast_nullable_to_non_nullable
              as bool,
      selfHarm: null == selfHarm
          ? _self.selfHarm
          : selfHarm // ignore: cast_nullable_to_non_nullable
              as bool,
      selfHarmIntent: null == selfHarmIntent
          ? _self.selfHarmIntent
          : selfHarmIntent // ignore: cast_nullable_to_non_nullable
              as bool,
      selfHarmInstructions: null == selfHarmInstructions
          ? _self.selfHarmInstructions
          : selfHarmInstructions // ignore: cast_nullable_to_non_nullable
              as bool,
      violence: null == violence
          ? _self.violence
          : violence // ignore: cast_nullable_to_non_nullable
              as bool,
      violenceGraphic: null == violenceGraphic
          ? _self.violenceGraphic
          : violenceGraphic // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _Categories implements Categories {
  const _Categories(
      {required this.sexual,
      @JsonKey(name: 'sexual/minors') required this.sexualMinors,
      required this.harassment,
      @JsonKey(name: 'harassment/threatening')
      required this.harassmentThreatening,
      required this.hate,
      @JsonKey(name: 'hate/threatening') required this.hateThreatening,
      required this.illicit,
      @JsonKey(name: 'illicit/violent') required this.illicitViolent,
      @JsonKey(name: 'self-harm') required this.selfHarm,
      @JsonKey(name: 'self-harm/intent') required this.selfHarmIntent,
      @JsonKey(name: 'self-harm/instructions')
      required this.selfHarmInstructions,
      required this.violence,
      @JsonKey(name: 'violence/graphic') required this.violenceGraphic});
  factory _Categories.fromJson(Map<String, dynamic> json) =>
      _$CategoriesFromJson(json);

  @override
  final bool sexual;
  @override
  @JsonKey(name: 'sexual/minors')
  final bool sexualMinors;
  @override
  final bool harassment;
  @override
  @JsonKey(name: 'harassment/threatening')
  final bool harassmentThreatening;
  @override
  final bool hate;
  @override
  @JsonKey(name: 'hate/threatening')
  final bool hateThreatening;
  @override
  final bool illicit;
  @override
  @JsonKey(name: 'illicit/violent')
  final bool illicitViolent;
  @override
  @JsonKey(name: 'self-harm')
  final bool selfHarm;
  @override
  @JsonKey(name: 'self-harm/intent')
  final bool selfHarmIntent;
  @override
  @JsonKey(name: 'self-harm/instructions')
  final bool selfHarmInstructions;
  @override
  final bool violence;
  @override
  @JsonKey(name: 'violence/graphic')
  final bool violenceGraphic;

  /// Create a copy of Categories
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$CategoriesCopyWith<_Categories> get copyWith =>
      __$CategoriesCopyWithImpl<_Categories>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$CategoriesToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Categories &&
            (identical(other.sexual, sexual) || other.sexual == sexual) &&
            (identical(other.sexualMinors, sexualMinors) ||
                other.sexualMinors == sexualMinors) &&
            (identical(other.harassment, harassment) ||
                other.harassment == harassment) &&
            (identical(other.harassmentThreatening, harassmentThreatening) ||
                other.harassmentThreatening == harassmentThreatening) &&
            (identical(other.hate, hate) || other.hate == hate) &&
            (identical(other.hateThreatening, hateThreatening) ||
                other.hateThreatening == hateThreatening) &&
            (identical(other.illicit, illicit) || other.illicit == illicit) &&
            (identical(other.illicitViolent, illicitViolent) ||
                other.illicitViolent == illicitViolent) &&
            (identical(other.selfHarm, selfHarm) ||
                other.selfHarm == selfHarm) &&
            (identical(other.selfHarmIntent, selfHarmIntent) ||
                other.selfHarmIntent == selfHarmIntent) &&
            (identical(other.selfHarmInstructions, selfHarmInstructions) ||
                other.selfHarmInstructions == selfHarmInstructions) &&
            (identical(other.violence, violence) ||
                other.violence == violence) &&
            (identical(other.violenceGraphic, violenceGraphic) ||
                other.violenceGraphic == violenceGraphic));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      sexual,
      sexualMinors,
      harassment,
      harassmentThreatening,
      hate,
      hateThreatening,
      illicit,
      illicitViolent,
      selfHarm,
      selfHarmIntent,
      selfHarmInstructions,
      violence,
      violenceGraphic);

  @override
  String toString() {
    return 'Categories(sexual: $sexual, sexualMinors: $sexualMinors, harassment: $harassment, harassmentThreatening: $harassmentThreatening, hate: $hate, hateThreatening: $hateThreatening, illicit: $illicit, illicitViolent: $illicitViolent, selfHarm: $selfHarm, selfHarmIntent: $selfHarmIntent, selfHarmInstructions: $selfHarmInstructions, violence: $violence, violenceGraphic: $violenceGraphic)';
  }
}

/// @nodoc
abstract mixin class _$CategoriesCopyWith<$Res>
    implements $CategoriesCopyWith<$Res> {
  factory _$CategoriesCopyWith(
          _Categories value, $Res Function(_Categories) _then) =
      __$CategoriesCopyWithImpl;
  @override
  @useResult
  $Res call(
      {bool sexual,
      @JsonKey(name: 'sexual/minors') bool sexualMinors,
      bool harassment,
      @JsonKey(name: 'harassment/threatening') bool harassmentThreatening,
      bool hate,
      @JsonKey(name: 'hate/threatening') bool hateThreatening,
      bool illicit,
      @JsonKey(name: 'illicit/violent') bool illicitViolent,
      @JsonKey(name: 'self-harm') bool selfHarm,
      @JsonKey(name: 'self-harm/intent') bool selfHarmIntent,
      @JsonKey(name: 'self-harm/instructions') bool selfHarmInstructions,
      bool violence,
      @JsonKey(name: 'violence/graphic') bool violenceGraphic});
}

/// @nodoc
class __$CategoriesCopyWithImpl<$Res> implements _$CategoriesCopyWith<$Res> {
  __$CategoriesCopyWithImpl(this._self, this._then);

  final _Categories _self;
  final $Res Function(_Categories) _then;

  /// Create a copy of Categories
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? sexual = null,
    Object? sexualMinors = null,
    Object? harassment = null,
    Object? harassmentThreatening = null,
    Object? hate = null,
    Object? hateThreatening = null,
    Object? illicit = null,
    Object? illicitViolent = null,
    Object? selfHarm = null,
    Object? selfHarmIntent = null,
    Object? selfHarmInstructions = null,
    Object? violence = null,
    Object? violenceGraphic = null,
  }) {
    return _then(_Categories(
      sexual: null == sexual
          ? _self.sexual
          : sexual // ignore: cast_nullable_to_non_nullable
              as bool,
      sexualMinors: null == sexualMinors
          ? _self.sexualMinors
          : sexualMinors // ignore: cast_nullable_to_non_nullable
              as bool,
      harassment: null == harassment
          ? _self.harassment
          : harassment // ignore: cast_nullable_to_non_nullable
              as bool,
      harassmentThreatening: null == harassmentThreatening
          ? _self.harassmentThreatening
          : harassmentThreatening // ignore: cast_nullable_to_non_nullable
              as bool,
      hate: null == hate
          ? _self.hate
          : hate // ignore: cast_nullable_to_non_nullable
              as bool,
      hateThreatening: null == hateThreatening
          ? _self.hateThreatening
          : hateThreatening // ignore: cast_nullable_to_non_nullable
              as bool,
      illicit: null == illicit
          ? _self.illicit
          : illicit // ignore: cast_nullable_to_non_nullable
              as bool,
      illicitViolent: null == illicitViolent
          ? _self.illicitViolent
          : illicitViolent // ignore: cast_nullable_to_non_nullable
              as bool,
      selfHarm: null == selfHarm
          ? _self.selfHarm
          : selfHarm // ignore: cast_nullable_to_non_nullable
              as bool,
      selfHarmIntent: null == selfHarmIntent
          ? _self.selfHarmIntent
          : selfHarmIntent // ignore: cast_nullable_to_non_nullable
              as bool,
      selfHarmInstructions: null == selfHarmInstructions
          ? _self.selfHarmInstructions
          : selfHarmInstructions // ignore: cast_nullable_to_non_nullable
              as bool,
      violence: null == violence
          ? _self.violence
          : violence // ignore: cast_nullable_to_non_nullable
              as bool,
      violenceGraphic: null == violenceGraphic
          ? _self.violenceGraphic
          : violenceGraphic // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
mixin _$CategoryScores {
  /// Serializes this CategoryScores to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is CategoryScores);
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'CategoryScores()';
  }
}

/// @nodoc
class $CategoryScoresCopyWith<$Res> {
  $CategoryScoresCopyWith(CategoryScores _, $Res Function(CategoryScores) __);
}

/// @nodoc
@JsonSerializable()
class _CategoryScores implements CategoryScores {
  const _CategoryScores();
  factory _CategoryScores.fromJson(Map<String, dynamic> json) =>
      _$CategoryScoresFromJson(json);

  @override
  Map<String, dynamic> toJson() {
    return _$CategoryScoresToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _CategoryScores);
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'CategoryScores()';
  }
}

/// @nodoc
mixin _$CategoryAppliedInputTypes {
  /// Serializes this CategoryAppliedInputTypes to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is CategoryAppliedInputTypes);
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'CategoryAppliedInputTypes()';
  }
}

/// @nodoc
class $CategoryAppliedInputTypesCopyWith<$Res> {
  $CategoryAppliedInputTypesCopyWith(
      CategoryAppliedInputTypes _, $Res Function(CategoryAppliedInputTypes) __);
}

/// @nodoc
@JsonSerializable()
class _CategoryAppliedInputTypes implements CategoryAppliedInputTypes {
  const _CategoryAppliedInputTypes();
  factory _CategoryAppliedInputTypes.fromJson(Map<String, dynamic> json) =>
      _$CategoryAppliedInputTypesFromJson(json);

  @override
  Map<String, dynamic> toJson() {
    return _$CategoryAppliedInputTypesToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _CategoryAppliedInputTypes);
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'CategoryAppliedInputTypes()';
  }
}

// dart format on
