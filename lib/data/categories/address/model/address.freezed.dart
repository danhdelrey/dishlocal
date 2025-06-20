// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'address.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Address {
  double get latitude;
  double get longitude;
  String? get displayName;
  String? get exactAddress;

  /// Create a copy of Address
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $AddressCopyWith<Address> get copyWith =>
      _$AddressCopyWithImpl<Address>(this as Address, _$identity);

  /// Serializes this Address to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is Address &&
            (identical(other.latitude, latitude) ||
                other.latitude == latitude) &&
            (identical(other.longitude, longitude) ||
                other.longitude == longitude) &&
            (identical(other.displayName, displayName) ||
                other.displayName == displayName) &&
            (identical(other.exactAddress, exactAddress) ||
                other.exactAddress == exactAddress));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, latitude, longitude, displayName, exactAddress);

  @override
  String toString() {
    return 'Address(latitude: $latitude, longitude: $longitude, displayName: $displayName, exactAddress: $exactAddress)';
  }
}

/// @nodoc
abstract mixin class $AddressCopyWith<$Res> {
  factory $AddressCopyWith(Address value, $Res Function(Address) _then) =
      _$AddressCopyWithImpl;
  @useResult
  $Res call(
      {double latitude,
      double longitude,
      String? displayName,
      String? exactAddress});
}

/// @nodoc
class _$AddressCopyWithImpl<$Res> implements $AddressCopyWith<$Res> {
  _$AddressCopyWithImpl(this._self, this._then);

  final Address _self;
  final $Res Function(Address) _then;

  /// Create a copy of Address
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? latitude = null,
    Object? longitude = null,
    Object? displayName = freezed,
    Object? exactAddress = freezed,
  }) {
    return _then(_self.copyWith(
      latitude: null == latitude
          ? _self.latitude
          : latitude // ignore: cast_nullable_to_non_nullable
              as double,
      longitude: null == longitude
          ? _self.longitude
          : longitude // ignore: cast_nullable_to_non_nullable
              as double,
      displayName: freezed == displayName
          ? _self.displayName
          : displayName // ignore: cast_nullable_to_non_nullable
              as String?,
      exactAddress: freezed == exactAddress
          ? _self.exactAddress
          : exactAddress // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

@JsonSerializable(explicitToJson: true)
class _Address implements Address {
  const _Address(
      {required this.latitude,
      required this.longitude,
      this.displayName,
      this.exactAddress});
  factory _Address.fromJson(Map<String, dynamic> json) =>
      _$AddressFromJson(json);

  @override
  final double latitude;
  @override
  final double longitude;
  @override
  final String? displayName;
  @override
  final String? exactAddress;

  /// Create a copy of Address
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$AddressCopyWith<_Address> get copyWith =>
      __$AddressCopyWithImpl<_Address>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$AddressToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Address &&
            (identical(other.latitude, latitude) ||
                other.latitude == latitude) &&
            (identical(other.longitude, longitude) ||
                other.longitude == longitude) &&
            (identical(other.displayName, displayName) ||
                other.displayName == displayName) &&
            (identical(other.exactAddress, exactAddress) ||
                other.exactAddress == exactAddress));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, latitude, longitude, displayName, exactAddress);

  @override
  String toString() {
    return 'Address(latitude: $latitude, longitude: $longitude, displayName: $displayName, exactAddress: $exactAddress)';
  }
}

/// @nodoc
abstract mixin class _$AddressCopyWith<$Res> implements $AddressCopyWith<$Res> {
  factory _$AddressCopyWith(_Address value, $Res Function(_Address) _then) =
      __$AddressCopyWithImpl;
  @override
  @useResult
  $Res call(
      {double latitude,
      double longitude,
      String? displayName,
      String? exactAddress});
}

/// @nodoc
class __$AddressCopyWithImpl<$Res> implements _$AddressCopyWith<$Res> {
  __$AddressCopyWithImpl(this._self, this._then);

  final _Address _self;
  final $Res Function(_Address) _then;

  /// Create a copy of Address
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? latitude = null,
    Object? longitude = null,
    Object? displayName = freezed,
    Object? exactAddress = freezed,
  }) {
    return _then(_Address(
      latitude: null == latitude
          ? _self.latitude
          : latitude // ignore: cast_nullable_to_non_nullable
              as double,
      longitude: null == longitude
          ? _self.longitude
          : longitude // ignore: cast_nullable_to_non_nullable
              as double,
      displayName: freezed == displayName
          ? _self.displayName
          : displayName // ignore: cast_nullable_to_non_nullable
              as String?,
      exactAddress: freezed == exactAddress
          ? _self.exactAddress
          : exactAddress // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

// dart format on
