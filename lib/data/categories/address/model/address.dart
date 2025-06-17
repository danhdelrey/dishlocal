import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
part 'address.g.dart';

@JsonSerializable()
class Address extends Equatable {
  final double? latitude;
  final double? longitude;
  final String? displayName;

  const Address({
     this.latitude,
     this.longitude,
     this.displayName,
  });

  factory Address.fromJson(Map<String, dynamic> json) => _$AddressFromJson(json);
  Map<String, dynamic> toJson() => _$AddressToJson(this);

  @override
  List<Object?> get props => [
        latitude,
        longitude,
        displayName,
      ];
}
