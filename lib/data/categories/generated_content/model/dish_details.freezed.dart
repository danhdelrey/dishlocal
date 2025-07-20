// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'dish_details.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$DishDetails {
  /// Mô tả tổng quan, khách quan về món ăn.
  String get overview;

  /// Danh sách các thành phần chính.
  List<String> get mainIngredients;

  /// Mô tả ngắn gọn về cách chế biến phổ biến.
  String get preparation;

  /// Nguồn gốc hoặc vùng miền nổi tiếng với món ăn này.
  String get origin;

  /// Hương vị đặc trưng của món ăn.
  String get flavorProfile;

  /// Mục đích sử dụng phổ biến (bữa sáng, trưa, tối, ăn vặt...).
  String get usage;

  /// Create a copy of DishDetails
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $DishDetailsCopyWith<DishDetails> get copyWith =>
      _$DishDetailsCopyWithImpl<DishDetails>(this as DishDetails, _$identity);

  /// Serializes this DishDetails to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is DishDetails &&
            (identical(other.overview, overview) ||
                other.overview == overview) &&
            const DeepCollectionEquality()
                .equals(other.mainIngredients, mainIngredients) &&
            (identical(other.preparation, preparation) ||
                other.preparation == preparation) &&
            (identical(other.origin, origin) || other.origin == origin) &&
            (identical(other.flavorProfile, flavorProfile) ||
                other.flavorProfile == flavorProfile) &&
            (identical(other.usage, usage) || other.usage == usage));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      overview,
      const DeepCollectionEquality().hash(mainIngredients),
      preparation,
      origin,
      flavorProfile,
      usage);

  @override
  String toString() {
    return 'DishDetails(overview: $overview, mainIngredients: $mainIngredients, preparation: $preparation, origin: $origin, flavorProfile: $flavorProfile, usage: $usage)';
  }
}

/// @nodoc
abstract mixin class $DishDetailsCopyWith<$Res> {
  factory $DishDetailsCopyWith(
          DishDetails value, $Res Function(DishDetails) _then) =
      _$DishDetailsCopyWithImpl;
  @useResult
  $Res call(
      {String overview,
      List<String> mainIngredients,
      String preparation,
      String origin,
      String flavorProfile,
      String usage});
}

/// @nodoc
class _$DishDetailsCopyWithImpl<$Res> implements $DishDetailsCopyWith<$Res> {
  _$DishDetailsCopyWithImpl(this._self, this._then);

  final DishDetails _self;
  final $Res Function(DishDetails) _then;

  /// Create a copy of DishDetails
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? overview = null,
    Object? mainIngredients = null,
    Object? preparation = null,
    Object? origin = null,
    Object? flavorProfile = null,
    Object? usage = null,
  }) {
    return _then(_self.copyWith(
      overview: null == overview
          ? _self.overview
          : overview // ignore: cast_nullable_to_non_nullable
              as String,
      mainIngredients: null == mainIngredients
          ? _self.mainIngredients
          : mainIngredients // ignore: cast_nullable_to_non_nullable
              as List<String>,
      preparation: null == preparation
          ? _self.preparation
          : preparation // ignore: cast_nullable_to_non_nullable
              as String,
      origin: null == origin
          ? _self.origin
          : origin // ignore: cast_nullable_to_non_nullable
              as String,
      flavorProfile: null == flavorProfile
          ? _self.flavorProfile
          : flavorProfile // ignore: cast_nullable_to_non_nullable
              as String,
      usage: null == usage
          ? _self.usage
          : usage // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _DishDetails implements DishDetails {
  const _DishDetails(
      {required this.overview,
      required final List<String> mainIngredients,
      required this.preparation,
      required this.origin,
      required this.flavorProfile,
      required this.usage})
      : _mainIngredients = mainIngredients;
  factory _DishDetails.fromJson(Map<String, dynamic> json) =>
      _$DishDetailsFromJson(json);

  /// Mô tả tổng quan, khách quan về món ăn.
  @override
  final String overview;

  /// Danh sách các thành phần chính.
  final List<String> _mainIngredients;

  /// Danh sách các thành phần chính.
  @override
  List<String> get mainIngredients {
    if (_mainIngredients is EqualUnmodifiableListView) return _mainIngredients;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_mainIngredients);
  }

  /// Mô tả ngắn gọn về cách chế biến phổ biến.
  @override
  final String preparation;

  /// Nguồn gốc hoặc vùng miền nổi tiếng với món ăn này.
  @override
  final String origin;

  /// Hương vị đặc trưng của món ăn.
  @override
  final String flavorProfile;

  /// Mục đích sử dụng phổ biến (bữa sáng, trưa, tối, ăn vặt...).
  @override
  final String usage;

  /// Create a copy of DishDetails
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$DishDetailsCopyWith<_DishDetails> get copyWith =>
      __$DishDetailsCopyWithImpl<_DishDetails>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$DishDetailsToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _DishDetails &&
            (identical(other.overview, overview) ||
                other.overview == overview) &&
            const DeepCollectionEquality()
                .equals(other._mainIngredients, _mainIngredients) &&
            (identical(other.preparation, preparation) ||
                other.preparation == preparation) &&
            (identical(other.origin, origin) || other.origin == origin) &&
            (identical(other.flavorProfile, flavorProfile) ||
                other.flavorProfile == flavorProfile) &&
            (identical(other.usage, usage) || other.usage == usage));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      overview,
      const DeepCollectionEquality().hash(_mainIngredients),
      preparation,
      origin,
      flavorProfile,
      usage);

  @override
  String toString() {
    return 'DishDetails(overview: $overview, mainIngredients: $mainIngredients, preparation: $preparation, origin: $origin, flavorProfile: $flavorProfile, usage: $usage)';
  }
}

/// @nodoc
abstract mixin class _$DishDetailsCopyWith<$Res>
    implements $DishDetailsCopyWith<$Res> {
  factory _$DishDetailsCopyWith(
          _DishDetails value, $Res Function(_DishDetails) _then) =
      __$DishDetailsCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String overview,
      List<String> mainIngredients,
      String preparation,
      String origin,
      String flavorProfile,
      String usage});
}

/// @nodoc
class __$DishDetailsCopyWithImpl<$Res> implements _$DishDetailsCopyWith<$Res> {
  __$DishDetailsCopyWithImpl(this._self, this._then);

  final _DishDetails _self;
  final $Res Function(_DishDetails) _then;

  /// Create a copy of DishDetails
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? overview = null,
    Object? mainIngredients = null,
    Object? preparation = null,
    Object? origin = null,
    Object? flavorProfile = null,
    Object? usage = null,
  }) {
    return _then(_DishDetails(
      overview: null == overview
          ? _self.overview
          : overview // ignore: cast_nullable_to_non_nullable
              as String,
      mainIngredients: null == mainIngredients
          ? _self._mainIngredients
          : mainIngredients // ignore: cast_nullable_to_non_nullable
              as List<String>,
      preparation: null == preparation
          ? _self.preparation
          : preparation // ignore: cast_nullable_to_non_nullable
              as String,
      origin: null == origin
          ? _self.origin
          : origin // ignore: cast_nullable_to_non_nullable
              as String,
      flavorProfile: null == flavorProfile
          ? _self.flavorProfile
          : flavorProfile // ignore: cast_nullable_to_non_nullable
              as String,
      usage: null == usage
          ? _self.usage
          : usage // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

// dart format on
