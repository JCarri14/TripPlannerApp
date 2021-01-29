class City {
  final String city;
  final String regionCode;
  final String country;

  City({this.city, this.regionCode, this.country});

  factory City.fromJson(Map<String, dynamic> json) {
    return City(
      city: json['city'],
      regionCode: json['regionCode'],
      country: json['country'],
    );
  }
}
