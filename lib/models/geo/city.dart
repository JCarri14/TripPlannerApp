class City {
  final String apiId;
  final String name;
  final String region;
  final String country;
  final double latitude;
  final double longitude;

  City({this.apiId, this.name, this.region, this.country, this.latitude, this.longitude});

  factory City.fromJson(Map<String, dynamic> json) {
    return City(
      apiId: json['wikiDataId'],
      name: json['name'],
      region: json['region'],
      country: json['country'],
      latitude: json['latitude'],
      longitude: json['longitude']
    );
  }
}
