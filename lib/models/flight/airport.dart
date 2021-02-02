class Airport {
  final String airportId;
  final String cityId;
  
  Airport({this.airportId,
  this.cityId});

  factory Airport.fromJson(Map<String, dynamic> json) {
    return Airport(
      airportId: json['PlaceId'],
      cityId: json['CityId'],
    );
  }
}
