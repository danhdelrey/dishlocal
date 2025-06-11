class GeocodingNominatimResponse {
  final int? placeId;
  final String? licence;
  final String? osmType;
  final int? osmId;
  final String? lat;
  final String? lon;
  final String? displayName;
  final GeocodingNominatimAddress? address;
  final List<String>? boundingbox;

  GeocodingNominatimResponse({
    this.placeId,
    this.licence,
    this.osmType,
    this.osmId,
    this.lat,
    this.lon,
    this.displayName,
    this.address,
    this.boundingbox,
  });

  factory GeocodingNominatimResponse.fromJson(Map<String, dynamic> json) {
    return GeocodingNominatimResponse(
      placeId: int.tryParse(json['place_id']?.toString() ?? ''),
      licence: json['licence'],
      osmType: json['osm_type'],
      osmId: int.tryParse(json['osm_id']?.toString() ?? ''),
      lat: json['lat'],
      lon: json['lon'],
      displayName: json['display_name'],
      // Kiểm tra xem 'address' có tồn tại và khác null không trước khi parse
      address: json['address'] != null ? GeocodingNominatimAddress.fromJson(json['address']) : null,
      boundingbox: json['boundingbox'] != null ? List<String>.from(json['boundingbox']) : null,
    );
  }
  @override
  String toString() {
    final buffer = StringBuffer();
    buffer.writeln('GeocodingNominatimResponse {');
    buffer.writeln('  placeId: ${placeId ?? 'N/A'},');
    buffer.writeln('  displayName: ${displayName ?? 'N/A'},');
    buffer.writeln('  lat: ${lat ?? 'N/A'}, lon: ${lon ?? 'N/A'},');
    // In đối tượng address lồng nhau
    if (address != null) {
      // Thụt lề cho toàn bộ chuỗi của đối tượng address
      final indentedAddress = address.toString().split('\n').map((line) => '  $line').join('\n');
      buffer.writeln('  address:\n$indentedAddress,');
    } else {
      buffer.writeln('  address: N/A,');
    }
    buffer.writeln('  boundingbox: ${boundingbox?.toString() ?? 'N/A'},');
    buffer.writeln('  osmType: ${osmType ?? 'N/A'},');
    buffer.writeln('  osmId: ${osmId ?? 'N/A'},');
    buffer.writeln('  licence: ${licence ?? 'N/A'}');
    buffer.write('}');
    return buffer.toString();
  }
}

class GeocodingNominatimAddress {
  final String? road;
  final String? village;
  final String? stateDistrict;
  final String? state;
  final String? postcode;
  final String? country;
  final String? countryCode;

  GeocodingNominatimAddress({
    this.road,
    this.village,
    this.stateDistrict,
    this.state,
    this.postcode,
    this.country,
    this.countryCode,
  });

  factory GeocodingNominatimAddress.fromJson(Map<String, dynamic> json) {
    return GeocodingNominatimAddress(
      road: json['road'],
      village: json['village'],
      stateDistrict: json['state_district'],
      state: json['state'],
      postcode: json['postcode'],
      country: json['country'],
      countryCode: json['country_code'],
    );
  }
  @override
  String toString() {
    final buffer = StringBuffer();
    buffer.writeln('GeocodingNominatimAddress {');
    buffer.writeln('  road: ${road ?? 'N/A'},');
    buffer.writeln('  village: ${village ?? 'N/A'},');
    buffer.writeln('  stateDistrict: ${stateDistrict ?? 'N/A'},');
    buffer.writeln('  state: ${state ?? 'N/A'},');
    buffer.writeln('  postcode: ${postcode ?? 'N/A'},');
    buffer.writeln('  country: ${country ?? 'N/A'},');
    buffer.writeln('  countryCode: ${countryCode ?? 'N/A'}');
    buffer.write('}');
    return buffer.toString();
  }
}
