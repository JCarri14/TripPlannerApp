class Region {
  final String apiId;
  final String name;
  final String code;
  final String countryCode;

  Region({this.apiId, this.name, this.code, this.countryCode});

  factory Region.fromJson(Map<String, dynamic> json) {
    return Region(
      apiId: json['wikiDataId'],
      name: json['name'],
      code: json['isoCode'],
      countryCode: json['countryCode']
    );
  }
}
